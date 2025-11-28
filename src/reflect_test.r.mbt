///|
pub impl Reflecter for MyStruct1 with _get_type(self) -> @oboard/reflect.ReflectType {
  Struct(
    name="MyStruct1",
    fields=[
      Int(name="field1", value=self.field1),
      String(name="field2", value=self.field2),
      Double(name="field3", value=self.field3),
    ],
    methods=[Function(name="new")],
  )
}

///|
pub impl Reflecter for MyStruct1 with _get(self, name) -> @oboard/reflect.ReflectType? {
  match name {
    "field1" => Some(Int(name="field1", value=self.field1))
    "field2" => Some(String(name="field2", value=self.field2))
    "field3" => Some(Double(name="field3", value=self.field3))
    _ => None
  }
}
