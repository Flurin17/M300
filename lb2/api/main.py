#!/usr/bin/env python3
from flask import Flask, request
from flask_restful import Resource, Api
import random

app = Flask(__name__)
api = Api(app)

class HelloWorld(Resource):
    def get(self):
        return {"about": "Hello World!"}

class greetings(Resource):
    def get(self):
        return {"welcome": "on this Website"}

class malrechnen(Resource):
    def get(self, num, mal):
        return {"result": num*mal}

class randomZahl(Resource):
    def get(self, min, max):
        randomErgebnis = random.randint(min, max)
        return {"Number": randomErgebnis}, 201

class errorCodes(Resource):
    def get(self, errorCode):
        return {"ErrorCode": errorCode}, errorCode
api.add_resource(HelloWorld, "/api/hello/")
api.add_resource(malrechnen, "/api/rechnen/<int:num>*<int:mal>")
api.add_resource(randomZahl, "/api/random/<int:min>-<int:max>")
api.add_resource(greetings, "/api/")
api.add_resource(errorCodes, "/api/status/<int:errorCode>")


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0",port=80)