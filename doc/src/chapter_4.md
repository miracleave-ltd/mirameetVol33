# 4. DBのバージョンアップ

<!-- toc -->

## 4.1 別バージョンのDBを起動

Dockerで環境構築するメリットとして、ミドルウェアのバージョンアップ等も容易に実施することが出来ることが挙げられます。
現在PostgreSQL13で起動しているので、こちらを15にアップデートしてみましょう。

ローカル環境に直接PostgreSQLがインストールされている場合は、単純にpg_upgradeすれば良い場面もあるかもしれませんが、
例えば、案件A：ver13、案件B：ver13の状態で案件Aだけ15に上げたいという状況だといかがでしょう？


### バックアップを取得
バージョン13のコンテナからバックアップを取得します。
以下をコマンドプロンプトより実行します。
```bash
docker-compose exec db pg_dumpall --clean --username postgres > backup.sql
```

その後データベースコンテナの削除を行います。
```bash
docker container ls -a
docker container rm [コンテナID]
```

ボリュームも同様に削除します。

```bash
docker volume ls
docker volume remove v33-volume
```

### バージョンをアップデート
※並行して稼働させるなら順番等考える必要あり。

```diff
  v33_db:
    container_name: v33_db
-    image: postgres:13
+    image: postgres:15
    ports:
      - "5432:5432"
    volumes:
      - v33-volume:/var/lib/postgresql/data
    environment:
      - TZ=Asia/Tokyo
      - POSTGRES_USER=v33
      - POSTGRES_PASSWORD=meetupv33
```

その後、一度dev containerの接続を閉じて、再度ReOpen Containerする。

### リストア

```bash
cat backup.sql | docker-compose exec -T v33_db psql --username v33
```

ユーザーの登録が出来るか動作確認をして問題無ければDBのバージョンアップは完了となります。

### 補足：ボリュームとコンテナの単純再作成
ローカル環境においては、既に登録済みのデータを諦めることが出来るのであれば
途中のバックアップやリストアの手順をスキップして単純にコンテナの再作成をすることでアップデートをすることも可能です。
テストデータがseedで用意されているのであれば、よほど特殊なデータで無い限りは単純再作成でも良いかもしれません。
