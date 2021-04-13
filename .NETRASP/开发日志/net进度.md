# net Iast Agent 进展

**前面都是一些网站**
**进展在最后**

## net Hook 理论

[注入方法理论](https://zhuanlan.zhihu.com/p/61464591)

## 一开始打算借助 Harmony 通过承载启动进行 hook

> 借助 Harmony 通过承载启动也许不可行
> 原因是承载启动需要重新编译后才可以整合到项目中
> 突破口也是找有没有不重新编译就可以整合到项目的办法，这涉及到 netCore 的运行机制

[Apm 探针设计理念](https://zhuanlan.zhihu.com/p/103456434)
[Harmony 文档](https://github.com/pardeike/Harmony/wiki)
[在.netCore 中使用承载启动](https://docs.microsoft.com/zh-cn/aspnet/core/fundamentals/host/platform-specific-configuration?view=aspnetcore-3.1)
[通过承载启动注册中间件间接实现 http 请求 hook](https://stackoverflow.com/questions/62990363/how-to-register-middleware-in-hostingstartup)

## profiling

[通过 profiling 来实现 apm 原理](https://www.cnblogs.com/caozhiyuan/p/10352650.html)
[Profiling API](https://docs.microsoft.com/zh-cn/dotnet/framework/unmanaged-api/profiling/profiling-interfaces)
[Microsoft 发布的 Profiler 框架(.net 和.netCore)](https://github.com/microsoft/clr-samples)
[还算友好的 Profiling 学习教程](https://dev.to/gabbersepp/how-does-a-net-profiler-work-49e5)
[使用 C#(等托管语言)编写 Profiling API 不可行，只能在 C++(非托管语言)中编写](https://stackoverflow.com/questions/5736845/is-is-possible-to-use-profiling-api-right-from-c)
[hook 过程中静态方法与实例方法的参数位置不同](https://www.cnblogs.com/ptfblog/archive/2011/12/16/2290735.html)

## 在探查器中通过反射调用 dotnet 库

[在 C++中使用.net](https://www.cnblogs.com/bluedoctor/p/6362908.html)
[在非托管 C++中使用.net](https://www.cnblogs.com/xfuture/p/3728417.html)
[c++/clr 简介](https://zhuanlan.zhihu.com/p/33450706)

## 最终的进展

目前主要开发两个 dll：

- `profiler`: 对 net 程序进行 hook
- `netReflectDLL`:使用反射调用 net 的内容

1. 现在可以在 `profiler` 中对方法进行 hook，拿到其参数地址，并可以调用 `netReflectDLL` 来间接的实现 net 反射。
2. 本打算通过参数地址转为 net 对象，但无法由指向 net 对象的 C++指针转为 `Object^`托管指针，这就不能通过反射解析得到的参数。
3. 也考虑过不使用反射，仅仅使用 C++结构体来直接解析参数，参数是基础数据类型和简单的数据结构时还可以，一旦遇到了复杂的数据结构（比如 `httpRequest`这种)，手动解析难度太大了，基本就只能猜成员变量在内存中的排序，甚至连成员变量究竟有几个都搞不清楚。
