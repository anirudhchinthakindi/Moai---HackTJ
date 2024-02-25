import uuid
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import sqlite3

class Circle:
    def __init__(self, members=[], name=""):
        self._name = name
        self._circle_id = str(uuid.uuid4())
        self._member_ids = members

    def get_name(self): return self._name
    def get_member_ids(self): return self._member_ids
    def get_contribution_percentage(self): return self._contribution_percentage
    def get_circle_id(self): return self._circle_id

    def set_name(self, name): 
        self._name = name
    def set_circle_id(self, circle_id): 
        self._circle_id = circle_id
    def set_member_ids(self, member_ids): 
        self._member_ids = member_ids
    def set_contribution_percentage(self, contribution_percentage):
        if 0 <= contribution_percentage <= 100: 
            self._contribution_percentage = contribution_percentage
        else: print("Contribution percentage must be between 0 and 100.")

    def circle_save_to_database(self):
        conn = sqlite3.connect("circle_database.db") # Connect to the SQLite database (create if not exists)
        cursor = conn.cursor() # Create a cursor object to interact with the database

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS persons (
                circle_id TEXT PRIMARY KEY,
                name TEXT,
                member_ids TEXT,
                contribution_percentage REAL
            )
        ''')

        member_ids_str = ",".join(self._member_ids) if self._member_ids else None
        cursor.execute('''
            INSERT OR REPLACE INTO circleDatabase VALUES (?,?, ?, ?)
        ''', (
            self._circle_id, self._name, member_ids_str, self._contribution_percentage
        ))
        conn.commit()
        conn.close()

    @staticmethod
    def get_user_info(user_id):
        conn = sqlite3.connect("circle_database.db")
        cursor = conn.cursor()

        # Retrieve person information from the database
        cursor.execute('''
            SELECT * FROM circles WHERE id = ?
        ''', (user_id,))

        result = cursor.fetchone()
        conn.close()
        if result: return result  # Result is a tuple with (id, name, email, phone_number, monthly_income)
        else: return None

class User:
    def __init__(self, name, email, phone_number, monthly_income, credit_card=None, circle=None):
        self._id = str(uuid.uuid4())
        self._name = name
        self._email = email
        self._phone_number = phone_number
        self._monthly_income = monthly_income
        self._credit_card = credit_card
        self._circle = circle if circle else None
        self.user_save_to_database()

    # Getters
    def get_id(self): return self._id
    def get_name(self): return self._name
    def get_email(self): return self._email
    def get_phone_number(self): return self._phone_number
    def get_monthly_income(self): return self._monthly_income
    def get_circle(self): return self._circle
    def get_credit_card(self): return self._credit_card

    # Setters
    def set_name(self, name): 
        self._name = name
    def set_email(self, email): 
        self._email = email
    def set_phone_number(self, phone_number): 
        self._phone_number = phone_number
    def set_monthly_income(self, income): 
        self._monthly_income = income
    def set_credit_card(self, credit_card): 
        self._credit_card = credit_card
    def set_circle(self, circle): 
        self._circle = circle

    """
    def send_confirmation_email(self):
        # Your email and password for the SMTP server
        sender_email = "ankchinta@gmail.com"  # replace with your email
        sender_password = "" #replace with your email password
        recipient_email = self.get_email()

        # Email server settings (for Gmail)
        smtp_server = "smtp.gmail.com"
        smtp_port = 587

        # Create the email message
        message = MIMEMultipart()
        message['From'] = sender_email
        message['To'] = recipient_email
        message['Subject'] = "Moai | Confirmation Email"

        # Body of the email
        body = f"Hello {self.get_name()},\n\nThank you for your registration. Your ID is: {self.get_id()}\nYou do not need this to log in; just use your email. This is simply for your records.\n\nBest regards,\nMoai Team"
        message.attach(MIMEText(body, 'plain'))

        # Establish a connection to the SMTP server
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, recipient_email, message.as_string()) # Send the email
    """
    def user_save_to_database(self):
        conn = sqlite3.connect("userDatabase.db") # Connect to the SQLite database (create if not exists)
        cursor = conn.cursor() # Create a cursor object to interact with the database

        # Create a table if it doesn't exist
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS persons (
                id TEXT PRIMARY KEY,
                name TEXT,
                email TEXT,
                phone_number TEXT,
                monthly_income REAL,
                credit_number TEXT,
                cvv TEXT,
                expiration_date TEXT,
                zip_code TEXT,
                circle_id TEXT
            )
        ''')

        # Check if the person is associated with a circle
        circle_id = self._circle.get_circle_id() if self._circle else None

        # Insert or update the person's information in the database
        cursor.execute('''
            INSERT OR REPLACE INTO persons VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            self._id, 
            self._name, 
            self._email, 
            self._phone_number, 
            self._monthly_income,
            self._credit_card.get_credit_number() if self._credit_card else None,
            self._credit_card.get_cvv() if self._credit_card else None,
            self._credit_card.get_expiration_date() if self._credit_card else None,
            self._credit_card.get_zip_code() if self._credit_card else None,
            circle_id
        ))
        # Commit the changes and close the connection
        conn.commit()
        conn.close()

    @staticmethod
    def get_user_info(user_id):
        conn = sqlite3.connect("userDatabase.db")
        cursor = conn.cursor()

        # Retrieve person information from the database
        cursor.execute('''
            SELECT * FROM persons WHERE id = ?
        ''', (user_id,))

        result = cursor.fetchone()
        conn.close()
        if result: return result  # Result is a tuple with (id, name, email, phone_number, monthly_income)
        else: return None

class CreditCard:
    def __init__(self, credit_number, cvv, expiration_date, zip_code):
        self._credit_number = credit_number
        self._cvv = cvv
        self._expiration_date = expiration_date
        self._zip_code = zip_code

    # Getters
    def get_credit_number(self):
        return self._credit_number

    def get_cvv(self):
        return self._cvv

    def get_expiration_date(self):
        return self._expiration_date

    def get_zip_code(self):
        return self._zip_code

    # Setters
    def set_credit_number(self, credit_number):
        self._credit_number = credit_number

    def set_cvv(self, cvv):
        self._cvv = cvv

    def set_expiration_date(self, expiration_date):
        self._expiration_date = expiration_date

    def set_zip_code(self, zip_code):
        self._zip_code = zip_code

def testAllClasses():
    # User Class
    person1 = User("Lalit Boyapati", "lalitroy234@gmail.com", 1234567890, 5000)
    print("ID:", person1.get_id())
    print("Name:", person1.get_name())
    print("Email:", person1.get_email())
    print("Phone Number:", person1.get_phone_number())
    print("Monthly Income:", person1.get_monthly_income())

    # Updating information
    person1.set_name("Anirudh Chinthakindi")
    person1.set_monthly_income(6000)

    print("\nAfter updating:")
    print("Name:", person1.get_name())
    print("Monthly Income:", person1.get_monthly_income())
    print("\nNew Information")
    person1.user_save_to_database()

    person2 = User("Vivaan Radheswar", "v.radheshwar19@gmail.com", 1234567890, 5000)

    # Retrieve person information by user ID
    print("\nPull User Information from database via ID and print out information:")
    user_id_to_search = person2.get_id()
    person_info = User.get_user_info(user_id_to_search)

    if person_info:
        print("User ID:", person_info[0])
        print("Name:", person_info[1])
        print("Email:", person_info[2])
        print("Phone Number:", person_info[3])
        print("Monthly Income:", person_info[4])
    else: print("User ID not found")
    circleNew = Circle("My Circle")
    #circleNew.circle_save_to_database()
    person2.set_circle(circleNew)
    person2.user_save_to_database()
    print("Test save Circle object and retrieve it from database")
    print("Circle ID:", person2.get_circle().get_circle_id())

    # Sending a confirmation email
    print("\nSending a confirmation email to:", person1.get_email())
    #person1.send_confirmation_email()
    print("Confirmation email sent to:", person1.get_email())

    # Example usage of Circle class:
    print("\nCircle Tests:")
    person1 = User("John Doe", "john.doe@example.com", "123-456-7890", 5000)
    person2 = User("Jane Smith", "jane.smith@example.com", "987-654-3210", 6000)
    person3 = User("Bob Johnson", "bob.johnson@example.com", "555-123-4567", 7000)

    circle1 = Circle()
    circle1.set_member_ids([person1.get_id(), person2.get_id(), person3.get_id()])
    circle1.set_contribution_percentage(3)

    print("Circle Member IDs:", circle1.get_member_ids())
    print("Contribution Percentage:", circle1.get_contribution_percentage())

    # Example usage of CreditCard class:
    print("\nFinal Tests:")
    credit_card = CreditCard("1234 5678 9012 3456", "123", "12/25", "12345")
    finalUser = User("John Doe", "john.doe@example.com", "123-456-7890", 5000, credit_card)
    finalUser.set_circle(Circle([finalUser.get_id()], "Final Circle"))

    print("Person Information:")
    print("Name:", finalUser.get_name())
    print("Email:", finalUser.get_email())
    print("Phone Number:", finalUser.get_phone_number())
    print("Monthly Income:", finalUser.get_monthly_income())
    circle2 = finalUser.get_circle()
    print(circle2.get_member_ids())

    print("Circle:", circle2.get_name())
    print("\nCredit Card Information:")
    print("Credit Number:", finalUser.get_credit_card().get_credit_number())
    print("CVV:", finalUser.get_credit_card().get_cvv())
    print("Expiration Date:", finalUser.get_credit_card().get_expiration_date())
    print("Zip Code:", finalUser.get_credit_card().get_zip_code())
    print("done")

testAllClasses()