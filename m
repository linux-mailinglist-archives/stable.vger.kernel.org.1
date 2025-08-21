Return-Path: <stable+bounces-172007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89646B2F927
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C403A42B5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345C2D3744;
	Thu, 21 Aug 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r1/HYWwK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C842DC349
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780923; cv=none; b=fMvgWBA2sLa6KSoYx20CphQv0JrnJDarEevDNu1beoIFMcYZrsb61YI0TxDQsDzmutVX6r2rGAogoOBCIWHrSC2zYvwEf4U0MALozbltLv8cYLDWdX7t5nIUaKrabkWA87/JC6Sc24ISUoraYXqiriihqzGEgAEyJazfR40dtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780923; c=relaxed/simple;
	bh=bHBd9R25xIVDpms2iD+mjEAI09xcvMExjV5iy2/zyEU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SxNtHTV9POhvH+mq6S6Q88th9NSFh6UXr/Z+O1n1I5OcPOfpYPkfOM/pVw8Fgf9WT8DUKYRYv31U6FuiEKlLdA+RtPDNiz3C8FJWFxJJqPpI0F+8lhEI0fP10/uZR25yyKwtm5rI53da+whe55gHmWMEFreCeIzAj1iptP3Gz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r1/HYWwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24633C4CEEB;
	Thu, 21 Aug 2025 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780923;
	bh=bHBd9R25xIVDpms2iD+mjEAI09xcvMExjV5iy2/zyEU=;
	h=Subject:To:Cc:From:Date:From;
	b=r1/HYWwKjYm1JCRoiF6ef0UtKNelUZBlMteeAab8Amb8fvhOW1jXMOqMQ5gFI0QcE
	 FbSlCfN0NHXxWab+mrKX2XQu+RC62Z2hPE19iR6u8ZXke5FtcrYrYbsHT04TavE3m3
	 0nOWe+i6d/siekgEZtrgWvGBZi80gM1KyywDcAig=
Subject: FAILED: patch "[PATCH] crypto: x86/aegis - Fix sleeping when disallowed on" failed to apply to 5.15-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:55:04 +0200
Message-ID: <2025082104-whooping-armband-6944@gregkh>
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
git cherry-pick -x c7f49dadfcdf27e1f747442e874e9baa52ab7674
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082104-whooping-armband-6944@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7f49dadfcdf27e1f747442e874e9baa52ab7674 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 8 Jul 2025 12:38:28 -0700
Subject: [PATCH] crypto: x86/aegis - Fix sleeping when disallowed on
 PREEMPT_RT

skcipher_walk_done() can call kfree(), which takes a spinlock, which
makes it incorrect to call while preemption is disabled on PREEMPT_RT.
Therefore, end the kernel-mode FPU section before calling
skcipher_walk_done(), and restart it afterwards.

Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
atomic=true.  The point of atomic=true was to make skcipher_walk_done()
safe to call while in a kernel-mode FPU section, but that does not
actually work.  So just use the usual atomic=false.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index f1b6d40154e3..3cb5c193038b 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -119,7 +119,9 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 					   walk->dst.virt.addr,
 					   round_down(walk->nbytes,
 						      AEGIS128_BLOCK_SIZE));
+		kernel_fpu_end();
 		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+		kernel_fpu_begin();
 	}
 
 	if (walk->nbytes) {
@@ -131,7 +133,9 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 			aegis128_aesni_dec_tail(state, walk->src.virt.addr,
 						walk->dst.virt.addr,
 						walk->nbytes);
+		kernel_fpu_end();
 		skcipher_walk_done(walk, 0);
+		kernel_fpu_begin();
 	}
 }
 
@@ -176,9 +180,9 @@ crypto_aegis128_aesni_crypt(struct aead_request *req,
 	struct aegis_state state;
 
 	if (enc)
-		skcipher_walk_aead_encrypt(&walk, req, true);
+		skcipher_walk_aead_encrypt(&walk, req, false);
 	else
-		skcipher_walk_aead_decrypt(&walk, req, true);
+		skcipher_walk_aead_decrypt(&walk, req, false);
 
 	kernel_fpu_begin();
 


