import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:persons_app/ui/views/anasayfa.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {

  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0,left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(
                    hintText: "Kişi Ad",
                    filled: true,
                    fillColor: Color(hexColor("ffc8dd")),

                ),),
              TextField(
                controller: tfKisiTel,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Kişi Tel",
                    filled: true,
                    fillColor: Color(hexColor("ffc8dd")),
                ),),
              ElevatedButton(
                  onPressed: () {
                    context.read<KayitSayfaCubit>().kaydet(tfKisiAdi.text, tfKisiTel.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa()));
                  },
                  child: const Text("Kaydet",style: TextStyle(color: Colors.black,fontSize: 18),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(hexColor("bde0fe"))
                  ),
              )

            ],
          ),
        ),
      ),

    );
  }
}

int hexColor(String color) {
  String newColor = '0xff' + color;
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}