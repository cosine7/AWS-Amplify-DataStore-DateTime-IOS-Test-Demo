// swiftlint:disable all
import Amplify
import Foundation

public struct DateTimeTest: Model {
  public let id: String
  public var dateTime: Temporal.DateTime?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      dateTime: Temporal.DateTime? = nil) {
    self.init(id: id,
      dateTime: dateTime,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      dateTime: Temporal.DateTime? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.dateTime = dateTime
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}