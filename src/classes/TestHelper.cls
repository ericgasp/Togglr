/**
 * @description A collection of helpers for unit tests.
 */
@isTest
public class TestHelper {
    private static final String EXCEPTION_NAME_PARAM = 'exceptionName';
    private static final String PARAM_PARAM = 'param';
    private static final String E_PARAM = 'e';

    private static final String EXPECTED_EXCEPTION_ERROR = 'Expected a(n) {0} to be thrown.';
    private static final String EXPECTED_MESSAGE_ERROR = 'The exception thrown does not match the expected message.';

    /**
     * @description Asserts that the test was expecting an ArgumentNullException to be thrown.
     */
    public static void expectedArgumentNullException() {
        expectedException(ArgumentNullException.class.getName());
    }

    /**
     * @description Asserts that the test was expecting a given exception to be thrown, as passed
     *              in using the exceptionName parameter.
     * @param exceptionName The name of the expected exception.
     * @throws An ArgumentNullException if exceptionName is null.
     */
    public static void expectedException(String exceptionName) {
        ArgumentNullException.throwIfNull(exceptionName, EXCEPTION_NAME_PARAM);

        System.assert(false, String.format(EXPECTED_EXCEPTION_ERROR, new List<String> { exceptionName }));
    }

    /**
     * @description Asserts that the given exception is an ArgumentNullException and that the message
     *              matches the expected message.
     * @param e The thrown exception.
     * @param param The parameter that was checked, and is expected to be named in the message.
     * @throws An ArgumentNullException if either of the parameters are null.
     */
    public static void assertArgumentNullException(Exception e, String param) {
        ArgumentNullException.throwIfNull(e, E_PARAM);
        ArgumentNullException.throwIfNull(param, PARAM_PARAM);

        if (!(e instanceof ArgumentNullException)) {
            System.assert(false, String.format(EXPECTED_EXCEPTION_ERROR,
                    new List<String> { ArgumentNullException.class.getName() }));
        }

        String expectedMessage = String.format(ArgumentNullException.ARGUMENT_NULL_EXCEPTION_ERROR,
                new List<String> { param });
        System.debug(expectedMessage);
        System.debug(e.getMessage());
        if (e.getMessage() != expectedMessage) {
            System.assert(false, EXPECTED_MESSAGE_ERROR);
        }
    }
}