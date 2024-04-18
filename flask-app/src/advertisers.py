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
@advertisers.route('/AdLiaisons/<adID>', methods=['GET'])
def get_liason(adID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM AdLiaison AD JOIN Advertiser A ON AD.liaisonID = A.liaisonID WHERE AD.liaisonID = {0}'.format(adID))
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
@advertisers.route('/Travel_Data/<advertiserID>', methods=['GET'])
def get_traveler_data(advertiserID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Travel_Data TD JOIN Traveler T ON TD.travelerID = T.travelerID where advertiserID = {0}'.format(advertiserID))
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
@advertisers.route('/Property_Data/<advertiserID>', methods=['GET'])
def get_property_data(advertiserID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Property_Data PD JOIN Property P ON PD.propertyID = P.propertyID where advertiserID = {0}'.format(advertiserID))
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

