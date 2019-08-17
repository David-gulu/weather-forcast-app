//bean

class SearchUnit {

  String admin_area;
  String parent_city;
  String location;


  @override
  SearchUnit(String _admin_area, _parent_city, _location) {

    admin_area = _admin_area;
    parent_city = _parent_city;
    location = _location;

    print ('search detail : ' + _admin_area +' ' + _parent_city + ' '+ _location );


  }

  String getAdminArea () {

    return admin_area;


  }

  String getParentCity () {

    return parent_city;


  }

  String getLocation () {

    return location;


  }



}