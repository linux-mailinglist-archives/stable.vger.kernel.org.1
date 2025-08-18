Return-Path: <stable+bounces-169949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B90FFB29E4B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B64D7A18C6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E51226CE5;
	Mon, 18 Aug 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+reSpAm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C022036FA
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510379; cv=none; b=M26U0VguH+/iH5I+/6AnGSAQXskz10cgdklKCpDmOCb1e7f5v2of6CVZQQsLky7NFk7PZbF9031+4La4QZXS4dazwK4uZ/qXN1/mJrUeK1cziV2LzbQcGy5eo1mN1p7RX7bXBYNv4YTFja44y943LIuqVCKzuQ5JJC9t5RcDAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510379; c=relaxed/simple;
	bh=hrPQxGkTxstqpXnFgnct5aZVHWWvIkbHjKApuGYZM2o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OivTu9jTW+CMEkx21/wgSSHNUA+XNvkWEIgwT21+NCD4WD2+DiWTxnuPPi6IqdSAhLHvurwaIwvZe4nZKgLhZ+T4pUBB7twxqgUEAT8BAlOQFX7RybWoOhltBXI68f24F7Ole8au7ExEurd2AMksDxw29w2ZRdl2yeHMYNCDu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+reSpAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B4DC4CEEB;
	Mon, 18 Aug 2025 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510376;
	bh=hrPQxGkTxstqpXnFgnct5aZVHWWvIkbHjKApuGYZM2o=;
	h=Subject:To:Cc:From:Date:From;
	b=z+reSpAm+UEYelc4VLPVgsID9q50T2+Kz+7Sj22Th2dGkTsGGdlrfuJVBuIM02W58
	 4aIkxx8X6pG4RD+2HK+eB/8A9ZPKB3n89leUj/dM7OS9wUaKCny/aqXQsX8Hq9uIA5
	 GxKUoTaSgUbvFHHtPjpwq498k1YFp+2vWVdL7mcQ=
Subject: FAILED: patch "[PATCH] rust: workaround `rustdoc` target modifiers bug" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:46:13 +0200
Message-ID: <2025081813-overhand-resolute-c0f3@gregkh>
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
git cherry-pick -x abbf9a44944171ca99c150adad9361a2f517d3b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081813-overhand-resolute-c0f3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From abbf9a44944171ca99c150adad9361a2f517d3b6 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sun, 27 Jul 2025 11:23:17 +0200
Subject: [PATCH] rust: workaround `rustdoc` target modifiers bug

Starting with Rust 1.88.0 (released 2025-06-26), `rustdoc` complains
about a target modifier mismatch in configurations where `-Zfixed-x18`
is passed:

    error: mixing `-Zfixed-x18` will cause an ABI mismatch in crate `rust_out`
      |
      = help: the `-Zfixed-x18` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
      = note: unset `-Zfixed-x18` in this crate is incompatible with `-Zfixed-x18=` in dependency `core`
      = help: set `-Zfixed-x18=` in this crate or unset `-Zfixed-x18` in `core`
      = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=fixed-x18` to silence this error

The reason is that `rustdoc` was not passing the target modifiers when
configuring the session options, and thus it would report a mismatch
that did not exist as soon as a target modifier is used in a dependency.

We did not notice it in the kernel until now because `-Zfixed-x18` has
been a target modifier only since 1.88.0 (and it is the only one we use
so far).

The issue has been reported upstream [1] and a fix has been submitted
[2], including a test similar to the kernel case.

  [ This is now fixed upstream (thanks Guillaume for the quick review),
    so it will be fixed in Rust 1.90.0 (expected 2025-09-18).

      - Miguel ]

Meanwhile, conditionally pass `-Cunsafe-allow-abi-mismatch=fixed-x18`
to workaround the issue on our side.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Closes: https://lore.kernel.org/rust-for-linux/36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com/
Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250727092317.2930617-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/Makefile b/rust/Makefile
index 4263462b8470..d47f82588d78 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -65,6 +65,10 @@ core-cfgs = \
 
 core-edition := $(if $(call rustc-min-version,108700),2024,2021)
 
+# `rustdoc` did not save the target modifiers, thus workaround for
+# the time being (https://github.com/rust-lang/rust/issues/144521).
+rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
+
 # `rustc` recognizes `--remap-path-prefix` since 1.26.0, but `rustdoc` only
 # since Rust 1.81.0. Moreover, `rustdoc` ICEs on out-of-tree builds since Rust
 # 1.82.0 (https://github.com/rust-lang/rust/issues/138520). Thus workaround both
@@ -77,6 +81,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
+		$(rustdoc_modifiers_workaround) \
 		$(if $(rustdoc_host),,--sysroot=/dev/null) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -215,6 +220,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
 		--sysroot=/dev/null \
+		$(rustdoc_modifiers_workaround) \
 		--test-builder $(objtree)/scripts/rustdoc_test_builder \
 		$< $(rustdoc_test_kernel_quiet); \
 	$(objtree)/scripts/rustdoc_test_gen


