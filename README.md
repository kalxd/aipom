Aipom
=====

一个小型静态服务程序，目标代替python的`http.server`模块。

# 帮助 #

```bash
$ aipom -h
Aipom [ <option> ... ]
 where <option> is one of
  -p <端口>, --port <端口> : 开放端口
  -d <目录>, --dir <目录> : 静态服务文件目录
  --help, -h : Show this help
  -- : Do not treat any remaining argument as a switch (at this level)
 Multiple single-letter switches can be combined after one `-'; for
  example: `-h-' is the same as `-h --'
```

# 用起来的样子 #

```
XGLey@DESKTOP-4JQV3CJ ~/C/W/Sample> aipom
Your Web application is running at http://localhost:8000.
Stop this program at any time to terminate the Web Server.
GET / - 200
GET /layui/css/layui.css - 200
GET /layui/layui.js - 200
GET /layui/lay/modules/element.js - 200
GET /layui/lay/modules/jquery.js - 200
```

# license #

GPL v3
