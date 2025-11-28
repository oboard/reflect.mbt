///|
// 解析阶段的中间结构，避免直接耦合到 @morm.*
struct FieldSpec {
  label : String
  field_type : String
  attrs : Array[ReflectAttribute]
} derive(Show, ToJson)

///|
struct MethodSpec {
  name : String
  attrs : Array[ReflectAttribute]
} derive(Show, ToJson)

///|
struct StructSpec {
  name : String
  fields : Array[FieldSpec]
  methods : Array[MethodSpec]
  attrs : Array[ReflectAttribute]
} derive(Show, ToJson)

///|
fn generate_impl(spec : StructSpec) -> String {
  let struct_name = spec.name
  let display_name = spec.name
  let lines = StringBuilder::new()
  lines.write_string("///|\n")
  lines.write_string(
    "pub impl Reflecter for \{struct_name} with _get_type(self) -> @oboard/reflect.ReflectType {\n",
  )
  lines.write_string("  Struct(name=\"\{display_name}\",\n")
  lines.write_string("    fields=[\n")
  spec.fields.each(field => lines.write_string(
    "    \{field.field_type}(name=\"\{field.label}\", value=self.\{field.label}, attrs=\{field.attrs}),\n",
  ))
  lines.write_string("    ],\n")
  lines.write_string("    methods=[\n")
  if spec.methods.length() > 0 {
    spec.methods.each(m => lines.write_string(
      "      Function(name=\"\{m.name}\", attrs=\{m.attrs}),\n",
    ))
  }
  lines.write_string("    ],\n")
  lines.write_string("    attrs=\{spec.attrs},\n")
  lines.write_string("  )\n")
  lines.write_string("}\n")
  lines.write_string("\n")
  lines.write_string("///|\n")
  lines.write_string(
    "pub impl Reflecter for \{struct_name} with _get_property(self, name) -> @oboard/reflect.ReflectType? {\n",
  )
  lines.write_string("  match name {\n")
  spec.fields.each(field => lines.write_string(
    "    \"\{field.label}\" => Some(\{field.field_type}(name=\"\{field.label}\", value=self.\{field.label}, attrs=\{field.attrs}))\n",
  ))
  lines.write_string("    _ => None\n")
  lines.write_string("  }\n")
  lines.write_string("}\n")
  lines.to_string()
}

///|
fn main {
  let argv = @sys.get_cli_args()
  let input_file = @ref.new("")
  let output_file = @ref.new("")
  let usage =
    #| MoonBit ORM CLI tool for generating database schema from Moonbit files
    #| usage: 
    #|      morm-gen <input_file> -o <output_file>
    #|
  @ArgParser.parse(
    [
      (
        "--output-file",
        "-o",
        String(file => output_file.val = file),
        "Output file",
      ),
    ],
    file => input_file.val = file,
    usage,
    argv,
  )
  try {
    let (ast, _) = @parser.parse_file(input_file.val)
    let specs = parse_entities_from_ast(ast)
    //
    let codes : Array[String] = []
    specs.each(spec => codes.push(generate_impl(spec)))
    let code = codes.join("\n\n")
    @fs.write_string_to_file(output_file.val, code, encoding="utf8")
    let entity_names = specs.map(spec => spec.name)
    if entity_names.length() > 0 {
      println("Generated \{output_file.val} for entities: \{entity_names}")
    }
  } catch {
    @fs.IOError(e) => println("IOError: \{e}")
  }
}
