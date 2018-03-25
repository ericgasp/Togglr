@isTest
private class ArgumentNullExceptionTest {
    private static final String TEST_VAR = 'testVar';

    @isTest
    private static void throwIfNull_objIsNull_expectException() {
        try {
            test.startTest();
            ArgumentNullException.throwIfNull(null, TEST_VAR);
            TestHelper.expectedArgumentNullException();
        } catch (Exception e) {
            TestHelper.assertArgumentNullException(e, TEST_VAR);
        } finally {
            test.stopTest();
        }
    }

    @isTest
    private static void throwIfNull_objIsNotNull_expectNoException() {
        try {
            test.startTest();
            ArgumentNullException.throwIfNull('Not Null', TEST_VAR);
        } catch (Exception e) {
            System.assert(false, 'Expected there to be no exception thrown.');
        } finally {
            test.stopTest();
        }
    }
}