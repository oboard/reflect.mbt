///|
pub impl Reflecter for MyStruct1 with _get_type(self) -> @oboard/reflect.ReflectType {
  Struct(
    name="MyStruct1",
    fields=[
      Int(name="field1", value=self.field1, attrs=[
        { id: "my", name: "Attribute3", params: {} },
      ]),
      String(name="field2", value=self.field2, attrs=[]),
      Double(name="field3", value=self.field3, attrs=[]),
    ],
    methods=[
      Function(name="new", attrs=[{ id: "my", name: "Attribute4", params: {} }]),
    ],
    attrs=[
      { id: "my", name: "Attribute1", params: {} },
      { id: "my", name: "Attribute2", params: {} },
    ],
  )
}

///|
pub impl Reflecter for MyStruct1 with _get_property(self, name) -> @oboard/reflect.ReflectType? {
  match name {
    "field1" =>
      Some(
        Int(name="field1", value=self.field1, attrs=[
          { id: "my", name: "Attribute3", params: {} },
        ]),
      )
    "field2" => Some(String(name="field2", value=self.field2, attrs=[]))
    "field3" => Some(Double(name="field3", value=self.field3, attrs=[]))
    _ => None
  }
}
