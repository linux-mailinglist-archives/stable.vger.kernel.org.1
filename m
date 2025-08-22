Return-Path: <stable+bounces-172246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D51B30C3F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5191784EC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D6261B93;
	Fri, 22 Aug 2025 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JucR2Kd3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D7223DE7
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831995; cv=none; b=fdjwK5tzVnvndsBSKSeO8siFk+OYzF5b4V8WCILkvcJJJyqNThztK4yxTYlDIddX9Ne1CNDqSOf5f9u9qt9aJeQJRUwDyYxN7K/GSunxe5HJSNzi6C0esjDKDD+GkWqAe9wrIiIV8y5b/MSusMH0R8W03sJhllnj12DR0rrbkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831995; c=relaxed/simple;
	bh=04Elsdzk9BoBQYqIGP8dwCUswnNew+WNsnXmul2FlOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2T7BkBF6F9goZstUGQYI6p5kWG+hfsd7NzNp7O9SJBwDMYiUlyd3dzTqUdlJNWkbWvFhTy9KpsOOqXLCAERiFqf/4DZ60byEdfqpUC4uLo9r6VScSWU48Esgb1wUMDdiyG923cA2AO4u8ADhI4lInq9DmjNso2+MRB7TeMxCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JucR2Kd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B95C4CEEB;
	Fri, 22 Aug 2025 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755831994;
	bh=04Elsdzk9BoBQYqIGP8dwCUswnNew+WNsnXmul2FlOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JucR2Kd3n4Xwl772DPfOLrvkVavZJkv6Isau8pO3Dni2t+1QkcVxzYyGtFabofTMn
	 skZdWX1Rf20SmgynJ3S8Kv0bFzCTBLH3p+pHvZ4k99Shxi/RADsoEGYMaukRXl2tK8
	 MYMTXTqT4Uqid/qXoQvygVXLGAwabxN11hmosCp8FwYnxeqvnEns1/fHCnPf5WltXi
	 +bJVgFxnn0pznIcRgqGgU1xyMxJCeB2SzP+1iG/M4801wXFZwptF3GS3HDH/71repc
	 BnatLVEeRQq7xRKfG4NZgm5e+d1O3m/L30KJnBuQCAxUkIfhM131lgFYwiVo7HsrP6
	 h0B9womVlYd3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] crypto: x86/aegis128 - eliminate some indirect calls
Date: Thu, 21 Aug 2025 23:06:28 -0400
Message-ID: <20250822030632.1053504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082114-proofs-slideshow-5515@gregkh>
References: <2025082114-proofs-slideshow-5515@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit b8d2e7bac3f768e5ab0b52a4a6dd65aa130113be ]

Instead of using a struct of function pointers to decide whether to call
the encryption or decryption assembly functions, use a conditional
branch on a bool.  Force-inline the functions to avoid actually
generating the branch.  This improves performance slightly since
indirect calls are slow.  Remove the now-unnecessary CFI stubs.

