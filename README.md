# 在Steam客户端以及Leaft 4 Dead 2游戏中输入中文的工具（主要在FreeBSD上使用）

## 在[Minecraft聊天助手](https://github.com/m13253/minecraft-chat-helper)的基础上进行修改，仅供参考

目前，对于FreeBSD，我[无法在Left 4 Dead2中使用输入法](https://github.com/shkhln/linuxulator-steam-utils/issues/125)。
- 可以忍受在Steam中复制粘贴，但不能接受在游戏中切换全屏/工作区来复制粘贴:(

- 至少，两种动作中的一种必须消失掉，所以就有了这个！

只在FreeBSD上运行过，但我认为这应该也适用于大多数Linux发行版。

**功能：**
- 启动输入窗口后自动切换至指定的中文输入法，关闭后自动恢复为指定的英文输入法。

- 对于Left 4 Dead 2，自动切换窗口全屏状态。

- 同一时间仅允许一个脚本运行。

## 依赖
**FreeBSD和Linux:**

zenity, xclip, xdotool

脚本是为i3wm与fcitx5编写的，但它们不是必须的，如果使用其他的输入法框架和窗口管理器/桌面环境，请参考**使用方法**适当修改脚本内容。

## 使用方法
在你的窗口管理器中绑定一个快捷键来启动脚本

或者

在你的桌面环境中添加一个热键或是类似的东西来启动脚本

确保```input_tool.sh```具有可执行权限。

**可能要修改的东西：**
```
# L4D2窗口
# 使用xprop检查
W_Name="Left 4 Dead 2"
W_Class="hl2_linux"

# 输入法名称
# 查看~/.config/fcitx5/profile
InputN_ZH="pinyin"
InputN_EN="keyboard-us"

# --delay 输入延迟，太短可能会少字
xdotool type --delay 100 "$_input_tool_input"

```
**CLI上的输入法的控制程序和窗口管理器控制程序**

实际命令请等效替换为自己所使用的
```
fcitx5-remote
i3-msg
```
