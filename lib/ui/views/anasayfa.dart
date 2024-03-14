import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/kisiler.dart';
import 'package:persons_app/ui/cubit/anasayfa_cubit.dart';
import 'package:persons_app/ui/views/detay_sayfa.dart';
import 'package:persons_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  Future<void> kisiAra(String arananKelime) async{
    print("Kişi ara: $arananKelime");
  }

  Future<void> kisiSil(String kisi_id) async{
    print("Silinen Kişi id: ${kisi_id}");
  }

 @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisileriListele();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            context.read<AnasayfaCubit>().ara(aramaSonucu);          },
        ) :
            const Text("Kişiler"),
            actions: [
              aramaYapiliyorMu ?
                  IconButton(
                      onPressed: () {
                      setState(() {
                        aramaYapiliyorMu = false;
                      });
                      context.read<AnasayfaCubit>().kisileriListele();
                      },
                      icon: const Icon(Icons.search_off_outlined)) :
                  IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: const Icon(Icons.search))

        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi) {
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context,index) {
                var kisiNesnesi = kisilerListesi[index];

                return SizedBox(
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisiNesnesi,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                      child: Card(
                        color: Color(hexColor("ffc8dd")),
                        elevation: 10,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kisiNesnesi.kisi_adi,style: const TextStyle(color: Colors.black,fontSize: 20),),
                                  Text(kisiNesnesi.kisi_no.toString(),style: const TextStyle(color: Colors.black,fontSize: 16)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text("${kisiNesnesi.kisi_adi} silinsin mi?",style: TextStyle(fontSize: 17),),
                                      action: SnackBarAction(
                                        label: "EVET",
                                        textColor: Colors.red,
                                        onPressed: () {
                                          context.read<AnasayfaCubit>().sil(kisiNesnesi.kisi_id);
                                        },
                                      ),
                                    )
                                  );
                                },
                                icon: const Icon(CupertinoIcons.xmark))
                          ],
                        )

                      ),
                    ),
                  ),
                );

              },
            );

          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hexColor("bde0fe")),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitSayfa()));
        },
        child: const Icon(CupertinoIcons.add),
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