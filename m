Return-Path: <stable+bounces-192769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB07C427B2
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 06:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672A9188EC2A
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 05:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA2E26E6E4;
	Sat,  8 Nov 2025 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yE/oN+ne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166141F419A
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762579449; cv=none; b=D3nlVGHXRvo6eYy/P53oj7zxP8WZuoXOPOcT0bKIbz2Ksv1dovTiYEGo8XR5B4FElTgL7lKR21urTZkbGV0yop3nxPx7fKqZJjZYSFZ4Y8LDPLaj1+isGeRECRNlGZregZX1ai+CvE8QMPzWEVJRqpSsU9VfjeLBLAxo2Bky/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762579449; c=relaxed/simple;
	bh=viDK+BQMKPWCkXU8yEX35LKQDgQgO06CTEkK8rndBBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a/r+ZEhCGk7pTfYyEfzIHBJofZf5itiR61NR/l2qxsOuiepCSZD0sKkyVaoIzKCjUZOT4O6seNZK+vXgllJE5wGb/S17KOG2mClF2S7oUTVB8wop+Gu7cTNIkXeVBcgtJdJ6fG7AlYa9fMZPg3PxHWg79LyL68lgVcBeldFt0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yE/oN+ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575E5C113D0;
	Sat,  8 Nov 2025 05:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762579448;
	bh=viDK+BQMKPWCkXU8yEX35LKQDgQgO06CTEkK8rndBBM=;
	h=Subject:To:Cc:From:Date:From;
	b=yE/oN+neSJsQIRKXI63z7cWMZcJRBAkUuNT2hxJjhTBdC7tAD4ZWBido+23+Jjs05
	 FiFyfxFuw4BuR/D211vy99WaAJFrvOW25dsIg0nwacM5zJ2dNUwq7YCx1GRavqCQT6
	 TiUHl+mTvM+KniMLoF8xd6EW2ul+lyGpQEVHU8YA=
Subject: FAILED: patch "[PATCH] rust: kbuild: workaround `rustdoc` doctests modifier bug" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,jforbes@fedoraproject.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 08 Nov 2025 14:24:05 +0900
Message-ID: <2025110805-fame-viability-c333@gregkh>
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
git cherry-pick -x fad472efab0a805dd939f017c5b8669a786a4bcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110805-fame-viability-c333@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fad472efab0a805dd939f017c5b8669a786a4bcf Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sun, 2 Nov 2025 22:28:53 +0100
Subject: [PATCH] rust: kbuild: workaround `rustdoc` doctests modifier bug

The `rustdoc` modifiers bug [1] was fixed in Rust 1.90.0 [2], for which
we added a workaround in commit abbf9a449441 ("rust: workaround `rustdoc`
target modifiers bug").

However, `rustdoc`'s doctest generation still has a similar issue [3],
being fixed at [4], which does not affect us because we apply the
workaround to both, and now, starting with Rust 1.91.0 (released
2025-10-30), `-Zsanitizer` is a target modifier too [5], which means we
fail with:

      RUSTDOC TK rust/kernel/lib.rs
    error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `kernel`
     --> rust/kernel/lib.rs:3:1
      |
    3 | //! The `kernel` crate.
      | ^
      |
      = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
      = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
      = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
      = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error

A simple way around is to add the sanitizer to the list in the existing
workaround (especially if we had not started to pass the sanitizer
flags in the previous commit, since in that case that would not be
necessary). However, that still applies the workaround in more cases
than necessary.

Instead, only modify the doctests flags to ignore the check for
sanitizers, so that it is more local (and thus the compiler keeps checking
it for us in the normal `rustdoc` calls). Since the previous commit
already treated the `rustdoc` calls as kernel objects, this should allow
us in the future to easily remove this workaround when the time comes.

By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
ones rather than appending, so it needs to be all done in the same flag.
Moreover, unknown modifiers are rejected, and thus we have to gate based
on the version too.

Finally, `-Zsanitizer-cfi-normalize-integers` is not affected (in Rust
1.91.0), so it is not needed in the workaround for the moment.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Link: https://github.com/rust-lang/rust/issues/146465 [3]
Link: https://github.com/rust-lang/rust/pull/148068 [4]
Link: https://github.com/rust-lang/rust/pull/138736 [5]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Link: https://patch.msgid.link/20251102212853.1505384-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/Makefile b/rust/Makefile
index a9fb9354b659..3e545c1a0ff4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -69,6 +69,9 @@ core-edition := $(if $(call rustc-min-version,108700),2024,2021)
 # the time being (https://github.com/rust-lang/rust/issues/144521).
 rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
 
+# Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
+doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
+
 # `rustc` recognizes `--remap-path-prefix` since 1.26.0, but `rustdoc` only
 # since Rust 1.81.0. Moreover, `rustdoc` ICEs on out-of-tree builds since Rust
 # 1.82.0 (https://github.com/rust-lang/rust/issues/138520). Thus workaround both
@@ -236,7 +239,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
 		--sysroot=/dev/null \
-		$(rustdoc_modifiers_workaround) \
+		$(doctests_modifiers_workaround) \
 		--test-builder $(objtree)/scripts/rustdoc_test_builder \
 		$< $(rustdoc_test_kernel_quiet); \
 	$(objtree)/scripts/rustdoc_test_gen


