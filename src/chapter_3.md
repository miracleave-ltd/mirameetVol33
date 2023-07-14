# 3. テーブル作成とSeedデータ投入

環境作成が出来ましたので、新規画面を作成していきます。

以下のような社員情報を表示する画面を作っていきます。
![image-20191121003744232](https://user-images.githubusercontent.com/53431136/69325948-53db6d00-0c8e-11ea-982e-650f9e31d71d.png)

新規画面を作成するには、モデルの追加、コントローラーの追加、ビューの追加、ルーティングの追加を行います。
![05](https://user-images.githubusercontent.com/85742205/133610593-2e0400db-1d6a-4260-8fc6-565dcc27d603.png)

<!-- toc -->

初めに、各ファイルを作成する為にWEBのコンテナに接続します。

```bash
docker exec -it myapp_web_1 bash
```

# 3.1. migrate準備

railsのgenerateコマンドを実行してmodelの作成を行います。

以下を実行し、`model`ファイルと`migration`ファイルを作成します。<br>モデル名は**単数形**で先頭は**大文字**にします。

```ruby
rails g model Employee number:string name:string date:string
```

以下を実行し、上記で作成した`migrateion`ファイルをデータベースへ反映させます。

```ruby
rails db:migrate
```

以下を実行し、コントローラーの作成を行います。コントローラー名は**複数形**で先頭は**大文字**にします．

```ruby
rails g controller Employees
```

`myapp\app\controllers\employees_controller.rb`を以下のとおり、編集します。<br>`Employee`テーブルのデータを全て取得する簡単なプログラムです。

`employees_controller.rb`
```ruby
class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end
end
```

## 3.2. Seedデータ準備

`myapp\db\seeds.rb`のファイルを以下のとおり、編集します。
`seeds.rb`
```ruby
Employee.create(
  [
    {
      number: '001',
      name: 'Yamada',
      date: '2018/01/01',
    },
    {
      number: '002',
      name: 'Tanaka',
      date: '2019/04/01',
    },
    {
      number: '003',
      name: 'Sato',
      date: '2019/05/01',
    },
  ],
)
```

上記で用意したデータを投入します。

```ruby
rails db:seed
```

データを投入したらアクセス時の画面を作成していきます。
