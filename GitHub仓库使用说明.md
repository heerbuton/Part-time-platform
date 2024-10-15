# GitHub仓库使用说明

### 1.连接到我的仓库

现在Git Bash里进行登录

#### **1.生成SSH密钥** 

在Git Bash中输入以下命令：

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

将`your_email@example.com`替换为你的GitHub账号邮箱。按照提示操作，可以设置密码保护你的密钥。

#### **2.添加SSH密钥到SSH代理** 

使用以下命令将生成的SSH私钥添加到SSH代理中：

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

确保`~/.ssh/id_rsa`是正确的私钥文件路径。

#### **3.添加SSH公钥到GitHub账号**

查看你的公钥：

```bash
cat ~/.ssh/id_rsa.pub
```

- 复制公钥的完整内容。
- 登录你的GitHub账号，进入Settings > SSH and GPG keys。
- 点击“New SSH key”按钮，将复制的公钥粘贴到“Key”文本框中，并添加一个标题，然后点击“Add SSH key”。

#### **4.测试SSH连接**

在Git Bash中运行以下命令来测试你的SSH连接：

```bash
ssh -T git@github.com
```

如果一切设置正确，你将看到一条欢迎消息。

#### **5.配置Git**

确保你的Git配置中包含了你的GitHub邮箱和用户名：

```bash
git config --global user.email "your_email@example.com"
git config --global user.name "your_username"
```

将`your_email@example.com`和`your_username`替换为你的GitHub账号邮箱和用户名。

#### 6.下载到本地

```
git clone https://github.com/heerbuton/Part-time-platform.git
```

初次使用需要在Git Bash里面使用这段命令

使用方法：在任意目录下右键，打开Git Bush，然后输入这段命令，然后就会在该目录下，自动新建文件夹，文件夹名称为项目仓库名称--Part-time-platform



### 2.上传文件

```
git add .
git commit -m "随便输入什么（最好是用以说明你这次提交的内容）"
git push origin main
```

在Part-time-platform文件夹内正常加入文件或修改文件，最后完成所有修改后，打开Git Bush，依次输出上述命令。

### 3.更新本地仓库

在Part-time-platform文件夹内，打开Git Bush输入

```
git pull
```

12qw
