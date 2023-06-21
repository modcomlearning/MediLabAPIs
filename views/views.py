# Import Required modules
import pymysql
from flask_restful import *
from flask import *
from functions import *
import pymysql.cursors

# import JWT Packages
from flask_jwt_extended import create_access_token, jwt_required, create_refresh_token


# Member SignUp.
class MemberSignUp(Resource):
     def post(self):
          # Connect to MySQL
          json = request.json
          surname = json['surname'] 
          others = json['others']
          gender = json['gender']
          email = json['email']
          phone = json['phone']
          dob = json['dob']
          password = json['password']
          location_id = json['location_id']
          
          # Validate Password
          response = passwordValidity(password)
          if response ==True:
               if check_phone(phone):
                   connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
                   cursor = connection.cursor()
                   # Insert Data
                   sql = ''' Insert into members(surname, others,  gender, email,
                   phone, dob, password, location_id)values(%s, %s, %s, %s,%s, 
                   %s, %s, %s) '''
                   # Provide Data
          
                   data = (surname, others, gender, encrypt(email), encrypt(phone), 
                           dob, hash_password(password), location_id)
                   try:
                        cursor.execute(sql, data)
                        connection.commit()
                        # Send SMS/EMail
                        code = gen_random(4)
                        send_sms(phone, '''Thank you for Joining MediLab. 
                        Your Secret No: {}. Do not share.'''.format(code))
                        return jsonify({'message': 'Successful Registered'})
                   except:
                        connection.rollback()
                        return jsonify({'message': 'Failed. Try Again'})

               else:
                    return jsonify({'message': 'Invalid Phone +254'})

          else:
               return jsonify({'message': response})


class MemberSignin(Resource):
     def post(self):
          json = request.json
          surname = json['surname']
          password = json['password']
          # The user  enters a Plain Text Email
          sql = "select * from members where surname = %s"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, surname)
          count = cursor.rowcount
          if count == 0:
                return jsonify({'message': 'User does Not exist'})
          else:
                 # user Exist
                 member = cursor.fetchone()
                 hashed_password = member['password']   # This Password is hashed
                 # Jane provided a Plain password
                 if hash_verify(password, hashed_password):
                       # TODO JSON WEB Tokens
                       access_token = create_access_token(identity=surname,
                                                          fresh=True)
                       refresh_token = create_refresh_token(surname)

                       return jsonify({'message': member, 
                                       'access_token': access_token,
                                       'refresh_token':refresh_token})

                 else:
                       return jsonify({'message': 'Login Failed'})
                 

# can we use Encrypted Email?
# Read on JWT Tokens? What are they? WHere are they Used?
# Tommorow
# Token, Member Profile, Add Dependant. View Dependants
# Member  Profile
class MemberProfile(Resource):
     @jwt_required(refresh=True) # Refresh Token
     def post(self):
          json = request.json
          member_id = json['member_id']
          sql = "select * from members where member_id = %s"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, member_id)
          count = cursor.rowcount
          if count == 0:
               return jsonify({'message': 'Member does Not exist'})
          else:
               member = cursor.fetchone()
               return jsonify({'message': member})
          
# Add Deoendant.
class AddDependant(Resource):
     @jwt_required(refresh=True) # Refresh Token
     def post(self):
          # Connect to MySQL
          json = request.json
          member_id = json['member_id']
          surname = json['surname'] 
          others = json['others']
          dob = json['dob']

          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          cursor = connection.cursor()
          # Insert Data
          sql = ''' Insert into dependants(member_id,surname, others, dob)
          values(%s, %s, %s, %s) '''
          # Provide Data
          data = (member_id, surname, others, dob)
          try:
               cursor.execute(sql, data)
               connection.commit()
               return jsonify({'message': 'Dependant Added'})
          except:
               connection.rollback()
               return jsonify({'message': 'Failed. Try Again'})



