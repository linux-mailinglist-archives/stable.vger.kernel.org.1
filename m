Return-Path: <stable+bounces-143139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3052AB329E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E810B7AEA20
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D425A353;
	Mon, 12 May 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVd9l4DH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771D25A2C3
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040544; cv=none; b=Ok+rUG+3I8zCdq9o8XKrUxHV6pwvsO4I+jblsNzHSyTVqEE4OUXxMrpvtIoY8RMN8okXFLS/WN2sdzuw62fVe8GUcsYg/dc01SGeltahmv+99JV89Wnd+hoBB94Z+d+Z/UumJJWBcgbIwhIaXi+XGfc+ZP9weDGNVZCIs/pJBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040544; c=relaxed/simple;
	bh=YEAtPn7sPGJPtXckdx2GRWZIw8FVhW2nhBGRFDPqd+Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BCrNRNAImKdGy3LA6rdZQvUrE3lqGo7r5jsnBo2iKJTtwD64KX5h2BhToqScAIwruWfz7KOdWKvUcyHfyrnN/yr6WT6iejZVFlh4CPulPuRqBx62/WUBZp4obQ40denVN0p7aV7RH5MjfvBCG2tSmA2fJyQT/izH5hDtc/E9fJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVd9l4DH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C322EC4CEE7;
	Mon, 12 May 2025 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747040544;
	bh=YEAtPn7sPGJPtXckdx2GRWZIw8FVhW2nhBGRFDPqd+Y=;
	h=Subject:To:Cc:From:Date:From;
	b=ZVd9l4DHP4URBQPnGlyFcbeh6gb8o2E3xgoxqRjS5cnUmbVfozjXUtucCojp5JpFQ
	 OsccOZOM5uuk2fYyf9RHK/i7eqan6LC/AY3vG2lekctAINJ2DQn22hVD5ivZY4TijM
	 m/l00YzxCUNS8rU6Y4xPMeL1zzE+IM/yvWiIp+nA=
Subject: FAILED: patch "[PATCH] rust: clean Rust 1.88.0's `clippy::uninlined_format_args`" failed to apply to 6.14-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,lossin@kernel.org,tamird@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:02:17 +0200
Message-ID: <2025051217-trifle-batboy-aab3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 211dcf77856db64c73e0c3b9ce0c624ec855daca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051217-trifle-batboy-aab3@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 211dcf77856db64c73e0c3b9ce0c624ec855daca Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Fri, 2 May 2025 16:02:37 +0200
Subject: [PATCH] rust: clean Rust 1.88.0's `clippy::uninlined_format_args`
 lint

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

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 17c9660da450..ab0e5a72a059 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -93,7 +93,7 @@ pub(crate) fn arch(&self) -> Architecture {
 // For now, redirect to fmt::Debug for convenience.
 impl fmt::Display for Chipset {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        write!(f, "{:?}", self)
+        write!(f, "{self:?}")
     }
 }
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 878111cb77bc..fb61ce81ea28 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -73,7 +73,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 b'\r' => f.write_str("\\r")?,
                 // Printable characters.
                 0x20..=0x7e => f.write_char(b as char)?,
-                _ => write!(f, "\\x{:02x}", b)?,
+                _ => write!(f, "\\x{b:02x}")?,
             }
         }
         Ok(())
@@ -109,7 +109,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 b'\\' => f.write_str("\\\\")?,
                 // Printable characters.
                 0x20..=0x7e => f.write_char(b as char)?,
-                _ => write!(f, "\\x{:02x}", b)?,
+                _ => write!(f, "\\x{b:02x}")?,
             }
         }
         f.write_char('"')
@@ -447,7 +447,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // Printable character.
                 f.write_char(c as char)?;
             } else {
-                write!(f, "\\x{:02x}", c)?;
+                write!(f, "\\x{c:02x}")?;
             }
         }
         Ok(())
