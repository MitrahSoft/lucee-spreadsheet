<cfscript>
describe( "setSheetPrintOrientation",function(){

	beforeEach( function(){
		variables.xls = s.new();
		variables.xlsx = s.newXlsx();
	});

	it( "throws an exception if the mode is invalid",function() {
		expect( function(){
			s.setSheetPrintOrientation( xls, "blah" );
		}).toThrow( regex="Invalid mode" );
	});

	it( "throws an exception if the both sheet name and number are specified",function() {
		expect( function(){
			s.setSheetPrintOrientation( xls, "landscape", "test", 1 );
		}).toThrow( regex="Invalid arguments" );
	});

	it( "by default sets the active sheet to the specified orientation",function() {
		makePublic( s, "getActiveSheet" );
		var sheet = s.getActiveSheet( xls );
		expect( sheet.getPrintSetup().getLandscape() ).toBeFalse();
		s.setSheetPrintOrientation( xls, "landscape" );
		expect( sheet.getPrintSetup().getLandscape() ).toBeTrue();
		s.setSheetPrintOrientation( xls, "portrait" );
		expect( sheet.getPrintSetup().getLandscape() ).toBeFalse();
		//xlsx
		var sheet = s.getActiveSheet( xlsx );
		expect( sheet.getPrintSetup().getLandscape() ).toBeFalse();
		s.setSheetPrintOrientation( xlsx, "landscape" );
		expect( sheet.getPrintSetup().getLandscape() ).toBeTrue();
		s.setSheetPrintOrientation( xlsx, "portrait" );
		expect( sheet.getPrintSetup().getLandscape() ).toBeFalse();
	});

	it( "sets the named sheet to the specified orientation",function() {
		makePublic( s, "getSheetByName" );
		xls.createSheet( "test" );
		s.setSheetPrintOrientation( xls, "landscape", "test" );
		var sheet = s.getSheetByName( xls, "test" );
		expect( sheet.getPrintSetup().getLandscape() ).toBeTrue();
	});

	it( "sets the specified sheet number to the specified orientation",function() {
		makePublic( s, "getSheetByNumber" );
		xls.createSheet( "test" );
		var sheet = s.getSheetByNumber( xls, 2 );
		expect( sheet.getPrintSetup().getLandscape() ).toBeFalse();
		// named arguments
		s.setSheetPrintOrientation( workbook=xls, mode="landscape", sheetNumber=2 );
		expect( sheet.getPrintSetup().getLandscape() ).toBeTrue();
		//positional
		s.setSheetPrintOrientation( xls, "portrait", "", 2 );
		expect( sheet.getPrintSetup().getLandscape() ).toBeFalse();
	});

});	
</cfscript>