

import 'package:expense_tracker/user.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "coral-shift-348919",
  "private_key_id": "428b97a38cc505b95007007c5dcf4de5487578eb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDA4ZyPrRwXiwUm\nYZjPPRsMFvUKbJ38CB2xTiAlCDHZDCvWOXIDTHIAVyBW2CoV9Wq9yGcTV8z0rAck\nkJEmCQNPa7B1IMXRAbbTyAAClX4CptO9Plik2B2rj8N6zzg0pQSYjb9k/M6lJ7/K\nNhf5AqU1ar2LmwqWu5aSrXXnp2svCssDW7vky9PjXGfTp98MZnPeORgwKp8ouQis\n1q8D6brEBPTgS9o39dF2JHXJBC02E/AMuirvrjBPuFPWtB2GMJagFQK96NVaWZyp\nHs5OlgwDxk65EzFTuVygZBm9rA3iUEx3e/GmhbHr4Tqk9pUMXinadtah0kNCBx2Y\nNxs7TrVTAgMBAAECggEAO8XO5FGDqqIY4veMyPBJUPpOTsAxR1jmhrtMx90dwYL9\nlMIxnGcUzxkw+ui7RhnLTevsUXi8mbgz8Hdim9RgM70OLoYM94Pd+gx5QFO+fKjh\nZjyLcO5OZ4vCSu0roFjhLzuCLBQSH+lNDKetzyusMf0Vp01RPzv74hGiP7tIwoc+\nUmTlSsqOAxkCkXYbrfftCUgb6MA4SgqsbfIa67rUdHjLX3Ios8l7hYIpV4LWp8oU\n5mpCD529BjHGMeFLBfv2JtP035ULn+00lzlqUkM/ae3VZWmz0kFFusUk0RHEKYIE\n5KtS+acJwAjsdNal2erk8HTYOdsYY0M45GET83eUiQKBgQDpyXybHSU4uyzBoZzA\nLlbHCsL5ERvR2hJ3O7Mp9iUsgAk1TtvTB+Z1MnLWNWxN0y7G21VfhmkrAkEEFrSK\nxXU6BWn1sWihrWdI4Gge4JMnIqoA/vCySHk5y5FPjPm/ZBPQBhjBG/V/dZwMWMcd\nSsVillZaZxxdgQL9i6KxMV8IOQKBgQDTNSeUMdSXZHmra6vGaUtHCdzMirVre7n0\nc8XSlr4UrK1HOcnstJeg5f/AKhgM1PEQWt5IAZ2MuxzXSfjeX2jKl1oJV617hIzG\nfwTNxhzWz1wUnGrYfTeG7tQ4KMkugS78ylM+F4SQYWaL1eY8rRKmqlL8EojYJ7Ax\neWRqr/lx6wKBgQDcgZSr4UOYTMMcJ0jn400qE7ZuoXpx5pQALikA7Q+G94S36Rdh\n5lOyOtEhxeXPSd8W5Q2TOf27+TZFmvzS3weAoFaezKR5ykpe7HqIlR12jjV3Fv8D\nyWO95Ym7VKbDpKsjTHzQt4RIoi97XckAkeO250Gvpw2UC/k8GBZttrmB0QKBgCGv\n57kuXX8sKm/aA5Lo9nXFL+977EXRfS5tTM8y9exsQlMK95cGkuy54pnu3NknGbAH\nHk8T2uI4cfgwtz4Yr6kojNbSojwCP0XluolroOvuNPygmjYferzN2RGAB96gAjOV\nvcM4kw9IScfh/RAOdtwYbJYCCsuXQPYTK54MpVezAoGAUXIJG0OM93LxMyjEhHLX\nk2Xx+cihP3Qm4FN+IGGP87qyWf9vCXHhxpFdxs9CmIXohYbMRGG9ZKzlUIMDqhMw\ntmEMfP3EjWn+VRw3XEEOBreDqlOeVNwo/5AflYFV/EHON0yGzE6BZy14FqmvLJcm\nmZiIGSo1ZKu35rKMA1jQnL8=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-tutorial@coral-shift-348919.iam.gserviceaccount.com",
  "client_id": "114062271528585166507",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-tutorial%40coral-shift-348919.iam.gserviceaccount.com"
}
  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1ixw1gdr8uH_XPisiHi8ji-Fqiesrj6EaH2uuYUzoi_8';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true; 

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();

    final firstRow = UserFields.getFields();
    _worksheet!.values.insertRow(1, firstRow);
     
  }


  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }
  
 
  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  Future<List> gettransaction() async {
    final values = (await _worksheet!.values.allRows()).skip(1).toList();
    return values.map((value) => UserFields.fromSheets(value)).toList();
  }

  /* Future<bool> deletetransaction(int index) {
    return _worksheet!.deleteRow(index + 2);
  } */
  

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }

 

}