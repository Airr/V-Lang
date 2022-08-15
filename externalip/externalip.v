//~ module main
import net

fn main() {
	mut buf := []u8{len: 100}
	mut result := []string{}
	
	mut conn := net.dial_udp('resolver1.opendns.com:53')?
	defer {
		conn.close() or {}
	}
	
	prefix := "\x41\x41\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00"
	message := "\x04\x6d\x79\x69\x70\x07\x6f\x70\x65\x6e\x64\x6e\x73\x03\x63\x6f\x6d"
	suffix := "\x00\x00\x01\x00\x01"
	
	query := prefix + message + suffix

	conn.write_string(query) or {
		println(err) 
		exit(-1)
	}
	res, _ := conn.read(mut buf)?

	for item in buf[res-4..res] { 
		result << "$item"
	}
	
	ip := result.join('.')
	
	println("External IP: $ip")

}
