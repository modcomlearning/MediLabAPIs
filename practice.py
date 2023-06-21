# # Try/Except
# try:
#     x = 5 + 4
# except:
#     print("Failed")
# OOP.
#An object has state and behaviors
# States = properties/attributes that define an object - color, height, name, etc
# Behavior = What does the object do - functionalities
# Example are like move(), eat() ,etc
# In programming states - properties  & behavior are functions/method.
class Fish():
    # Contructor of Properties/States
    def __init__(self):
        self.name = "Bob"
        self.age = 4
        self.color = "silver"
        self.weight = 3

    # a function inside a class is called a method
    def swim(self, lake) : # Parameter
        message = (self.name, "can swim.", lake)
        return message
    
    def jump(self) :
        message = self.name, "can Jump."
        return message


# Call the Object/Instantiate
fish = Fish()
print(fish.age)
#print(fish.swim("L. Nakuru"))
# Prefer
message = fish.swim("L. Nakuru") # argument
print(type(message))
print(message)



bookings = [{
    'x':10,
    'y':15
}, {
    'x':100,
    'y':200
}]


for booking in bookings:
    member  = {
        'b':78
    }
    # add key
    booking['z'] = member

    print(bookings)











