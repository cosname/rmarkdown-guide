# 开始写作

写作的过程应当包括以下几个步骤：

- **从官方源 Fork 一个自己的分支**；

  这一步在 GitHub 项目网页（<https://github.com/cosname/rmarkdown-guide>）中完成。

- **将自己的 Fork 克隆到本地电脑中**；

  ```
  # 以自己的 Fork 为例，将 `username` 替换为自己的用户名
  git clone https://github.com/<username>/rmarkdown-guide
  ```

- **创建一个新的 branch，并切换到这个分支上进行创作**；

  ```
  # branch-name 使用一个 reasonable 的单词拼写
  git branch chapter3
  git checkout chapter3
  ```

- **在新的本地分支上写作内容（:writing_hand:）**；

- **将内容 commit 到本地的 git 仓库中**；

  ```
  git add chapter3.Rmd
  git commit -m "Update Chapter 3"
  ```

- **本地 git 仓库中的内容 push 到自己的 GitHub 仓库中**；

  ```
  git push --set-upstream origin chapter3
  ```

- **在图书主体仓库提交一个 Pull request**；

在这里提交 PR <https://github.com/cosname/rmarkdown-guide/pulls>。提交后注意检查 GitHub Action 运行的结果（一般需要等待几十分钟才能看到），如果运行不成功请先自行排查问题来源。

- **管理员审核通过后，合并到主体仓库中**。

- **主体仓库更新后，其它的创作者在自己 Fork 的主分支中会看到一个 “Fetch Upstream” 的按钮，点击该按钮与主仓库同步**。

- **同步本地的仓库**。

  ```
  git pull
  ```

- **一个新的创作从创建一个新分支开始**。

对上述步骤的详细说明如下：

## Fork 一个自己的分支

