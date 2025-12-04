///|
pub type Any = @any.Any

///|
pub type TypeInfo = @any.TypeInfo

///|
pub(open) trait Reflect {
  type_info(Self) -> TypeInfo
  kind(Self) -> Kind
  attrs(Self) -> Array[ReflectAttribute]
  field(Self, String) -> Any?
  fields(Self) -> Iter2[String, Any]
  variant(Self) -> (String, Array[Any])?
  index(Self, Int) -> Any?
  as_any(Self) -> Any
}

///|
pub(all) enum Kind {
  Primitive
  Struct
  Enum
  Array
  Tuple
  Function
  Unit
}

///|
pub fn[T : Reflect] type_of(x : T) -> TypeInfo {
  x.type_info()
}

///|
pub fn[T : Reflect] get_field(x : T, field : String) -> Any? {
  x.field(field)
}

///|
pub impl Reflect for Int with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for Int with kind(_) {
  Primitive
}

///|
pub impl Reflect for Int with attrs(_) {
  []
}

///|
pub impl Reflect for Int with field(_, _) {
  None
}

///|
pub impl Reflect for Int with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for Int with variant(_) {
  None
}

///|
pub impl Reflect for Int with index(_, _) {
  None
}

///|
pub impl Reflect for Int with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for String with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for String with kind(_) {
  Primitive
}

///|
pub impl Reflect for String with attrs(_) {
  []
}

///|
pub impl Reflect for String with field(_, _) {
  None
}

///|
pub impl Reflect for String with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for String with variant(_) {
  None
}

///|
pub impl Reflect for String with index(_, _) {
  None
}

///|
pub impl Reflect for String with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for Double with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for Double with kind(_) {
  Primitive
}

///|
pub impl Reflect for Double with attrs(_) {
  []
}

///|
pub impl Reflect for Double with field(_, _) {
  None
}

///|
pub impl Reflect for Double with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for Double with variant(_) {
  None
}

///|
pub impl Reflect for Double with index(_, _) {
  None
}

///|
pub impl Reflect for Double with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for Bool with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for Bool with kind(_) {
  Primitive
}

///|
pub impl Reflect for Bool with attrs(_) {
  []
}

///|
pub impl Reflect for Bool with field(_, _) {
  None
}

///|
pub impl Reflect for Bool with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for Bool with variant(_) {
  None
}

///|
pub impl Reflect for Bool with index(_, _) {
  None
}

///|
pub impl Reflect for Bool with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for Int64 with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for Int64 with kind(_) {
  Primitive
}

///|
pub impl Reflect for Int64 with attrs(_) {
  []
}

///|
pub impl Reflect for Int64 with field(_, _) {
  None
}

///|
pub impl Reflect for Int64 with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for Int64 with variant(_) {
  None
}

///|
pub impl Reflect for Int64 with index(_, _) {
  None
}

///|
pub impl Reflect for Int64 with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for BigInt with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for BigInt with kind(_) {
  Primitive
}

///|
pub impl Reflect for BigInt with attrs(_) {
  []
}

///|
pub impl Reflect for BigInt with field(_, _) {
  None
}

///|
pub impl Reflect for BigInt with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for BigInt with variant(_) {
  None
}

///|
pub impl Reflect for BigInt with index(_, _) {
  None
}

///|
pub impl Reflect for BigInt with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for Json with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for Json with kind(_) {
  Primitive
}

///|
pub impl Reflect for Json with attrs(_) {
  []
}

///|
pub impl Reflect for Json with field(_, _) {
  None
}

///|
pub impl Reflect for Json with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for Json with variant(_) {
  None
}

///|
pub impl Reflect for Json with index(_, _) {
  None
}

///|
pub impl Reflect for Json with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl Reflect for Unit with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl Reflect for Unit with kind(_) {
  Unit
}

///|
pub impl Reflect for Unit with attrs(_) {
  []
}

///|
pub impl Reflect for Unit with field(_, _) {
  None
}

///|
pub impl Reflect for Unit with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for Unit with variant(_) {
  None
}

///|
pub impl Reflect for Unit with index(_, _) {
  None
}

///|
pub impl Reflect for Unit with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl[T] Reflect for Array[T] with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl[T] Reflect for Array[T] with kind(_) {
  Array
}

///|
pub impl[T] Reflect for Array[T] with attrs(_) {
  []
}

///|
pub impl[T] Reflect for Array[T] with field(_, _) {
  None
}

///|
pub impl[T] Reflect for Array[T] with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl[T] Reflect for Array[T] with variant(_) {
  None
}

///|
pub impl[T] Reflect for Array[T] with index(self, idx) {
  if idx >= 0 && idx < self.length() {
    Some(@any.Any::of(self[idx]))
  } else {
    None
  }
}

///|
pub impl[T] Reflect for Array[T] with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl[T] Reflect for T? with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl[T] Reflect for T? with kind(_) {
  Enum
}

///|
pub impl[T] Reflect for T? with attrs(_) {
  []
}

///|
pub impl[T] Reflect for T? with field(_, _) {
  None
}

///|
pub impl[T] Reflect for T? with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl[T] Reflect for T? with variant(self) {
  match self {
    Some(v) => Some(("Some", [@any.Any::of(v)]))
    None => Some(("None", []))
  }
}

///|
pub impl[T] Reflect for T? with index(_, _) {
  None
}

///|
pub impl[T] Reflect for T? with as_any(self) {
  @any.Any::of(self)
}

///|
pub impl[T, E] Reflect for Result[T, E] with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl[T, E] Reflect for Result[T, E] with kind(_) {
  Enum
}

///|
pub impl[T, E] Reflect for Result[T, E] with attrs(_) {
  []
}

///|
pub impl[T, E] Reflect for Result[T, E] with field(_, _) {
  None
}

///|
pub impl[T, E] Reflect for Result[T, E] with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl[T, E] Reflect for Result[T, E] with variant(self) {
  match self {
    Ok(v) => Some(("Ok", [@any.Any::of(v)]))
    Err(e) => Some(("Err", [@any.Any::of(e)]))
  }
}

///|
pub impl[T, E] Reflect for Result[T, E] with index(_, _) {
  None
}

///|
pub impl[T, E] Reflect for Result[T, E] with as_any(self) {
  @any.Any::of(self)
}
