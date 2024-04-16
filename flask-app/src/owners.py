from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db



owners = Blueprint('owners', __name__)


# GET routes
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


# POST routes
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


# create a new stay
@owners.route('/createstay', methods=['POST'])
def add_new_stay():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    startDate = the_data['startDate']
    endDate = the_data['endDate']
    travelerID = the_data['travelerID']
    propertyID = the_data['propertyID']
    

    # Constructing the query
    query = 'insert into Stay_At (startDate, endDate, travelerID, propertyID) values ("'
    query += str(startDate) + '", "'
    query += str(endDate) + '", '
    query += str(travelerID) + ', '
    query += str(propertyID) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# create a new message with a traveler
@owners.route('/createmsg', methods=['POST'])
def add_new_msg():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variables
    content = the_data['content']
    travelerID = the_data['travelerID']
    ownerID = the_data['ownerID']

    # Constructing the query
    query = 'insert into Stay_Messages (content, travelerID, ownerID) values ("'
    query += content + '", '
    query += str(travelerID) + ', '
    query += str(ownerID) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# PUT routes
# update a property
@owners.route('/updateproperty', methods=['PUT'])
def update_property():

    # collect data from request object
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
    propertyID = the_data['propertyID']

    # construct query
    query = 'UPDATE Property SET address = %s, city = %s, region = %s, country = %s, type = %s, description = %s, title = %s, price = %s, ownerID = %s WHERE propertyID = %s'
    data = (address, city, region, country, type, description, title, price, ownerID, propertyID)

    # execute and commit
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()

    return 'property updated!'

# DELETE routes
# delete an owners property
@owners.route('/deleteproperty', methods=['DELETE'])
def delete_property():
    # collect data from request object
    the_data = request.json
    current_app.logger.info(the_data)
    
    # extracting the variable
    propertyID = the_data['propertyID']
    
    # construct query
    query = 'DELETE FROM Property WHERE propertyID = %s'
    
    # execute and commit
    cursor = db.get_db().cursor()
    cursor.execute(query, (propertyID,))
    db.get_db().commit()
    
    return 'Property deleted successfully!'

