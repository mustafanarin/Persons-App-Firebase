import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/kisiler.dart';
import 'package:persons_app/ui/cubit/detay_sayfa_cubit.dart';
import 'package:persons_app/ui/views/anasayfa.dart';

class DetaySayfa extends StatefulWidget {
  Kisiler kisi;
  DetaySayfa({required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();


  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_adi;
    tfKisiTel.text = kisi.kisi_no.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Detay"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0,left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              TextField(
                controller: tfKisiAdi,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Kişi Ad",
                    filled: true,
                    fillColor: Color(hexColor("ffc8dd")),
                ),),
              TextField(
                controller: tfKisiTel,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Kişi Tel",
                    filled: true,
                    fillColor: Color(hexColor("ffc8dd")),
                ),),
              ElevatedButton(
                  onPressed: () {
                    context.read<DetaySayfaCubit>().guncelle(widget.kisi.kisi_id,tfKisiAdi.text, tfKisiTel.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa()));
                    },
                child: const Text("Güncelle",style: TextStyle(color: Colors.black,fontSize: 18),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(hexColor("bde0fe"))
                ),)

            ],
          ),
        ),
      ),

    );
  }
}
