# 4. DB のバージョンアップ

<!-- toc -->

## 4.1 別バージョンの DB を起動

Docker で環境構築するメリットとして、ミドルウェアのバージョンアップを容易に実施することが出来ることが挙げられます。

ローカル環境に直接 PostgreSQL がインストールされている場合は、単純に pg_upgrade すれば良い場面もあるかもしれませんが、
例えば、案件 A：ver13、案件 B：ver13 の状態で案件 A だけ 15 にアップデートしたい！ という状況だといかがでしょう？

PC を複数台用意する訳にも行かず困ってしまいますよね？

現在 PostgreSQL13 で当システムは起動しているので、15 にアップデートしてみましょう。

### seedを取得

バージョン 13 のコンテナからデータを取得します。
以下をVSCodeターミナルより実行します。

```ruby
bundle exec rails db:seed:dump MODELS=users
```

その後データベースコンテナの削除を行います。
こちらはコマンドプロンプト等、VSCode以外のDevContainerの外から実施します。

```bash
docker container rm -f [コンテナID]
```

ボリュームも同様に削除します。

```bash
docker volume rm -f mirameetvol33-main_v33-volume
```

### バージョンをアップデート

・docker-compose.yml

```diff
  v33_db:
    container_name: v33_db
-    image: postgres:13
+    image: postgres:15
    ports:
      - "5433:5432"
    volumes:
      - v33-volume:/var/lib/postgresql/data
    environment:
      - TZ=Asia/Tokyo
      - POSTGRES_USER=v33
      - POSTGRES_PASSWORD=meetupv33
```

Dev Container の接続を一度閉じて、再度接続する。
![Alt text](./img/chapter4_1.png)

![reopen container](./img/reopen-container.jpg)

### マイグレーション

VSCodeで一度DBを作成し、マイグレーションを実施
```ruby
rails db:create
rails db:migrate
```

バックアップしておいたseedデータを投入
```bash
rails db:seed
```

ユーザーの登録が出来るか動作確認をして問題無ければ DB のバージョンアップは完了となります。

### 補足：本番稼働中システムに対するDBバージョンアップについて

当手順はあくまでローカル開発環境向けの手順となります。

本番稼働中のシステムにおいてはデータを損なわないように
入念な計画の元、専用の移行ツール開発等が必須となりますのでご注意ください。

