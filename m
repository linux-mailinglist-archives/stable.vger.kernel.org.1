Return-Path: <stable+bounces-172003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358ACB2F916
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA34D18875F0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED739311979;
	Thu, 21 Aug 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="St4SrzcD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86B2DC349
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780905; cv=none; b=dfmROztZlvUFLtpt9ZkJ7t/FWTP9801JQHGytfUkrxR/0ntBb6nMZ5gXYR3OlJOwwwlG94jm6rlYC66jzWr5Hbso5g/brP/6cYr+DMGhm7Bke+roi45ULq9/p9ufTdTxitdhxddgqwJiHwu1qvCftW9YgtVleSIPtkW6Z1M5q2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780905; c=relaxed/simple;
	bh=lSLc/NtZFaH14mimkU3thPs3vancULRH7FegJFuQr+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B/Ux450oi9bLjBRCRt70cdn/pXd8rGt502LFc1xzvxss4yCohpNSI/Yy8zdlEJmpNLSbaUNaC+xny9mKEtn6EKw5W7vJqwR51dxeVjSl03tQrkwHTiwG82MUapXlBaKhOopyJlOTr7YZ4CWhEBofL3TKWuXHSCWxAGAIzT6Sd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=St4SrzcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E403FC4CEEB;
	Thu, 21 Aug 2025 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780905;
	bh=lSLc/NtZFaH14mimkU3thPs3vancULRH7FegJFuQr+g=;
	h=Subject:To:Cc:From:Date:From;
	b=St4SrzcDlDrVmrkSAdcs89JVnvxYhPVppTETG99neDXD6VhKH1863M9PB0F1NMbP/
	 cxmItNgua58rd0VOLl8lROTDHCVRABGkvHP6GEnpAMZrVUlB0SE6wnbYkJKE1mi33e
	 o5YzHRsufamfC5bBx8wsp0yBK5dX6dpa3t1+DCRk=
Subject: FAILED: patch "[PATCH] crypto: x86/aegis - Fix sleeping when disallowed on" failed to apply to 6.12-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:55:02 +0200
Message-ID: <2025082102-shrug-unused-8ce2@gregkh>
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
git cherry-pick -x c7f49dadfcdf27e1f747442e874e9baa52ab7674
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082102-shrug-unused-8ce2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


