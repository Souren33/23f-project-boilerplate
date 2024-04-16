from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db



travelers = Blueprint('travelers', __name__)

# Get all the properties from the database
@travelers.route('/properties', methods=['GET'])
def get_properties():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Property')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get property detail for property with particular propertyID
@travelers.route('/properties/<propertyID>', methods=['GET'])
def get_property(propertyID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Property where propertyID = {0}'.format(propertyID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve messages between an owner and traveler
@travelers.route('/staymessages/<ownerID>/<travelerID>', methods=['GET'])
def get_messages_between(ownerID, travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stay_Messages where ownerID = {0} AND travelerID = {1}'.format(ownerID, travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

