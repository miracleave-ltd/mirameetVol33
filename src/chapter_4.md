# 4. 画面の作成

<!-- toc -->

## 4.1 ルーティングの設定

`myapp\config\routes.rb`のファイルを編集します。

```ruby
Rails.application.routes.draw do
  root to: 'employees#index'
  resources :employees
end
```

## 4.2. 画面の作成

`inde.html.erb`ファイルを新規作成します。

```bash
touch app/views/employees/index.html.erb
```

`myapp\app\views\employees\index.html.erb`のファイルを編集します
`index.html.erb`
```html
<h1>List of employees</h1>

<table border="1" width="700" cellspacing="0" cellpadding="5" bordercolor="#333333" class="table table-hover">
  <thead class="thead-dark">
    <tr>
      <th bgcolor="#87cefa" class="align-middle" scope="col" width="100"><font size="+1" color="#FFFFFF">Employee no</font></th>
      <th bgcolor="#87cefa" class="align-middle" scope="col" width="400"><font size="+1" color="#FFFFFF">Name</font></th>
      <th bgcolor="#87cefa" class="align-middle" scope="col" width="150"><font size="+1" color="#FFFFFF">Hire date</font></th>
    </tr>
  </thead>


  <tbody>
    <% @employees.each do |employee| %>
      <tr scope="row">
        <td><%= employee.number %></td>
        <td><%= employee.name %></td>
        <td><%= employee.date %></td>
      </tr>
    <% end %>
  </tbody>
</table>
```

## 4.3. 画面の確認

`http://localhost:3000/`にアクセスし、以下の画面が表示されたら完成です！

![image-20191121003744232](https://user-images.githubusercontent.com/53431136/69325948-53db6d00-0c8e-11ea-982e-650f9e31d71d.png)

## 4.4. おまけ

今回は扱いませんが、`scaffold`を使用して雛形的な自動生成も行う事が出来ます。<br>コントローラーやモデルの作成を省けるというメリットもありますが、デメリットとしては`MVC`や`Rails`への理解が浅いと**よくわからないが出来た**状態になってしまうことが考えられます。

## 4.5. モデルから画面まで自動生成します

```ruby
rails g scaffold Personal number:string name:string date:string
```

## 4.6. 追加したモデルのテーブルを作成

```ruby
rails db:migrate
```

## 4.7. 何が出来たのか確認

`http://localhost:3000/personals`に接続して画面の確認を行います。

![キャプチャ](https://user-images.githubusercontent.com/53431136/69335804-d40ace00-0ca0-11ea-9fe8-3a8f0cbd74c4.PNG)
