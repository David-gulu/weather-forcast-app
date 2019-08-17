//bean

class LifeStyleUnit {

  String _type;  //生活指数类别，洗车度，防晒度等
  String _brf;  //生活指数简介
  String _txt;   //生活指数详细描述

  @override
  LifeStyleUnit(String type, String brf, String txt) {
    _type = type;
    _brf = brf;
    _txt = txt;

    //print('styleunit: ' + type + ' ' + brf + ' ' + txt);

  }

  String getType() {

    return _type;


  }

  String getBrf() {

    return _brf;


  }

  String getTxt() {

    return _txt;


  }



}