from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_USER']='dbadmin'
app.config['MYSQL_PASSWORD']= ''
app.config['MYSQL_HOST']= '10.30.0.3'
app.config['MYSQL_DB']= 'todo'
app.config['MYSQL_CURSORCLASS']= 'DictCursor'

mysql = MySQL(app)


@app.route('/' , methods =['GET'])
def users(todo):
    cur = mysql.connection.cursor()
    if todo is not None:
        cur.execute('''insert into todo (user, todo) values (1, '''+todo+''')''')
        mysql.connection.commit()
    cur.execute('''SELECT * FROM todo''')
    rv = cur.fetchall()
    return str(rv)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='80', debug=True)
