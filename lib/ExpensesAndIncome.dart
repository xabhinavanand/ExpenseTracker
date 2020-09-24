class ExpensesData
{
  String st;
  double savings;
  double expenses=0;
  var colour;
  ExpensesData(this.st,this.savings,this.colour);
}
class Transact {
  Transact({
    this.id,
    this.amount,
    this.isSpent,
  });

  int id;
  int amount;
  int isSpent;

  factory Transact.fromMap(Map<String, dynamic> json) => Transact(
    id: json["id"],
    amount: json["amount"],
    isSpent: json["isSpent"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "amount": amount,
    "isSpent": isSpent,
  };
}