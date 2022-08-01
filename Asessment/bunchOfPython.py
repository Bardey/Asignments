import psycopg2
import random
from datetime import datetime, date, timedelta
from random_username.generate import generate_username
import string
from dateutil import relativedelta


def randIdGen(digits):
    return random.randint(10 ** (digits - 1), 10 ** digits)


def randDateTimeGen(startYear, endYear):
    inicio = datetime(startYear, 1, 1)
    final = datetime(endYear, 12, 31)
    random_datetime = inicio + (final - inicio) * random.random()
    return random_datetime

def initRandDate(start_date):
    random_date = start_date + (datetime.now().date() - start_date) * random.random()
    return random_date

def randDateGen(datetimein):
    return datetimein.date()


def randusernameGen():
    return generate_username()[0]


def randPwGen(length=8):
    characters = string.ascii_letters + string.digits + string.punctuation
    return "".join(random.sample(characters, length))

def courseDuration(seconds):

    # Use the below code if you want it in a string
    return timedelta(seconds=seconds)


def completeDuration(startTime, endTime):
    diff = relativedelta.relativedelta(startTime, endTime)

    years = diff.years
    months = diff.months
    days = diff.days
    hours = diff.hours
    minutes = diff.minutes
    seconds = diff.seconds

    return '{}Y-{}M-{}D-{}h-{}m-{}s'.format(years, months, days, hours, minutes, seconds)


def randCourseName():
    with open('courses.txt') as file:
        return random.choice([x for x in file])


def randTagName(numOfWords):
    with open('randWords.txt') as file:
        tagString = ""
        for i in file:
            for j in range(numOfWords):
                tagString += "#" + random.choice([x for x in i.split(', ')]) + " "

        return tagString

def manual_insert_employee(user_id =randIdGen(8), employee_num = randIdGen(5),
                           creation_date=datetime.now().date(), username=None, password = None, emp_level=0):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute(
            "INSERT INTO employee (user_id, employee_num, creation_date, username, pw, emp_level) VALUES (%s, %s, %s, "
            "%s, %s, %s); ",
            (user_id, employee_num, creation_date, username, password, emp_level))
    conn.commit()
    cur.close()
    conn.close()

def insertEmployee(numRows):

    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    for i in range(numRows):
        cur.execute("INSERT INTO employee (user_id, employee_num, creation_date, username, pw, emp_level) VALUES (%s, %s, %s, %s, %s, %s); ",
                    (randIdGen(8), randIdGen(5), randDateGen(randDateTimeGen(2001, datetime.now().year)), randusernameGen(), randPwGen(), 0))
    conn.commit()
    cur.close()
    conn.close()


    for i in range(numRows):
        cur.execute(
            "INSERT INTO employee (user_id, employee_num, creation_date, username, pw, emp_level) VALUES (%s, %s, %s, %s, %s, %s); ",
            (randIdGen(8), randIdGen(5), randDateGen(randDateTimeGen(2001, datetime.now().year)), randusernameGen(),
             randPwGen(), 0))

    conn.commit()
    cur.close()
    conn.close()



def manual_platform(platform_id=randIdGen(3), platform_name=None, hyper_path=None):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute("INSERT INTO platform (platform_id, platform_name, hyper_path) VALUES (%s, %s, %s); ",
                (platform_id, platform_name, hyper_path))
    conn.commit()
    cur.close()
    conn.close()


def createPlatform():
    with open('platforms.txt') as file:
        for x in file:
            conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
            cur = conn.cursor()
            cur.execute("INSERT INTO platform (platform_id, platform_name, hyper_path) VALUES (%s, %s, %s); ",
                (randIdGen(3), x, "www.{}.com".format(x.lower().replace(" ", "").strip())))
            conn.commit()
            cur.close()
            conn.close()


def manual_insert_courses(course_id=randIdGen(4), course_name=randCourseName(), platform_id=None, duration=None, create_date=datetime.now().date(), tags=None):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()

    cur.execute(
        "INSERT INTO course (course_id, course_name, platform_id, duration, create_date, tags) VALUES (%s, %s, %s, %s, %s, %s); ",
        (course_id, course_name, platform_id, duration, create_date, tags))

    conn.commit()
    cur.close()
    conn.close()
def insertCourses(numRows):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    def getplatform():
        cur.execute("SELECT platform_id FROM platform")
        rec = random.choice(cur.fetchall())
        return rec

    for i in range(numRows):
        cur.execute("INSERT INTO course (course_id, course_name, platform_id, duration, create_date, tags) VALUES (%s, %s, %s, %s, %s, %s); ",
            (randIdGen(4), randCourseName(), getplatform(), courseDuration(random.randint(1800,288000)),
             randDateGen(randDateTimeGen(2010, datetime.now().year)), randTagName(5)))
    conn.commit()
    cur.close()
    conn.close()



def manual_ongoing_training(training_id=randIdGen(5), user_id=randIdGen(8), course_id=randIdGen(4),
                            status="in progress", complete_percentage=None,
                            start_date=datetime.now().date(), finish_date=None, last_updated=None):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()

    cur.execute(
        "INSERT INTO ongoing_training (training_id, user_id, course_id, status, complete_percentage, start_date, finish_date, last_updated) VALUES (%s, %s, %s, %s, %s, %s, %s, %s); ",
        (training_id, user_id, course_id, status, complete_percentage, start_date, finish_date, last_updated))

    conn.commit()
    cur.close()
    conn.close()
