import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name, email, address, bankAccNo, ifscCode, gitHandle;
  DateTime dob;
  DocumentSnapshot userDoc;
  User(
      {this.name,
      this.email,
      this.address,
      this.bankAccNo,
      this.ifscCode,
      this.gitHandle,
      this.dob});

  User.fromDoc(this.userDoc) {
    final data = userDoc.data();
    name = data['name'];
    email = data['email'];
    dob = data['birth_date'];
    address = data['address'];
    bankAccNo = data['bank_acc_no'];
    ifscCode = data['IFSC_code'];
    gitHandle = data['github_handle'];
  }

  @override
  String toString() {
    String msg = 'UserInfo:';
    msg += '\nName: $name';
    msg += '\nEmail: $email';
    msg += '\nDate of Birth: $dob';
    msg += '\nAddress: $address';
    msg += '\nBankAccNo: $bankAccNo';
    msg += '\nIFSC: $ifscCode';
    msg += '\nGtihub: $gitHandle';
    return msg;
  }
}
