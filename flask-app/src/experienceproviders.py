from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

experienceproviders = Blueprint('experienceproviders', __name__)

## view all info for a traveler
@experienceproviders.route('/Traveler/<travelerID>', methods=['GET'])
def get_traveler_info(travelerID):
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

## view all reviews for an exp provider
@experienceproviders.route('/Experience_Reviews/<providerID>', methods=['GET'])
def get_all_reviews(providerID):
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

    ## view all ads for an exp provider
@experienceproviders.route('/Experience_Ads/<providerID>', methods=['GET'])
def get_all_ads(providerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Experience_Ads where providerID = {0}'.format(providerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

        ## view all bundles for an exp provider
@experienceproviders.route('/Bundle/<providerID>', methods=['GET'])
def get_all_bundles(providerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Bundle JOIN Offer JOIN ExperienceProviders where providerID = {0}'.format(providerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

        ## view all bundles for an exp provider
@experienceproviders.route('/Offers/<providerID>', methods=['GET'])
def get_all_offers(providerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Offer where providerID = {0}'.format(providerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


    ## view all info of a bundle
@experienceproviders.route('/bundle/<bundleID>', methods=['GET'])
def get_bundle_info(bundleID):
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

    ## view all experiences of a bundle
@experienceproviders.route('/experience/<bundleID>', methods=['GET'])
def get_experiences_in_bundle(bundleID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Experience where bundleID = {0}'.format(bundleID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

        ## view info of an experience for a specific traveler
@experienceproviders.route('/experience/<travelerID>', methods=['GET'])
def get_experience_info(travelerID):
    cursor = db.get_db().cursor()
    query = 'select * from Experience where travelerID = {0}'.format(travelerID)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

## get ad given advertiser and provider ids
@experienceproviders.route('/Experience_Ads/<adID>/<providerID>', methods=['GET'])
def get_ad(adID, providerID):
    cursor = db.get_db().cursor()
    query = 'select * from Experience_Ads where adID = {0}'.format(adID)
    query += ' AND providerID = {0}'.format(providerID)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# create a new offer
@experienceproviders.route('/createoffer', methods=['POST'])
def add_new_offer():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    bundleID = the_data['bundleID']
    providerID = the_data['providerID']
    

    # Constructing the query
    query = 'insert into Offer (bundleID, providerID) values ('
    query += str(bundleID) + ', '
    query += str(providerID) + ') '
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# create a new offer
@experienceproviders.route('/createbundle', methods=['POST'])
def add_new_bundle():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    description = the_data['description']
    _type = the_data['type']
    title = the_data['title']
    price = the_data['price']
    

    # Constructing the query
    query = "insert into Bundle (description, type, title, price) values ('"
    query += str(description) + "', '"
    query += str(_type) + "', '"
    query += str(title) + "', "
    query += str(price) + ") "
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# create a new experience 
@experienceproviders.route('/createexperience', methods=['POST'])
def add_new_experience():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    bundleID = the_data['bundleID']
    travelerID = the_data['travelerID']
    date = the_data['date']

    

    # Constructing the query
    query = "insert into Experience (date, bundleID, travelerID) values ('"
    query += str(date) + "', "
    query += str(bundleID) + ", "
    query += str(travelerID) + ")"
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# create a new provider
@experienceproviders.route('/createprovider', methods=['POST'])
def add_new_provider():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    companyName = the_data['companyName']
    address = the_data['address']
    city = the_data['city']
    region = the_data['region']
    country = the_data['country']
    email = the_data['email']
    description = the_data['description']
    

    # Constructing the query
    query = 'insert into ExperienceProvider (companyName, address, city, region, country, email, description) values ("'
    query += str(companyName) + '", "'
    query += str(address) + '", '
    query += str(city) + '", "'
    query += str(region) + '", "'
    query += str(country) + '", "'
    query += str(email) + '", "'
    query += str(description) + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# create a new advertiser
@experienceproviders.route('/createad', methods=['POST'])
def add_new_advertiser():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    advertiserID = the_data['advertiserID']
    package = the_data['package']
    providerID = the_data['providerID']
    

    # Constructing the query
    query = "insert into Experience_Ads (advertiserID, package, providerID) values("
    query += str(advertiserID) + ", '"
    query += str(package) + "', "
    query += str(providerID) + ")"
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


# delete a bundle 
@experienceproviders.route('/deletebundle', methods=['DELETE'])
def delete_bundle():
    # collect data from request object
    the_data = request.json
    current_app.logger.info(the_data)
    
    # extracting the variable
    bundleID = the_data['bundleID']
    
    # construct query
    query = 'DELETE FROM Bundle WHERE bundleID = %s'
    
    # execute and commit
    cursor = db.get_db().cursor()
    cursor.execute(query, (bundleID,))
    db.get_db().commit()
    
    return 'Bundle deleted successfully!'

# delete a offer 
@experienceproviders.route('/deleteoffer', methods=['DELETE'])
def delete_offer():
    # collect data from request object
    the_data = request.json
    current_app.logger.info(the_data)
    
    # extracting the variable
    bundleID = the_data['bundleID']
    providerID = the_data['providerID']
    
    # construct query
    query = 'DELETE FROM Bundle WHERE bundleID = ' + bundleID
    query += ' AND providerID = ' + providerID
    
    # execute and commit
    cursor = db.get_db().cursor()
    cursor.execute(query, (bundleID,))
    db.get_db().commit()
    
    return 'Offer deleted successfully!'

    # update a property
@experienceproviders.route('/updatebundle', methods=['PUT'])
def update_bundle():

    # collect data from request object
    the_data = request.json
    current_app.logger.info(the_data)


    #extracting the variable
    description = the_data['description']
    _type = the_data['type']
    title = the_data['title']
    price = the_data['price']
    bundleID = str(the_data['bundleID'])

    # construct query
    query = 'UPDATE Bundle SET description = %s, type = %s, title = %s, price = %s WHERE bundleID = %s'
    data = (description, _type, title, price, bundleID)

    # execute and commit
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()

    return 'bundle updated!'

# delete a advertisement
@experienceproviders.route('/deleteadvertisement', methods=['DELETE'])
def delete_advertisement():
    # collect data from request object
    the_data = request.json
    current_app.logger.info(the_data)
    
    # extracting the variable
    adID = the_data['adID']
    
    # construct query
    query = 'DELETE FROM Experience_Ads WHERE adID = %s'
    
    # execute and commit
    cursor = db.get_db().cursor()
    cursor.execute(query, (adID,))
    db.get_db().commit()
    
    return 'Advertisement deleted successfully!'