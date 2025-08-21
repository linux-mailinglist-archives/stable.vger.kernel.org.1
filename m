Return-Path: <stable+bounces-172004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F2B2F914
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE619162611
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5B311979;
	Thu, 21 Aug 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euLwYFzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC32DC349
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780915; cv=none; b=PhJcOKrge8zc6uIA1F/dZQSl3VuLYw5gvsB91E+Cb7689mm1ZX09AYBKnINzQdsMyBa03rKt0/C0WRGRxwrDhbfKWyUBRTERDRK2ddd/Veo5RucVOjDl4LFHDRQlhSRWktw+Zd0qCnzqvVISq5l98OM+6Ek2duUWnGekiQwBolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780915; c=relaxed/simple;
	bh=7Xo05138UMregt/sujIreRbbD77CoNjTkz2z8c8I0vw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d1l3zhJcGXMctGkDlHb96L/rZBl3MyjmMXiF2mtTQ1BMzyg4UQd7Rh+sm5F2qfGBzdYEG2z5OZ/W5d28z5ikFFsRBtMtPX3QUduf5tF0/bU4yML/EXxemBBrCtEK0hNXO65zVSyeQTZMgIK6FZvlQQ2+4n3mbJQav+TJ7T6zOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euLwYFzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD897C113CF;
	Thu, 21 Aug 2025 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780914;
	bh=7Xo05138UMregt/sujIreRbbD77CoNjTkz2z8c8I0vw=;
	h=Subject:To:Cc:From:Date:From;
	b=euLwYFzEcqXGjwUaiUNXKwwAvEyJvpL7DdLhr4VLTXubMHQZ4/ak9fak/hIOAiV4/
	 DnRGtdm2rJ6HJlE86wquIaz4zO7Dse8lBoooidmat06Cgin84dpDq+Nkmq6mEyD9Tx
	 IWiJt8XZU8/3Lvhw9TloQVJUizROClZFODk+hKpE=
Subject: FAILED: patch "[PATCH] crypto: x86/aegis - Fix sleeping when disallowed on" failed to apply to 6.1-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:55:03 +0200
Message-ID: <2025082103-chamomile-hesitant-52e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c7f49dadfcdf27e1f747442e874e9baa52ab7674
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082103-chamomile-hesitant-52e3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


