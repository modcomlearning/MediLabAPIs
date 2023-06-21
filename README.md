# MediLab API
This is an APi Build in Python Flask framework and MySQl database, 

### The APi has 3 Parts.

1. The API allows register a member, sign in, pfofile, add dependants, make booking, make payments etc.

2. Other APIs include sign in, sign up laboratory,add lab tests, add nurses, allocate to nurses.

3. Nurse Apis allows nurses to Login and access their allocated Tasks, change password.

### How to Install

Step1: Download xampp from  https://www.apachefriends.org/
Step2: Create and import medilab.sql.

Step3: Create a flask app and Install these Packages
```
pip install flask
pip install pymysql
pip install bcrypt
pip install africastalking
pip install fpdf
```

Step 4: Python Set up.

Create a Folder named views and place the view_nurses.py, views.py and views_dashboard.py Inside.

In the root folder create a functions.py.
In the root folder again create app.py and configure your Endpoints.

Run Your App.

Useful Links
https://flask.palletsprojects.com/en/1.1.x/
https://github.com/africastalking/AfricasTalking-SDK-







