import 'package:flutter/material.dart';

//non-library
import 'package:jinnie/Screens/HomeScreen.dart';
import 'package:jinnie/Screens/SignUpScreen.dart';
import 'package:jinnie/Utils/Helper.dart';
import 'package:jinnie/API/ApiHandler.dart';
import 'package:jinnie/Utils/Constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {

  ScrollController _scroll;
  FocusNode _focus = new FocusNode();

  var _isLoading = false;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  
  String _emailText;
  String _passwordText;
  
  @override
  void dispose() {
    super.dispose();
    _scroll.dispose();
    _focus.dispose();
  }

  @override
  void initState() {
    super.initState();
    
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  _performPushHomeScreen() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  _performLoginUser() {
    setState(() {
      _isLoading = true;          
    });

    LoginRegApiHandler.loginUser(this._emailText, this._passwordText).then((userModel){
      
      if (userModel != null) {
        print(userModel.email);
        setState(() {
          _isLoading = false;
        });
        // Constants.tempAccessToken = "aa";
        _performPushHomeScreen();
      }
      else {
        Helper.showErrorDialog(context);
      }
    });
    
  }

  Widget _loadingIndicator() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  _loginButtonPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performLoginUser();
    }
    else {
      setState(() {
        _autoValidate = true;              
      });
    }
  }

  ListTile _buildLogo() {
    return new ListTile(
      title: Image.network("http://sid.cps.unizar.es/SEMANTICWEB/GENIE/GENIE_files/GENIE%20LOGO.png", width: 200, height: 200,),
      subtitle: Text("Help people and meet new friends around you"),
    );
  }

  TextFormField _buildEmailTextField(String label, String hint) {
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
      validator: Helper.validatePassword,
      obscureText: true,
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

  RaisedButton _buildLoginButton() {
    return new RaisedButton(
      onPressed: (){
        _loginButtonPressed();
      },
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 45.0,
            alignment: Alignment.center,
            child: new Text("Login", style: TextStyle(color: Colors.white, fontSize: 18.0)),
          )
        ],
      )
    );
  }

  RaisedButton _buildFacebookLoginButton() {
    return new RaisedButton(
      onPressed: (){
        _loginButtonPressed();
      },
      color: Color(0XFF3C5A99),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.face, color: Colors.white, size: 25.0),
          Padding(padding: const EdgeInsets.only(left: 4.0, right: 4.0)),
          Container(
            height: 45.0,
            alignment: Alignment.center,
            child: new Text("Continue with Facebook", style: TextStyle(color: Colors.white, fontSize: 16.0)),
          )
        ],
      )
    ); 
  }

  ListTile _buildForgottenAndSignupButton() {
    return ListTile(
      title: MaterialButton(
        onPressed: (){},
        child: Text("Forgotten password", style: TextStyle(fontWeight: FontWeight.w200, color: Colors.blue)),
      ),
      subtitle: MaterialButton(
        onPressed: (){
          _showSignUpMenu();
        },
        child: Text("Join Jinnie", style: TextStyle(fontWeight: FontWeight.w200, color: Colors.blue)),
      ),
    );
  }

  void _showSignUpMenu() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new SignUpScreen();
      },
      fullscreenDialog: true
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0XFFf7f7f7),
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
              _buildLogo(),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(8.0)),
                    _buildEmailTextField("Email", "Enter your email"),
                    Padding(padding: const EdgeInsets.all(8.0)),
                    _buildPasswordTextField(),
                    Padding(padding: const EdgeInsets.all(8.0)),
                    _buildLoginButton()
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.all(4.0)),
              Divider(),
              Padding(padding: const EdgeInsets.all(4.0)),
              _buildFacebookLoginButton(),
              Padding(padding: const EdgeInsets.all(8.0)),
              _buildForgottenAndSignupButton()
            ],
          ),
        ),
      ),
    );
  }
}
