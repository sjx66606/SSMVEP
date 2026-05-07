# -*- coding: utf-8 -*-
# @Time    : 2024/7/8 15:59
# @Author  : sjx_alo！！
# @FileName: classifier4.py
# @Algorithm ：
# @Description: SSVEP深度学习4分类模型   对每个组的组间进行4分类  每条数据扩充为5条
import os

from scipy.io import loadmat
import numpy as np
import pandas as pd
from model.EegNet1 import EegNet
import torch
import torch.nn as nn
import torch.utils.data as Data
from sklearn.metrics import accuracy_score, precision_score, f1_score, recall_score, confusion_matrix
from tqdm import tqdm
import warnings

warnings.filterwarnings("ignore")



best_length = 0
# 时间窗口大小
splid_window = 4800
epochs = 500
batch_size = 4
# 分割窗口大小
# splid_window = 1000

best_score_list = []
# channels = 4: 'PO7','PO8','T7','T8'
# channels = 5:'PO7','PO8','T7','T8','POZ'
# channels = 8:'PO3','PO4','PO7','PO8','POZ','O1','OZ','O2'
# channels = 6: 'PO7','PO8','T7','T8','O1','O2'
# channels = 7: 'PO7','PO8','T7','T8','O1','O2','OZ'
# rchannels = 8:'PO7','PO8','T7','T8','O1','O2','FP1','FP2'
# channels = 12: 'PO7','PO8','T7','T8','O1','O2','FZ','C3','C4','F3','F4','PZ'
# channels = 10: 'PO7','PO8','T7','T8','O1','O2','FZ','C3','C4','PZ'
sel_channels_name = ['PO3','PO4','PO7','PO8','POZ','O1','OZ','O2']

