library flutter_loan_calculator;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_loan_calculator/models/table_model.dart';
import 'package:flutter_loan_calculator/pages/table_page.dart';

class PaymentGenerator extends StatefulWidget {

  final String description;

  const PaymentGenerator({Key key, this.description}) : super(key: key);

  @override
  _PaymentGeneratorState createState() => _PaymentGeneratorState();
}

class _PaymentGeneratorState extends State<PaymentGenerator>
    with SingleTickerProviderStateMixin {

  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool isSelectedLeft = true;
  TabController _tabController;
  bool isVisible = false; // Gelişmiş seçenekler görünürlük
  double contSize = 300.0; // Card dynamic yükseklik
  double creditAmount; // Girilen kredi tutarı
  double interest; // Girilen faiz
  int creditTermM; // Girilen vade ihtiyaç
  int creditTermY; // Girilen vade konut
  double bsmv = 0.05; // Girilen bsmv default 0.05
  double kkdf = 0.15; // Girilen kkdf default 0.15
  List<int> creditTermMonthly = []; // Aylık Vade Dropdown listesi
  List<int> creditTermYearly = []; // Yıllık Vade Dropdown listesi

  // hesaplama method değişkenleri
  CreditTableModel creditTableModel;
  List<CreditTableModel> creditModelList = [];
  double taxInterest; // Vergi faizi
  double temp1, temp2; // değişkenler
  double installment; // aylık taksit
  double mainRemainingMoney; // Kalan ana para

  String description = "Ev satın alırken istediğinizde size uygun konut veya "
      "ihtiyaç kredisi oranlarını buradan kolaylıkla hesaplayabilirsiniz.";

  // todo: for Localization
  String descriptionTitle = "Konut Kredi Teklifleri";
  String tabFirstTitle = "Konut Kredisi";
  String tabSecondTitle = "İhtiyaç Kredisi";
  String creditAmountInputLabelText = "Kredi Tutarı";
  String interestInputLabelText = "Faiz";
  String termDropDownText = "Vade";
  String monthText = " Ay";
  String settingsButtonText = "Gelişmiş Seçenekler";
  String bsmvText = "BSMV";
  String kkdfText = "KKDF";
  String firstCalculatorButtonText = "Konut Kredisi Hesapla";
  String secondCalculatorButtonText = "İhtiyaç Kredisi Hesapla";
  String validatorWarning = "Lütfen bu alanı doldurun!";
  String validatorWarning2 = "Lütfen kullanılabilir değer girin!";

  @override
  void initState() {

    if(widget.description != null){
      description = widget.description;
    }

    _tabController = new TabController(vsync: this, length: 2);

    creditTermY = 12;
    creditTermM = 1;

    for (int i = 0; i < 60; i++) {
      creditTermMonthly.add((i + 1));
    }
    for (int i = 0; i < 30; i++) {
      creditTermYearly.add((i + 1) * 12);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: tabBar(),
    );
  }

  Widget tabBar() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: DefaultTabController(
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
                              alignment: Alignment.centerLeft,
                              padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Text(
                                descriptionTitle,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(description),
                            ),
                            SizedBox(
                              height: 10,
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
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(11)),
                                  ),
                                  child: Container(
                                    height: 40,
                                    margin:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      alignment: isSelectedLeft
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              2.5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(11)),
                                            /*border: Border(
                                              top: BorderSide(color: Colors.grey.shade400, width: 40.0),
                                            ),*/
                                          ),
                                        ),
                                        TabBar(
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
                                          onTap: (index) {
                                            setState(() {
                                              isSelectedLeft =
                                              index == 0 ? true : false;
                                            });
                                          },
                                          tabs: <Widget>[
                                            Tab(
                                              text: tabFirstTitle,
                                            ),
                                            Tab(
                                              text: tabSecondTitle,
                                            )
                                          ],
                                        ),
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
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Tab(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          // Kredi Tutarı input
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  creditAmountInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.02,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                onSaved: (input) {
                                                  setState(() {
                                                    creditAmount =
                                                        double.parse(input);
                                                  });
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
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
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  interestInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                onSaved: (input) {
                                                  interest =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Vade input
                                          Flexible(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              child:
                                              DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<
                                                    int>(
                                                  hint: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child:
                                                    Text(termDropDownText),
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
                                                  items: creditTermYearly.map<
                                                      DropdownMenuItem<
                                                          int>>((int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        child: Text(
                                                            value.toString() +
                                                                monthText),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Gelişmiş Seçenek inputları
                                          Flexible(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: FlatButton(
                                                child: Text(
                                                  settingsButtonText,
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
                                          // KKDF
                                          Visibility(
                                            visible: isVisible,
                                            child: Flexible(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: TextFormField(
                                                  onTap: () {
                                                    _autoValidate = false;
                                                  },
                                                  initialValue: kkdf.toString(),
                                                  decoration: InputDecoration(
                                                    labelText: kkdfText,
                                                    labelStyle: TextStyle(
                                                        color: Colors.black54),
                                                    errorStyle: TextStyle(
                                                        height: 0.04,
                                                        fontSize: 10),
                                                    border:
                                                    OutlineInputBorder(),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        left: 10),
                                                  ),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  onSaved: (input) {
                                                    setState(() {
                                                      kkdf =
                                                          double.parse(input);
                                                    });
                                                  },
                                                  validator: (String value) {
                                                    return validWarn(value);
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
                                          // BSMV
                                          Visibility(
                                            visible: isVisible,
                                            child: Flexible(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: TextFormField(
                                                  onTap: () {
                                                    _autoValidate = false;
                                                  },
                                                  initialValue: bsmv.toString(),
                                                  decoration: InputDecoration(
                                                    labelText: bsmvText,
                                                    labelStyle: TextStyle(
                                                        color: Colors.black54),
                                                    errorStyle: TextStyle(
                                                        height: 0.04,
                                                        fontSize: 10),
                                                    border:
                                                    OutlineInputBorder(),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        left: 10),
                                                  ),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  onSaved: (input) {
                                                    setState(() {
                                                      bsmv =
                                                          double.parse(input);
                                                    });
                                                  },
                                                  validator: (String value) {
                                                    return validWarn(value);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Hesaplama Butonu
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
                                                  firstCalculatorButtonText,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    calculators(creditTermY);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                TablePage(
                                                                  creditTableList:
                                                                  creditModelList,
                                                                  creditAmount:
                                                                  creditAmount,
                                                                  creditTerm:
                                                                  creditTermY,
                                                                  interest:
                                                                  interest,
                                                                  bsmv:
                                                                  bsmv,
                                                                  kkdf:
                                                                  kkdf,
                                                                  installment:
                                                                  installment,
                                                                )));
                                                  } else {
                                                    setState(() {
                                                      _autoValidate = true;
                                                    });
                                                  }
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
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  creditAmountInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                onSaved: (input) {
                                                  creditAmount =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
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
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  interestInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                onSaved: (input) {
                                                  interest =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Vade input
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
                                                    color:
                                                    Colors.grey.shade200),
                                              ),
                                              child:
                                              DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<
                                                    int>(
                                                  hint: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child:
                                                    Text(termDropDownText),
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
                                                  items: creditTermMonthly.map<
                                                      DropdownMenuItem<
                                                          int>>((int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        child: Text(
                                                            value.toString() +
                                                                monthText),
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
                                                  settingsButtonText,
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
                                                child: TextFormField(
                                                  onTap: () {
                                                    _autoValidate = false;
                                                  },
                                                  initialValue: kkdf.toString(),
                                                  decoration: InputDecoration(
                                                    labelText: kkdfText,
                                                    labelStyle: TextStyle(
                                                        color: Colors.black54),
                                                    errorStyle: TextStyle(
                                                        height: 0.04,
                                                        fontSize: 10),
                                                    border:
                                                    OutlineInputBorder(),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        left: 10),
                                                  ),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  onSaved: (input) {
                                                    setState(() {
                                                      kkdf =
                                                          double.parse(input);
                                                    });
                                                  },
                                                  validator: (String value) {
                                                    return validWarn(value);
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
                                                child: TextFormField(
                                                  onTap: () {
                                                    _autoValidate = false;
                                                  },
                                                  initialValue: bsmv.toString(),
                                                  decoration: InputDecoration(
                                                    labelText: bsmvText,
                                                    labelStyle: TextStyle(
                                                        color: Colors.black54),
                                                    errorStyle: TextStyle(
                                                        height: 0.04,
                                                        fontSize: 10),
                                                    border:
                                                    OutlineInputBorder(),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        left: 10),
                                                  ),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  onSaved: (input) {
                                                    setState(() {
                                                      bsmv =
                                                          double.parse(input);
                                                    });
                                                  },
                                                  validator: (String value) {
                                                    return validWarn(value);
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
                                                  secondCalculatorButtonText,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    calculators(creditTermM);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                TablePage(
                                                                  creditTableList:
                                                                  creditModelList,
                                                                  creditAmount:
                                                                  creditAmount,
                                                                  creditTerm:
                                                                  creditTermM,
                                                                  interest:
                                                                  interest,
                                                                  bsmv:
                                                                  bsmv,
                                                                  kkdf:
                                                                  kkdf,
                                                                  installment:
                                                                  installment,
                                                                )));
                                                  } else {
                                                    setState(() {
                                                      _autoValidate = true;
                                                    });
                                                  }
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
            ),
          ],
        ),
      ),
    );
  }

  calculators(int length){
    taxInterest = (interest / 100) * (1 + bsmv + kkdf);
    temp1 = taxInterest * pow((1 + taxInterest), length);
    temp2 = pow((1 + taxInterest), length) - 1;
    installment = creditAmount * temp1 / temp2;

    creditModelList.clear();
    for (int row = 0; row < length; row++) {
      creditTableModel = new CreditTableModel();
      if (row == 0) {
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
      } else {
        creditTableModel.installment = installment;

        creditTableModel.interest = mainRemainingMoney * (interest / 100);

        creditTableModel.kkdf = creditTableModel.interest * kkdf;

        creditTableModel.bsmv = creditTableModel.interest * bsmv;

        creditTableModel.mainCurrency = installment -
            (creditTableModel.interest +
                creditTableModel.kkdf +
                creditTableModel.bsmv);

        mainRemainingMoney = mainRemainingMoney - creditTableModel.mainCurrency;

        creditTableModel.mainRemainingMoney = mainRemainingMoney;

        creditModelList.add(creditTableModel);
      }
    }
  }

  String validWarn(String value) {
    if (value.isEmpty || value == null || value == "null") {
      return validatorWarning;
    } else if (double.parse(value) <= 0) {
      return validatorWarning2;
    } else {
      return null;
    }
  }
}
