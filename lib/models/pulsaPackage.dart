class PulsaPackage {
  final String id;
  final int nominal;
  final int bonus; // bonus pulsa dalam rupiah, 0 jika tidak ada

  const PulsaPackage({
    required this.id,
    required this.nominal,
    this.bonus = 0,
  });

  int get total => nominal; // bisa tambah admin fee nanti
}

final List<PulsaPackage> availablePulsa = [
  PulsaPackage(id: 'pulsa_10', nominal: 10000),
  PulsaPackage(id: 'pulsa_25', nominal: 25000),
  PulsaPackage(id: 'pulsa_50', nominal: 50000),
  PulsaPackage(id: 'pulsa_100', nominal: 100000),
  PulsaPackage(id: 'pulsa_150', nominal: 150000),
  PulsaPackage(id: 'pulsa_200', nominal: 200000),
];