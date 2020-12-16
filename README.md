# 讲座助手聊天机器人

## 小组成员与分工

- 吴昊：前端交互界面设计，设配器的实现
- 马小涵： 讲座信息搜集以及相关功能的实现
- 汪增辉： 测试与部署

## 选题背景

## 应用场景

# 前端交互的设计
主要分为下面几个部分内容
- 用Rails搭建网页、交互界面
- 数据库的设计
- 适配器的设计

任务目标：用Rails构建一个与Lita交互的网络应用框架，形式上与聊天室类似。每个用户登陆后可以分别与Lita进行一对一的交互。

测试：
- 打开网页，进入登陆界面
- 输入用户名、密码（默认user1，password），点击登陆，进入聊天页面
- 在聊天界面输入的`double 2` （这里选择最简单的功能）
- 聊天界面回复`2+2=4`

## 由Rails构建聊天室

设计了5个控制器，其对应的功能分别是

controller | function
------------ | -------------
welcome | 展示首页，导航至登陆模块
applicants | 处理用户的创建（注册）
sessions | 登陆
chatrooms | 聊天界面
messages | 聊天的消息

设计了两种资源（resources）分别是用户users与消息messages，它们的结构如下面代码所示。对于每一条消息，我们通过`reference`找到对应的用户（一定是消息的发送方或者接受方）

```ruby
  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.boolean "from_bot"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
```

需要注意的是，我采用的方式是把所有的用户与聊天机器人交互的消息都存在一起，在展示的时候我通过`user_id`确定发送的用户是谁，从而决定是否展示。在展示界面中，我再通过`from_bot`确定发送方是用户还是机器人，决定消息显示的位置。

最终聊天界面如下

## Lita适配器的设计

我在项目的执行过程中逐渐发现，适配器的设计是一个非常复杂的过程，要考虑的因素很多。

首先，要决定应该把Lita作为一个守护进程（daemon）还是作为嵌入在Rails框架中的一个方法。采用后面一种方法要简单一些，如果只考虑“一来一回”的交互，即对于用户的每一句话，只给出一句回复，那么可以直接用`Lita::Robot.new`创建一个机器人对象，用`Lita::Robot.receive(message)`来接受命令。但这样做的问题是无法处理延时任务的情况，比如`schedule`功能。

其次，要考虑Lita如何读取命令。我这里想到的方法是让Rails前端和后端的Lita守护进程同时与数据库Sqlite3进行交互，在聊天界面发送消息时则在数据库中创建对应的项，Lita则通过一个循环不断检索sqlite3数据库中的message表，看是否有没有读的内容。如果有未处理的来自用户的信息，则读取并处理。

Lita回复的消息直接写入数据库的messages表中，`from_bot`域设置为`1`

## 



环境
```
ruby 2.6.5
rails 6.0.3.4
```
## 适配器
利用了 元编程

## 数据库的设计

## 界面设计与美化
参考 https://codepen.io/sajadhsm/pen/odaBdd
1. 利用CSS美化页面
2. 使用`form_with`方法


修改数据库
user@test.com
qwer12321

## 本地部署

1. 下载Railschatbot
2. 下载MyLita，将MyLita移入Railschatbot文件夹中
3. 在
4. 在MyLita目录下执行`lita -d`
5. 在
