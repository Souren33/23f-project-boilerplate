from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db



advertisers = Blueprint('advertisers', __name__)


@advertisers.route('/advertisersinfo/<advertiserID>', methods=['GET'])
def get_advertiserinfo(advertiserID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Advertiser where advertiserID = {0}'.format(advertiserID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# GET routes
# View the liaison information for a specifc advertiser
@advertisers.route('/AdLiaisons/<liaisonID>', methods=['GET'])
def get_liason(liaisonID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from AdLiaison where liaisonID = {0}'.format(liaisonID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


#Allow advertiser to view traveler data 
@advertisers.route('/TravelData/<advertiserID>', methods=['GET'])
def get_traveler_data(advertiserID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from TravelData TD JOIN Traveler T ON TD.travelerID = t.travelerID where advertiserID = {0}'.format(advertiserID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response




#Allow advertiser to view property data
@advertisers.route('/PropertyData/<advertiserID>', methods=['GET'])
def get_property_data(advertiserID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from TravelData TD JOIN Property P ON TD.travelerID = P.propertyID where advertiserID = {0}'.format(advertiserID))
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
@advertisers.route('/properties/<propertyID>', methods=['GET'])
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



#views all expereince ads by a specific advertiser 
@advertisers.route('/ExperienceAds/<advertiserID>', methods=['GET'])
def get_ad_info(advertiserID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Experience_Ads where advertiserID = {0}'.format(advertiserID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response