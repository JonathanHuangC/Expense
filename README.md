# flutter_bookkeeping

## 1. 第一版优化情况

### 1.1待优化：

#### 1.1.1登录板块：

1. 主题颜色，打开是白色的，可以设置一下颜色 

2. 弹出输入框出现超出边界问题，具体如下：

   <img src="E:/md%E6%96%87%E4%BB%B6/md%E6%96%87%E4%BB%B6%E5%9B%BE%E7%89%87/image-20210819222841850.png" alt="image-20210819222841850" style="zoom:50%;" />

3. 登录之后连接到首页板块，这里的登录还没有连接上

4. 忘记密码错位，如下：

   <img src="E:/md%E6%96%87%E4%BB%B6/md%E6%96%87%E4%BB%B6%E5%9B%BE%E7%89%87/image-20210819223041591.png" alt="image-20210819223041591" style="zoom:50%;" />

   5. 接收验证码功能未完成（待考虑邮箱实现）

#### 1.1.2  推荐模块

1. 图片默认设置为asstes路径下，防止找不到图片，

#### 1.1.3 我的页面

1. listItem前面图标替换，可换彩色一点的
2. 修改用户名、密码功能是全局？
3. 密码修改页面，新旧密码更改时，如果一样要提示，再次输入新密码如果和新密码不一样请提示
4. 记账提醒功能是不是真的能做到提醒
5. 隐私政策优化一下下
6. 加入我们一个邮箱就OK，可以放上gitBub链接
7. 退出按钮点击直接到的登录页面
8. 点击更换头像仿佛不能成功，我的操作问题？

#### 1.1.4 首页页面

1. 数据库数据可自行添加，记账页面直接选择分类，输入钱数，日期点击日期图例，备注写上，点击保存，数据库就有数据，可根据数据库数据自行发挥
2. 点击进入详情的左括号和个人中心保持一致

#### 1.1.5 记账页面

1. 记账主页面的图片展示需要不断保存才能看到结果，
2. 类别新增之后，直接可以看到结果（待完成）
3. 数据持久化，新增过来的不能时刻保持在本地存储里面
4. 输入的钱数计算结果返回到controller中 
5. 日期选择框优化
6. 收入部分完善，包括收入的分类页面和分类管理 OK
7. 数据库两张表的查询完善，包括按照年份查询，按照belong查询，OK

#### 1.1.6 报表页面

1. 可行性日历展示

2. 导出消费记录功能实现（可以在导航那里就是月份和支出，多第三类出来，一个导出消费数据并给出具体建议的页面，目前就做个导出按钮就好）

3. 点击月份的时候的箭头有了，但是月份展示没有了

4. 月份中点击饼图弹出的字体太大，如下：

   ![image-20210819231850574](E:/md%E6%96%87%E4%BB%B6/md%E6%96%87%E4%BB%B6%E5%9B%BE%E7%89%87/image-20210819231850574.png)

5. 月份前提示是哪一年，默认是当年，展示具体的年份，

6. 下面详细数据是找出还是收入？？？是点击了月收入和月支出有不一样的展示吗？

7. 详细数据 的图标可以和分类里面的图片做一样的，不是固定的这个

8. 具体的钱数同上，和首页功能第一条一样，怎么记录数据完成记录并展示

   

## 2. 第二版优化情况

#### 2.1.1登录板块：

1.  邮箱功能完成，
2.  密码登录完成

#### 2.1.2  推荐模块

1. 图片展示完成
2. 点击图片进行网页跳转
3. 新增爬虫+推荐算法，实现推荐功能

#### 2.1.3 我的页面

1. listItem前面图标替换，可换彩色一点的
2. 密码修改和用户修改之后直接返回到原页面，不用再返回当前的页面了
3. 头像来一个默认的真正的图片，
4. 记账提醒功能是不是真的能做到提醒
5. 隐私政策优化一下下
6. 点击账本初始化之后，数据库内容清空，再次进入之后全是默认的数据
7. 备份和同步功能，做存储到云端，把数据库里面的内容存储到服务器上（暂时找找资料，先不忙做），如果要做的话，可以去阿里云申请按照天进行购买，购买对应的服务器，

#### 2.1.4 首页页面

1. 点击进入详情的左括号和个人中心保持一致

2. 首页左上角返回箭头不要

   ![image-20210826171514995](E:/md%E6%96%87%E4%BB%B6/md%E6%96%87%E4%BB%B6%E5%9B%BE%E7%89%87/image-20210826171514995.png)

3. 钱数对应于反问数据库的具体钱数，不做定的，其余的每周每月一样子标题对应于实际的值，不是定值

   

#### 2.1.5 记账页面

1. 记账主页面的图片展示需要不断保存才能看到结果，
2. 类别新增之后，直接可以看到结果
3. 数据持久化，新增过来的不能时刻保持在本地存储里面
4. 输入的钱数计算结果返回到controller中 
5. 按钮做和主题颜色一样的按钮，可以进行颜色设置

#### 2.1.6 报表页面

1. 导出按钮点击之后，给一个页面，展示导出后的excel文件，

   提供一个接口，把数据库支出和收入里面的数据导出到excel文件，保存到手机上，在我点击了导出之后，可以弹出对应的excel页面

   我查过，是可以实现的

2. 默认的月份支出和收入也年份收入支出 可以多一点数据，刚打开的时候有不一样颜色，到时候演示的时候，就不用自己再记那么多账让他看了