图书的主体放在 [`cosname/rmarkdown-guide`](https://github.com/cosname/rmarkdown-guide) 中，开始创作的时候，需要在这个页面点击 Fork 创建一个自己的分支。

创作需要在自己的本地分支上进行，因此需要将自己的分支克隆到本地。

```
# run git in your local computer
git clone https://github.com/gaospecial/rmarkdown-guide
```

此时可以尝试一下 `git push` 命令，如果提示登录，则可以进行下列设置

```
git remote set-url origin git+ssh://git@github.com/gaospecial/rmarkdown-guide.git
```

如果是第一次使用 GitHub push 的话，则还需要配置 SSH 秘钥才能实现无感 push。

## GitHub 配置 SSH 密钥

> 如果已经配置好的话，该步可以跳过。

SSH 密钥是成对的，包括公钥和私钥，公钥登记到 GitHub 网站，私钥存储在本地计算机（私有）。

密钥在本地生成。点击鼠标右键，选择“Git Bash here”，输入下列命令将生成一对SSH密钥。
默认情况下，私钥保存在 “`~/.ssh/id_rsa`” 文件中，公钥保存在 “`~/.ssh/id_rsa.pub`"文件中
（没错，在 Windows 下的 Git bash 下面也可以使用 `~` 代表家目录）。

```
ssh-keygen
cat ./.ssh/id_rsa.pub
```

复制这个公钥的全部内容，进入GitHub - Setting - SSH and GPG keys，选择“New SSH key”，将公钥粘贴进去，点击 “Add SSH key”，即可完成公钥添加。

这样，以后就调用 “Git bash shell” 时，便会自动提供私钥认证，不需要输入用户名和密码了。


## 管理 R 包

项目采用 **renv**（<https://rstudio.github.io/renv/articles/renv.html>） 管理 R 包依赖，它可以基于单个项目创建 R 包的管理环境，而不是依赖全局的 R Library。克隆项目后，在 R 中运行

```r
# 本地安装 renv 包
install.packages("renv")
# 安装本书依赖的 R 包
renv::restore()
```

`renv::restore()` 根据 `renv.lock` 中的内容在项目根目录中的 `renv/library/` 下安装本书当下依赖的特定版本的 R 包，这样可以保证所有作者使用的 R 包版本相同。安装完成后下次启动项目，`.Rprofile` 文件中的脚本会自动加载这些包的环境。

作者在写作过程中可以正常使用 `install.packages()` 或者 `renv::install()` 安装自己所需的其他 R 包并在 R Markdown 文件中引用，建议使用后者，可以避免重复下载已经全局安装过的包。

写作完成准备提交时，我们需要将这些新引入 R 包环境更新到 `renv.lock` 中，让其他作者后续写作中也可以使用这些包。在 R 中运行

```r
# 更新 renv.lock
renv::snapshot()
```

这样，在我们提交新的 `renv.lock` 至主仓库后，其他作者再次运行 `renv::restore()` 便可以添加这些 R 包至自己的项目环境。

## 对于专有名词的约定

- 对于软件包的名称、函数、参数、示例、图片等格式进行统一；
- 软件包名称用粗体，例如 **rmarkdown**；
- 函数用代码，并附上括号，例如 `render()`；
- 参数用代码，无括号，例如 `output = "html_document"`；
- 示例代码和输出的长度以一页篇幅以内为限，最好不超过半页（行距可以调小），尽量减少跨页面展示的现象；
- 图片的长宽比统一，显示不完整时边缘显示切割（图片展示主要结果）；

## 中英文混排的写作规范

保持中英文混排的规范，正确使用标点符号，主要参考资料为：

- 中文技术文档规范 <https://github.com/ruanyf/document-style-guide>
- 中文文案排版指北 <https://github.com/sparanoid/chinese-copywriting-guidelines/blob/master/README.zh-Hans.md>

### 空格

> 「有研究显示，打字的时候不喜欢在中文和英文之间加空格的人，感情路都走得很辛苦，有七成的比例会在 34 岁的时候跟自己不爱的人结婚，而其余三成的人最后只能把遗产留给自己的猫。毕竟爱情跟书写都需要适时地留白。
>
> 与大家共勉之。」——[vinta/paranoid-auto-spacing](https://github.com/vinta/pangu.js)

#### 中英文之间需要增加空格

正确：

> 在 LeanCloud 上，数据存储是围绕 `AVObject` 进行的。

错误：

> 在LeanCloud上，数据存储是围绕`AVObject`进行的。
>
> 在 LeanCloud上，数据存储是围绕`AVObject` 进行的。

完整的正确用法：

> 在 LeanCloud 上，数据存储是围绕 `AVObject` 进行的。每个 `AVObject` 都包含了与 JSON 兼容的 key-value 对应的数据。数据是 schema-free 的，你不需要在每个 `AVObject` 上提前指定存在哪些键，只要直接设定对应的 key-value 即可。

例外：「豆瓣FM」等产品名词，按照官方所定义的格式书写。

#### 中文与数字之间需要增加空格

正确：

> 今天出去买菜花了 5000 元。

错误：

> 今天出去买菜花了 5000元。
>
> 今天出去买菜花了5000元。

#### 数字与单位之间需要增加空格

正确：

> 我家的光纤入屋宽带有 10 Gbps，SSD 一共有 20 TB

错误：

> 我家的光纤入屋宽带有 10Gbps，SSD 一共有 20TB

例外：度 / 百分比与数字之间不需要增加空格：

正确：

> 今天是 233° 的高温。
>
> 新 MacBook Pro 有 15% 的 CPU 性能提升。

错误：

> 今天是 233 ° 的高温。
>
> 新 MacBook Pro 有 15 % 的 CPU 性能提升。

#### 全角标点与其他字符之间不加空格

正确：

> 刚刚买了一部 iPhone，好开心！

错误：

> 刚刚买了一部 iPhone ，好开心！
>
> 刚刚买了一部 iPhone， 好开心！


### 标点符号

#### 不重复使用标点符号

正确：

> 德国队竟然战胜了巴西队！
>
> 她竟然对你说「喵」？！

错误：

> 德国队竟然战胜了巴西队！！
>
> 德国队竟然战胜了巴西队！！！！！！！！
>
> 她竟然对你说「喵」？？！！
>
> 她竟然对你说「喵」？！？！？？！！

### 全角和半角

不明白什么是全角（全形）与半角（半形）符号？请查看维基百科条目『[全角和半角](https://zh.wikipedia.org/wiki/%E5%85%A8%E5%BD%A2%E5%92%8C%E5%8D%8A%E5%BD%A2)』。

#### 使用全角中文标点

正确：

> 嗨！你知道嘛？今天前台的小妹跟我说「喵」了哎！
>
> 核磁共振成像（NMRI）是什么原理都不知道？JFGI！

错误：

> 嗨! 你知道嘛? 今天前台的小妹跟我说 "喵" 了哎！
>
> 嗨!你知道嘛?今天前台的小妹跟我说"喵"了哎！
>
> 核磁共振成像 (NMRI) 是什么原理都不知道? JFGI!
>
> 核磁共振成像(NMRI)是什么原理都不知道?JFGI!

#### 数字使用半角字符

正确：

> 这个蛋糕只卖 1000 元。

错误：

> 这个蛋糕只卖 １０００ 元。

例外：在设计稿、宣传海报中如出现极少量数字的情形时，为方便文字对齐，是可以使用全角数字的。

#### 遇到完整的英文整句、特殊名词，其内容使用半角标点

正确：

> 乔布斯那句话是怎么说的？「Stay hungry, stay foolish.」
>
> 推荐你阅读《Hackers & Painters: Big Ideas from the Computer Age》，非常的有趣。

错误：

> 乔布斯那句话是怎么说的？「Stay hungry，stay foolish。」
>
> 推荐你阅读《Hackers＆Painters：Big Ideas from the Computer Age》，非常的有趣。

### 名词

#### 不要使用人称代词

写作过程中尽量避免使用“你”、“我们”这样的称呼，应使用更为客观的表达，如“本章”、“本节”等，或换一种表述。

#### 专有名词使用正确的大小写

大小写相关用法原属于英文书写范畴，不属于本 wiki 讨论内容，在这里只对部分易错用法进行简述。

正确：

> 使用 GitHub 登录
>
> 我们的客户有 GitHub、Foursquare、Microsoft Corporation、Google、Facebook, Inc.。

错误：

> 使用 github 登录
>
> 使用 GITHUB 登录
>
> 使用 Github 登录
>
> 我们的客户有 github、foursquare、microsoft corporation、google、facebook, inc.。
>
> 我们的客户有 GITHUB、FOURSQUARE、MICROSOFT CORPORATION、GOOGLE、FACEBOOK, INC.。
>
> 我们的客户有 Github、FourSquare、MicroSoft Corporation、Google、FaceBook, Inc.。


注意：当网页中需要配合整体视觉风格而出现全部大写／小写的情形，HTML 中请使用标淮的大小写规范进行书写；并通过 `text-transform: uppercase;`／`text-transform: lowercase;` 对表现形式进行定义。

#### 不要使用不地道的缩写

正确：

> 我们需要一位熟悉 TypeScript、HTML5，至少理解一种框架（如 React、Next.js）的前端开发者。

错误：

> 我们需要一位熟悉 Ts、h5，至少理解一种框架（如 RJS、nextjs）的 FED。


### 链接之间增加空格

推荐用法：

> 请 [提交一个 issue](#) 并分配给相关同事。
>
> 访问我们网站的最新动态，请 [点击这里](#) 进行订阅！

对比用法：

> 请[提交一个 issue](#)并分配给相关同事。
>
> 访问我们网站的最新动态，请[点击这里](#)进行订阅！

