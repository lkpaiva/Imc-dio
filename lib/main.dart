import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "O Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40.0) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person_outline,
                  size: 120.0, color: Colors.black87),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Nome completo",
                    labelStyle: TextStyle(color: Colors.black87)
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.black87),
                ),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso";
                  }
                  if (value!.isNotEmpty) {
                    double? checkDouble = double.tryParse(value);
                    if (checkDouble == null) {
                      return "Insira um número";
                    }
                  }
                },
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.black87),
                  ),
                  controller: heightController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira sua Altura";
                    }

                    if (value!.isNotEmpty) {
                      double? checkDouble = double.tryParse(value);
                      if (checkDouble == null) {
                        return "Insira um número";
                      }
                    }
                    return null;
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
