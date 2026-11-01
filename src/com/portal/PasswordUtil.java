package com.portal;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/** Creates and verifies salted PBKDF2 password hashes. */
final class PasswordUtil {
    private static final int SALT_LENGTH = 16;
    private static final int ITERATIONS = 120000;
    private static final int KEY_LENGTH = 256;
    private static final SecureRandom RANDOM = new SecureRandom();

    private PasswordUtil() { }

    static String hash(String password) throws GeneralSecurityException {
        byte[] salt = new byte[SALT_LENGTH];
        RANDOM.nextBytes(salt);
        byte[] derived = derive(password, salt);
        return Base64.getEncoder().encodeToString(salt) + ":"
                + Base64.getEncoder().encodeToString(derived);
    }

    static boolean verify(String password, String storedHash) {
        if (password == null || storedHash == null) return false;
        String[] parts = storedHash.split(":", 2);
        if (parts.length != 2) return false;
        try {
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] expected = Base64.getDecoder().decode(parts[1]);
            byte[] actual = derive(password, salt);
            return MessageDigest.isEqual(expected, actual);
        } catch (IllegalArgumentException | GeneralSecurityException ex) {
            return false;
        }
    }

    private static byte[] derive(String password, byte[] salt)
            throws GeneralSecurityException {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt,
                ITERATIONS, KEY_LENGTH);
        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                    .generateSecret(spec).getEncoded();
        } finally {
            spec.clearPassword();
        }
    }
}
