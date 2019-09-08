import os
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  database="dl_project",
  user="root",
  password="****"
  )

path = '***************************audio\\unbalanced'

files = []
# r=root, d=directories, f = files
for r, d, f in os.walk(path):
    for file in f:
        if '.mp3' in file:
            cursor = mydb.cursor()
            query = ("UPDATE unbalanced_files SET file_downloaded = %s WHERE filename=%s ")
            tmp = 1
            tmp2 = str(file)
            input = (tmp, tmp2)
            cursor.execute(query,input)
            mydb.commit()
            print(file)

mydb.close()
