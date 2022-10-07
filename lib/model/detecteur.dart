class Detecteur {
  final String name;
  final String id;
  final String ip;

  const Detecteur({
    required this.name,
    required this.id,
    required this.ip,
  });

  Detecteur copy({
    String? name,
    String? id,
    String? ip,
  }) =>
      Detecteur(
        name: name ?? this.name,
        id: id ?? this.id,
        ip: ip ?? this.ip,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Detecteur &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              id == other.id &&
              ip == other.ip;

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ ip.hashCode;
}
