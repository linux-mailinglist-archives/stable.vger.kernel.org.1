Return-Path: <stable+bounces-172006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F9B2F926
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5993B225E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB46E31576D;
	Thu, 21 Aug 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+ZagovX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA4311C21
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780920; cv=none; b=tlViCj4GCGMkDGvHkkyN7KPaKite+p8honlanAby9Pa18cn6s/FfoUSeDk4Jw2n8VCwbiucr3Gwyany6iokWad5DvtvJIVY09P+14EbmZ6MYE5ZjClmaNQoAr3Jm+Kny6IIDF0Y9AHzYLbmezAJbnrjz93QyLu1ZwxHxG0eGw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780920; c=relaxed/simple;
	bh=5WrdliQkSlCSXDDZVA5yBAZGiPaaN/6oynK4opWcSek=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F+BGrsPz4TzbJVjCSwa6H1+eebkgu0F+wTQ/1Y5XtlzWxoWU+2WlzwQnGn5nRyUahpFPu6zQSIzOX/Oac7rRfwIKfb3Ld6ghmvUnLtzwpTeQN0s8r4DsOH4Afn/Y9udiHKLDrv3M6ct6Ul3FZ/Y3r0U5SLGElmWNm9OqsNMvQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+ZagovX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F65C4CEEB;
	Thu, 21 Aug 2025 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780920;
	bh=5WrdliQkSlCSXDDZVA5yBAZGiPaaN/6oynK4opWcSek=;
	h=Subject:To:Cc:From:Date:From;
	b=Z+ZagovXKCGmHV6GpM9S2uRCRblmt+Npf3/GonLqsV6AMSt8b6LZwL8azoVfA2TAw
	 YOL685faAU6vjQWvFh/R8J+3ULM+Ph0cGwF7oj0m0pdbGtrWwd74YVzYx6yQVgqVYy
	 wjjFl7z/2LGCKqq1t3IKsmwAB0mrkLKCv6kjjtps=
Subject: FAILED: patch "[PATCH] crypto: x86/aegis - Fix sleeping when disallowed on" failed to apply to 5.10-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:55:04 +0200
Message-ID: <2025082104-syrup-acquire-04a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c7f49dadfcdf27e1f747442e874e9baa52ab7674
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082104-syrup-acquire-04a4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


