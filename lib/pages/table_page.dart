import 'package:flutter_loan_calculator/models/table_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  final List<CreditTableModel> creditTableList;
  final double creditAmount;
  final int creditTerm;
  final double interest;
  final double bsmv;
  final double kkdf;
  final double installment;

  TablePage({
    this.creditTableList,
    this.creditAmount,
    this.creditTerm,
    this.interest,
    this.bsmv,
    this.kkdf,
    this.installment,
  });

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  // todo: for localizations
  // todo: String ifadeler yerine localization bilgisi girilebilir
  String tableAppBarTitle = "Ödeme Tablosu";
  String creditAmountText = "Kredi Tutarı";
  String installmentText = "Taksit Tutarı";
  String creditTermText = "Kredi Vadesi";
  String bsmvText = "BSMV";
  String kkdfText = "KKDF";
  String creditInterestText = "Kredi Faizi";
  String periodText = "Dönem";
  String mainMoneyText = "Ana Para";
  String interestText = "Faiz";
  String remainingMainMoneyText = "Kalan Ana Para";
  String moneyType = " TL";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tableAppBarTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 11,
              margin: EdgeInsets.all(11),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: dataBodyTitle(),
                ),
              ),
            ),
            Card(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget dataBodyTitle() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
            label: Text(
              creditAmountText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              creditTermText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              creditInterestText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              bsmvText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              kkdfText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              installmentText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
      ],
      rows: <DataRow>[
        DataRow(
          cells: [
            DataCell(
              Text(widget.creditAmount.toStringAsFixed(2)),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(widget.creditTerm.toString()),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(widget.interest.toStringAsFixed(2)),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(widget.bsmv.toStringAsFixed(2)),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(widget.kkdf.toStringAsFixed(2)),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(widget.installment.toStringAsFixed(2)),
              showEditIcon: false,
              placeholder: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget dataBody() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
            label: Text(
              periodText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              installmentText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              mainMoneyText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              interestText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              kkdfText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              bsmvText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              remainingMainMoneyText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
      ],
      rows: widget.creditTableList
          .map((dataRow) => DataRow(cells: [
        DataCell(
          Text(
              (widget.creditTableList.indexOf(dataRow) + 1).toString()),
          showEditIcon: false,
          placeholder: false,
        ),
        DataCell(
          Text(dataRow.installment.toStringAsFixed(2) + moneyType),
          showEditIcon: false,
          placeholder: false,
        ),
        DataCell(
          Text(dataRow.mainCurrency.toStringAsFixed(2)),
          showEditIcon: false,
          placeholder: false,
        ),
        DataCell(
          Text(dataRow.interest.toStringAsFixed(2)),
          showEditIcon: false,
          placeholder: false,
        ),
        DataCell(
          Text(dataRow.kkdf.toStringAsFixed(2)),
          showEditIcon: false,
          placeholder: false,
        ),
        DataCell(
          Text(dataRow.bsmv.toStringAsFixed(2)),
          showEditIcon: false,
          placeholder: false,
        ),
        DataCell(
          Text(dataRow.mainRemainingMoney.toStringAsFixed(2)),
          showEditIcon: false,
          placeholder: false,
        ),
      ]))
          .toList(),
    );
  }
}
