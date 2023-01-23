//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {
    
    var testInstance: ANFExploreCardTableViewController!
    var testInstanceCardRepo: ANFExploreCardRepo!
    var testProductData : ProductData?
    var navigationController: UINavigationController!
    var ANFExploreCardDetailsVC: ANFExploreCardDetailsViewController!
    var selectedData:ProductData?
    lazy var testviewModel : ANFExploreCardViewModel = {
        return ANFExploreCardViewModel {  message in
            print(message)
        }
    }()
    
    /// Type Tests
    func testConformsToDecodable() {
        XCTAssertTrue((testProductData as Any) is Decodable)
    }
    
    ///testLaunchViewModelswhenInit
    func testLaunchViewModels_whenInit() {
        XCTAssertTrue(testviewModel.PeoductList.value.isEmpty)
    }
    
    ///testAPIReturnsExpectedData
    func testAPIReturnsExpectedData() {
        let expectation = XCTestExpectation(description: "API returns expected data")
        testviewModel.PeoductList.observe {  result in
            if result.isEmpty {
                XCTFail("No Data")
            } else {
                XCTAssertNotNil(self.testviewModel.PeoductList.value)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func setUp() {
        testInstance = UIStoryboard(name: "ExploreCard", bundle: nil).instantiateViewController(withIdentifier: "ANFExploreCardTableViewController") as? ANFExploreCardTableViewController
        
        testGetJson()
        ANFExploreCardDetailsVC = ANFExploreCardDetailsViewController()
        navigationController = UINavigationController(rootViewController: ANFExploreCardDetailsVC)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    ///testGetJsonData
    func testGetJson() {
        testInstance.getProductList()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for n seconds")], timeout: 5.0)
        XCTAssert(testInstance.productList.count != 0)
    }
    
    /// testTableViewCellCreateCellsWithReuseIdentifier
    func test_TableViewCell_CreateCellsWithReuseIdentifier() {
        let reuseIdentifier = "exploreContentCell"
        let indexPath = IndexPath(row: 0, section: 0)
        // When: dequeue a cell with a reuse identifier
        let cell = testInstance.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        // Then: the reuse identifier should match the expected value
        XCTAssertEqual(cell.reuseIdentifier, reuseIdentifier, "The reuse identifier should match the expected value")
    }
    
    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldBeTen() {
        let numberOfRows = testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == testInstance.productList.count, "table view should have 10 cells")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? exploreContentCell
        let title = firstCell?.lblTitle
        XCTAssert(title?.text?.count ?? 0 > 0, "title should not be blank")
    }
    
    func test_cellForRowAtIndexPath_ImageViewImage_shouldNotBeNil() {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? exploreContentCell
        let imageView = firstCell?.ivBackground
        XCTAssert(imageView?.image != nil, "image view image should not be nil")
    }
    
    /// test_DidSelectRow
    func test_DidSelectRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        testInstance.tableView.delegate?.tableView?(testInstance.tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(navigationController.topViewController === ANFExploreCardDetailsVC)
    }
    
}
