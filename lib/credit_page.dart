import 'package:calculator/table_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatefulWidget {
  @override
  _CreditPageState createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> with TickerProviderStateMixin {
  List<String> _credits = [
    '12 Ay',
    '24 Ay',
    '36 Ay',
    '48 Ay',
    '60 Ay',
    '72 Ay',
    '84 Ay',
    '96 Ay',
    '108 Ay',
    '120 Ay',
    '120 Ay',
    '132 Ay',
    '144 Ay',
    '156 Ay',
    '168 Ay',
    '180 Ay'
  ];

  double bsmv = 0.05;
  double kkdf = 0.15;



  String dropdownValue;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return tabBar();
  }

  Widget tabBar(){
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          DefaultTabController(
            length: 2,
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding:
                          EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Text("Konut Kredi Teklifleri"),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "Ev satın alırken istediğinizde size uygun konut veya "
                                  "ihtiyaç kredisi oranlarını .... uygulaması üzerinden "
                                  "tek bir sayfada kaşılaştırarak, kredi başvurunuzu "
                                  "kolaylıkla yapabilirsiniz."),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Tab bar butonları
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade200),
                              ),
                              child: Container(
                                //color: Colors.redAccent,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                child: TabBar(
                                  //onTap: (e){debugPrint(e.toString());},
                                  //indicatorSize:TabBarIndicatorSize.label,// Üstteki çubuk küçüldü
                                  //unselectedLabelStyle: TextStyle(backgroundColor: Colors.grey.shade400,),
                                  //labelStyle: TextStyle(color: Colors.redAccent),

                                  controller: _tabController,
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.black,
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 4.0,
                                    ),
                                    insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                                  ),
                                  tabs: <Widget>[
                                    /*Container(
                                      height: 35,
                                      child: Text("Konut Kredisi"),
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      height: 35,
                                      alignment: Alignment.center,
                                      child: Text("İhtiyaç Kredisi"),
                                    ),*/
                                    Tab(
                                      text: "Konut Kredisi",
                                    ),
                                    Tab(
                                      text: "İhtiyaç Kredisi",
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Tab bar elemanları
                          Container(
                            height: 300,
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                Tab(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Kredi Tutarı",
                                              labelStyle: TextStyle(
                                                  color: Colors.black54),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 10),
                                            ),
                                            keyboardType:
                                            TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10,  right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Faiz",
                                              labelStyle: TextStyle(
                                                  color: Colors.black54),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 10),
                                            ),
                                            keyboardType:
                                            TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              hint: Padding(
                                                padding:
                                                EdgeInsets.only(left: 10),
                                                child: Text("Vade"),
                                              ),
                                              value: dropdownValue,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                              items: _credits.map<
                                                  DropdownMenuItem<
                                                      String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(value),
                                                      ),
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: FlatButton(
                                            child: Text("Gelişmiş Seçenekler",style: TextStyle(fontSize: 12,color: Colors.blueAccent),),
                                            onPressed: (){
                                              settings();
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          color: Colors.blue,
                                          child: FlatButton(
                                            child: Text(
                                              "Konut Kredisi Hesapla",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TablePage()));
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Kredi Tutarı",
                                              labelStyle: TextStyle(
                                                  color: Colors.black54),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 10),
                                            ),
                                            keyboardType:
                                            TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10,  right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Faiz",
                                              labelStyle: TextStyle(
                                                  color: Colors.black54),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 10),
                                            ),
                                            keyboardType:
                                            TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              hint: Padding(
                                                padding:
                                                EdgeInsets.only(left: 10),
                                                child: Text("Vade"),
                                              ),
                                              value: dropdownValue,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                              items: _credits.map<
                                                  DropdownMenuItem<
                                                      String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(value),
                                                      ),
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          color: Colors.blue,
                                          child: FlatButton(
                                            child: Text(
                                              "İhtiyaç Kredisi Hesapla",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TablePage()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void settings() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Text("Gelişmiş Ayarlar",
                style: TextStyle(fontSize: 20,),
                textAlign: TextAlign.center,
              ),
              Divider(),
            ],
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: TextFormField(
                      initialValue: kkdf.toString(),
                      decoration: InputDecoration(
                        labelText: "KKDF",
                        labelStyle: TextStyle(
                            color: Colors.black54),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 10),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (input){
                        kkdf = double.parse(input);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: TextFormField(
                      initialValue: bsmv.toString(),
                      decoration: InputDecoration(
                        labelText: "BSMV",
                        labelStyle: TextStyle(
                            color: Colors.black54),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 10),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (input){
                        bsmv = double.parse(input);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 11,
          actions: <Widget>[
            FlatButton(
              child: Text("OK",style: TextStyle(color: Colors.blueAccent),),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

}
