# ローカル環境の CleanUp

<!-- toc -->

最後に構築した Docker 環境の削除を行います。
Dev Container の VSCode ターミナル上ではなく、コマンドプロンプトで実施するようお願いします。

## コンテナの削除

次のコマンドを実行し、コンテナの状態を確認します。

以下コメント部分に記載しているようなコンテナが対象となります。※若干名称が異なる可能性あります

```sh
docker container ls -a

# CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS                           PORTS                                 NAMES
# 0875b41f2d63   postgres:15                  "docker-entrypoint.s…"   4 minutes ago    Up 4 minutes                     0.0.0.0:5434->5432/tcp                v33_db
# 1038e3c437bd   mirameetvol33-main_v33_web   "/bin/sh -c 'echo Co…"   48 minutes ago   Up 4 minutes                     0.0.0.0:3001->3000/tcp                v33_web
# 74bca59dd4e8   mailhog/mailhog              "MailHog"                48 minutes ago   Up 4 minutes                     1025/tcp, 0.0.0.0:8025->8025/tcp      v33_mail
```

上記で確認できた`CONTAINER ID`を次のコマンドで利用し、コンテナを削除します。

複数 ID スペース区切りで一括で指定可能です。

```sh
docker container rm -f [CONTAINER ID 1件目] [CONTAINER ID 2件目] ・・・
```

## イメージの削除

次のコマンドを実行し、作成したコンテナイメージを確認します。

```sh
docker image ls

# REPOSITORY                   TAG             IMAGE ID       CREATED          SIZE
# mirameetvol33-main_v33_web   latest          32ed84dc1bd0   59 minutes ago   1.08GB
# postgres                     13              efc790b27960   3 weeks ago      407MB
# postgres                     15              43677b39c446   3 weeks ago      412MB
# mailhog/mailhog              latest          4de68494cd0d   3 years ago      392MB
```

上記で確認できた`IMAGE ID`を利用して、ビルドされたイメージを削除します。

こちらも同じくスペース区切りで複数指定できます。

```sh
docker image rm -f [IMAGE ID 1件目] [IMAGE ID 2件目] ・・・
```

次のようなメッセージが確認できたら、イメージが正常に削除出来ています。

> Untagged: mirameetvol33_v33_web...

## ボリュームの削除

次のコマンドを実行し、作成したボリュームを確認します。

```sh
docker volume ls

# DRIVER    VOLUME NAME
# local     mirameetvol33-main_v33-volume
```

上記で確認できた`volume NAME`を利用して、ボリュームを削除します。

```sh
docker volume rm -f [volume NAME]
```

## フォルダの削除

最後にフォルダを削除します。

### Mac の場合

```sh
# 一つ上の階層に移動
cd ../
# mirameetVol33-mainフォルダが存在しているかを確認
ls
# mirameetVol33-mainフォルダが存在している場合、下記コマンドを実行しフォルダを削除
rm -rf mirameetVol33-main
```

### Windows の場合

```sh
# 一つ上の階層に移動
cd ../
# mirameetVol33-mainフォルダが存在しているかを確認
dir
# mirameetVol33-mainフォルダが存在している場合、下記コマンドを実行しフォルダを削除
rd /s /q mirameetVol33-main
# PowerShellをご使用の方はこちらのコマンドをご使用下さい
Remove-Item mirameetVol33-main -Recurse -Force
```

以上。
