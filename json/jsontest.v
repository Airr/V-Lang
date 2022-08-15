import json2
import os {read_file}
import strings {repeat}
 
fn convert(items json2.Map, num int) {
	indent := repeat(32,num)
	for name, value in items {
		value_type := value.type_name()
		key := '$indent$name:'

		match value_type {
			json2.type_map, json2.type_array { 
				println('$key')
				convert(value.as_map(), num + 4)
			}else{
				println('$key $value')
			}
		}
	}
}
 
fn main() {
	json_file := os.args[1] or {
		eprintln('Usage:  $os.executable() <Json File to Process>')
		exit(1)
	}
	json_data := read_file(json_file) or {
		eprintln(err) 
		exit(-1)
	}
	result := json2.raw_decode(json_data) or {
		eprintln('Error: "$json_file" is not a valid Json File!')
		exit(-1)
	}
	data := result.as_map()
 
	for key, _ in data {
		println('$key:')
		obj := data['$key'] or { panic('key not found') }
		items := obj.as_map()
		convert(items,4)
	}
}
     