for j in range(1,10):
    all_data_x = []
    all_data_y = []
    for i in range(4):
        # 通过改变这里的dataset后面的数值  来设置对不同的组进行分类
        data_path = '../../data/dataset' + str(i) + '/data' + str(j) + '.mat'
        data = loadmat(data_path)
        channels = data['X0'][0][0]['chanlocs'][0]['labels'][:]
        sel_channels = [np.where(channels == name)[0][0] for name in sel_channels_name]
        all_data_x0 = data['X0'][0][:]['data']
        all_data_x0 = np.concatenate(all_data_x0).reshape(len(all_data_x0), -1, 5000)
        data_x = all_data_x0[:, sel_channels, :]

        # if j == 2:
        #     # 删除33(M1)、43(M2)、60(CB1)、64(CB2)等通道
        #     channels_to_remove = [32, 42, 59, 63]  # 第33、43、60、64通道
        #     data_x = np.delete(data_x, channels_to_remove, axis=1)

        data_y = [i for k in range(len(data_x))]
        all_data_x.extend(data_x)
        all_data_y.extend(data_y)


    all_data_x = np.array(all_data_x).reshape(-1, len(data_x[0]), 5000)
    all_data_y = np.array(all_data_y).reshape(-1, 1)


    # 合并特征和标签成为一个 TensorDataset
    dataset = torch.utils.data.TensorDataset(
        torch.FloatTensor(all_data_x),
        torch.LongTensor(all_data_y))

    # 定义训练集和测试集的比例，例如 80% 训练，20% 测试
    train_size = int(0.8 * len(dataset))
    # valid_size = int(0.2 * len(dataset))
    test_size = len(dataset) - train_size

    # 分割数据集
    train_dataset, test_dataset = Data.random_split(dataset, [train_size, test_size],
                                                    generator=torch.Generator().manual_seed(2024))

    # 创建 DataLoader 以便于批处理
    train_loader = Data.DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
    #valid_loader = Data.DataLoader(train_dataset, batch_size=16, shuffle=True)
    test_loader = Data.DataLoader(test_dataset, batch_size=batch_size, shuffle=False)


    model = EegNet(chunk_size= len(all_data_x[0,0]),
                     num_electrodes = len(data_x[0]),
                     F1 = 8,
                     F2 = 16,
                     D = 2,
                     num_classes = 4,
                     kernel_1 = 64,
                     kernel_2 = 16,
                     dropout = 0.25)

    # 判断电脑是否含有cuda  如果有就用cuda  否则使用cpu
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    # 初始化模型
    model = model.to(device)
    # 初始化优化器
    optimizer = torch.optim.Adam(model.parameters(), lr=0.0001)
    # 定义损失函数
    loss_function = nn.CrossEntropyLoss()

    # 分类指标：准确率（ACC）、召回率（Recall）、精确度（precision）、F1分数（F-score）和混淆矩阵
    acc = []
    recall = []
    precision = []
    f_score = []
    valid_acc = []
    valid_recall = []
    valid_precision = []
    valid_f_score = []

    best_score = 0
    # 开始训练
    for i in range(epochs):
        model.train()
        tol_loss = 0.0
        train_bar = tqdm(train_loader)   # 实时显示加载了多少数据
        train_preds = []
        train_trues = []
        # 设置前缀
        train_bar.set_description(f'Epoch [{i+1}/{epochs}]')
        for idx_batch, (x, y) in enumerate(train_bar):
            # 将训练数据输入模型
            netout = model(x.to(device)).squeeze(axis=2)
            # 计算损失函数
            loss = loss_function(netout,y.to(device).squeeze())
            # 固定格式  优化器梯度归零  损失反向传播 优化器更新
            optimizer.zero_grad()
            loss.backward()
            # Update weights
            optimizer.step()
            tol_loss += loss.data
            train_preds.extend(torch.argmax(netout, dim=1).detach().cpu().numpy())
            train_trues.extend(y.detach().cpu().numpy())

            # 计算精度
            accuracy_epoch = accuracy_score(train_trues, train_preds)
            # 更新训练信息

            # 设置你想要在本次循环内实时监视的变量  可以作为后缀打印出来
            train_bar.set_postfix(loss = tol_loss.item(), acc = accuracy_epoch)
            #train_bar.update(1)  # 设置你每一次想让进度条更新的iteration 大小

        # model.eval()
        test_pres = []
        test_trues = []
        

       
        test_netout = model(test_dataset.dataset[:][0].to(device))
        test_pres.extend(torch.argmax(test_netout, dim=1).detach().cpu().numpy())
        test_trues.extend(test_dataset.dataset[:][1].detach().cpu().numpy())


        test_trues_np = np.array(test_trues).reshape(-1,1)
        test_pres_np = np.array(test_pres).reshape(-1,1)
        # 计算精度、precision、recall、f_score
        acc.append(accuracy_score(test_trues, test_pres))
        precision.append(precision_score(test_trues, test_pres,average='macro'))
        recall.append(recall_score(test_trues, test_pres,average='macro'))
        f_score.append(f1_score(test_trues, test_pres,average='macro'))

    # 绘制混淆矩阵
    matrix = confusion_matrix(test_trues, test_pres)
    # print('Confusion Matrix:')
    # print(np.matrix(matrix))

    best_ind = np.argmax(acc)
    # 将测试集指标进行输出   输出到csv文件中
    scores = {'Accuracy':acc[best_ind],'Precision':precision[best_ind],
              'Recall':recall[best_ind], 'F-score':f_score[best_ind]}
    print(scores)


    best_ind = np.argmax(acc)
    # 将测试集指标进行输出   输出到csv文件中
    scores = {'Accuracy':acc[best_ind],'Precision':precision[best_ind],
              'Recall':recall[best_ind], 'F-score':f_score[best_ind]}
    best_score_list.extend(list(scores.values()))
print(scores)
scores_pd = pd.DataFrame(np.array(best_score_list).reshape(-1,4), columns=['Accuracy', 'Precision', 'Recall', 'F-score'])
save_name = 'res4_b' + str(batch_size) + '_c' + str(len(data_x[0])) + '.csv'
while save_name in os.listdir('./'):
    save_name = 'res4_b' + str(batch_size) + '_c' + str(len(data_x[0])) +'r' +str(np.random.randint(0,2024)) + '.csv'

scores_pd.to_csv('./' + save_name)
print(np.mean(best_score_list))

