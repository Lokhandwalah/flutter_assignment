import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/user.dart';

abstract class Database {
  static final db = FirebaseFirestore.instance;
  final users = db.collection('users');
  Future createUser(User user);
  Future getUser(String userEmail);
}

class DatabaseService extends Database {
  @override
  Future<void> createUser(User user) async {
    await Database.db.runTransaction(
      (transaction) async => transaction.set(
        users.doc(user.email),
        {
          'name': user.name,
          'email': user.email,
          'birth_date': user.dob,
          'adress': user.address,
          'bank_acc_no': user.bankAccNo,
          'IFSC_code': user.ifscCode,
          'github_handle': user.gitHandle
        },
      ),
    );
  }

  @override
  Future<User> getUser(String userEmail) async {
    DocumentSnapshot userDoc;
    await Database.db.runTransaction((transaction) async {
      userDoc = await transaction.get(users.doc(userEmail));
    });
    return User.fromDoc(userDoc);
  }
}
