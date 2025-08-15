Return-Path: <stable+bounces-169762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302BB2839D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986021B66903
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA87308F33;
	Fri, 15 Aug 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GnVD8mbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C12C21C8
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274202; cv=none; b=pqmdl0k1CLGtZq3+6qtzNxfYGC2jU235MTcpVBhwiMVC+08i+jYTJy/MYIDDs0GylvPlm/BoOh1/eV9h6qsHasmCPnoU0Rn1KoYoXUb6l6ZHVGXQf7m2fu8RL2B7FWyqbLLgf/g6CfYv9WcIhXtI+B7PAJSeyA9JxYKbhmJQLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274202; c=relaxed/simple;
	bh=SoY58ScDROLrvFcngYdaR22dV4UJ5yRVWi340Nm9TY4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SfxZ/ALuz1z2oKT8wF5FvIIFiU9wHju0+fsce39MI+pBdi0IACQocQmd/fRpdE9i0QNL0Zd/cXbFkZxaURsxUf22ZhSIGvAj0SsuiERaIjN8jiJvm4kwRAiIdf0xVY88MVWf0gPapU4yRAR1XwWL38XxY0CC/JzIvpj3rths4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GnVD8mbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8C0C4CEEB;
	Fri, 15 Aug 2025 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755274202;
	bh=SoY58ScDROLrvFcngYdaR22dV4UJ5yRVWi340Nm9TY4=;
	h=Subject:To:Cc:From:Date:From;
	b=GnVD8mbZkfAWAjgxTxqAlAFdQVil8zPjjVGr76dwoN8jQFJDmqvSIi24wRjaOwpnE
	 K0GSJRkNRCFJOt633awcOoWMmzPPPP6FvrB/yyn9YAYzydoScOKxX4Ytmn99/JnGag
	 McXQZBWASPyHHgTtXEGsdJOPTDzYjhGUwujz+ikE=
Subject: FAILED: patch "[PATCH] lib/crypto: arm64/poly1305: Fix register corruption in" failed to apply to 6.12-stable tree
To: ebiggers@kernel.org,ardb@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 18:09:56 +0200
Message-ID: <2025081556-relish-alongside-9c22@gregkh>
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
git cherry-pick -x eec76ea5a7213c48529a46eed1b343e5cee3aaab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081556-relish-alongside-9c22@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eec76ea5a7213c48529a46eed1b343e5cee3aaab Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 6 Jul 2025 16:10:58 -0700
Subject: [PATCH] lib/crypto: arm64/poly1305: Fix register corruption in
 no-SIMD contexts

Restore the SIMD usability check that was removed by commit a59e5468a921
("crypto: arm64/poly1305 - Add block-only interface").

This safety check is cheap and is well worth eliminating a footgun.
While the Poly1305 functions should not be called when SIMD registers
are unusable, if they are anyway, they should just do the right thing
instead of corrupting random tasks' registers and/or computing incorrect
MACs.  Fixing this is also needed for poly1305_kunit to pass.

Just use may_use_simd() instead of the original crypto_simd_usable(),
since poly1305_kunit won't rely on crypto_simd_disabled_for_test.

Fixes: a59e5468a921 ("crypto: arm64/poly1305 - Add block-only interface")
Cc: stable@vger.kernel.org
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250706231100.176113-4-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/arm64/poly1305-glue.c b/lib/crypto/arm64/poly1305-glue.c
index c9a74766785b..31aea21ce42f 100644
--- a/lib/crypto/arm64/poly1305-glue.c
+++ b/lib/crypto/arm64/poly1305-glue.c
@@ -7,6 +7,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/neon.h>
+#include <asm/simd.h>
 #include <crypto/internal/poly1305.h>
 #include <linux/cpufeature.h>
 #include <linux/jump_label.h>
@@ -33,7 +34,7 @@ void poly1305_blocks_arch(struct poly1305_block_state *state, const u8 *src,
 			  unsigned int len, u32 padbit)
 {
 	len = round_down(len, POLY1305_BLOCK_SIZE);
-	if (static_branch_likely(&have_neon)) {
+	if (static_branch_likely(&have_neon) && likely(may_use_simd())) {
 		do {
 			unsigned int todo = min_t(unsigned int, len, SZ_4K);
 


