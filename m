Return-Path: <stable+bounces-143272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F282FAB394A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780491647A6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D214286;
	Mon, 12 May 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+7NuXd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C325A2B7
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056701; cv=none; b=KpoGd3YShSUil9Kw0mnFh2lj9PhuIuGshVeK7M0Z805+6axebQirxB54Yjho9ephMNz8Grv1nSYJR/o/ExO2nNZSk4kKSfPY5sYduHlY8kuTaRESXOzCponhmsVCFHgBJZxgo5A2+1h3SyNJgYmkte4gFYYZEBvBDI8OnXJoGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056701; c=relaxed/simple;
	bh=TzlFNfGdcdb40yCFhHrY2zWtD0E6H8zOUtj08Dgxlwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T63KfSA35LyfMzkxr+BPiPdpedKdriX/aZVKnDdKVyN6A1aUWF10s56Xi4gRPBYNQgD7W2dnxzt/4p0pYCL/9J0tkyEY6lMLmkpkbb5N245NoAynqKiFQfgylLEwDpxCaVcpsYo63uh8RmqGfxSWnLffZKsl4Tor48yNAliv5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+7NuXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E98C4CEE7;
	Mon, 12 May 2025 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747056701;
	bh=TzlFNfGdcdb40yCFhHrY2zWtD0E6H8zOUtj08Dgxlwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NW+7NuXdxpm9G8Zh7jahGGOA5h3Ksri6ED0Nkf1MKdmW+9Tr+zYyF7efuHPvcSmF8
	 i/svqi91upfkapUd1dK2Oj82yq2A0VaG1459mq6H1N6FVfEeSN8Dg22oVEvG51KmMU
	 FpV1To5co7VdxoU4cGpRBRwY+ErQzpMJJBjOW+PBOo3r6c3bWgwZWwqG2L6vThLpS6
	 llPpS/owHIGiuB/l6lmEfn/cUEb5+j1DXPN7jLY81MfrrsM/AoOmFn1WFAqMOXLMbZ
	 0QTmMrd7V2MD1NoyOtQWTC0A52Mku/DCPrjuNwf+jWMMxFUh53i4+xNDUxXBcG2Arn
	 5J2Na4bhTv71Q==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH 6.12.y] rust: clean Rust 1.88.0's `clippy::uninlined_format_args` lint
Date: Mon, 12 May 2025 15:31:26 +0200
Message-ID: <20250512133126.1409649-1-ojeda@kernel.org>
In-Reply-To: <2025051218-radiator-fang-0ab6@gregkh>
References: <2025051218-radiator-fang-0ab6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.88.0 (expected 2025-06-26) [1], `rustc` may move
back the `uninlined_format_args` to `style` from `pedantic` (it was
there waiting for rust-analyzer suppotr), and thus we will start to see
lints like:

    warning: variables can be used directly in the `format!` string
       --> rust/macros/kunit.rs:105:37
        |
    105 |         let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
        |                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
    help: change this to
        |
    105 -         let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
    105 +         let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{test}");

There is even a case that is a pure removal:

    warning: variables can be used directly in the `format!` string
      --> rust/macros/module.rs:51:13
       |
    51 |             format!("{field}={content}\0", field = field, content = content)
       |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       |
       = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
    help: change this to
       |
    51 -             format!("{field}={content}\0", field = field, content = content)
    51 +             format!("{field}={content}\0")

The lints all seem like nice cleanups, thus just apply them.

We may want to disable `allow-mixed-uninlined-format-args` in the future.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust-clippy/pull/14160 [1]
Acked-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250502140237.1659624-6-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 211dcf77856db64c73e0c3b9ce0c624ec855daca)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs         | 46 +++++++++++++++++++-------------------
 rust/macros/module.rs      | 19 +++++-----------
 rust/macros/pinned_drop.rs |  3 +--
 3 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d04c12a1426d..78ccfeb73858 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -55,7 +55,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 b'\r' => f.write_str("\\r")?,
                 // Printable characters.
                 0x20..=0x7e => f.write_char(b as char)?,
-                _ => write!(f, "\\x{:02x}", b)?,
+                _ => write!(f, "\\x{b:02x}")?,
             }
         }
         Ok(())
@@ -90,7 +90,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 b'\\' => f.write_str("\\\\")?,
                 // Printable characters.
                 0x20..=0x7e => f.write_char(b as char)?,
-                _ => write!(f, "\\x{:02x}", b)?,
+                _ => write!(f, "\\x{b:02x}")?,
             }
         }
         f.write_char('"')
@@ -397,7 +397,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // Printable character.
                 f.write_char(c as char)?;
             } else {
-                write!(f, "\\x{:02x}", c)?;
+                write!(f, "\\x{c:02x}")?;
             }
         }
         Ok(())
@@ -428,7 +428,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // Printable characters.
                 b'\"' => f.write_str("\\\"")?,
                 0x20..=0x7e => f.write_char(c as char)?,
-                _ => write!(f, "\\x{:02x}", c)?,
+                _ => write!(f, "\\x{c:02x}")?,
             }
         }
         f.write_str("\"")
@@ -588,13 +588,13 @@ fn test_cstr_as_str_unchecked() {
     #[test]
     fn test_cstr_display() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        assert_eq!(format!("{hello_world}"), "hello, world!");
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
+        assert_eq!(format!("{non_printables}"), "\\x01\\x09\\x0a");
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
     }
 
     #[test]
@@ -605,47 +605,47 @@ fn test_cstr_display_all_bytes() {
             bytes[i as usize] = i.wrapping_add(1);
         }
         let cstr = CStr::from_bytes_with_nul(&bytes).unwrap();
-        assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
+        assert_eq!(format!("{cstr}"), ALL_ASCII_CHARS);
     }
 
     #[test]
     fn test_cstr_debug() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
+        assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"");
+        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\x09\\x0a\"");
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
+        assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
     }
 
     #[test]
     fn test_bstr_display() {
         let hello_world = BStr::from_bytes(b"hello, world!");
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        assert_eq!(format!("{hello_world}"), "hello, world!");
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
-        assert_eq!(format!("{}", escapes), "_\\t_\\n_\\r_\\_'_\"_");
+        assert_eq!(format!("{escapes}"), "_\\t_\\n_\\r_\\_'_\"_");
         let others = BStr::from_bytes(b"\x01");
-        assert_eq!(format!("{}", others), "\\x01");
+        assert_eq!(format!("{others}"), "\\x01");
         let non_ascii = BStr::from_bytes(b"d\xe9j\xe0 vu");
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
     }
 
     #[test]
     fn test_bstr_debug() {
         let hello_world = BStr::from_bytes(b"hello, world!");
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
+        assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
-        assert_eq!(format!("{:?}", escapes), "\"_\\t_\\n_\\r_\\\\_'_\\\"_\"");
+        assert_eq!(format!("{escapes:?}"), "\"_\\t_\\n_\\r_\\\\_'_\\\"_\"");
         let others = BStr::from_bytes(b"\x01");
-        assert_eq!(format!("{:?}", others), "\"\\x01\"");
+        assert_eq!(format!("{others:?}"), "\"\\x01\"");
         let non_ascii = BStr::from_bytes(b"d\xe9j\xe0 vu");
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
+        assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
     }
 }
 
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index e7a087b7e884..da2a18b276e0 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -48,7 +48,7 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
             )
         } else {
             // Loadable modules' modinfo strings go as-is.
-            format!("{field}={content}\0", field = field, content = content)
+            format!("{field}={content}\0")
         };
 
         write!(
@@ -124,10 +124,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             };
 
             if seen_keys.contains(&key) {
-                panic!(
-                    "Duplicated key \"{}\". Keys can only be specified once.",
-                    key
-                );
+                panic!("Duplicated key \"{key}\". Keys can only be specified once.");
             }
 
             assert_eq!(expect_punct(it), ':');
@@ -140,10 +137,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
                 "firmware" => info.firmware = Some(expect_string_array(it)),
-                _ => panic!(
-                    "Unknown key \"{}\". Valid keys are: {:?}.",
-                    key, EXPECTED_KEYS
-                ),
+                _ => panic!("Unknown key \"{key}\". Valid keys are: {EXPECTED_KEYS:?}."),
             }
 
             assert_eq!(expect_punct(it), ',');
@@ -155,7 +149,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
 
         for key in REQUIRED_KEYS {
             if !seen_keys.iter().any(|e| e == key) {
-                panic!("Missing required key \"{}\".", key);
+                panic!("Missing required key \"{key}\".");
             }
         }
 
@@ -167,10 +161,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
         }
 
         if seen_keys != ordered_keys {
-            panic!(
-                "Keys are not ordered as expected. Order them like: {:?}.",
-                ordered_keys
-            );
+            panic!("Keys are not ordered as expected. Order them like: {ordered_keys:?}.");
         }
 
         info
diff --git a/rust/macros/pinned_drop.rs b/rust/macros/pinned_drop.rs
index 88fb72b20660..79a52e254f71 100644
--- a/rust/macros/pinned_drop.rs
+++ b/rust/macros/pinned_drop.rs
@@ -25,8 +25,7 @@ pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream
             // Found the end of the generics, this should be `PinnedDrop`.
             assert!(
                 matches!(tt, TokenTree::Ident(i) if i.to_string() == "PinnedDrop"),
-                "expected 'PinnedDrop', found: '{:?}'",
-                tt
+                "expected 'PinnedDrop', found: '{tt:?}'"
             );
             pinned_drop_idx = Some(i);
             break;
-- 
2.49.0


