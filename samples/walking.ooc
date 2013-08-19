use mxml
import io/File

main: func {
	
	// load our XML file, using opaque mode to preserve all whitespace in string values
	file := File new("walking.xml")
	tree := XmlNode new() .loadString(file read(), MXML_OPAQUE_CALLBACK)
	
	myData := tree findElement("my_data")
	
	"Now walking over everything:" println()
	walk(myData)
	
	tree delete()
}

walk: func (group:XmlNode) {
	
	item := group findElement("item")
	
	while (item) {
		item getAttr("type") println()
		item = item findElement(group, "item")
	}
	
}