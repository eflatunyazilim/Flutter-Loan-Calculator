class CreditTableModel {
  double installment; // Taksit tutarı
  double mainCurrency; // Ana para
  double interest; // Faiz
  double kkdf;
  double bsmv;
  double mainRemainingMoney; // Kalan ana para

  CreditTableModel({
    this.installment,
    this.mainCurrency,
    this.interest,
    this.kkdf,
    this.bsmv,
    this.mainRemainingMoney,
  });


}
