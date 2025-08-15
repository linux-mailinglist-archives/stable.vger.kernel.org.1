Return-Path: <stable+bounces-169758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A7FB2838B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363CB7ACDD6
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC218307AF6;
	Fri, 15 Aug 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQGlPzXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCB2FCBFC
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274171; cv=none; b=Npx+PapJ2n4nCHBb2CUMFjS3U/wfo6VaEK2jQ/a5VIkgcGlec0HLX4D3ZAmOc+cAynytqnm7anDDyQiFjepKaWmddj9b5TWNNjhLHLPLTMmhrwqOB/U4Cw9dFveJB29yFbK6sHFG8YMQvq1mB9yW06Q/2Ag4LPVYpufGTGuETUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274171; c=relaxed/simple;
	bh=GmHjGMjw6+CUrzt6IQQcXw5LWhMJBrQBEFzTQAyVuVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KDTFuhMpn4FNX2fkF++XZa/EZFGe4Ek9niOgRbseXNBfuBan+47VmfH0gGRySgUIeY4Zyjv1kHWtSPoUzfdr5k6gY48t6z0XoUqwLfPw6i6j4LwWD8fCPRGXAFo6W/uKHYEjafC9+m6S9MYH2TgnOnQl+YqNxnQrF4BMf3YuLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQGlPzXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1266C4CEF4;
	Fri, 15 Aug 2025 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755274171;
	bh=GmHjGMjw6+CUrzt6IQQcXw5LWhMJBrQBEFzTQAyVuVk=;
	h=Subject:To:Cc:From:Date:From;
	b=FQGlPzXTcdPTr8pEbQXbkdp4QiE1J3VbBPs4oGrOq528tw8jfYszaGlZ7Zlawm84b
	 UVgu9dfeozU7pXc9iLuqTfOh4IAoapv4o4Qr9IVfM5mY7B7JW5G8mgzt+cbOC0JfEk
	 5n8vhjvzcUmW/ujQ9WeYtLfUrZ2wN16RQF/mZgsw=
Subject: FAILED: patch "[PATCH] lib/crypto: x86/poly1305: Fix register corruption in no-SIMD" failed to apply to 5.15-stable tree
To: ebiggers@kernel.org,ardb@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 18:09:08 +0200
Message-ID: <2025081508-handcart-oversweet-f21e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 16f2c30e290e04135b70ad374fb7e1d1ed9ff5e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081508-handcart-oversweet-f21e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16f2c30e290e04135b70ad374fb7e1d1ed9ff5e7 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 6 Jul 2025 16:10:59 -0700
Subject: [PATCH] lib/crypto: x86/poly1305: Fix register corruption in no-SIMD
 contexts

Restore the SIMD usability check and base conversion that were removed
by commit 318c53ae02f2 ("crypto: x86/poly1305 - Add block-only
interface").

This safety check is cheap and is well worth eliminating a footgun.
While the Poly1305 functions should not be called when SIMD registers
are unusable, if they are anyway, they should just do the right thing
instead of corrupting random tasks' registers and/or computing incorrect
MACs.  Fixing this is also needed for poly1305_kunit to pass.

Just use irq_fpu_usable() instead of the original crypto_simd_usable(),
since poly1305_kunit won't rely on crypto_simd_disabled_for_test.

Fixes: 318c53ae02f2 ("crypto: x86/poly1305 - Add block-only interface")
Cc: stable@vger.kernel.org
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250706231100.176113-5-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/x86/poly1305_glue.c b/lib/crypto/x86/poly1305_glue.c
index b7e78a583e07..968d84677631 100644
--- a/lib/crypto/x86/poly1305_glue.c
+++ b/lib/crypto/x86/poly1305_glue.c
@@ -25,6 +25,42 @@ struct poly1305_arch_internal {
 	struct { u32 r2, r1, r4, r3; } rn[9];
 };
 
+/*
+ * The AVX code uses base 2^26, while the scalar code uses base 2^64. If we hit
+ * the unfortunate situation of using AVX and then having to go back to scalar
+ * -- because the user is silly and has called the update function from two
+ * separate contexts -- then we need to convert back to the original base before
+ * proceeding. It is possible to reason that the initial reduction below is
+ * sufficient given the implementation invariants. However, for an avoidance of
+ * doubt and because this is not performance critical, we do the full reduction
+ * anyway. Z3 proof of below function: https://xn--4db.cc/ltPtHCKN/py
+ */
+static void convert_to_base2_64(void *ctx)
+{
+	struct poly1305_arch_internal *state = ctx;
+	u32 cy;
+
+	if (!state->is_base2_26)
+		return;
+
+	cy = state->h[0] >> 26; state->h[0] &= 0x3ffffff; state->h[1] += cy;
+	cy = state->h[1] >> 26; state->h[1] &= 0x3ffffff; state->h[2] += cy;
+	cy = state->h[2] >> 26; state->h[2] &= 0x3ffffff; state->h[3] += cy;
+	cy = state->h[3] >> 26; state->h[3] &= 0x3ffffff; state->h[4] += cy;
+	state->hs[0] = ((u64)state->h[2] << 52) | ((u64)state->h[1] << 26) | state->h[0];
+	state->hs[1] = ((u64)state->h[4] << 40) | ((u64)state->h[3] << 14) | (state->h[2] >> 12);
+	state->hs[2] = state->h[4] >> 24;
+	/* Unsigned Less Than: branchlessly produces 1 if a < b, else 0. */
+#define ULT(a, b) ((a ^ ((a ^ b) | ((a - b) ^ b))) >> (sizeof(a) * 8 - 1))
+	cy = (state->hs[2] >> 2) + (state->hs[2] & ~3ULL);
+	state->hs[2] &= 3;
+	state->hs[0] += cy;
+	state->hs[1] += (cy = ULT(state->hs[0], cy));
+	state->hs[2] += ULT(state->hs[1], cy);
+#undef ULT
+	state->is_base2_26 = 0;
+}
+
 asmlinkage void poly1305_block_init_arch(
 	struct poly1305_block_state *state,
 	const u8 raw_key[POLY1305_BLOCK_SIZE]);
@@ -62,7 +98,9 @@ void poly1305_blocks_arch(struct poly1305_block_state *state, const u8 *inp,
 	BUILD_BUG_ON(SZ_4K < POLY1305_BLOCK_SIZE ||
 		     SZ_4K % POLY1305_BLOCK_SIZE);
 
-	if (!static_branch_likely(&poly1305_use_avx)) {
+	if (!static_branch_likely(&poly1305_use_avx) ||
+	    unlikely(!irq_fpu_usable())) {
+		convert_to_base2_64(ctx);
 		poly1305_blocks_x86_64(ctx, inp, len, padbit);
 		return;
 	}


