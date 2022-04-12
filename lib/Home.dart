import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _cpfController = TextEditingController();
  TextEditingController _cnpjController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _moedaController = TextEditingController();

  String _valorCpf = "";
  String _valorCnpj = "";
  String _valorTel = "";
  String _valorData = "";
  String _valorMoeda = "";
  String _valorcep = "";
  String _valorbd = "";
  String _hintTextUf = "UF";
  String _hintTextRegiao = "Cidade";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(title: const Center( child: Text("Mascaras e Validações"),
        ),
          backgroundColor: Colors.pink,),

        body:  SingleChildScrollView(
          padding: EdgeInsets.all(20),

          child: Column(
            children: [

              //CPF
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                decoration: const InputDecoration(
                    hintText: "Digite o CPF:",
                    labelText: "CPF"
                ),
              ),

              Padding(padding: const EdgeInsets.only(top: 5, bottom: 10),
                //CNPJ
                child: TextFormField(
                  controller: _cnpjController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CnpjInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                      hintText: "Digite o CNPJ:",
                      labelText: "CNPJ"
                  ),
                ),
              ),

              //CEP
              TextFormField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                decoration: const InputDecoration(
                    hintText: "Digite o CEP:",
                    labelText: "CEP"
                ),
              ),

              Padding(padding: const EdgeInsets.only(top: 5, bottom: 5),
                //TELEFONE
                child: TextFormField(
                  controller: _telController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                      hintText: "Digite o Telefone:",
                      labelText: "Telefone"
                  ),
                ),
              ),

              //DATA
              TextFormField(
                controller: _dataController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                decoration: const InputDecoration(
                    hintText: "Digite a Data Ex: 00/00/0000",
                    labelText: "Data"
                ),
              ),

              Padding(padding: const EdgeInsets.only(top: 5, bottom: 5),
                //MOEDA R$
                child: TextFormField(
                  controller: _moedaController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(casasDecimais: 2),
                  ],
                  decoration: const InputDecoration(
                      hintText: "Digite o Valor em R\$",
                      labelText: "Valor R\$"
                  ),
                ),
              ),


 //---------------Alguns exemplos de Padrões do Brasil Fields-------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      hint: Text("UF:  ${_hintTextUf}"),
                      onChanged: (regiaoSelecionada) {
                        setState(() {
                          _hintTextUf = regiaoSelecionada!;
                        });
                      },
                      items: Estados.listaEstados.map((String uf) {
                        return DropdownMenuItem(
                          value: uf,
                          child: Text(uf),
                        );
                      }).toList(),
                    ),

                    DropdownButton<String>(
                      hint: Text("Região: ${_hintTextRegiao}"),
                      onChanged: (regiaoSelecionada) {
                        setState(() {
                          _hintTextRegiao = regiaoSelecionada!;
                        });
                      },
                      items: Regioes.listaRegioes.map((String reg) {
                        return DropdownMenuItem(
                          value: reg,
                          child: Text(reg),
                        );
                      }).toList(),
                    ),
                  ]
              ),
//------------------------------------------------------------------------------

              Padding(padding: const EdgeInsets.only(top: 5, bottom: 5),
                child:  ElevatedButton(
                  onPressed: (){

                    setState(() {
                      _valorCpf = _cpfController.text.toString();
                      _valorCnpj = _cnpjController.text.toString();
                      _valorcep = _cepController.text.toString();
                      _valorTel = _telController.text.toString();
                      _valorData = _dataController.text.toString();
                      _valorMoeda = _moedaController.text.toString();

//--------------------------------- OUTRAS FORMATAÇÕES------------------------------

                      //para salvar o vl. sem vírgula no BD do campo Moeda
                      String moedaDB = _moedaController.text.toString();
                      moedaDB = moedaDB.replaceAll(".", "");
                      moedaDB = moedaDB.replaceAll(",", ".");

                      //Simulando recuperar o Valor do banco de Dados (para calculos)
                      double valorDouble = double.parse( moedaDB);
                      double total = valorDouble + 859.00;

                      //Recuperando do BD e exibindo o valor customizado na tela
                      var formatador = NumberFormat("#,##0.00", "pt_br");
                      var resultado = formatador.format( total);

                      //Agregando Valores à Variável
                      _valorbd = "Desmostrando a recuperação para BD: \n ${moedaDB} \n"
                          "Recupe. vl do DB e Fazendo Ops: \n ${total} Valor digitado + 859.00 \n"
                          "Recupe. vl do DB e Exibindo na tela: \n ${resultado}";

//---------------------------------------------------------------------------------
                    });
                  },
                  child: const Text("Recuperar Valores",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black
                    ),),

                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink[200],
                      shadowColor: Colors.grey[300],
                      elevation: 1,
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),),

              Text("Valores: \n  CPF: ${_valorCpf} \n"
                  "\n CNPJ:  ${_valorCnpj} \n"
                  "\n CEP:  ${_valorcep}  \n"
                  "\n Telefone:  ${_valorTel}  \n"
                  "\n Data:  ${_valorData}  \n"
                  "\n Estado:  ${_hintTextUf}  \n"
                  "\n Região:  ${_hintTextRegiao}  \n"
                  "\n Valor:  ${_valorMoeda} \n",
                textAlign:TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),

              Text("Ops Banco de Dados \"MOEDAS\": \n  ${_valorbd}  \n",
                textAlign:TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),),
            ],
          ),
        )
    );
  }
}
