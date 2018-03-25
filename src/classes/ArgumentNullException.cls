/**
 * @description A custom exception for null arguments.
 */
public with sharing class ArgumentNullException extends Exception {
    /**
     * @description The error set when an ArgumentNullException is thrown.
     */
    public static final String ARGUMENT_NULL_EXCEPTION_ERROR = 'Unexpected null argument: {0}.';

    /**
     * @description Tests whether the object passed in is null, and throws an ArgumentNullException if it is.
     * @param o The object to test.
     * @param param The string parameter name of the object being tested.
     * @throws An ArgumentNullException if o is null.
     */
    public static void throwIfNull(Object o, String param) {
        if (o == null) {
            throw new ArgumentNullException(String.format(ARGUMENT_NULL_EXCEPTION_ERROR, new List<String> { param }));
        }
    }
}