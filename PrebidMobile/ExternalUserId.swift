/*   Copyright 2020-2021 Prebid.org, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import UIKit

/// Defines the User Id Object from an External Thrid Party Source
@objcMembers
public class ExternalUserId: NSObject, NSCoding, NSSecureCoding, JSONConvertible {
    
    /// Indicates whether the class supports secure coding.
    public static var supportsSecureCoding: Bool {
        true
    }
    
    
    // MARK: - Properties
    
    /// The source of the external user ID.
    public var source: String
    
    /// The identifier of the external user ID.
    public var identifier: String
    
    /// The type of the external user ID, represented as an optional `NSNumber`.
    public var atype: NSNumber?
    
    /// Additional attributes related to the external user ID, represented as an optional dictionary.
    public var ext: [String: Any]?

    // MARK: - Initialization
    
    ///Initialize ExternalUserId Class
    /// - Parameter source: Source of the External User Id String.
    /// - Parameter identifier: String of the External User Id.
    /// - Parameter atype: (Optional) Int of the External User Id.
    /// - Parameter ext: (Optional) Dictionary of the External User Id.
    public init(source: String, identifier: String, atype: NSNumber? = nil, ext:[String: Any]? = nil) {
        self.source = source
        self.identifier = identifier
        self.atype = atype
        self.ext = ext
        super.init()
    }
    
    /// Encodes the properties of the class using the given encoder.
    public func encode(with coder: NSCoder) {
        coder.encode(self.source, forKey: "source")
        coder.encode(self.identifier, forKey: "identifier")
        coder.encode(self.atype, forKey: "atype")
        coder.encode(self.ext, forKey: "ext")
    }
    
    /// Initializes an `ExternalUserId` instance from the given decoder.
    public required init?(coder: NSCoder) {
        self.source = coder.decodeObject(forKey: "source") as? String ?? ""
        self.identifier = coder.decodeObject(forKey: "identifier") as? String ?? ""
        self.atype = coder.decodeObject(forKey: "atype") as? NSNumber
        self.ext = coder.decodeObject(forKey: "ext") as? [String: Any]
    }
    
    /// Converts the `ExternalUserId` instance to a JSON dictionary.
    public func toJSONDictionary() -> [AnyHashable: Any] {
        guard source.count != 0 && identifier.count != 0 else {
            return [:]
        }
        var transformedEUIdDic = [AnyHashable: Any]()
        transformedEUIdDic["source"] = source
        
        var externalUserIdDict = [AnyHashable: Any] ()
        externalUserIdDict["id"] = identifier
        externalUserIdDict["atype"] = atype
        externalUserIdDict["ext"] = ext
        
        transformedEUIdDic["uids"] = [externalUserIdDict]
        return transformedEUIdDic
    }
}
