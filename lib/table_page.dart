import 'package:flutter/material.dart';
import 'model/credit_table_model.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  var credits = <CreditTableModel>[
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount:  1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount:  1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
    CreditTableModel(
        installmentAmount: 1100.55,
        mainCurrency: 100000.00,
        interest: 0.9,
        kkdf: 0.05,
        bsmv: 0.15,
        mainRemainingMoney: 98000.15),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ödeme Tablosu"),
        ),
        body: Card(
          elevation: 11,
          margin: EdgeInsets.all(11),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: dataBody(),
              ),
            ),
          ),
        ));
  }

  Widget dataBody() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
            label: Text("Dönem"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text("Taksit Tutarı"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text("Ana Para"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text("Faiz"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text("KKDF"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text("BSMV"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text("Kalan Ana Para"),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
      ],
      rows: credits
          .map((dataRow) => DataRow(cells: [
                DataCell(
                  Text((credits.indexOf(dataRow)+1).toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.installmentAmount.toString() + " TL"),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.mainCurrency.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.interest.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.kkdf.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.bsmv.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.mainRemainingMoney.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
              ]))
          .toList(),
    );
  }
}
