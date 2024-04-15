from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db



owners = Blueprint('owners', __name__)



# retrieve all properties of an owner
@owners.route('/properties/<ownerID>', methods=['GET'])
def get_properties(ownerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Property where ownerID = {0}'.format(ownerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve information on one property of an owner
@owners.route('/properties/<ownerID>/<propertyID>', methods=['GET'])
def get_property(ownerID, propertyID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Property where ownerID = {0} AND propertyID = {1}'.format(ownerID, propertyID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve information of a specific traveler
@owners.route('/travelers/<travelerID>', methods=['GET'])
def get_traveler(travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Traveler where travelerID = {0}'.format(travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve all reviews on an owners property
@owners.route('/propertyreviews/<propertyID>', methods=['GET'])
def get_reviews(propertyID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from PropertyReview where propertyID = {0}'.format(propertyID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# view information of owner
@owners.route('/owners/<ownerID>', methods=['GET'])
def get_owner(ownerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Owner where ownerID = {0}'.format(ownerID))
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
@owners.route('/staymessages/<ownerID>/<travelerID>', methods=['GET'])
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

# retrieve all messages of an owner
@owners.route('/staymessages/<ownerID>', methods=['GET'])
def get_messages_all(ownerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stay_Messages where ownerID = {0}'.format(ownerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve all stays at a particular property
@owners.route('/stayats/<propertyID>', methods=['GET'])
def get_stay_ats(propertyID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stay_At where propertyID = {0}'.format(propertyID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve information for a specific stay
@owners.route('/stayats/<propertyID>/<travelerID>', methods=['GET'])
def get_stay_at(propertyID, travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stay_At where propertyID = {0} AND travelerID = {1}'.format(propertyID, travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response