# 3. 外部連携のモック化

<!-- toc -->

`mailhog` という開発用メールサーバーを利用して簡単なメール送信機能を作成して
動作の確認が出来るかを確認しましょう

mailhog は docker-compose.yml の以下部分に定義されていて DevContainer 起動時点で
既に環境が作成されており使用できる状態です。

```
  v33_mail:
    container_name: v33_mail
    image: mailhog/mailhog
    ports:
      - "8025:8025"
```

### ユーザー画面管理画面作成

Rails の scaffold 機能を使用して、簡単なユーザー画面を作成します。

はじめに以下コマンドを実施します。

```Ruby
rails g scaffold User name:string email:string
```

その後マイグレーションをしましょう。

```Ruby
rails db:migrate
```

### メール送信機能追加

Rails 組み込みの ActionMailer を使いメール機能の実装をします。

```
rails generate mailer User
```

作成された user_mailer.rb を以下の通り修正します。

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

メールの本文に設定する内容を記載します。

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
を以下の差分の追加行のみ追記します。

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
に以下２行のメール送信用設定値を追加し準備完了です。

```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { address: 'v33_mail', port: 1025 }
```

以下アドレスからユーザー画面を確認してみましょう。

http://localhost:3001/users/

任意のユーザーを登録した後にメールが送信されます。

mailhog から内容を確認してみましょう！

http://localhost:8025/

### 補足：その他開発用のメールサーバーについて

Rails の場合は letter_opener という Gem が存在しますので、こちらもメール開発を行う際の選択肢の一つに挙げられます。
