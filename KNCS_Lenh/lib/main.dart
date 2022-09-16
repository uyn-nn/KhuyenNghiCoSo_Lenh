import 'package:flutter/material.dart';

class FakeData {
  FakeData(this.date, this.buy, this.sell, this.kn);
  final String date;
  final String buy;
  final String sell;
  final String kn;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khuyến nghị cơ sở_Lệnh',
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FakeData> dataRecommendations = [
    FakeData('13/08', 'SMALL BUY', '', '130.50'),
    FakeData('10/07', '', 'SMALL SELL', '145.50'),
    FakeData('05/07', 'BIG BUY', '', '105.50'),
    FakeData('03/07', 'SMALL BUY', '', '99.90'),
    FakeData('01/07', '', 'BIG SELL', '90.90'),
  ];

  Widget _selectionBuySell({required String title}) {
    Color backgroundColor;

    if (title == '') {
      return const SizedBox();
    } else if (title.contains('BUY')) {
      backgroundColor = const Color(0xff47BC85);
    } else {
      // Title contains SELL
      backgroundColor = const Color(0xffD7354E);
    }
    return Container(
      width: 83,
      height: 21,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xffFFFFFF)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DataRow _selectionTableRecommendations(
      {required String date,
      required String kn,
      required String buying,
      required String sell}) {
    return DataRow(
      cells: <DataCell>[
        DataCell(
          SizedBox(
              width: 43,
              height: 17,
              child: Text(
                date,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff000000)),
                textAlign: TextAlign.left,
              )),
        ),
        DataCell(_selectionBuySell(title: buying)),
        DataCell(_selectionBuySell(title: sell)),
        DataCell(SizedBox(
          width: double.infinity,
          height: 17,
          child: Text(
            kn,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xff000000)),
            textAlign: TextAlign.right,
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
            width: 375,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color(0xff9D9EA3).withOpacity(0.12),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  DataTable(
                    columnSpacing: 10,
                    showBottomBorder: true,
                    dividerThickness: 0,
                    horizontalMargin: 9,
                    columns: <DataColumn>[
                      DataColumn(
                          label: Container(
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Ngày',
                                style: TextStyle(
                                  color: Color(0xff9D9EA3),
                                  fontSize: 10,
                                ),
                              ))),
                      DataColumn(
                        label: Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.center,
                            child: const Text(
                              'Điểm mua',
                              style: TextStyle(
                                color: Color(0xff9D9EA3),
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      DataColumn(
                        label: Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.center,
                            child: const Text(
                              'Điểm bán',
                              style: TextStyle(
                                color: Color(0xff9D9EA3),
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      DataColumn(
                          label: Container(
                              padding: const EdgeInsets.only(left: 9),
                              alignment: Alignment.centerLeft,
                              child: const Text('Giá KN',
                                  style: TextStyle(
                                    color: Color(0xff9D9EA3),
                                    fontSize: 10,
                                  ))))
                    ],
                    rows: <DataRow>[
                      ...List.generate(
                          dataRecommendations.length,
                          (index) => _selectionTableRecommendations(
                              date: dataRecommendations[index].date,
                              buying: dataRecommendations[index].buy,
                              sell: dataRecommendations[index].sell,
                              kn: dataRecommendations[index].kn)),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
