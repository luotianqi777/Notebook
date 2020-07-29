# Agent 端请求转发错误的说明文档

## 问题：发送请求后无响应数据

### 配置参数

> [IAST 节点地址](https://192.168.172.239:8001/#/app/node/detail/cmd_98k?id=DMHUEHFXSQADARKH&client=1)

| ip                | port   | AesKey             | AgentID            |
| ----------------- | ------ | ------------------ | ------------------ |
| `192.168.172.239` | `9090` | `WPOIVXHUZINJRDQC` | `DMHUEHFXSQADARKH` |

### 心跳 Json

```json
{
  "id": "DMHUEHFXSQADARKH",
  "ts": 1595925350,
  "msg": {
    "client_info": {
      "version_pocs": 0,
      "version_main": 3010015,
      "ip": "192.168.172.146",
      "language": "java",
      "language_version": "1.8.131",
      "server": "Tomcat",
      "server_version": "8.5.5"
    },
    "cmd": 9001
  }
}
```

### 向服务端发送的 json 数据

```json
{
  "id": "DMHUEHFXSQADARKH",
  "aes": "TybzmhImjm9jEhE4sv/qka51HOnWUEchovg/1THV4hsepKC0U9Fqd3AM+VO4+rIkYPI43B6oRaGQt/Y26N1ClGRpHVfMIz3Xnn5DrL2j3vF3J8e54dS/Gi3WE2YFt21kuKJ/Jq2faii2PQJ8NRSBciez+MxBwQ31GFSPgnXbtBBQLjoh7Iikq/jRxwyyEFYLUr2eSllCBctZTs94UcaKZJdMXlukNQWnFYFuZDNvAkt2zuvzDcF7zm48Ds0v6aWH9qsRhQuUWnHkhazJ1RG71qEnlXdce3y5QyMr/PzTcV+dDlE3EQ==",
  "aestag": "3MIzxS8ldwoOTCGpJWK1wQ==",
  "aesnonce": "ee/p5ORQziT18dUM"
}
```

- `aes`的值为请求转发的 json 数据经`AesGcm`格式加密后的字节流转为`Base64`后的字符串
- `aestag`的值为加密算法计算出的`16bit`大小的字节组转为`Base64`后的字符串
- `aesnonce`的值为`12bit`大小的随机字节组转为`Base64`后的字符串，随机字节组用做加密算法的`nonce`
- 将 json 数据按`utf8`格式转码为字节流并在头部加入`4bit`大小的字节组存入后续字节流大小
- 经大神测试`AesGcm`加密没有问题

### 抓包数据如下

![抓包图片](TCP.png)

发送的数据总长度`412`，前四个字节`00 00 01 98`=`408`，为后续数据长度。

### 正确心跳 Json

```json
{
  "id": "DXGVUYDRJZDKBVIL",
  "ts": 1595935997,
  "msg": {
    "client_info": {
      "version_main": 3010016,
      "version_pocs": 0,
      "ip": "192.168.91.1",
      "language": "Java",
      "language_version": "1.8.0_131",
      "server": "Apache Tomcat",
      "server_version": "8.5.38",
      "req_num": 0
    },
    "cmd": 9001
  }
}
```

### 修改后的心跳 Json(仍然无回复)

```json
{
  "id": "DXGVUYDRJZDKBVIL",
  "ts": 1595935997,
  "msg": {
    "client_info": {
      "version_main": 3010016,
      "version_pocs": 0,
      "ip": "192.168.91.1",
      "language": "Java",
      "language_version": "1.8.0_131",
      "server": "Apache Tomcat",
      "server_version": "8.5.38",
      "req_num": 0
    },
    "cmd": 9001
  }
}
```

### 正常返回的 Json

```json
{
  "id": "45h65jm23f4j23JG",
  "ts": 1595935999,
  "msg": {
    "sinfo": { "dirtyblock": "false", "mode": "active", "switch": "off" },
    "plugin_info": [],
    "dns_info": [],
    "hosts_info": [],
    "vpn_info": {
      "ports": [80, 443],
      "psk": "default_psk",
      "ups": { "default_user": "default_password" }
    },
    "proxy_info": []
  }
}
```
