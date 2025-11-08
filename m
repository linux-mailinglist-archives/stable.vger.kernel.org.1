Return-Path: <stable+bounces-192781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D21C42DFF
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2430188F63D
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF91DE4F1;
	Sat,  8 Nov 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccdgvLtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9267483
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610871; cv=none; b=Em6FsuUNTJ82TuiBC0ce+QdmPmcS3HioGLZv2XcTgV46YpE0FOxoRym5JFD6YwKflkamep5e+gWWPSj2IhOl3x7hKPxHdKst+KFAzbVjFGTsG9RNeTe9/hFzE+Ffm2saRmsI/ROYi3kpBEFcOIR6nsYDnoClnxDfK6HwP6xC0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610871; c=relaxed/simple;
	bh=k7NZTR5S1qKB1g4bNrayjMhj2tvE1ITn7isu3HuBvD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+FMvK9FKWicEbeRrjqGXPfje+QAW4tsbNRbUTO+7Ws7Fbj7C/39Dl9XKu48xHmg8RhdduZXug+iKvLuX2FN59erabnLQ42fQuVtzlOYpms16zXcRbHIVOQ3j05tVRccIxUdnHfnqcTkaugLVejI4ZYEfKIRNrKT9Q4zwaytHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccdgvLtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E017C4CEFB;
	Sat,  8 Nov 2025 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762610871;
	bh=k7NZTR5S1qKB1g4bNrayjMhj2tvE1ITn7isu3HuBvD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccdgvLtxDY8kljuuW7wd73km4HbIzkRO4bJVt6tQCv4NNbkIfY33A8+sXeBaNL+Ts
	 UNOGFXcv6ibDQjYSZKUNbPLikMUmV646VfNI6AY0a83H2KZzH63vhuanr5f3z6P/n1
	 XOKf1xkz/vOr3bN2eMCvjrrkB91U5JrjMLf84q1V3pDE1Jksng2xzK3OQ0UG+M77zT
	 yM1tqG6S/9Xiyt+K4qR+2QB/2z9IK8EA6HuevkfkUhR9C5YG9Lh+C7EkXS3RlU4oy6
	 LG/nHQjFDwgx16Un/x/k5tj2zo8Bo6kMoX7g7ZypHT96AQosAqGqyrqC+wAZHQvgnF
	 Me9cUAH/W3rKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rust: kbuild: treat `build_error` and `rustdoc` as kernel objects
Date: Sat,  8 Nov 2025 09:07:48 -0500
Message-ID: <20251108140748.129017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110816-catalog-residency-716f@gregkh>
References: <2025110816-catalog-residency-716f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 16c43a56b79e2c3220b043236369a129d508c65a ]

Even if normally `build_error` isn't a kernel object, it should still
be treated as such so that we pass the same flags. Similarly, `rustdoc`
targets are never kernel objects, but we need to treat them as such.

Otherwise, starting with Rust 1.91.0 (released 2025-10-30), `rustc`
will complain about missing sanitizer flags since `-Zsanitizer` is a
target modifier too [1]:

    error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `build_error`
     --> rust/build_error.rs:3:1
      |
    3 | //! Build-time error.
      | ^
      |
      = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
      = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
      = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
      = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error

Thus explicitly mark them as kernel objects.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/138736 [1]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Link: https://patch.msgid.link/20251102212853.1505384-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 07c13100000cd..6bcc478900af2 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -107,12 +107,18 @@ rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
+# Even if `rustdoc` targets are not kernel objects, they should still be
+# treated as such so that we pass the same flags. Otherwise, for instance,
+# `rustdoc` will complain about missing sanitizer flags causing an ABI mismatch.
+rustdoc-compiler_builtins: private is-kernel-object := y
 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
+rustdoc-ffi: private is-kernel-object := y
 rustdoc-ffi: $(src)/ffi.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
+rustdoc-kernel: private is-kernel-object := y
 rustdoc-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings --extern uapi
@@ -433,6 +439,10 @@ $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+# Even if normally `build_error` is not a kernel object, it should still be
+# treated as such so that we pass the same flags. Otherwise, for instance,
+# `rustc` will complain about missing sanitizer flags causing an ABI mismatch.
+$(obj)/build_error.o: private is-kernel-object := y
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-- 
2.51.0


