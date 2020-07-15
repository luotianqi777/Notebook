# 总计划

```mermaid
gantt
dateFormat MM-DD
title 总计划
section 研究
hook方式研究: done, hook_find, 06-22, 3d
假期+检测: done, holiday, after hook_find, 5d
hook位置研究: done, hook_location, after holiday, 6d
承载启动研究: done, startup ,after holiday, 6d
section 开发
demo实现: done, hook_impl, after startup, 3d
数据转发: active, data_send, after hook_impl, 2d
漏洞检测: bug_check, after data_send, 4d
```

## 今日计划

```mermaid
gantt
dateFormat  HH:mm
title 今日计划
查找相关项目: 09:00, 14:00
查找插件配置方式: 14:00, 21:00
```

### 优先进行的计划

- [ ] 写一个DLL加载工具
  - [x] 读取项目依赖
  - [x] 派生HarmongPatchAttribute，减少代码冗余
  - [x] **实现动态加载DLL**
    - [x] 找到依赖对应dll类库的路径
    - [x] 解决Patch找不到dll路径后Prefix会报错的问题(修改Harmony源码)
    - [x] 参考`SkyApm`的做法
  - [x] 对一个方法只需要在一个类中进行配置(利用Attribute)
  - [ ] ParamType列表处理方式要好好想想
- [ ] 插件配置方式(Nuget包 or 插件独立发布 or 插件依赖框架)
- [ ] **`Context`传递**
  - [x] 通过承载启动注册一个注册中间件的服务(但不确定服务的参数中能不能找到注册方法)
  - [x] 找到asp.net源码中底层配置中间件的方法去hook
  - [x] 找到http的方法去hook
  - [ ] 找类似项目学习经验
- [x] **函数调用栈**
  - [x] 可以打印，但也含有`Agent`端信息
  - [ ] 去除`Agent`端信息
  - [ ] 去除依赖`dll`的信息

### 暂时搁置的计划

- [ ] [发布后未加载程序集](https://docs.microsoft.com/zh-cn/aspnet/core/fundamentals/host/platform-specific-configuration?view=aspnetcore-3.1)
  - [ ] 加载顺序:`ConfigureAppConfiguration`还是`UseConfiguration`
  - [ ] 指定承载启动程序集设置环境变量`HostingStartupLibrary;HostingStartupPackage;StartupDiagnostics`
  - [ ] 承载启动激活选项
    - [ ] 运行时存储
    - [ ] NuGet包
- [ ] 线程上下文同步(`harmony`自带的`state`参数 or [通过C#实现](https://lindexi.gitee.io/post/C-dotnet-%E8%87%AA%E5%B7%B1%E5%AE%9E%E7%8E%B0%E4%B8%80%E4%B8%AA%E7%BA%BF%E7%A8%8B%E5%90%8C%E6%AD%A5%E4%B8%8A%E4%B8%8B%E6%96%87.html))
