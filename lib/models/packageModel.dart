class InternetPackage {
  final String id;
  final String name;
  final String quota;
  final String description;
  final int pricePerMonth;
  final bool isPopular;
  final List<String> features;
 
  const InternetPackage({
    required this.id,
    required this.name,
    required this.quota,
    required this.description,
    required this.pricePerMonth,
    this.isPopular = false,
    required this.features,
  });
 
  int get ppn => (pricePerMonth * 0.11).round();
  int get total => pricePerMonth + ppn;
}
 
final List<InternetPackage> availablePackages = [
  InternetPackage(
    id: 'basic',
    name: 'Basic',
    quota: '1 GB',
    description: 'Cocok untuk browsing & media sosial',
    pricePerMonth: 79000,
    features: ['Streaming SD', 'Browsing cepat', 'WhatsApp & email'],
  ),
  InternetPackage(
    id: 'turbo',
    name: 'Turbo',
    quota: '15 GB',
    description: 'Ideal untuk streaming & WFH',
    pricePerMonth: 149000,
    isPopular: true,
    features: ['Streaming Full HD', 'Video call lancar', 'WFH optimal', 'Gaming ringan'],
  ),
  InternetPackage(
    id: 'ultra',
    name: 'Ultra',
    quota: '20 GB',
    description: 'Sempurna untuk gaming & 4K',
    pricePerMonth: 249000,
    features: ['Streaming 4K', 'Gaming online', 'Download cepat', 'Multi-device'],
  ),
  InternetPackage(
    id: 'giga',
    name: 'Giga',
    quota: '50 GB',
    description: 'Untuk rumah dan kantor kecil',
    pricePerMonth: 399000,
    features: ['Unlimited bandwidth', 'Prioritas jaringan', 'Cocok 10+ perangkat', 'Support 24/7'],
  ),
];