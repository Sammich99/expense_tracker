class UserFields {
  static final String transaction = 'Transaction';
  static final String amount = 'Amount';
  static final String expense_income = 'Expense/Income';

  static List<String> getFields() => [transaction, amount, expense_income];

  static fromSheets(List<String> value) {}
}