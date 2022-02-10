#!/bin/bash
function parse {
  BACKUP_PATH=$1
  NAME=$2
  MESSAGE=$3
  MESSAGE_FILENAME="./temp/${MESSAGE}tb.txt"
  MESSAGE_REGEX="${MESSAGE}.\{1,3\}\[.\{1,6\}\]\+"
  count=0
  total=0
  max=0
  /bin/sudo /bin/cat ${BACKUP_PATH} | /bin/grep "$NAME" | /bin/grep -o $MESSAGE_REGEX > $MESSAGE_FILENAME 
  for i in $( /bin/awk -F'[][]' '{print $2}' $MESSAGE_FILENAME )
    do 
      total=$(echo $total+$i | /bin/bc )
      ((count++))
      if [ $(echo "$max<=$i" | /bin/bc) -ge 1 ] 
        then 
          max=$i
        fi
    done
  if [ $total == 0 ]
    then
      echo "$NAME ${MESSAGE}: 0 messages"
    else
      echo "$NAME ${MESSAGE}: average in minute is $(echo "scale=2; $total / $count" | /bin/bc ) "
      echo "$NAME ${MESSAGE}: max in minute is $max "
  fi
}

BACKUP_PATH="/var/log/thingsboard/thingsboard.log"
TOTAL='totalMsgs' 
SUCCESSFUL='successfulMsgs' 
FAILED='failedMsgs'
REQUESTS='requests'
FAILURES='failures'
TOTAL_ADDED='totalAdded'

/bin/mkdir -p temp
parse $BACKUP_PATH TbRuleEngineConsumerStats $TOTAL
parse $BACKUP_PATH TbRuleEngineConsumerStats $SUCCESSFUL
parse $BACKUP_PATH TbRuleEngineConsumerStats $FAILED
parse $BACKUP_PATH "JS.Invoke.Stats" $REQUESTS
parse $BACKUP_PATH "JS.Invoke.Stats" $FAILURES
parse $BACKUP_PATH CassandraBufferedRateExecutor $TOTAL_ADDED
parse $BACKUP_PATH TbSqlBlockingQueue $TOTAL_ADDED
/bin/sudo /bin/rm -r ./temp/*tb.txt