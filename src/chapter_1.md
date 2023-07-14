# 1. Railsプロジェクトの作成

<!-- toc -->

## 1.1. myappをユーザー直下に配置します

githubページ：https://github.com/miracleave-ltd/mirameet_v23

`docker-hands-on-master.zip`を解凍し、`myapp`ディレクトリをユーザー直下に配置します。<br>※画像はWindowsの場合
![キャプチャ](https://user-images.githubusercontent.com/53431136/69335083-7033d580-0c9f-11ea-9253-b1a876eae9ae.PNG)

![image-20191119101214129](https://user-images.githubusercontent.com/53431136/69317135-a5c7c700-0c7d-11ea-9b27-40e50614be1f.png)

## 1.2. 配置したmyappフォルダに移動します

```
# Windows
cd C:\Users\myapp
# Mac
cd ~/myapp
```

## 1.3. Railsの新規プロジェクトを作成します

以下を実行するとmyapp配下にファイルが作成されます。

```
docker-compose run web rails new . --force --no-deps --database=mysql
```

次はデータベースの準備を行います。
