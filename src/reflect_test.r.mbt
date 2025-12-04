///|
pub impl @reflect.Reflect for MyStruct1 with type_info(self) {
  @any.Any::of(self).type_info()
}

///|
pub impl @reflect.Reflect for MyStruct1 with kind(_) {
  Struct
}

///|
pub impl @reflect.Reflect for MyStruct1 with attrs(_) {
  [
    { id: "my", name: "Attribute1", params: { "a": "\"1\"", "b": "\"2\"" } },
    { id: "my", name: "Attribute2", params: { "_": "haha" } },
  ]
}

///|
pub impl @reflect.Reflect for MyStruct1 with field(self, name) {
  match name {
    "field1" => Some(@any.Any::of(self.field1))
    "field2" => Some(@any.Any::of(self.field2))
    "field3" => Some(@any.Any::of(self.field3))
    _ => None
  }
}

///|
pub impl @reflect.Reflect for MyStruct1 with fields(self) {
  Iter2::new(fn(yield_) {
    if yield_("field1", @any.Any::of(self.field1)) == IterEnd {
      return IterEnd
    }
    if yield_("field2", @any.Any::of(self.field2)) == IterEnd {
      return IterEnd
    }
    if yield_("field3", @any.Any::of(self.field3)) == IterEnd {
      return IterEnd
    }
    IterContinue
  })
}

///|
pub impl @reflect.Reflect for MyStruct1 with variant(_) {
  None
}

///|
pub impl @reflect.Reflect for MyStruct1 with index(_, _) {
  None
}

///|
pub impl @reflect.Reflect for MyStruct1 with as_any(self) {
  @any.Any::of(self)
}
