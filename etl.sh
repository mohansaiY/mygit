set -x

export SVN_PATH=$1
export ETL_ENV=$2
export ETL_IMPORT=$3
export ETL_FROM_DIR=$SVN_PATH/ETL
export TARGET_DIR=$4
export checkfiles=$SVN_PATH/../checkfiles

#cd $ETL_FROM_DIR
#ls > $checkfiles/ETL.txt
EIM_LOG=/home/jenkins/jenkins/workspace/DWBI_IQE/EIM_LOGS
export ETL_LIST=$checkfiles/ETL.txt


if [ -s $ETL_LIST ]
then

for file in `cat $ETL_LIST`
do 
	echo "file name is: $file"
		if [ -f $ETL_FROM_DIR/$file ]
			then
				echo "$file is exist"
				echo " Starting the IMPORT SCRIPT"
				$ETL_IMPORT $ETL_FROM_DIR/$file $ETL_ENV $ETL_FROM_DIR $TARGET_DIR | tee -a $EIM_LOG/ETL.log 2>&1
			else
				echo "$file is not exist" | tee -a $EIM_LOG/ETL.log 2>&1
          fi



done

else
    echo -e "$ETL_LIST is not avilable or file is empty" | tee -a $EIM_LOG/ETL.log 2>&1
fi

set +x

