import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os dados";

  void resetFields(){
    pesoController.text = "";
    alturaController.text = "";
    setState((){
      _infoText = "Informe os dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcularIMC(){
    setState((){
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text)/100;
      double imc = peso/(altura*altura);
      if(imc < 18.6){
        _infoText = "IMC abaixo do ideal(${imc.toStringAsPrecision(3)})";
      }
      if(imc >= 18.6 && imc < 28.0){
        _infoText = "IMC ideal (${imc.toStringAsPrecision(3)})";
      }
      else{
        _infoText = "IMC de uma baleia (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 0.8,
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          "Calculadora IMC",
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: resetFields,
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    controller: pesoController  ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Insira o seu peso!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller:  alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Insira sua altura!';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0 , bottom: 10.0),
                    child : Container(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            calcularIMC;
                          }
                        },
                        child: Text(
                            "Calcular",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0
                            )
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.green,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ]
            ),
        )
      ),
    );
  }
}
