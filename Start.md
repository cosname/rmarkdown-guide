# 开始写作

写作的过程应当包括以下几个步骤：

- 在本地电脑上写作内容；
- 将内容 commit 到本地的 git 仓库中；
- 本地 git 仓库中的内容 push 到自己的 GitHub 仓库中；
- 在图书主体仓库提交一个 Pull request；
- 管理员审核通过后，合并到主体仓库中。

为了开始创作，需要进行必要的设置，主要有以下几个步骤。

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

## 设置 upstream 仓库

如果主仓库中有了更新，那么怎么同步到自己的仓库中呢？
推荐的方法是在本地仓库中添加一个 remote upstream。

```
# Add a new remote upstream repository
git remote add upstream https://github.com/cosname/rmarkdown-guide.git

# Sync your fork
git fetch upstream
git checkout master
git merge upstream/master
```

同步的过程中，本地仓库会先与主仓库同步，commit change 之后，再通过 git push 命令将主仓库的修改同步到自己在 GitHub 上的分支中去。

## 管理 R 包

项目采用 (renv)[https://rstudio.github.io/renv/articles/renv.html] 管理 R 包依赖，它可以基于单个项目创建 R 包的管理环境，而不是依赖全局的 R Library。克隆项目后，在 R 中运行

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


## 提交创作好的章节

在 GitHub 上面发起一个 Pull Request 即可将自己的仓库中的内容同步到 `cosname/rmarkdown-guide`。待管理员审核通过后，即完成创作。

## 建议

- 建议每一章节单独创建一个 branch 来进行创作，以最大可能避免版本间的冲突（让冲突处理起来比较简单）。

