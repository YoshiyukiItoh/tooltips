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

