# 2. Docker + VSCode の構築

<!-- toc -->

## 2.1. プロジェクトのクローン

githubページ：https://github.com/miracleave-ltd/mirameetVol33

`mirameetVol33-main.zip`を解凍し、そのディレクトリをユーザー直下に配置します。<br>※画像はWindowsの場合
![キャプチャ](./img/chapter_2_1.png)

![キャプチャ2](./img/chapter_2_2.png)

## 2.2. mirameetVol33-mainフォルダに移動 ～ VScodeで起動

```
# Windows
cd C:\Users\mirameetVol33-main
# Mac
cd ~/mirameetVol33-main

# Windows・Mac共通
code .
```

## 2.3. コンテナ内のフォルダをVSCodeで開く

Dev Container拡張機能を利用し、コンテナ内のVScodeに接続します。

・コンテナで再度開くを選択

![reopen container](./img/reopen-container.jpg)

・ウインドウが表示されない場合は左下からコンテナで再度開く

![attache-environment.jpg](./img/attache-environment.jpg)
![reopen container2](./img/reopen-container2.jpg)

・左下に開発コンテナと表示されていれば成功です

![atacche-remote.jpg](./img/atacche-remote.jpg)


## 補足：開発コンテナーについて

![devcontainer image](./img/devcontainer-image.jpg)

別のVSCodeが立ち上がるが、devcontainer.json の設定によりプラグインの入れなおしは不要

![plugins](./img/plugins.jpg)

## 2.4. Railsプロジェクトを起動

実行設定の Debug v33 web から Rails を起動する
![キャプチャ3](./img/chapter_2_3.png)

`http://localhost:3000/`

画面が表示されれば環境構築は完了となります


## 補足：各ファイルの解説

**Dockerfile**

元になるイメージと変更する手順を記述する。
今回は ruby のバージョン 3.2.2 を指定しています。
また、Docker イメージのビルドはキャッシュが利用できるので `Gemfile` を先に追加して `bundle install` をすることにより、時間のかかるインストール処理をキャッシュすることができます。

**docker-compose.yml**

複数のコンテナをまとめて管理するための定義です。
今回は DB のコンテナである `v33_db`, Rails を起動する `v33_web`, メールサーバーを起動する `v33_mail` の3つのコンテナを定義しています。

**.devcontainer/devcontainer.json**

コンテナ内の VSCode についての定義です。
VSCode を起動するコンテナの指定やインストールするプラグインを定義できます。
