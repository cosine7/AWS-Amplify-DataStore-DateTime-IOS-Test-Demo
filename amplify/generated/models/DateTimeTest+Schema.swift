// swiftlint:disable all
import Amplify
import Foundation

extension DateTimeTest {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case dateTime
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let dateTimeTest = DateTimeTest.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "DateTimeTests"
    
    model.fields(
      .id(),
      .field(dateTimeTest.dateTime, is: .optional, ofType: .dateTime),
      .field(dateTimeTest.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(dateTimeTest.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}