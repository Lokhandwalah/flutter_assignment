import 'package:assignment/app/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:toast/toast.dart';
import '../utils/validations.dart';
import '../utils/color_styles.dart';
import '../utils/date_time_picker.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/dialogs.dart';
import '../../domain/models/user.dart';
import '../../data/services/database.dart';

class SignupScreen extends StatefulWidget {
  static final String route = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _handleBackPressed,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'User Registration',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: primary),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Please fill up all the details',
                      style: TextStyle(color: primary, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    _buildNameField(),
                    _buildeditField(),
                    _buildDateField(),
                    _buildAddressField(),
                    _buildBankAccField(),
                    _buildIFSCField(),
                    _buildGithubField(),
                    MyButton(
                        title: 'Register',
                        btnColor: primary,
                        titleColor: white,
                        action: _handleSignup),
                    SizedBox(height: 30)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  MyTextField _buildGithubField() {
    return MyTextField(
      child: TextFormField(
        keyboardType: TextInputType.streetAddress,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Github Handle is required'),
          PatternValidator(r'^[A-Za-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}$',
              errorText: 'Invalid Github Handle'),
        ]),
        onSaved: (val) => user.gitHandle = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: FontAwesome.github, label: 'Github Handle'),
      ),
    );
  }

  MyTextField _buildIFSCField() {
    return MyTextField(
      child: TextFormField(
        keyboardType: TextInputType.streetAddress,
        validator: MultiValidator([
          RequiredValidator(errorText: 'IFSC code is required'),
          PatternValidator(r'^[A-Z]{4}0[A-Z0-9]{6}$',
              errorText: 'Invalid IFSC code')
        ]),
        onSaved: (val) => user.ifscCode = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: Icons.subject, label: 'IFSC'),
      ),
    );
  }

  MyTextField _buildBankAccField() {
    return MyTextField(
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Bank Acc no is required'),
          LengthRangeValidator(
              exact: 14, errorText: 'Bank Acc No must be 14 digits long')
        ]),
        onSaved: (val) => user.bankAccNo = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: Icons.account_balance_outlined,
            label: 'Bank Account No'),
      ),
    );
  }

  MyTextField _buildAddressField() {
    return MyTextField(
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        minLines: 1,
        textCapitalization: TextCapitalization.sentences,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Address is required'),
          MinLengthValidator(5, errorText: 'Address too short'),
        ]),
        onSaved: (val) => user.address = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: Icons.location_city, label: 'Address'),
      ),
    );
  }

  MyTextField _buildDateField() {
    return MyTextField(
      child: DateTimeField(
        onShowPicker: DateTimePicker().datePicker,
        format: DateFormat('dd/MM/yyyy'),
        validator: DateValidator(errorText: 'Birth date Required'),
        onSaved: (val) => user.dob = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: Icons.calendar_today_outlined, label: 'Birth Date'),
      ),
    );
  }

  MyTextField _buildeditField() {
    return MyTextField(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Email is required'),
          EmailValidator(errorText: 'Invalid Email'),
        ]),
        onSaved: (val) => user.email = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: Icons.email_outlined, label: 'Email'),
      ),
    );
  }

  MyTextField _buildNameField() {
    return MyTextField(
      child: TextFormField(
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Name is required'),
          MinLengthValidator(3, errorText: 'Name too short'),
          WordCountValidator(2, errorText: 'First and Last name required')
        ]),
        onSaved: (val) => user.name = val,
        decoration: MyTextField.textFieldDecoration(
            prefixIcon: Icons.person_outline, label: 'Full Name'),
      ),
    );
  }

  void _handleSignup() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool confirm = await showConfirmationDialog(
        context,
        title: 'Confirm',
        content: 'Proceed with these entererd details',
      );
      if (confirm) {
        showLoader(context, canPop: true);
        await DatabaseService().createUser(user);
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (_) => DialogBox(
            title: 'Done',
            content: 'User Registration Succesfull!',
            btn1Text: 'Ok',
            btn1Func: () => Navigator.of(context).pop(),
            btn1Color: primary,
          ),
        );
        setState(() {
          _autovalidateMode = AutovalidateMode.disabled;
          _formKey.currentState.reset();
        });
      }
    } else
      setState(() => _autovalidateMode = AutovalidateMode.always);
  }

  DateTime currentBackPressTime;
  Future<bool> _handleBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show('Press back again to exit', context,
          backgroundColor: Colors.white, textColor: Colors.black);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
