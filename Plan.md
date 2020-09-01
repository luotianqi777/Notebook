# 总计划

```mermaid
gantt
dateFormat MM-DD
title 开发进度安排
section 请求转发
请求转发: active, 07-23, 5d
心跳: active, 4d
section 漏洞检测
文件: 5d
xxe: 2d
xss: 2d
SSRF: 2d
命令: 3d
section 自动化安装
自动化安装: 4d
section 日志文件
日志文件: 3d
```

## 优先进行的计划

- [x] 实现请求转发
- [x] 心跳
- [x] 测试漏洞检测
- [ ] 开发漏洞检测
  - [x] Sql 注入
  - [ ] 命令注入
  - [x] 文件读取
  - [x] 文件写入
  - [ ] 文件上传
  - [x] XXE
  - [x] SSRF
  - [ ] XSS
- [ ] 自动化安装
- [x] 日志文件
- [x] 配置文件
