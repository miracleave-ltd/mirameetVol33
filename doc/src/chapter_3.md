# 3. 外部連携のモック化

<!-- toc -->

`mailhog` という開発用メールサーバーを利用して簡単なメール送信機能を作成して
動作の確認が出来るかを確認しましょう！

mailhogはdocker-compose.ymlの以下部分に定義されていてDevContainer起動時点で
既に環境が作成されており使用できる状態です。

```
  v33_mail:
    container_name: v33_mail
    image: mailhog/mailhog
    ports:
      - "8025:8025"
```

### ユーザー画面管理画面作成
Railsのscaffold機能を使用して、簡単なユーザー画面を作成します。
以下コマンドを実施します。

```Ruby
rails g scaffold User name:string email:string
```

その後マイグレーションしましょう。

```Ruby
rails db:migrate
```

### メール送信機能追加

```
rails generate mailer User
```

作成されたuser_mailer.rbを以下の通り修正します。

・user_mailer.rb
```
class UserMailer < ApplicationMailer
  default from: 'noreply@meetup.com'

  def welcome_email
    @user = params[:user]

    mail(
      subject: '登録完了',
      to: @user.email
    )
  end
end
```

メール本文を作成
```
touch app/views/user_mailer/welcome_email.text.erb
```

作成されたメール本文定義ファイルに以下の通り記載しましょう。
```
<%= @user.name %>様

新規登録ありがとうございます。

引き続きミートアップをお楽しみください。

```

app/controllers/users_controller.rb
を以下の追記と記載された部分のみ追記。

```diff
# POST /users or /users.json
def create
  @user = User.new(user_params)

  respond_to do |format|
    if @user.save
+      UserMailer.with(user: @user).welcome_email.deliver_later
      format.html { redirect_to user_url(@user), notice: "User was successfully created." }
      format.json { render :show, status: :created, location: @user }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end
```

config/enviroments/development.rb
に以下２行のメール送信用設定値を追加
```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { address: 'mailhog', port: 1025 }
```

以下アドレスからユーザー画面を確認してみましょう。
http://localhost:3000/users/


メール送信して mailhog から内容が確認出来るか確認しましょう！
http://localhost:8025/


### 補足：その他開発用のメールサーバーについて
Railsの場合はletter_openerというGemが存在するのでそちらを使用しても同等の操作をすることが可能です。

