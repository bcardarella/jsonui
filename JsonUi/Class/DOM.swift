//
//  DOM
//  Phoenix LiveView Swift Client
//
//  Created by Brian Cardarella on 3/19/21.
//


import SwiftSoup

class DOM {

    static let phx_component = "data-phx-component"
    static let phx_main = "data-phx-main"
    static let phx_session = "data-phx-session"
    static let phx_static = "data-phx-static"

    static let staticKey = "s"
    static let componentKey = "c"
    
    static func parse(html: String) -> Document {
        return try SwiftSoup.parse(html)
    }
    
    static func all(htmlTree: Document, selector: String) -> Elements {
        return htmlTree.select(selector)
    }
    
    static func maybeOne(htmlTree: Document, selector: String, type: String = "selector") {

    }
    
    // performance optimization is to reduce this to a single walk of the tree
    // to collect all of the attribute values for the given `name`
    static func allAttributes(htmlTree: Document, key: String) -> [String] {
        let elements = htmlTree.getElementsByAttribute(key)
        
        var values: [String] = []
        
        for element in elements {
            values.append(element.attr(key))
        }
        
        return values
    }
    
    static func allValues(node: Element) -> [String: String] {
        let values: [String: String] = [:]
        
        let attributes = node.getAttributes()
        
        for attribute in attributes {
            let key = valueKey(attribute.getkey())
            let value = attribute.getValue()
            
            values[key] = value
        }
        
        return values
    }
    
    // Extracts the correct appended value from the value key
    static private func valueKey(key: String) -> String {
        let phxValue = "phx-value-"
        let value = "value"
        if key.hasPrefix(phxValue) {
            return String(key.dropFirst(phxValue.count))
        } else if key == value {
            return value
        } else {
            // original LiveView code has `nil` but Swift doesn't seem to
            // play nice with interpolating `nil` so using emptry String
            return ""
        }
    }
    
    static func inspectHTML(nodes: Elements) -> String {
        return node.toString()
    }
    
    static func inspectHTML(node: Element) -> String {
        return node.outerHtml()
    }
    
    static func tag(node: Element) -> String {
        return node.tagName()
    }
    
    static func attribute(node: Element, key: String) -> String {
        return node.attr(key)
    }
    
    static func toHTML(htmlTree: Document) -> String {
        return htmlTree.outerHtml()
    }
    static func toText(htmlTree: Document) -> String {
        return htmlTree.text()
    }
    
    static func byID(htmlTree: Document, id: String) -> Element {
        return htmlTree.select("#\(id)").first()
    }
    
    static func childNodes(node: Element) -> Elements {
        return node.getChildNodes()
    }
    
    static func attrs(node: Element) -> Attributes {
        return node.getAttributes()
    }
    
    static func innerHTML(htmlTree: Document, id: String) {
        return childNodes(byId(htmlTree, id))
    }
    
    static func findStaticViews(htmlTree: Document) {
        let staticViews: [String: String] = [:]
        let allViews = all(htmlTree, self.phx_static)
        
        for view in allViews {
            staticViews[view.attr("id")] = view.attr(self.phx_static)
        }
        
        return staticViews
    }
    
    static func findLiveViews(htmlTree: Document) {
        let liveViews: [(String, String, String)] = []
        let allViews = all(htmlTree, self.phx_static)
        
        for view in allViews {
            let id = view.attr("id")
            let dataStatic = view.attr(self.phx_static)
            let dataSession = view.attr(self.phx_session)
            let dataMain = view.attr(self.phx_main)
            
            if dataStatic == nil || dataStatic == "" {
                dataStatic = nil
            }
            
            let found = (id, dataSession, dataStatic)
            
            if dataMain == "true" {
                liveViews.append(found)
            } else {
                liveViews.insert(found, at: 0)
            }
        }
        
        liveViews.reverse()
        
        return liveViews
    }
    
    static func deepMerge(target: Dictionary, source: Dictionary) {
        
    }
    
    static func filter(node: Element, closure: () -> Void) {
        
    }
    
    static func reverseFilter(node: Element, closure: () -> Void) {
        
    }
    
    static func mergeDiff(rendered: Dictionary, diff: Dictionary) {
        
    }
    
    static func dropCids(rendered: Dictionary, cids: Array) {
        
    }
    
    static func renderDiff(rendered: Dictionary) {
        
    }
    
    static func patchID(id: String, htmlTree: Document, innerHtml: Element) {
        
    }
    
    static func componentIDs(id: String, htmlTree: Document) {
        
    }
}
