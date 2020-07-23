# 总计划

```mermaid
gantt
dateFormat MM-DD
title 研究规划
section 研究
hook研究: done, hook_find, 06-22, 3d
假期+检测: done, holiday, after hook_find, 5d
hook位置研究: done, hook_location, after holiday, 6d
承载启动研究: done, startup ,after holiday, 6d
section 演示
demo实现: done, hook_impl, after startup, 5d
http请求获取: done, data_send, after hook_impl, 10d
检测demo: done, bug_check, after data_send, 3d
```

```mermaid
gantt
dateFormat MM-DD
title 开发规划
section 请求转发
请求转发: active, request, 07-23, 4d
section 漏洞检测
命令执行: cmd_exec, after request, 2d
文件: file, after cmd_exec, 4d
SSRF: ssrf, after file, 2d
xxe: xxe, after ssrf, 2d
xss: xss, after xxe, 2d
section 心跳
心跳: doki, after xss, 4d
section 自动化安装
自动化安装: auto, after doki, 5d
section 日志文件
日志文件: log, after auto, 3d
section 配置文件
配置文件: configure, after log, 3d
```

## 今日计划

```mermaid
gantt
dateFormat  HH:mm
title 今日计划
请求转发: 09:00,21:00
```

### 优先进行的计划

- [ ] 实现请求转发
- [ ] 测试漏洞检测
- [ ] 开发漏洞检测
  - [ ] 命令执行
  - [ ] 文件相关
  - [ ] SSRF
  - [ ] XXE
  - [ ] XSS
- [ ] 心跳
- [ ] 自动化安装
- [ ] 日志文件
- [ ] 配置文件

### 暂时搁置的计划

- [ ] 写一个 DLL 加载工具
  - [x] 读取项目依赖
  - [x] 派生 HarmongPatchAttribute，减少代码冗余
  - [x] **实现动态加载 DLL**
    - [x] 找到依赖对应 dll 类库的路径
    - [x] 解决 Patch 找不到 dll 路径后 Prefix 会报错的问题(修改 Harmony 源码)
    - [x] 参考`SkyApm`的做法
  - [x] 对一个方法只需要在一个类中进行配置(利用 Attribute)
  - [ ] ParamType 列表处理方式要好好想想
- [ ] 插件配置方式(Nuget 包 or 插件独立发布 or 插件依赖框架)
- [x] **函数调用栈**
  - [x] 可以打印，但也含有`Agent`端信息
  - [ ] 去除`Agent`端信息
  - [ ] 去除依赖`dll`的信息
- [ ] [发布后未加载程序集](https://docs.microsoft.com/zh-cn/aspnet/core/fundamentals/host/platform-specific-configuration?view=aspnetcore-3.1)
  - [ ] 加载顺序:`ConfigureAppConfiguration`还是`UseConfiguration`
  - [ ] 指定承载启动程序集设置环境变量`HostingStartupLibrary;HostingStartupPackage;StartupDiagnostics`
  - [ ] 承载启动激活选项
    - [ ] 运行时存储
    - [ ] NuGet 包