@@ -479,7 +479,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // Printable characters.
                 b'\"' => f.write_str("\\\"")?,
                 0x20..=0x7e => f.write_char(c as char)?,
-                _ => write!(f, "\\x{:02x}", c)?,
+                _ => write!(f, "\\x{c:02x}")?,
             }
         }
         f.write_str("\"")
@@ -641,13 +641,13 @@ fn test_cstr_as_str_unchecked() {
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
@@ -658,47 +658,47 @@ fn test_cstr_display_all_bytes() {
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
 
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 4f553ecf40c0..99ccac82edde 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -15,10 +15,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     }
 
     if attr.len() > 255 {
-        panic!(
-            "The test suite name `{}` exceeds the maximum length of 255 bytes",
-            attr
-        )
+        panic!("The test suite name `{attr}` exceeds the maximum length of 255 bytes")
     }
 
     let mut tokens: Vec<_> = ts.into_iter().collect();
@@ -102,16 +99,14 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     let mut kunit_macros = "".to_owned();
     let mut test_cases = "".to_owned();
     for test in &tests {
-        let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
+        let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{test}");
         let kunit_wrapper = format!(
-            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ {}(); }}",
-            kunit_wrapper_fn_name, test
+            "unsafe extern \"C\" fn {kunit_wrapper_fn_name}(_test: *mut kernel::bindings::kunit) {{ {test}(); }}"
         );
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
             test_cases,
-            "    kernel::kunit::kunit_case(kernel::c_str!(\"{}\"), {}),",
-            test, kunit_wrapper_fn_name
+            "    kernel::kunit::kunit_case(kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
         )
         .unwrap();
     }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a9418fbc9b44..2f66107847f7 100644
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
@@ -126,10 +126,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             };
 
             if seen_keys.contains(&key) {
-                panic!(
-                    "Duplicated key \"{}\". Keys can only be specified once.",
-                    key
-                );
+                panic!("Duplicated key \"{key}\". Keys can only be specified once.");
             }
 
             assert_eq!(expect_punct(it), ':');
@@ -143,10 +140,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
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
@@ -158,7 +152,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
 
         for key in REQUIRED_KEYS {
             if !seen_keys.iter().any(|e| e == key) {
-                panic!("Missing required key \"{}\".", key);
+                panic!("Missing required key \"{key}\".");
             }
         }
 
@@ -170,10 +164,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
         }
 
         if seen_keys != ordered_keys {
-            panic!(
-                "Keys are not ordered as expected. Order them like: {:?}.",
-                ordered_keys
-            );
+            panic!("Keys are not ordered as expected. Order them like: {ordered_keys:?}.");
         }
 
         info
diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
index 6529a387673f..cce712d19855 100644
--- a/rust/macros/paste.rs
+++ b/rust/macros/paste.rs
@@ -50,7 +50,7 @@ fn concat_helper(tokens: &[TokenTree]) -> Vec<(String, Span)> {
                 let tokens = group.stream().into_iter().collect::<Vec<TokenTree>>();
                 segments.append(&mut concat_helper(tokens.as_slice()));
             }
-            token => panic!("unexpected token in paste segments: {:?}", token),
+            token => panic!("unexpected token in paste segments: {token:?}"),
         };
     }
 
diff --git a/rust/pin-init/internal/src/pinned_drop.rs b/rust/pin-init/internal/src/pinned_drop.rs
index c824dd8b436d..c4ca7a70b726 100644
--- a/rust/pin-init/internal/src/pinned_drop.rs
+++ b/rust/pin-init/internal/src/pinned_drop.rs
@@ -28,8 +28,7 @@ pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream
             // Found the end of the generics, this should be `PinnedDrop`.
             assert!(
                 matches!(tt, TokenTree::Ident(i) if i.to_string() == "PinnedDrop"),
-                "expected 'PinnedDrop', found: '{:?}'",
-                tt
+                "expected 'PinnedDrop', found: '{tt:?}'"
             );
             pinned_drop_idx = Some(i);
             break;


