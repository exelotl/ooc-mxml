use mxml
import io/File

main: func {
	
	// load our XML file, using opaque mode to preserve all whitespace in string values
	file := File new("walking.xml")
	tree := XmlNode new() .loadString(file read(), MXML_OPAQUE_CALLBACK)
	
	myData := tree findElement("my_data")
	
	
	// By default, findElement uses MXML_DESCEND mode, so it will check sub-nodes too
	
	"\nfinding all the items:\n" println()
	
	item := myData findElement("item")
	
	while (item) {
		item getAttr("type") println()
		// 'myData' is the top node, so findElement returns null when it reaches the end of it
		item = item findElement(myData, "item")
	}
	
	// Using a custom function to read the data in more detail:
	
	"\nwalking more smartly over the data:\n" println()
	myData eachChildElement(printInfo)
	
	tree delete()
}


indentLevel := 0

printInfo: func (node: XmlNode) {
	
	"  " times(indentLevel) print()
	
	match (node getElement()) {
		case "item" =>
			desc := node getOpaque()
			"item: %s %s" printfln(node getAttr("type"), desc ? "("+desc+")" : "")
		case "group" =>
			"group: %s" printfln(node getAttr("name"))
			indentLevel += 1
			node eachChildElement(printInfo)
			indentLevel -= 1
	}
}