def ongoing_training(rowNum):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    def rand_percentage():
        my_list = [100, random.randint(1,50), random.randint(51,70), random.randint(71, 90), random.randint(91,99)]
        return random.choices(my_list, weights=(60, random.randint(1,75),
                                                random.randint(1,75), random.randint(1,75), random.randint(1,75)), k=1)[0]

    for i in range(rowNum):
        cur.execute("SELECT employee.user_id, employee.creation_date FROM employee;")
        rec = random.choice(cur.fetchall())
        u_id = rec[0]
        join_date = rec[1]
        cur.execute("SELECT course_id FROM course;")
        c_id = random.choice(cur.fetchall())[0]
        percentage = rand_percentage()
        status = "in progress"
        start_date = initRandDate(join_date)
        end_date = None
        last_updated = initRandDate(start_date)
        if percentage == 100:
            status = "completed"
            end_date = initRandDate(start_date)
            last_updated = end_date

        cur.execute("INSERT INTO ongoing_training (training_id, user_id, course_id, status, complete_percentage, start_date, finish_date, last_updated) VALUES (%s, %s, %s, %s, %s, %s, %s, %s); ",
            (randIdGen(5), u_id, c_id, status, percentage, start_date, end_date, last_updated))
    conn.commit()
    cur.close()
    conn.close()



def manual_insert_reviews(user_id=randIdGen(8), course_id=randIdGen(4), feedback=None, has_liked=None, rank_score=None):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()

    cur.execute(
        "INSERT INTO review (user_id, course_id, feedback, has_liked, rank_score) VALUES (%s, %s, %s, %s, %s); ",
        (user_id, course_id, feedback, has_liked, rank_score))

    conn.commit()
    cur.close()
    conn.close()
def insertreviews():
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()

    feedback = {
        1: "Very Bad",
        2: "Bad",
        3: "Sufficient",
        4: "Good",
        5: "Excellent"
    }


    def getcourse_id(u_id):
        cur.execute("SELECT course_id FROM ongoing_training WHERE user_id = %s",(u_id))
        rec = cur.fetchall()[0]
        return rec

    cur.execute("SELECT user_id FROM ongoing_training WHERE status ='completed';")
    rec = cur.fetchall()

    for i in rec:
        score = random.choice(list(feedback.keys()))
        feedback_text = feedback[score]
        has_liked = False
        if score > 3:
            has_liked = True
        cur.execute(
            "INSERT INTO review (user_id, course_id, feedback, has_liked, rank_score) VALUES (%s, %s, %s, %s, %s); ",
            (i, getcourse_id(i),feedback_text,  has_liked, score))

    conn.commit()
    cur.close()
    conn.close()

def manual_insertCert(cert_id=randIdGen(7), user_id=randIdGen(8), course_id=randIdGen(5), complete_duration=None, complete_date=datetime.now().date()):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO certification (cert_id, user_id, course_id, complete_duration, complete_date) VALUES (%s, %s, %s, %s, %s); ",
        (cert_id, user_id, course_id, complete_duration, complete_date))

    conn.commit()
    cur.close()
    conn.close()
def insertCert():
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()

    cur.execute("SELECT ongoing_training.user_id, course.course_id,"
                " course.duration, ongoing_training.finish_date FROM ongoing_training "
                "JOIN course ON course.course_id = ongoing_training.course_id  WHERE status ='completed';")
    rec = cur.fetchall()
    for i in rec:
        empid = i[0]
        cid = i[1]
        dur = i[2]
        c_date = i[3]
        cur.execute(
            "INSERT INTO certification (cert_id, user_id, course_id, complete_duration, complete_date) VALUES (%s, %s, %s, %s, %s); ",
            (randIdGen(7), empid,  cid, dur,  c_date))

    conn.commit()
    cur.close()
    conn.close()

def activate(table_name, where_clause):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute("UPDATE %s SET is_active='1' WHERE %s;", (table_name,where_clause))
    conn.commit()
    cur.close()
    conn.close()

def deactivate(table_name, where_clause):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute("UPDATE %s SET is_active='0' WHERE %s;", (table_name, where_clause))
    conn.commit()
    cur.close()
    conn.close()


def permanent_delete(table_name, where_clause):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute("DELETE FROM %s WHERE %s;", (table_name, where_clause))
    conn.commit()
    cur.close()
    conn.close()


def update(table_name, set_column, to_this, where_clause):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute("UPDATE %s SET %s = %s WHERE %s;", (table_name,set_column,to_this,where_clause))
    conn.commit()
    cur.close()
    conn.close()

def select(table_name, columns, where_clause):
    conn = psycopg2.connect("dbname='myEvolve' user='postgres' host='localhost' password='Lantibanti2001964'")
    cur = conn.cursor()
    cur.execute("SELECT %s FROM %s  WHERE %s;", (columns,table_name, where_clause))
    conn.commit()
    cur.close()
    conn.close()


def database_architect(emp_num, course_number):
    insertEmployee(emp_num)
    createPlatform()
    insertCourses(course_number)
    ongoing_training(emp_num*5)
    insertreviews()
    insertCert()

