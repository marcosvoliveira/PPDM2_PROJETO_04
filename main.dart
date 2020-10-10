import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance";

void main() async {
  print(await pegarDados());
  runApp(
    MaterialApp(
      //home: Container(),
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String ibovespaNome;
  String ibovespaLocal;
  String ibovespaPontos;
  String ibovespaVariacao;

  String nasdaqNome;
  String nasdaqLocal;
  String nasdaqPontos;
  String nasdaqVariacao;

  String nikkeiNome;
  String nikkeiLocal;

  String nikkeiVariacao;

  String cacNome;
  String cacLocal;
  String cacVariacao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bolsa de Valores no Mundo"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: pegarDados(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar os Dados",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                ibovespaNome = snapshot.data["results"]["stocks"]["IBOVESPA"]
                        ["name"]
                    .toString();
                ibovespaLocal = snapshot.data["results"]["stocks"]["IBOVESPA"]
                        ["location"]
                    .toString();
                ibovespaPontos = snapshot.data["results"]["stocks"]["IBOVESPA"]
                        ["points"]
                    .toString();
                ibovespaVariacao = snapshot.data["results"]["stocks"]
                        ["IBOVESPA"]["variation"]
                    .toString();
                //nasdaq
                nasdaqNome = snapshot.data["results"]["stocks"]["NASDAQ"]
                        ["name"]
                    .toString();
                nasdaqLocal = snapshot.data["results"]["stocks"]["NASDAQ"]
                        ["location"]
                    .toString();
                nasdaqPontos = snapshot.data["results"]["stocks"]["NASDAQ"]
                        ["points"]
                    .toString();
                nasdaqVariacao = snapshot.data["results"]["stocks"]["NASDAQ"]
                        ["variation"]
                    .toString();
                //nikkei
                nikkeiNome = snapshot.data["results"]["stocks"]["NIKKEI"]
                        ["name"]
                    .toString();
                nikkeiLocal = snapshot.data["results"]["stocks"]["NIKKEI"]
                        ["location"]
                    .toString();

                nikkeiVariacao = snapshot.data["results"]["stocks"]["NIKKEI"]
                        ["variation"]
                    .toString();

                //CAC
                cacNome = snapshot.data["results"]["stocks"]["CAC"]["name"]
                    .toString();
                cacLocal = snapshot.data["results"]["stocks"]["CAC"]["location"]
                    .toString();

                cacVariacao = snapshot.data["results"]["stocks"]["CAC"]
                        ["variation"]
                    .toString();

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "images/bolsa.jpg",
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                      Divider(),
                      construirTexto(ibovespaNome),
                      construirTexto(ibovespaLocal),
                      construirTexto(ibovespaPontos),
                      construirTexto(ibovespaVariacao),
                      Divider(),
                      construirTexto(nasdaqNome),
                      construirTexto(nasdaqLocal),
                      construirTexto(nasdaqPontos),
                      construirTexto(nasdaqVariacao),
                      Divider(),
                      construirTexto(nikkeiNome),
                      construirTexto(nikkeiLocal),
                      construirTexto(nikkeiVariacao),
                      Divider(),
                      construirTexto(cacNome),
                      construirTexto(cacLocal),
                      construirTexto(cacVariacao),
                    ], //children column
                  ),
                );
              } //if else
          } //swtich
        }, //builder
      ),
    );
  }
}

Future<Map> pegarDados() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Widget construirTexto(String texto) {
  return Text(
    texto,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.blueAccent,
      fontSize: 25,
    ),
  );
}
