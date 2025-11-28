///|
#my.Attribute1
#my.Attribute2
pub struct MyStruct1 {
  #my.Attribute3
  field1 : Int
  field2 : String
  field3 : Double
}

///|
#my.Attribute4
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
    ["Int", { "name": "field1", "value": 1, "attrs": ["#my.Attribute3"] }],
  ])
  @json.inspect(type1, content=[
    "Struct",
    {
      "name": "MyStruct1",
      "fields": [
        ["Int", { "name": "field1", "value": 1, "attrs": ["#my.Attribute3"] }],
        ["String", { "name": "field2", "value": "hello", "attrs": [] }],
        ["Double", { "name": "field3", "value": 3.14, "attrs": [] }],
      ],
      "methods": [["Function", { "name": "new", "attrs": ["#my.Attribute4"] }]],
      "attrs": ["#my.Attribute1", "#my.Attribute2"],
    },
  ])
}
