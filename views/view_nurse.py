# TODO
# Login Nurse.   provide   surname and password
# ViewAsignments  - provide nurse_id and returns invoice_no, flag
# ViewInvoiceDetails  - provide invoice_no  return tests under that invoice
# ChangePassword
# Import Required modules
import pymysql
from flask_restful import *
from flask import *
from functions import *
import pymysql.cursors

# import JWT Packages
from flask_jwt_extended import create_access_token, jwt_required, create_refresh_token

class NurseSignin(Resource):
     def post(self):
          json = request.json
          surname = json['surname']
          password = json['password']
          # The user  enters a Plain Text Email
          sql = "select * from nurses where surname = %s"
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
                 nurse = cursor.fetchone()
                 hashed_password = nurse['password']   # This Password is hashed
                 # Jane provided a Plain password
                 if hash_verify(password, hashed_password):
                       # TODO JSON WEB Tokens
                       access_token = create_access_token(identity=surname,
                                                          fresh=True)
                       refresh_token = create_refresh_token(surname)

                       return jsonify({'message': nurse, 
                                       'access_token': access_token,
                                       'refresh_token':refresh_token})

                 else:
                       return jsonify({'message': 'Login Failed'})
                 


class ViewAssignments(Resource):
     @jwt_required(refresh=True) # Refresh Token
     def post(self):
          json = request.json
          nurse_id = json['nurse_id']
          flag = json['flag']
          sql = "select * from nurse_lab_allocations where nurse_id = %s and flag = %s"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, (nurse_id, flag))
          count = cursor.rowcount
          if count == 0:
               message = "No {} Assignments".format(flag)
               return jsonify({'message': message})
          else:
               data = cursor.fetchall()
               return jsonify(data)



class ViewInvoiceDetails(Resource):
     @jwt_required(refresh=True) # Refresh Token
     def post(self):
          json = request.json
          invoice_no = json['invoice_no']
          
          sql = "select * from bookings where invoice_no = %s"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, (invoice_no))
          count = cursor.rowcount
          if count == 0:
               message = "Invoice No {} Does not Exist".format(invoice_no)
               return jsonify({'message': message})
          else:
               bookings = cursor.fetchall()
               import json
               jsonStr = json.dumps(bookings, indent=1, sort_keys=True, default=str)
                    # then covert json string to json object
               return json.loads(jsonStr)
               


class ChangePass(Resource):
     def put(self):
          json = request.json
          nurse_id = json['nurse_id']
          current_password = json['current_password']
          new_password = json['new_password']
          confirm_password = json['confirm_password']
    
          sql = "select * from nurses where nurse_id = %s"
          connection = pymysql.connect(host='localhost',
                                                user='root',
                                                password='',
                                                database='medilab')
          
          cursor = connection.cursor(pymysql.cursors.DictCursor)
          cursor.execute(sql, nurse_id)
          count = cursor.rowcount
          if count == 0:
                return jsonify({'message': 'Nurse does Not exist'})
          else:
               nurse = cursor.fetchone()
               hashed_password = nurse['password']   # This Password is hashed
                 # Jane provided a Plain password
               if hash_verify(current_password, hashed_password):
                       # You can Update
                       if new_password != confirm_password:
                            return jsonify({'message': 'Password Do Not match '})
                       else:
                            sql = '''Update nurses Set password = %s where nurse_id = %s'''
                            cursor = connection.cursor()
                            data = (hash_password(new_password),nurse_id)
                            try :
                                 cursor.execute(sql, data)
                                 connection.commit()
                                 return jsonify({'message': 'Password Changed '})
                            except:
                                 connection.rollback()
                                 return jsonify({'message':'Error in Changing the Password'})
               else:
                       return jsonify({'message': 'Current Password is Wrong '})

# https://github.com/modcomlearning/MediLabApis




















          pass



