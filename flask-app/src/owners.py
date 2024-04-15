from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db



owners = Blueprint('owners', __name__)



# retrieve all properties of an owner
@owners.route('/properties/<ownerID>', methods=['GET'])
def get_properties(ownerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Property where propertyID = {0}'.format(ownerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response