Note that just force-inlining the existing functions might cause the
compiler to optimize out the indirect branches, but that would not be a
reliable way to do it and the CFI stubs would still be required.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 3d9eb180fbe8 ("crypto: x86/aegis - Add missing error checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S  |  9 ++--
 arch/x86/crypto/aegis128-aesni-glue.c | 74 +++++++++++++--------------
 2 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 2de859173940..1b57558548c7 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -7,7 +7,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
 #include <asm/frame.h>
 
 #define STATE0	%xmm0
@@ -403,7 +402,7 @@ SYM_FUNC_END(crypto_aegis128_aesni_ad)
  * void crypto_aegis128_aesni_enc(void *state, unsigned int length,
  *                                const void *src, void *dst);
  */
-SYM_TYPED_FUNC_START(crypto_aegis128_aesni_enc)
+SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -500,7 +499,7 @@ SYM_FUNC_END(crypto_aegis128_aesni_enc)
  * void crypto_aegis128_aesni_enc_tail(void *state, unsigned int length,
  *                                     const void *src, void *dst);
  */
-SYM_TYPED_FUNC_START(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -557,7 +556,7 @@ SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
  * void crypto_aegis128_aesni_dec(void *state, unsigned int length,
  *                                const void *src, void *dst);
  */
-SYM_TYPED_FUNC_START(crypto_aegis128_aesni_dec)
+SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -654,7 +653,7 @@ SYM_FUNC_END(crypto_aegis128_aesni_dec)
  * void crypto_aegis128_aesni_dec_tail(void *state, unsigned int length,
  *                                     const void *src, void *dst);
  */
-SYM_TYPED_FUNC_START(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
 	FRAME_BEGIN
 
 	/* load the state: */
diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 4623189000d8..6c4c2cda2c2d 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -56,16 +56,6 @@ struct aegis_ctx {
 	struct aegis_block key;
 };
 
-struct aegis_crypt_ops {
-	int (*skcipher_walk_init)(struct skcipher_walk *walk,
-				  struct aead_request *req, bool atomic);
-
-	void (*crypt_blocks)(void *state, unsigned int length, const void *src,
-			     void *dst);
-	void (*crypt_tail)(void *state, unsigned int length, const void *src,
-			   void *dst);
-};
-
 static void crypto_aegis128_aesni_process_ad(
 		struct aegis_state *state, struct scatterlist *sg_src,
 		unsigned int assoclen)
@@ -114,20 +104,37 @@ static void crypto_aegis128_aesni_process_ad(
 	}
 }
 
-static void crypto_aegis128_aesni_process_crypt(
-		struct aegis_state *state, struct skcipher_walk *walk,
-		const struct aegis_crypt_ops *ops)
+static __always_inline void
+crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
+				    struct skcipher_walk *walk, bool enc)
 {
 	while (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
-		ops->crypt_blocks(state,
-				  round_down(walk->nbytes, AEGIS128_BLOCK_SIZE),
-				  walk->src.virt.addr, walk->dst.virt.addr);
+		if (enc)
+			crypto_aegis128_aesni_enc(
+					state,
+					round_down(walk->nbytes,
+						   AEGIS128_BLOCK_SIZE),
+					walk->src.virt.addr,
+					walk->dst.virt.addr);
+		else
+			crypto_aegis128_aesni_dec(
+					state,
+					round_down(walk->nbytes,
+						   AEGIS128_BLOCK_SIZE),
+					walk->src.virt.addr,
+					walk->dst.virt.addr);
 		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
 	}
 
 	if (walk->nbytes) {
-		ops->crypt_tail(state, walk->nbytes, walk->src.virt.addr,
-				walk->dst.virt.addr);
+		if (enc)
+			crypto_aegis128_aesni_enc_tail(state, walk->nbytes,
+						       walk->src.virt.addr,
+						       walk->dst.virt.addr);
+		else
+			crypto_aegis128_aesni_dec_tail(state, walk->nbytes,
+						       walk->src.virt.addr,
+						       walk->dst.virt.addr);
 		skcipher_walk_done(walk, 0);
 	}
 }
@@ -162,23 +169,26 @@ static int crypto_aegis128_aesni_setauthsize(struct crypto_aead *tfm,
 	return 0;
 }
 
-static void crypto_aegis128_aesni_crypt(struct aead_request *req,
-					struct aegis_block *tag_xor,
-					unsigned int cryptlen,
-					const struct aegis_crypt_ops *ops)
+static __always_inline void
+crypto_aegis128_aesni_crypt(struct aead_request *req,
+			    struct aegis_block *tag_xor,
+			    unsigned int cryptlen, bool enc)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aegis_ctx *ctx = crypto_aegis128_aesni_ctx(tfm);
 	struct skcipher_walk walk;
 	struct aegis_state state;
 
-	ops->skcipher_walk_init(&walk, req, true);
+	if (enc)
+		skcipher_walk_aead_encrypt(&walk, req, true);
+	else
+		skcipher_walk_aead_decrypt(&walk, req, true);
 
 	kernel_fpu_begin();
 
 	crypto_aegis128_aesni_init(&state, ctx->key.bytes, req->iv);
 	crypto_aegis128_aesni_process_ad(&state, req->src, req->assoclen);
-	crypto_aegis128_aesni_process_crypt(&state, &walk, ops);
+	crypto_aegis128_aesni_process_crypt(&state, &walk, enc);
 	crypto_aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();
@@ -186,18 +196,12 @@ static void crypto_aegis128_aesni_crypt(struct aead_request *req,
 
 static int crypto_aegis128_aesni_encrypt(struct aead_request *req)
 {
-	static const struct aegis_crypt_ops OPS = {
-		.skcipher_walk_init = skcipher_walk_aead_encrypt,
-		.crypt_blocks = crypto_aegis128_aesni_enc,
-		.crypt_tail = crypto_aegis128_aesni_enc_tail,
-	};
-
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aegis_block tag = {};
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	unsigned int cryptlen = req->cryptlen;
 
-	crypto_aegis128_aesni_crypt(req, &tag, cryptlen, &OPS);
+	crypto_aegis128_aesni_crypt(req, &tag, cryptlen, true);
 
 	scatterwalk_map_and_copy(tag.bytes, req->dst,
 				 req->assoclen + cryptlen, authsize, 1);
@@ -208,12 +212,6 @@ static int crypto_aegis128_aesni_decrypt(struct aead_request *req)
 {
 	static const struct aegis_block zeros = {};
 
-	static const struct aegis_crypt_ops OPS = {
-		.skcipher_walk_init = skcipher_walk_aead_decrypt,
-		.crypt_blocks = crypto_aegis128_aesni_dec,
-		.crypt_tail = crypto_aegis128_aesni_dec_tail,
-	};
-
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aegis_block tag;
 	unsigned int authsize = crypto_aead_authsize(tfm);
@@ -222,7 +220,7 @@ static int crypto_aegis128_aesni_decrypt(struct aead_request *req)
 	scatterwalk_map_and_copy(tag.bytes, req->src,
 				 req->assoclen + cryptlen, authsize, 0);
 
-	crypto_aegis128_aesni_crypt(req, &tag, cryptlen, &OPS);
+	crypto_aegis128_aesni_crypt(req, &tag, cryptlen, false);
 
 	return crypto_memneq(tag.bytes, zeros.bytes, authsize) ? -EBADMSG : 0;
 }
-- 
2.50.1


