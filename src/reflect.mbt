///|
pub(open) trait Reflecter {
  _get_type(Self) -> ReflectType
  _get(Self, String) -> ReflectType?
}

///|
pub(all) enum ReflectType {
  Struct(
    name~ : String,
    fields~ : Array[ReflectType],
    methods~ : Array[ReflectType]
  )
  Int(name~ : String, value~ : Int)
  String(name~ : String, value~ : String)
  Double(name~ : String, value~ : Double)
  Function(name~ : String)
} derive(Show, Eq, Hash, ToJson, FromJson)

///|
pub type Value

///|
pub fn[T : Reflecter] type_of(x : T) -> ReflectType {
  x._get_type()
}

///|
pub fn[T : Reflecter] get(x : T, name : String) -> ReflectType? {
  x._get(name)
}
