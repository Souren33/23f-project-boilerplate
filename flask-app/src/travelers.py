from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db



travelers = Blueprint('travelers', __name__)

# GET routes
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


# retrieve information for a specific stay
@travelers.route('/stayats/<propertyID>/<travelerID>', methods=['GET'])
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


# retrieve all reviews on an owners property
@travelers.route('/propertyreviews/<propertyID>', methods=['GET'])
def get_prop_reviews(propertyID):
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


# retrieve all reviews on an experience provider
@travelers.route('/provexperiencereviews/<providerID>', methods=['GET'])
def get_exp_reviews(providerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Experience_Reviews where providerID = {0}'.format(providerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# view the specific information of a bundle
@travelers.route('/bundles/<bundleID>', methods=['GET'])
def get_bundle(bundleID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Bundle where bundleID = {0}'.format(bundleID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# retrieve information of a specific experience
@travelers.route('/experiences/<bundleID>/<travelerID>', methods=['GET'])
def get_experience(bundleID, travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Experience where bundleID = {0} AND travelerID = {1}'.format(bundleID, travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# view all a travelers experience reviews
@travelers.route('/travexperiencereviews/<travelerID>', methods=['GET'])
def get_trav_exp_reviews(travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Experience_Reviews where travelerID = {0}'.format(travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# view all a travelers property reviews
@travelers.route('/travpropertyreviews/<travelerID>', methods=['GET'])
def get_trav_prop_reviews(travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from PropertyReview where travelerID = {0}'.format(travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve all messages of a traveler
@travelers.route('/staymessages/<travelerID>', methods=['GET'])
def get_messages_all(travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stay_Messages where travelerID = {0}'.format(travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# retrieve all stays of a traveler
@travelers.route('/stayats/<travelerID>', methods=['GET'])
def get_stay_ats(travelerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stay_At where travelerID = {0}'.format(travelerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all experience providers from the database
@travelers.route('/experienceproviders', methods=['GET'])
def get_providers():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM ExperienceProviders')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all bundles from the database
@travelers.route('/bundles', methods=['GET'])
def get_bundles():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Bundle')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all advertisements from the database
@travelers.route('/advertisements', methods=['GET'])
def get_ads():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Experience_Ads')
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
# create a new message with an owner
@travelers.route('/createmsg', methods=['POST'])
def add_new_msg():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variables
    content = the_data['content']
    dateSent = the_data['dateSent']
    travelerID = the_data['travelerID']
    ownerID = the_data['ownerID']

    # Constructing the query
    query = 'insert into Stay_Messages (content, dateSent, travelerID, ownerID) values ("'
    query += content + '", "'
    query += str(dateSent) + '", '
    query += str(travelerID) + ', '
    query += str(ownerID) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