class ViewDependants(Resource):
     @jwt_required(refresh=True) # Refresh Token
     def post(self):
          json = request.json
          member_id = json['member_id']
          sql = "select * from dependants where member_id = %s"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, member_id)
          count = cursor.rowcount
          if count == 0:
               return jsonify({'message': 'Member does Not exist'})
          else:
               dependants = cursor.fetchall()
               return jsonify(dependants)
          # {}   - Means Object in JSON, comes with key - value
          # []   - Means a JSON Array
          # [{}, {} ]  - JSON Array - with JSON Onjects


class Laboratories(Resource):
     def get(self):
          sql = "select * from laboratories"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql)
          count = cursor.rowcount
          if count == 0:
               return jsonify({'message': 'No Laboartories'})
          else:
               laboratories  = cursor.fetchall()
               return jsonify(laboratories) 


class LabTests(Resource):
     def post(self):
          json = request.json
          lab_id = json['lab_id']
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          sql = "select * from lab_tests where lab_id = %s"
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, lab_id)
          count = cursor.rowcount
          if count == 0:
               return jsonify({'message': 'No Lab test Found'})
          else:
               try:
                    lab_tests  = cursor.fetchall()
                    return jsonify(lab_tests) 
               except:
                    return jsonify({'message': 'Error'})


class MakeBooking(Resource):
     @jwt_required(refresh=True)
     def post(self):
          json = request.json
          member_id = json['member_id']
          booked_for = json['booked_for']
          dependant_id = json['dependant_id']
          test_id = json['test_id']
          appointment_date = json['appointment_date']
          appointment_time = json['appointment_time']
          where_taken = json['where_taken']
          latitude = json['latitude']
          longitude  = json['longitude']
          lab_id = json['lab_id']
          invoice_no = json['invoice_no']

          connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
          cursor = connection.cursor()

          # Insert Data
          sql = ''' Insert into bookings(member_id,booked_for, dependant_id,test_id, appointment_date,
         appointment_time, where_taken, latitude,longitude, lab_id, invoice_no )
          values(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) '''
          # Provide Data
          data = (member_id,booked_for, dependant_id,test_id, appointment_date,
          appointment_time, where_taken, latitude,longitude, lab_id, invoice_no)

          try:
               cursor.execute(sql, data)
               connection.commit()
               # Get Member Phone No
               sql = "select * from members where member_id = %s"
               cursor = connection.cursor(pymysql.cursors.DictCursor)
               cursor.execute(sql, member_id)
               member = cursor.fetchone()
               phone = member['phone']

               send_sms(decrypt(phone), 'Booking On {} at {} , Invoice {}'
                        .format(appointment_date, appointment_time, invoice_no))
               
               return jsonify({'message': 'Booking Received'})
          
          except Exception as error:
               connection.rollback()
               return jsonify({'message': 'Failed'})


     



class MyBookings(Resource):
    @jwt_required(refresh=True)
    def __init__(self):
         self.sql = "select * from bookings where member_id = %s"
         self.connection = pymysql.connect(host='localhost',
                                             user='root',
                                             password='',
                                             database='medilab')
                                             
         self.cursor = self.connection.cursor(pymysql.cursors.DictCursor)
         
    def get(self):
          # try:
               json = request.json
               member_id = json['member_id']
               
               self.cursor.execute(self.sql, member_id)
               count = self.cursor.rowcount
               if count == 0:
                    return jsonify({'message': 'No Bookings'})
               else:
                    bookings = self.cursor.fetchall()

                    import json
                    jsonStr = json.dumps(bookings, indent=1, sort_keys=True, default=str)
                    # then covert json string to json object
                    return json.loads(jsonStr)
               

          # except Exception as e:
          #      return jsonify({'message': e})
          
class MakePayment(Resource):
    @jwt_required(fresh=True)
    def post(self):
        json = request.json
        phone = json['phone']
        amount = json['amount']
        invoice_no = json['invoice_no']
        # Access Mpesa Functions locatated in functions.py
        mpesa_payment(amount, phone, invoice_no)
        return jsonify({'message': 'Sent - Complete Payment on Your Phone.'})

# Logout.
# SQL
# classes, functions
# If ELSE
# Cursor
# Try/Except
# JSON
# Return
# Flask.