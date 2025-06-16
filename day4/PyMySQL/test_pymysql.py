import pymysql
import pymysql.cursors

# (1) db connection
connection = pymysql.connect(
    host = '127.0.0.1',
    user='root',
    password='-',
    db='classicmodels',
    charset='utf8mb4',
    cursorclass=pymysql.cursors.DictCursor
    # DictCursor 사용하면 결과값이 딕셔너리 형태로 저장됨
    # 이 부분을 생략하면 튜플로 값을 받아옴 => key값이 없어 인덱스 값으로 접근해야함
    # 그리고 튜플은 json으로 바꾸는 등 형변환에 제한이 많음
)



# (2) CRUD

## 1. SELECT * FROM
def get_customers():
    cursor = connection.cursor()

    sql = "SELECT * FROM customers"
    cursor.execute(sql)

    customers = cursor.fetchone()
    # 값을 하나만 가져오고 싶으면 fetchone(), 전부 가져오고 싶으면 fetchall()

    print('customers : ', customers)
    print('customer Number : ', customers['customerNumber'])
    print('customer Name : ', customers['customerName'])
    print('customer country: ', customers['country'])
    
    cursor.close()


## 2. INSERT INTO
# 하기 전에 NOT NULL 설정 해제해준 다음 일부 데이터만 넣어줄 거임
def add_customers():
    cursor = connection.cursor()

    name = 'juhyun'
    family_name = 'jung'
    sql = f"INSERT INTO customers(customerNumber, customerName, contactLastName) VALUES(10000, '{name}', '{family_name}')"
    cursor.execute(sql)
    connection.commit() # 데이터베이스에 변경사항 적용
    cursor.close()


## 3. UPDATE INTO
def update_customer():
    cursor = connection.cursor()
    update_name = 'update_juhyun'
    contactLastName = 'update_jung'

    sql = f"UPDATE customers SET customerName = '{update_name}', contactLastName = '{contactLastName}' WHERE customerNumber = 10000"

    cursor.execute(sql)
    connection.commit()
    cursor.close()
    

## DELETE FROM
def delete_customer():
    cursor = connection.cursor()
    sql = "DELETE FROM customers WHERE customerNumber = 10000"
    cursor.execute(sql)
    connection.commit()
    cursor.close()

delete_customer()