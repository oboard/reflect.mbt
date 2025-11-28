///|
/// 解析阶段：使用中间结构 EntitySpec（调用者负责提供 AST）
// 说明：避免在此函数中调用可能带错误类型的 API，保持纯解析逻辑。
fn parse_entities_from_ast(
  ast : @moonbitlang/core/list.List[@moonbitlang/parser/syntax.Impl],
) -> Array[StructSpec] {
  let specs : Map[String, StructSpec] = {}
  ast.each(item => if item
    is @syntax.Impl::TopTypeDef(
      { tycon: name, components: Record(params), attrs, .. }
    ) {
    let fields : Array[FieldSpec] = []
    params.each(param => if param is { name: { label, .. }, ty, attrs, .. } {
      fields.push({
        label,
        field_type: match ty {
          Name(constr_id={ id: Ident(name~) | Dot(id=name, ..), .. }, ..) =>
            name
          Option(
            ty=Name(constr_id={ id: Ident(name~) | Dot(id=name, ..), .. }, ..),
            ..
          ) => name
          _ => "String"
        },
        attrs: attrs.map(attr => attr.raw).to_array(),
      })
    })
    specs.set(name, {
      name,
      fields,
      methods: [],
      attrs: attrs.map(attr => attr.raw).to_array(),
    })
  })
  ast.each(item => if item
    is @syntax.Impl::TopFuncDef(
      fun_decl={
        type_name: Some({ name: Ident(name=ty) | Dot(id=ty, ..), .. }),
        name: { name, .. },
        attrs,
        ..,
      },
      ..
    ) {
    specs[ty].methods.push({
      name,
      attrs: attrs.map(attr => attr.raw).to_array(),
    })
  })
  specs.values().to_array()
}
