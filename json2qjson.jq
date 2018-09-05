def json2qjson:
  def pp: if type == "string" then "\"\(.)\""  else . end;
  . as $in
  | foreach keys[] as $k (null; null; "\"\($k)\": \($in[$k] | pp)" ) ;

json2qjson
