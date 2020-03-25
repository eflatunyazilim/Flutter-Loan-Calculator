import 'dart:math';

import 'package:calculator/model/credit_table_model.dart';
import 'package:calculator/table_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatefulWidget {
  @override
  _CreditPageState createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> with TickerProviderStateMixin {

  List<int> creditTermMonthly = [];
  List<int> creditTermYearly = [];

  double creditAmount; // Girilen kredi tutarı
  double interest; // Girilen faiz
  int creditTermM; // Girilen vade ihtiyaç
  int creditTermY; // Girilen vade konut
  double bsmv = 0.05; // girilen bsmv
  double kkdf = 0.15; // girilen kkdf
  double mainCurrency;

  TabController _tabController;
  bool isVisible = false;
  double contSize = 300.0;

  // todo: for Localization
  String descriptionTitle = "Konut Kredi Teklifleri";
  String description =
      "Ev satın alırken istediğinizde size uygun konut veya "
      "ihtiyaç kredisi oranlarını .... uygulaması üzerinden "
      "tek bir sayfada kaşılaştırarak, kredi başvurunuzu "
      "kolaylıkla yapabilirsiniz.";
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);

    for (int i = 0; i < 60; i++) {
      creditTermMonthly.add((i + 1));
    }
    for (int i = 0; i < 30; i++) {
      creditTermYearly.add((i + 1) * 12);
    }

    super.initState();
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

  Widget tabBar() {
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
                          child: Text(descriptionTitle,style: TextStyle(fontSize: 16,color: Colors.black),),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(description),
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
                                    insets: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 40.0),
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
                            height: contSize,
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
                                      // Kredi Tutarı input
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
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
                                            keyboardType: TextInputType.number,
                                            onChanged: (input) {
                                              creditAmount =
                                                  double.parse(input);
                                              debugPrint(
                                                  "creditAmount : $creditAmount");
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Faiz input
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
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
                                            keyboardType: TextInputType.number,
                                            onChanged: (input) {
                                              interest = double.parse(input);
                                              debugPrint("interest: $interest");
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Vade input
                                      Flexible(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                            child: DropdownButton<int>(
                                              hint: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text("Vade"),
                                              ),
                                              value: creditTermY,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              onChanged: (int newValue) {
                                                setState(() {
                                                  creditTermY = newValue;
                                                });
                                              },
                                              items: creditTermYearly
                                                  .map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Text(
                                                        value.toString() +
                                                            " Ay"),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: FlatButton(
                                            child: Text(
                                              "Gelişmiş Seçenekler",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueAccent),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                                if (isVisible) {
                                                  contSize = 400.0;
                                                } else {
                                                  contSize = 300.0;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
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
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (input) {
                                                setState(() {
                                                  if (input != null &&
                                                      input != "" &&
                                                      double.parse(input) >
                                                          0.0) {
                                                    kkdf = double.parse(input);
                                                    debugPrint("kkdf: $kkdf");
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: SizedBox(
                                          height: 10,
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
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
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (input) {
                                                setState(() {
                                                  if (input != null &&
                                                      input != "" &&
                                                      double.parse(input) >
                                                          0.0) {
                                                    bsmv = double.parse(input);
                                                    debugPrint("kkdf: $bsmv");
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Flexible(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                            onPressed: () {
                                              calculators(creditTermY).then((value){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TablePage(
                                                              creditTableList: creditModelList,
                                                              creditAmount: creditAmount,
                                                              creditTerm: creditTermY,
                                                              interest: interest,
                                                              bsmv: bsmv,
                                                              kkdf: kkdf,
                                                              installment: installment,
                                                            )));
                                              },onError: (error){
                                                debugPrint("Hata => " + error.toString());
                                              });
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
                                      // Kredi Tutarı input
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
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
                                            keyboardType: TextInputType.number,
                                            onChanged: (input) {
                                              creditAmount =
                                                  double.parse(input);
                                              debugPrint(
                                                  "creditAmount : $creditAmount");
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Faiz input
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
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
                                            keyboardType: TextInputType.number,
                                            onChanged: (input) {
                                              interest = double.parse(input);
                                              debugPrint("interest: $interest");
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Vade input
                                      Flexible(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                            child: DropdownButton<int>(
                                              hint: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text("Vade"),
                                              ),
                                              value: creditTermM,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              onChanged: (int newValue) {
                                                setState(() {
                                                  creditTermM = newValue;
                                                });
                                              },
                                              items: creditTermMonthly
                                                  .map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                        value.toString() +
                                                            " Ay"),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: FlatButton(
                                            child: Text(
                                              "Gelişmiş Seçenekler",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueAccent),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                                if (isVisible) {
                                                  contSize = 400.0;
                                                } else {
                                                  contSize = 300.0;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
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
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (input) {
                                                setState(() {
                                                  if (input != null &&
                                                      input != "" &&
                                                      double.parse(input) >
                                                          0.0) {
                                                    kkdf = double.parse(input);
                                                    debugPrint("kkdf: $kkdf");
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: SizedBox(
                                          height: 10,
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
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
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (input) {
                                                setState(() {
                                                  if (input != null &&
                                                      input != "" &&
                                                      double.parse(input) >
                                                          0.0) {
                                                    bsmv = double.parse(input);
                                                    debugPrint("kkdf: $bsmv");
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Flexible(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TablePage(creditTableList: creditModelList,)));
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
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

  CreditTableModel creditTableModel;
  List<CreditTableModel> creditModelList = [];

  double taxInterest; // Vergi faizi
  double temp1, temp2; // değişkenler
  double installment; // aylık taksit
  double mainRemainingMoney; // Kalan ana para

  Future<void> calculators(int lenght) async{

    //    $ vergi_faiz = ( $ faiz / 100 ) * ( 1 + $ bsmv + $ kkdf );
    //    $ deger1 = $ vergi_faiz * pow (( 1 + $ vergi_faiz ), $ vade );
    //    $ deger2 = pow (( 1 + $ vergi_faiz ), $ vade ) - 1 ;
    //    $ taksit = $ kredi * $ deger1 / $ deger2 ;
    taxInterest = (interest / 100) * (1 + bsmv + kkdf);
    temp1 = taxInterest * pow((1 + taxInterest), lenght);
    temp2 = pow((1 + taxInterest), lenght) - 1;
    installment = creditAmount * temp1 / temp2;

    for (int row = 0; row < lenght; row++) {
      creditTableModel = new CreditTableModel();
      if (row == 0) {
        // $ _taksit = $ taksit ;
        // $ _faiz = $ kredi * ( $ faiz / 100 );
        //$ _kkdf = $ _faiz * $ kkdf ;
        //$ _bsmv = $ _faiz * $ bsmv ;
        //	$ _anapara = $ taksit - ( $ _faiz + $ _kkdf + $ _bsmv );
        //$ _kalananapara = $ kredi - $ _anapara ;
        creditTableModel.installment = installment;
        creditTableModel.interest = creditAmount * (interest / 100);
        creditTableModel.kkdf = creditTableModel.interest * kkdf;
        creditTableModel.bsmv = creditTableModel.interest * bsmv;
        creditTableModel.mainCurrency = installment -
            (creditTableModel.interest +
                creditTableModel.kkdf +
                creditTableModel.bsmv);

        mainRemainingMoney = creditAmount - creditTableModel.mainCurrency;
        creditTableModel.mainRemainingMoney = mainRemainingMoney;
        creditModelList.add(creditTableModel);

      }else{
        // $ _taksit = $ taksit ;
        // $ _faiz = $ _kalananapara * ( $ faiz / 100 );
        // $ _kkdf = $ _faiz * $ kkdf ;
        // $ _bsmv = $ _faiz * $ bsmv ;
        // $ _anapara = $ taksit - ( $ _faiz + $ _kkdf + $ _bsmv );
        // $ _kalananapara = $ _kalananapara - $ _anapara ;
        creditTableModel.installment = installment;
        creditTableModel.interest = mainRemainingMoney * (interest / 100);
        creditTableModel.kkdf = creditTableModel.interest * kkdf;
        creditTableModel.bsmv = creditTableModel.interest * bsmv;
        creditTableModel.mainCurrency =
            installment - (creditTableModel.interest + creditTableModel.kkdf + creditTableModel.bsmv);
        mainRemainingMoney = mainRemainingMoney - creditTableModel.mainCurrency;
        creditTableModel.mainRemainingMoney = mainRemainingMoney;

        creditModelList.add(creditTableModel);
      }
      //
    }
    for(int i=0;i<lenght;i++){
      debugPrint(creditModelList[i].mainRemainingMoney.toString());
    }


  }

}
