from flask import Flask
from flask_restful import Api
from flask_jwt_extended import JWTManager
app = Flask(__name__)

# # Set up JWT
# # Set up JWT
from datetime import timedelta
app.secret_key = "hfjdfhgjkdfhgjkdf865785"
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(minutes=1)
app.config["JWT_REFRESH_TOKEN_EXPIRES"] = timedelta(minutes=20)
jwt = JWTManager(app)


# Make the App an API
api = Api(app)

# Configure the Views/Endpoints
# APIs for Member
from views.views import MemberSignUp,MemberSignin, MemberProfile, AddDependant, ViewDependants, Laboratories
from views.views import LabTests, MakeBooking, MyBookings, MakePayment
api.add_resource(MemberSignUp, '/api/member_signup')
api.add_resource(MemberSignin, '/api/member_signin')
api.add_resource(MemberProfile, '/api/member_profile')
api.add_resource(AddDependant, '/api/add_dependant')
api.add_resource(ViewDependants, '/api/view_dependants')
api.add_resource(Laboratories, '/api/laboratories')
api.add_resource(MakeBooking, '/api/make_booking')
api.add_resource(LabTests, '/api/lab_tests')
api.add_resource(MyBookings, '/api/mybookings')
api.add_resource(MakePayment, '/api/make_payment')

# APIs for Dasboard
from views.views_dashboard import LabSignup, LabSignin, LabProfile, AddLabTests
from views.views_dashboard import ViewLabTests, ViewLabBookings, AddNurse,ViewNurses, TaskAllocation
api.add_resource(LabSignup, '/api/lab_signup')
api.add_resource(LabSignin, '/api/lab_signin')
api.add_resource(LabProfile, '/api/lab_profile')
api.add_resource(AddLabTests, '/api/add_tests')
api.add_resource(ViewLabTests, '/api/view_lab_tests')
api.add_resource(ViewLabBookings, '/api/view_bookings')
api.add_resource(AddNurse, '/api/add_nurse')
api.add_resource(ViewNurses, '/api/view_nurses')
api.add_resource(TaskAllocation, '/api/task_allocation')

# Confugure Urls for Nurses
from views.view_nurse import NurseSignin, ViewAssignments, ViewInvoiceDetails
api.add_resource(NurseSignin, '/api/nurse_signin')
api.add_resource(ViewAssignments, '/api/view_assignments')
api.add_resource(ViewInvoiceDetails, '/api/view_invoice_details')


if __name__ == '__main__':
    app.run(debug=True)

# Base URl  127.0.0.1:5000