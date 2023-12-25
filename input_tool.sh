# The MIT License (MIT)
#
# Copyright (c) 2014 Star Brilliant <m13253@hotmail.com>
# Copyright (c) 2023 oblivcheck (github.com/oblivcheck/steam_input_tool)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

#!/bin/bash

# L4D2窗口
# 使用xprop检查
W_Name="Left 4 Dead 2"
W_Class="hl2_linux"

# 输入法名称
# 查看~/.config/fcitx5/profile
InputN_ZH="pinyin"
InputN_EN="keyboard-us"

# 确保只有一个脚本在运行
if [ -e /tmp/_input_tool.lock ]; then
	exit 0
fi
touch /tmp/_input_tool.lock

set e
_input_tool_title=$RANDOM
touch /tmp/_input_tool_title
echo "$_input_tool_title" > /tmp/_input_tool_title

if(xdotool getwindowfocus getwindowname | grep -q "$W_Name") && [ "$(xdotool getwindowfocus getwindowclassname)" = "$W_Class" ]; then
	i3-msg fullscreen disable
fi

which zenity &>/dev/null || (echo '错误：zenity 程序未安装。' >&2; exit 2)
which xdotool &>/dev/null || (echo '错误：xdotool 程序未安装。' >&2; zenity --error --text '错误：xdotool 程序未安装' --title 'Input Tool'; exit 2)

(
_input_tool_title=$(cat /tmp/_input_tool_title)
_input_tool_count=0
while [ $_input_tool_count -lt 5 ]; do
    if(xdotool getwindowfocus getwindowname | grep -q "$_input_tool_title"); then
        fcitx5-remote -s ${InputN_ZH}
	# 即便这样也还是切换快了？
	#break
    fi

    sleep 0.1
    ((_input_tool_count++))
done
) &
_input_tool_input="$(zenity --entry --text '-----------------------------在下面输入想要输入的内容----------------------------' --title "Input Tool $_input_tool_title")"
test -z "$_input_tool_input" && rm /tmp/_input_tool.lock && exit 0
xdotool type --delay 10 "$_input_tool_input"
fcitx5-remote -s ${InputN_EN}

if(xdotool getwindowfocus getwindowname | grep -q "$W_Name") && [ "$(xdotool getwindowfocus getwindowclassname)" = "$W_Class" ]; then
	i3-msg fullscreen enable
fi

rm /tmp/_input_tool.lock
