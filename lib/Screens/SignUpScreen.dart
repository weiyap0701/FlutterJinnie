import 'package:flutter/material.dart';

//non-library
import 'package:jinnie/Utils/Helper.dart';
import 'package:jinnie/API/ApiHandler.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  var _isLoading = false;
  String _firstNameText;
  String _lastNameText;
  String _emailText;
  String _passwordText;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  _performRegisterUser() {
    setState(() {
      _isLoading = true;
    });

    LoginRegApiHandler.registerUser(this._emailText, this._passwordText, this._firstNameText, this._lastNameText).then((userModel) {
      setState(() {
        _isLoading = false;
      });
      if (userModel != null) {
        print(userModel.email);
      }
      else {
        Helper.showErrorDialog(context);
      }
    });
  }

  _signUpButtonPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performRegisterUser();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget _loadingIndicator() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  TextFormField _buildFirstNameTextField() {
    return new TextFormField(
      onSaved: (val) {
        this._firstNameText = val;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFFdfe3ee), width: 0.8),
          ),
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          icon: Icon(Icons.person, color: Colors.blueGrey),
          labelText: "First Name",
          hintText: "Enter your first name"),
    );
  }

  TextFormField _buildLastNameTextField() {
    return new TextFormField(
      onSaved: (val) {
        this._lastNameText = val;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFFdfe3ee), width: 0.8),
          ),
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          icon: Icon(Icons.person, color: Colors.blueGrey),
          labelText: "Last Name",
          hintText: "Enter your last name"),
    );
  }

  TextFormField _buildEmailTextField() {
    return new TextFormField(
      onSaved: (val) {
        this._emailText = val;
      },
      validator: Helper.validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFFdfe3ee), width: 0.8),
          ),
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          icon: Icon(Icons.email, color: Colors.blueGrey),
          labelText: "Email",
          hintText: "Enter your email"),
    );
  }

  TextFormField _buildPasswordTextField() {
    return new TextFormField(
      onSaved: (val) {
        this._passwordText = val;
      },
      obscureText: true,
      validator: Helper.validatePassword,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFFdfe3ee), width: 0.8),
          ),
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          icon: Icon(Icons.lock, color: Colors.blueGrey),
          labelText: "Password",
          hintText: "Enter your password"),
    );
  }

  Widget _buildTermsView() {
    return new ListTile(
        title: Text(
      "By signing up, I agree to Jinnie's Terms & Conditions and Privacy Policy.",
      style: TextStyle(fontSize: 14.0),
    ));
  }

  RaisedButton _buildSignUpButton() {
    return new RaisedButton(
        onPressed: () {
          _signUpButtonPressed();
        },
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 45.0,
              alignment: Alignment.center,
              child: new Text("Join Now",
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Sign Up"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: new SafeArea(
          top: false,
          bottom: false,
          child: _isLoading
              ? _loadingIndicator()
              : new ListView(
                  controller: _scroll,
                  padding: const EdgeInsets.fromLTRB(16.0, 26.0, 16.0, 16.0),
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          _buildFirstNameTextField(),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          _buildLastNameTextField(),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          _buildEmailTextField(),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          _buildPasswordTextField(),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          _buildTermsView(),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          _buildSignUpButton(),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
