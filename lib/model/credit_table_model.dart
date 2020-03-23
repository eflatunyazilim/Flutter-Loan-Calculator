class CreditTableModel {
  double installmentAmount;
  double mainCurrency;
  double interest;
  double kkdf;
  double bsmv;
  double mainRemainingMoney;

  CreditTableModel({
    this.installmentAmount,
    this.mainCurrency,
    this.interest,
    this.kkdf,
    this.bsmv,
    this.mainRemainingMoney,
  });

//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['installmentAmount'] = this.installmentAmount;
//    data['mainCurrency'] = this.mainCurrency;
//    data['interest'] = this.interest;
//    data['kkdf'] = this.kkdf;
//    data['bsmv'] = this.bsmv;
//    data['mainRemainingMoney'] = this.mainRemainingMoney;
//    return data;
//  }

}
