package com.portal;

/** Small helper for safely printing user-provided values into HTML. */
public final class HtmlUtil {
    private HtmlUtil() { }

    public static String escape(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
