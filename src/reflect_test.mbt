///|
pub struct MyStruct1 {
  field1 : Int
  field2 : String
  field3 : Double
}

///|
pub fn MyStruct1::new(
  field1 : Int,
  field2 : String,
  field3 : Double,
) -> MyStruct1 {
  MyStruct1::{ field1, field2, field3 }
}

///|
test "struct" {
  let struct1 = MyStruct1::{ field1: 1, field2: "hello", field3: 3.14 }
  let type1 = @reflect.type_of(struct1)
  @json.inspect(@reflect.get(struct1, "field1"), content=[
    ["Int", { "name": "field1", "value": 1 }],
  ])
  @json.inspect(type1, content=[
    "Struct",
    {
      "name": "MyStruct",
      "fields": [
        ["Int", { "name": "field1", "value": 1 }],
        ["String", { "name": "field2", "value": "hello" }],
        ["Double", { "name": "field3", "value": 3.14 }],
      ],
      "methods": [["Function", { "name": "new" }]],
    },
  ])
}
