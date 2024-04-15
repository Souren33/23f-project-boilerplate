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


# create a new property
@owners.route('/createproperty', methods=['POST'])
def add_new_property():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    address = the_data['address']
    city = the_data['region']
    region = the_data['region']
    country = the_data['country']
    type = the_data['type']
    description = the_data['description']
    title = the_data['title']
    price = the_data['price']
    ownerID = the_data['ownerID']

    # Constructing the query
    query = 'insert into Property (address, city, region, country, type, description, title, price, ownerID) values ("'
    query += address + '", "'
    query += city + '", "'
    query += region + '", "'
    query += country + '", "'
    query += type + '", "'
    query += description + '", "'
    query += title + '", '
    query += str(price) + ', '
    query += str(ownerID) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'