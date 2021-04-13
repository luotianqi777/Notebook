# Profiling 日志

## 参考资料

<https://dev.to/gabbersepp/create-a-net-profiler-with-the-profiling-api-start-of-an-unexpected-journey-198n>
<http://club.oneapm.com/t/net-profiling/805>

## 工作原理

### ICorProfilerCallback

探查器实现该接口。

### ICorProfilerInfo

告诉探查器要捕获的信息。

### (探查器)生命周期

- `ICorProfilerCallback.Initialize()`：CLR 初始化并加载分析器后调用，是**配置探查器的唯一位置**。
- `ICorProfilerCallback.Showdown()`：程序关闭时调用。

#### 探查器配置方法

- 添加`include<corprof.h>`
- 添加`CComQIPtr<ICorprofilerInfo[num]> ICorprofilerInfo`
- 添加`pICorProfilerInfoUnk->QueryInterface(IID_ICorProfilerInfo[num],(LPVOID*)&iCorProfilerInfo)`到`Initialize()`

- 通过`ICorprofilerInfo`设置事件过滤
  例如：

  > ```cpp
  > iCorProfilerInfo->SetEventMask(COR_PRF_MONITOR_EXCEPTIONS);
  > ```

  可设置的[事件枚举类型](https://docs.microsoft.com/zh-cn/dotnet/framework/unmanaged-api/profiling/cor-prf-monitor-enumeration)。

### hook 静态方法和实例方法时的参数获取区别

[参考资料](https://www.cnblogs.com/ptfblog/archive/2011/12/16/2290735.html)

实例方法的第一个参数为实例对象的地址(大概)，因此在 hook 时要比静态方法多一个参数。

### .net core 探查器

[参考资料](https://github.com/dotnet/runtime/issues/9211)

### 另外的 Profiling 项目

[clr](https://github.com/microsoft/clr-samples)
[Hijack](https://github.com/djhohnstein/.NET-Profiler-DLL-Hijack)

### 类

[类加载](https://docs.microsoft.com/zh-cn/dotnet/framework/unmanaged-api/profiling/icorprofilercallback-classloadstarted-metho])
