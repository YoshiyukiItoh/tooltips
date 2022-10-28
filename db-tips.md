# (PostgreSQL)DB,USER作成

```
create database user1;
CREATE USER user1 WITH PASSWORD 'user1';
grant user1 to postgres;
create schema user1 authorization user1;
\dn
```

# (Oracle)表領域、ユーザ作成

```
create bigfile tablespace user1 datafile '/oradata/USER1/user1.dbf' size 100M;
create temporary tablespace user1temp tempfile '/oradata/USER1/user1temp.dbf' size 100M;
create user user1 identified by user1 default tablespace user1 temporary tablespace user1temp;
grant resource to user1;
grant connect to user1;
alter user user1 quota unlimited on user1;
```

# (PostgreSQL)invalid index確認

```
SELECT pg_class.relname 
FROM pg_class, pg_index 
WHERE pg_index.indisvalid = false 
AND pg_index.indexrelid = pg_class.oid;
```

# (Oracle)alertログに時刻を付与する

```
awk 'begin{t=""}; {if (match($0, /^....-..-..T..:..:..\.......\+..\:..$/)){t=$0} else {printf("%s | %s\n",t,$0)}}' <アラートログファイル名>
```

# (Oracle)自動オプティマイザ統計収集

ref. https://haradago.hatenadiary.org/entry/20090917/p1

## 統計情報の自動収集を無効にする。

```
exec DBMS_SCHEDULER.DISABLE('GATHER_STATS_JOB');
```

## ジョブスケジュールに登録されているジョブを調べる(GATHER_STATS_JOBが自動統計情報を示す)

```
select JOB_NAME ,ENABLED from DBA_SCHEDULER_JOBS;
```

また、以下のＳＱＬでテーブルごとに自動収集の有効・無効を指定することもできる。


## 指定したテーブルのみ自動統計情報を無効にする。

```
exec dbms_stats.lock_table_stats('SCOTT','tblHoge');
```

## 指定したテーブルのみ自動統計情報を有効にする。

```
exec dbms_stats.unlock_table_stats('SCOTT','tblHoge');
```

## テーブルごとの自動統計情報収集の有効・無効を確認するSQL。

```
select TABLE_NAME ,STATTYPE_LOCKED from USER_TAB_STATISTICS;
```

# Oracle RACのインターコネクトネットワーク設計について
RAC 環境における gc block lost やネットワークパフォーマンス低下のトラブルシューティング (Doc ID 2215983.1)

# (Oracle)便利SQLページ
https://oracle-base.com/dba/scripts

# (Oracle)チューニング対象のSQLを確認する
http://oracledba-memo.com/oracle/sql%E6%96%87%E9%96%A2%E9%80%A3/%E3%83%81%E3%83%A5%E3[…]0%E5%AF%BE%E8%B1%A1sql%E6%96%87%E3%81%AE%E7%A2%BA%E8%AA%8D/

# (Oracle)カーソルまわりの話し
https://kita-note.com/oracle-cursor

# (Oracle)

```
# SQLがわかる場合
select sql_text, sql_id from v$sql where sql_text like '%test1%';

# SQLがアプリから実行されていてわからない場合。v$sessionで頑張る
select sid, serial# , username, status, SQL_id, prev_sql_id
from v$session
where (sql_id is not null or prev_sql_id is not null)
and username like '<ユーザ名>'

```

