Return-Path: <stable+bounces-104223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F332E9F2278
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F370A1886B84
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04C17C96;
	Sun, 15 Dec 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmSJ+yud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B814C80
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734248344; cv=none; b=IT1ywFLy8W0uiuSsJraLgv0Htd7NB0Jpq5KqUGUlb3o+qZWKwv5dYBhrKpxX/2w30NiS6AsvZcyptc3Nt9isbjWJRsnLH/LVxNvnMU7CvRy/J4X3GnChRwcTUqLzkTlw/d8RT48RSokW4E5Qp0bkmU7qMBncQ0d/m8xzgT1R8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734248344; c=relaxed/simple;
	bh=PAPgnMizaAKo2qQl+8972g3lGXXyVC5YxH+Q1IBm75c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=abPA4Zil0zQ4LBggO3F0sBUvFEgngrkcrj4MNgtxntIGr/EVQSMc8mhwuDKZakjzirUjaBEVkN++VgcPZ4wWeNfp88B1XkSgURKVL9HI2pzrNFcaE2mvUk1ImOqvjC4B2lYMq3d1TcE6mDD3miwBHfMEMVDblmX/i8KBhVgXfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmSJ+yud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65436C4CECE;
	Sun, 15 Dec 2024 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734248344;
	bh=PAPgnMizaAKo2qQl+8972g3lGXXyVC5YxH+Q1IBm75c=;
	h=Subject:To:Cc:From:Date:From;
	b=vmSJ+yudZ4LFzw6rf3QTb5qUmz4o/hRS7ZEs45ur5GazfagpjYuaudcV6U3RO1iYc
	 itC1L6cZd5XtNvqVTm7K2Gp2uCDxWH4ySLikdHMEZpMf1oajakH7+2BJRVcawxgQRi
	 8q6CR4+/OlFL1rW8VBs/3optkK5a2B0hceYtRG2s=
Subject: FAILED: patch "[PATCH] rust: kbuild: set `bindgen`'s Rust target version" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,emilio@crisal.io,git@pvdrz.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 08:39:00 +0100
Message-ID: <2024121500-switch-jab-65fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7a5f93ea5862da91488975acaa0c7abd508f192b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121500-switch-jab-65fc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a5f93ea5862da91488975acaa0c7abd508f192b Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sat, 23 Nov 2024 19:03:23 +0100
Subject: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Each `bindgen` release may upgrade the list of Rust targets. For instance,
currently, in their master branch [1], the latest ones are:

    Nightly => {
        vectorcall_abi: #124485,
        ptr_metadata: #81513,
        layout_for_ptr: #69835,
    },
    Stable_1_77(77) => { offset_of: #106655 },
    Stable_1_73(73) => { thiscall_abi: #42202 },
    Stable_1_71(71) => { c_unwind_abi: #106075 },
    Stable_1_68(68) => { abi_efiapi: #105795 },

By default, the highest stable release in their list is used, and users
are expected to set one if they need to support older Rust versions
(e.g. see [2]).

Thus, over time, new Rust features are used by default, and at some
point, it is likely that `bindgen` will emit Rust code that requires a
Rust version higher than our minimum (or perhaps enabling an unstable
feature). Currently, there is no problem because the maximum they have,
as seen above, is Rust 1.77.0, and our current minimum is Rust 1.78.0.

Therefore, set a Rust target explicitly now to prevent going forward in
time too much and thus getting potential build failures at some point.

Since we also support a minimum `bindgen` version, and since `bindgen`
does not support passing unknown Rust target versions, we need to use
the list of our minimum `bindgen` version, rather than the latest. So,
since `bindgen` 0.65.1 had this list [3], we need to use Rust 1.68.0:

    /// Rust stable 1.64
    ///  * `core_ffi_c` ([Tracking issue](https://github.com/rust-lang/rust/issues/94501))
    => Stable_1_64 => 1.64;
    /// Rust stable 1.68
    ///  * `abi_efiapi` calling convention ([Tracking issue](https://github.com/rust-lang/rust/issues/65815))
    => Stable_1_68 => 1.68;
    /// Nightly rust
    ///  * `thiscall` calling convention ([Tracking issue](https://github.com/rust-lang/rust/issues/42202))
    ///  * `vectorcall` calling convention (no tracking issue)
    ///  * `c_unwind` calling convention ([Tracking issue](https://github.com/rust-lang/rust/issues/74990))
    => Nightly => nightly;

    ...

    /// Latest stable release of Rust
    pub const LATEST_STABLE_RUST: RustTarget = RustTarget::Stable_1_68;

Thus add the `--rust-target 1.68` parameter. Add a comment as well
explaining this.

An alternative would be to use the currently running (i.e. actual) `rustc`
and `bindgen` versions to pick a "better" Rust target version. However,
that would introduce more moving parts depending on the user setup and
is also more complex to implement.

Starting with `bindgen` 0.71.0 [4], we will be able to set any future
Rust version instead, i.e. we will be able to set here our minimum
supported Rust version. Christian implemented it [5] after seeing this
patch. Thanks!

Cc: Christian Poveda <git@pvdrz.com>
Cc: Emilio Cobos Álvarez <emilio@crisal.io>
Cc: stable@vger.kernel.org # needed for 6.12.y; unneeded for 6.6.y; do not apply to 6.1.y
Fixes: c844fa64a2d4 ("rust: start supporting several `bindgen` versions")
Link: https://github.com/rust-lang/rust-bindgen/blob/21c60f473f4e824d4aa9b2b508056320d474b110/bindgen/features.rs#L97-L105 [1]
Link: https://github.com/rust-lang/rust-bindgen/issues/2960 [2]
Link: https://github.com/rust-lang/rust-bindgen/blob/7d243056d335fdc4537f7bca73c06d01aae24ddc/bindgen/features.rs#L131-L150 [3]
Link: https://github.com/rust-lang/rust-bindgen/blob/main/CHANGELOG.md#0710-2024-12-06 [4]
Link: https://github.com/rust-lang/rust-bindgen/pull/2993 [5]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20241123180323.255997-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/Makefile b/rust/Makefile
index 9da9042fd627..a40a3936126d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -280,9 +280,22 @@ endif
 # architecture instead of generating `usize`.
 bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 
+# Each `bindgen` release may upgrade the list of Rust target versions. By
+# default, the highest stable release in their list is used. Thus we need to set
+# a `--rust-target` to avoid future `bindgen` releases emitting code that
+# `rustc` may not understand. On top of that, `bindgen` does not support passing
+# an unknown Rust target version.
+#
+# Therefore, the Rust target for `bindgen` can be only as high as the minimum
+# Rust version the kernel supports and only as high as the greatest stable Rust
+# target supported by the minimum `bindgen` version the kernel supports (that
+# is, if we do not test the actual `rustc`/`bindgen` versions running).
+#
+# Starting with `bindgen` 0.71.0, we will be able to set any future Rust version
+# instead, i.e. we will be able to set here our minimum supported Rust version.
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
-	$(BINDGEN) $< $(bindgen_target_flags) \
+	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.68 \
 		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
 		--no-debug '.*' --enable-function-attribute-detection \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \


