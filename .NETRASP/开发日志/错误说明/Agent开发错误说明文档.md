# Agent 端请求转发错误的说明文档

## 问题：发送请求后无响应数据

### 配置参数

> [IAST 节点地址](https://192.168.172.239:8001/#/app/node/detail/cmd_98k?id=DMHUEHFXSQADARKH&client=1)

| ip                | port   | AesKey             | AgentID            |
| ----------------- | ------ | ------------------ | ------------------ |
| `192.168.172.239` | `9090` | `WPOIVXHUZINJRDQC` | `DMHUEHFXSQADARKH` |

### 转发的 request 请求包装后的 json 信息

```json
{
  "id": "DMHUEHFXSQADARKH",
  "ts": 1595897468,
  "msg": {
    "result": {
      "urls": [
        {
          "method": "GET",
          "url": "https://localhost:5001/",
          "data": "",
          "headers": {
            "Cookie": null,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
            "Upgrade-Insecure-Requests": "1",
            "Connection": null,
            "Referer": null,
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36",
            "Host": "localhost:5001",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"
          },
          "iastrange": ["sql"]
        }
      ]
    },
    "cmd": 4001
  }
}
```

### 向服务器发送的 json 数据

```json
{
  "id": "DMHUEHFXSQADARKH",
  "aes": "zZkphDKgJU0d2DL0E19ZjN6qV7lZ3/h6IlmGFYiIEMxXYe9cB7DIglH4GO1GGutHiug9JK1mUntYEfNClJCQwXqjNGjBJJAtxnhvynFhrxp/CQmBupyUk2FopXT587rREeByUJrcM2G7Y0aS9GcLwndc2HJdVM7qpdvEyMOJuSzwaXcYdBy15icWH8bOptqSoJNNmKrskndpV6dTFwaF/3yrH/a/gaaAwLLwsPBs8CoNcw8kzZXPKh3DIl7pzJUZbbjCUJsMkUHZJdro41Zs7Ckle/lCOAVfsQMugCp0whR/Bm3SYkliuFMtjdnJzMpXc48asJcLlxBjDnkwPZRbe3IcANVldPw2EtOlrxBzOEokY8yQbfRjuXKyOss1zzX2OwGIqEYYW4RFbIa27k3vggse19Aid6jBp1J0apjBaSWwWxWJdimFLFyNUqVQUbGyv+gaLf5mk2J9orR0BXH21IWGtBEHShu8Mwp6VP8kDIOXCK664P4zDCqF/szyNNxb9ybl4rmB9IsCumdQaZyu6NYYuvKi9AnSZH+d0A/7ud4UOcrQgqLnioiY7/z1EfoKekDtLk6/7Z04ppXmeivkDqsVnXAC2lNNbwpbkxLP/KU9bja++kSEVInrs2Ef3BD7fQFtZ+fH/7mPkWpMOLhD91fb9aWq/43lKyMmF4UVHoxffAKAFDBD8NiFTbQjBret6TY291kJZBquCWuIOhaj0c+Zbht1RBtuUQopWruYuJdxmmkloUP5/1BHwjjQ2o7fgQTK0UPBIMvkQ6169CC7Lwflp8UUe+9YhqndIHmGp5dY0cRGay3HNtO/ZYgyIQ==",
  "aestag": "0x+kvLiYUAxwdb3Wwp9OIA==",
  "aesnonce": "PJzkhVdshrAOfBY5"
}
```

- `aes`的值为请求转发的 json 数据经`AesGcm`格式加密后的字节流转为`Base64`后的字符串
- `aestag`的值为加密算法计算出的`16bit`大小的字节组转为`Base64`后的字符串
- `aesnonce`的值为`12bit`大小的随机字节组转为`Base64`后的字符串，随机字节组用做加密算法的`nonce`
- 将 json 数据按`utf8`格式转码为字节流并在头部加入`4bit`大小的字节组存入后续字节流大小

### 抓包数据如下

![抓包图片](抓包数据.png)

发送的数据总长度`936`，前四个字节`0x03a4`=`932`，为后续数据长度。

### 心跳 Json

```json
{
  "id": "DMHUEHFXSQADARKH",
  "ts": 1595908415,
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
