Return-Path: <stable+bounces-192770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E348FC427B5
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 06:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E233B6E91
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 05:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED226E6E4;
	Sat,  8 Nov 2025 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UB2yrM8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580461F419A
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762579460; cv=none; b=mjQJZWfFPgh14G0VU6i/PAxl0kDV1nu5H7w7gHkspPzosgO7TqhAp23VzSwHx2Z805Ad8gJbladzBGXP0esm0+P8bVG6lciRBQM5slsirFww2FgZfG5SCgJCLzkynr+ri6GvBZ8fw5HpE9HHVFBp1/6VqBJjomYDLz5ci/z/fCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762579460; c=relaxed/simple;
	bh=QYO2EKL4gHHyWReXW61oggdfOqvH1okQ5NiRe9HVnYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l83aG3NYGLtAg2gObmyHLD5XN81/Ooc6Ff2ORKjLZCS/QLjhuWOjfGlDWYE82VXybUN0OqmVnxx4+01gAGPGw5UwunMOI4gcNH1phNkSocjAT2CPVSthRiOWDHJGgDfe/+UuEGYfUyWV1LdtqHFSgkB+LyiFSpKXzS3GoftjZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UB2yrM8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE65C4CEF7;
	Sat,  8 Nov 2025 05:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762579459;
	bh=QYO2EKL4gHHyWReXW61oggdfOqvH1okQ5NiRe9HVnYk=;
	h=Subject:To:Cc:From:Date:From;
	b=UB2yrM8l4S3YzdHndMOSs2/fQ/oLKbd8pYX5OHodJTS2aWZDbkVbu3HjKo7rYrGXO
	 Ec3KLVdYvuvrmWi7UKsUOvj4QUD8KGvvxPmtDYcDrTBrNJOq0ez32rlO5zChhDcjjm
	 R8MCmp1YdefLBEco1qyrq2a7VPwr8ZGffqwxvhLw=
Subject: FAILED: patch "[PATCH] rust: kbuild: treat `build_error` and `rustdoc` as kernel" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,jforbes@fedoraproject.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 08 Nov 2025 14:24:17 +0900
Message-ID: <2025110816-catalog-residency-716f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 16c43a56b79e2c3220b043236369a129d508c65a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110816-catalog-residency-716f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16c43a56b79e2c3220b043236369a129d508c65a Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sun, 2 Nov 2025 22:28:52 +0100
Subject: [PATCH] rust: kbuild: treat `build_error` and `rustdoc` as kernel
 objects

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

diff --git a/rust/Makefile b/rust/Makefile
index 23c7ae905bd2..a9fb9354b659 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -127,9 +127,14 @@ rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs
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
 
@@ -147,6 +152,7 @@ rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
     rustdoc-macros FORCE
 	+$(call if_changed,rustdoc)
 
+rustdoc-kernel: private is-kernel-object := y
 rustdoc-kernel: private rustc_target_flags = --extern ffi --extern pin_init \
     --extern build_error --extern macros \
     --extern bindings --extern uapi
@@ -522,6 +528,10 @@ $(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/compiler_builtins.o \
     $(obj)/$(libpin_init_internal_name) $(obj)/$(libmacros_name) FORCE
 	+$(call if_changed_rule,rustc_library)
 
+# Even if normally `build_error` is not a kernel object, it should still be
+# treated as such so that we pass the same flags. Otherwise, for instance,
+# `rustc` will complain about missing sanitizer flags causing an ABI mismatch.
+$(obj)/build_error.o: private is-kernel-object := y
 $(obj)/build_error.o: private skip_gendwarfksyms = 1
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)


