# ローカル環境のCleanUp

<!-- toc -->

最後に構築したDocker環境の削除を行います。

## コンテナの停止
次のコマンドを実行し、コンテナの状態を確認します。
```sh
docker container ls -a

# CONTAINER ID   IMAGE                           COMMAND                  CREATED        STATUS                      PORTS                                 NAMES
# b173bb2c3e2e   mirameetvol33_v33_web           "/bin/sh -c 'echo Co…"   3 days ago     Up 25 minutes               0.0.0.0:3000->3000/tcp                v33_web
# 23f502d1c58a   postgres:13                     "docker-entrypoint.s…"   3 days ago     Exited (137) 2 days ago                                           v33_db
# 901edcf563d4   mailhog/mailhog                 "MailHog"                3 days ago     Exited (2) 2 days ago                                             v33_mail
```
上記で確認できた`CONTAINER ID`を次のコマンドで利用し、コンテナを停止します。
```sh
docker container stop [CONTAINER ID]
```
## イメージの削除
次のコマンドを実行し、作成したコンテナイメージを確認します。
```sh
docker image ls

# REPOSITORY              TAG             IMAGE ID       CREATED         SIZE
# mirameetvol33_v33_web   latest          40dc866fa6c0   4 days ago      1.08GB
# postgres                13              efc790b27960   13 days ago     407MB
# mailhog/mailhog         latest          4de68494cd0d   3 years ago     392MB
```

上記で確認できた`IMAGE ID`を利用して、ビルドされたイメージを削除します。
```sh
docker image rm -f [IMAGE ID]
```
次のようなメッセージが確認できたら、イメージが正常に削除出来ています。
> Untagged: mirameetvol33_v33_web...

## フォルダの削除
最後にフォルダを削除します。

### Macの場合
```sh
# 一つ上の階層に移動
cd ../
# mirameetVol33-mainフォルダが存在しているかを確認
ls
# mirameetVol33-mainフォルダが存在している場合、下記コマンドを実行しフォルダを削除
rm -rf mirameetVol33-main
```
### Windowsの場合

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