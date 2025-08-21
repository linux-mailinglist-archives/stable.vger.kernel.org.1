Return-Path: <stable+bounces-172011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA89B2F91E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA018937FC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951031576D;
	Thu, 21 Aug 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKqo5hlU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E542D3744
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780937; cv=none; b=lY9zS4OtML3MLdI217NNeKRe0dPC/Y+ZTP285GE55z6QtW1UqidGvovGT9J7Sym/O9kSklvfjaUHVOAX5lkCbd6EVlj9F/TFqV4uEeJUQXK0A9PwmWkGzSKeeFnJ9r2ZCWysjOeGmx3lG934+OMX9ASFJe2xDCNJrH6YD3juNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780937; c=relaxed/simple;
	bh=xgXfN3O4ps67gfkyDP+GHk4NNTBsVoncSIT0P7FBfZI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oDmmsp+q7Ck7AEgfRtXIcLQz0Z5/sSup6mE+xlckV+/+pmEkt5jvzA/oJMsW2rTcbJH5pJW0VwScMZ/0NTbbPRFzZmUBwcWhQtfAzs5igv1InCWDcE8cjFrPRPMeZ6Y6VVmN5WuMNnkMp4ftSZ3CgM7gGsICUPhFteIpfEyJNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKqo5hlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1AEC4CEEB;
	Thu, 21 Aug 2025 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780937;
	bh=xgXfN3O4ps67gfkyDP+GHk4NNTBsVoncSIT0P7FBfZI=;
	h=Subject:To:Cc:From:Date:From;
	b=EKqo5hlU3vx4hPSSzL2S/JMrHVxQ+BDFSaa/GwH4y6VpxVUVK3EHTWrqHR6bRgzjo
	 S064EFqLpIRAB0ZdBC5waVrcOYkCYFiybkwS+84Y7dQooh7HkUClIRS+RMqirdwxtC
	 EAsPupjd1jaUbHxX2w7ockiasju4+FjQCOQjg15Q=
Subject: FAILED: patch "[PATCH] crypto: x86/aegis - Add missing error checks" failed to apply to 5.15-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:55:15 +0200
Message-ID: <2025082115-demystify-woozy-fa5f@gregkh>
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
git cherry-pick -x 3d9eb180fbe8828cce43bce4c370124685b205c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082115-demystify-woozy-fa5f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d9eb180fbe8828cce43bce4c370124685b205c3 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 8 Jul 2025 12:38:29 -0700
Subject: [PATCH] crypto: x86/aegis - Add missing error checks

The skcipher_walk functions can allocate memory and can fail, so
checking for errors is necessary.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 3cb5c193038b..f1adfba1a76e 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -104,10 +104,12 @@ static void crypto_aegis128_aesni_process_ad(
 	}
 }
 
-static __always_inline void
+static __always_inline int
 crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 				    struct skcipher_walk *walk, bool enc)
 {
+	int err = 0;
+
 	while (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
 		if (enc)
 			aegis128_aesni_enc(state, walk->src.virt.addr,
@@ -120,7 +122,8 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 					   round_down(walk->nbytes,
 						      AEGIS128_BLOCK_SIZE));
 		kernel_fpu_end();
-		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+		err = skcipher_walk_done(walk,
+					 walk->nbytes % AEGIS128_BLOCK_SIZE);
 		kernel_fpu_begin();
 	}
 
@@ -134,9 +137,10 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 						walk->dst.virt.addr,
 						walk->nbytes);
 		kernel_fpu_end();
-		skcipher_walk_done(walk, 0);
+		err = skcipher_walk_done(walk, 0);
 		kernel_fpu_begin();
 	}
+	return err;
 }
 
 static struct aegis_ctx *crypto_aegis128_aesni_ctx(struct crypto_aead *aead)
@@ -169,7 +173,7 @@ static int crypto_aegis128_aesni_setauthsize(struct crypto_aead *tfm,
 	return 0;
 }
 
-static __always_inline void
+static __always_inline int
 crypto_aegis128_aesni_crypt(struct aead_request *req,
 			    struct aegis_block *tag_xor,
 			    unsigned int cryptlen, bool enc)
@@ -178,20 +182,24 @@ crypto_aegis128_aesni_crypt(struct aead_request *req,
 	struct aegis_ctx *ctx = crypto_aegis128_aesni_ctx(tfm);
 	struct skcipher_walk walk;
 	struct aegis_state state;
+	int err;
 
 	if (enc)
-		skcipher_walk_aead_encrypt(&walk, req, false);
+		err = skcipher_walk_aead_encrypt(&walk, req, false);
 	else
-		skcipher_walk_aead_decrypt(&walk, req, false);
+		err = skcipher_walk_aead_decrypt(&walk, req, false);
+	if (err)
+		return err;
 
 	kernel_fpu_begin();
 
 	aegis128_aesni_init(&state, &ctx->key, req->iv);
 	crypto_aegis128_aesni_process_ad(&state, req->src, req->assoclen);
-	crypto_aegis128_aesni_process_crypt(&state, &walk, enc);
-	aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
-
+	err = crypto_aegis128_aesni_process_crypt(&state, &walk, enc);
+	if (err == 0)
+		aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 	kernel_fpu_end();
+	return err;
 }
 
 static int crypto_aegis128_aesni_encrypt(struct aead_request *req)
@@ -200,8 +208,11 @@ static int crypto_aegis128_aesni_encrypt(struct aead_request *req)
 	struct aegis_block tag = {};
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	unsigned int cryptlen = req->cryptlen;
+	int err;
 
-	crypto_aegis128_aesni_crypt(req, &tag, cryptlen, true);
+	err = crypto_aegis128_aesni_crypt(req, &tag, cryptlen, true);
+	if (err)
+		return err;
 
 	scatterwalk_map_and_copy(tag.bytes, req->dst,
 				 req->assoclen + cryptlen, authsize, 1);
@@ -216,11 +227,14 @@ static int crypto_aegis128_aesni_decrypt(struct aead_request *req)
 	struct aegis_block tag;
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	unsigned int cryptlen = req->cryptlen - authsize;
+	int err;
 
 	scatterwalk_map_and_copy(tag.bytes, req->src,
 				 req->assoclen + cryptlen, authsize, 0);
 
-	crypto_aegis128_aesni_crypt(req, &tag, cryptlen, false);
+	err = crypto_aegis128_aesni_crypt(req, &tag, cryptlen, false);
+	if (err)
+		return err;
 
 	return crypto_memneq(tag.bytes, zeros.bytes, authsize) ? -EBADMSG : 0;
 }


