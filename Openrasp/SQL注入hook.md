# SQL注入Hook点分析

## Hook点

- `execute`
- `executeUpdate`
- `executeQuery`
- `addBatch`

> 所有SQL注入攻击最后都要通过上述方法之一。

## Hook获取的信息

- 执行的SQL语句（主要）
- 执行语句的Statement对象
- 数据库类型

## 检查是否为污点数据

### 识别逻辑是否发生改变

- 用户的某一个输入中是否含有多个token

例：`select * from table where a=?;`

- 合法输入: `a=abc` token:`abc`
- 非法输入: `a=abc or 1=1 ;--` token:`abc`,`or`,`1`,`=`,`1`,`;`,`--`
- 非法输入: `a=abc and false` token:`abc`,`and`,`false`
- 非法输入: `a=abc from 0x141249515` token:`abc`,`from`,`0x141249515`

### 语句策略检查(模拟防火墙)

- select`(,|null|[0-9]){5,}`
- `;`
- `0x`
- `/*!`
- `blackList function`(
- into `file`
- from `table`

### 记录数据库异常

> - $1060$, // Duplicate column name '5.5.60-0ubuntu0.14.04.1'
> - $1062$, // Duplicate entry '::root@localhost::1' for key 'group_key'
> - $1064$, // You have an error in your SQL syntax
> - $1105$, // XPATH syntax error:  '\~root@localhost\~'
> - $1367$  // Illegal non geometric 'user()' value found during parsing

### SQL正则表达式匹配关键字

> `union.*select.*from.*information_schema`
