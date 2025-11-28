///|
pub(open) trait Reflecter {
  _get_type(Self) -> ReflectType
  _get_property(Self, String) -> ReflectType?
}

///|
pub(all) enum ReflectType {
  Struct(
    name~ : String,
    fields~ : Array[ReflectType],
    methods~ : Array[ReflectType],
    attrs~ : Array[ReflectAttribute]
  )
  Int(name~ : String, value~ : Int, attrs~ : Array[ReflectAttribute])
  String(name~ : String, value~ : String, attrs~ : Array[ReflectAttribute])
  Double(name~ : String, value~ : Double, attrs~ : Array[ReflectAttribute])
  Bool(name~ : String, value~ : Bool, attrs~ : Array[ReflectAttribute])
  Float(name~ : String, value~ : Float, attrs~ : Array[ReflectAttribute])
  Int64(name~ : String, value~ : Int64, attrs~ : Array[ReflectAttribute])
  BigInt(name~ : String, value~ : BigInt, attrs~ : Array[ReflectAttribute])
  Unit(name~ : String, attrs~ : Array[ReflectAttribute])
  Function(name~ : String, attrs~ : Array[ReflectAttribute])
} derive(Show, Eq, ToJson)

///|
pub type Value

///|
pub fn[T : Reflecter] type_of(x : T) -> ReflectType {
  x._get_type()
}

///|
pub fn[T : Reflecter] get(x : T, name : String) -> ReflectType? {
  x._get_property(name)
}
