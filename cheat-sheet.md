# (Windows)Powershellでpingに日時を付ける

```
ping -t [IPアドレス] | %{(Get-Date).ToString() + " $_"}
```

# (Linux)shellでpingに日時を付ける

```
ping [宛先] | awk '{print strftime("%Y/%m/%d %H:%M:%S"), $0}'
```

# (Linux)過去タイムスタンプのディレクトリを作成する(テスト用)

```
function mktouch() {
  DIR=$1
  DIRPATH=`dirname ${DIR}`
  DIRNAME=`basename ${DIR}`
  mkdir ${DIRPATH}/${DIRNAME}
  touch -amt "${DIRNAME:0:12}.${DIRNAME:12}" ${DIRPATH}/${DIRNAME}
}
```

# (Oracle)ASMディスク毎の利用率を確認する。

```
col NAME for a15
col PATH for a20

select NAME, PATH, ROUND(TOTAL_MB/1024,2) as TOTAL_GB, ROUND(FREE_MB/1024,2) as FREE_GB  from v$asm_disk;
```

# (Oracle)ASMの空き領域

```
col NAME FORMAT a5
select group_number,name,state,type,total_mb as "TOTAL(MB)", free_mb as "FREE(MB)" ,round(free_mb/total_mb,4)*100 as "FREE(%)" from v$asm_diskgroup;
```

# (Oracle)レコード件数カウント

```
DECLARE
    NUM_COUNT NUMBER;
BEGIN
    FOR CUR IN (SELECT * FROM USER_TABLES) LOOP
        EXECUTE IMMEDIATE 'SELECT COUNT(*) INTO :NUM_COUNT FROM ' ||
        CUR.TABLE_NAME INTO NUM_COUNT;
        DBMS_OUTPUT.PUT_LINE(
        CUR.TABLE_NAME || ' : ' || NUM_COUNT || '件');
    END LOOP;
END;
/
```

# (Oracle)メンテナンスタスク確認

```
select * from dba_autotask_window_clients
```

# (Oracle)統計情報(ロックステータス / 最終取得)

```
SELECT TABLE_NAME, NUM_ROWS, STATTYPE_LOCKED, LAST_ANALYZED FROM USER_TAB_STATISTICS;
```

# (Oracle)10053trace取得

```
alter session set max_dump_file_size = UNLIMITED;
alter session set events '10053 trace name context forever, level 1';
<SQL実行>
alter session set events '10053 trace name context off';
exit
```

