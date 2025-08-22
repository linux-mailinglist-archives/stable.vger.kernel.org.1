Return-Path: <stable+bounces-172249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D48B30C2F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CF71CE7186
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A38265CA0;
	Fri, 22 Aug 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwIW6iUG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C9263C8F
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831997; cv=none; b=WgD3hv9eMzEhwBLWDtVoVELaPswOaw74kIoxzMb5SvaXeSNF25h+HE/x+Fr8jRU4Nuip8nEqx2j0avvDOKo3YZCGdCNzn2GmMk2XrvjLd0DmbsADzAebTpxIyrX2KsLr7a5xpW7xJIeMndNM6vvOp6z+t4zQLzsPx6DyxDgWe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831997; c=relaxed/simple;
	bh=a4TobKdqeODb8Zp3iiaAa5b78PBDH8s2g7l3zKPCt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEcgAH8h8QmpvHuUh2yvzm2VhO6od/IL+c3WCVVJck0IaFGKE76f4nUdksas7cQsBQCAtB4IaEkI6+n3IBiHAbdzl7bOW3w93A0gVZZCWc7bOLTrkeaWoS0hgVEdG5kNnWbxsjeGQczc6/m5civx7D6FCC9z6O+X9IJtiYNKwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwIW6iUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17607C116B1;
	Fri, 22 Aug 2025 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755831997;
	bh=a4TobKdqeODb8Zp3iiaAa5b78PBDH8s2g7l3zKPCt5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwIW6iUGKV2e6jkcNApAtG80BNhaU/9CtxP07y6qLKS1hfyyolWgWXGQ6jLw++Gm7
	 ysb9KL1RHjYXamKVX7L/jSAGFdKubjq2jj/OKBe5T+FXb9orNvNw2FzruSpOZIPF6S
	 T4mbLb5WnUYg+i/nmrrJNS5bGfRWmujWcEqizPe+WkHi0+/azEjeFDDVsYdA55ph0+
	 FzKDQIoEVAjcg0U2J3JQ/NmACsbqYYjPHHvShbUcUam+3e7QsHKUzBy3tLqS8Bq5QO
	 bN9umxgk29tt0vcJfFjd6HW7kOBWsL2jOTaYQKio4TTV9zFjlr+vcPbkRl3wVsy02s
	 93uP+dbKeqRNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] crypto: x86/aegis - Add missing error checks
Date: Thu, 21 Aug 2025 23:06:32 -0400
Message-ID: <20250822030632.1053504-5-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822030632.1053504-1-sashal@kernel.org>
References: <2025082114-proofs-slideshow-5515@gregkh>
 <20250822030632.1053504-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 3d9eb180fbe8828cce43bce4c370124685b205c3 ]

The skcipher_walk functions can allocate memory and can fail, so
checking for errors is necessary.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-glue.c | 36 +++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index de0aab6997d4..f5bbf274a54e 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -108,10 +108,12 @@ static void crypto_aegis128_aesni_process_ad(
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
@@ -124,7 +126,8 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 					   round_down(walk->nbytes,
 						      AEGIS128_BLOCK_SIZE));
 		kernel_fpu_end();
-		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+		err = skcipher_walk_done(walk,
+					 walk->nbytes % AEGIS128_BLOCK_SIZE);
 		kernel_fpu_begin();
 	}
 
@@ -138,9 +141,10 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
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
@@ -173,7 +177,7 @@ static int crypto_aegis128_aesni_setauthsize(struct crypto_aead *tfm,
 	return 0;
 }
 
-static __always_inline void
+static __always_inline int
 crypto_aegis128_aesni_crypt(struct aead_request *req,
 			    struct aegis_block *tag_xor,
 			    unsigned int cryptlen, bool enc)
@@ -182,20 +186,24 @@ crypto_aegis128_aesni_crypt(struct aead_request *req,
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
@@ -204,8 +212,11 @@ static int crypto_aegis128_aesni_encrypt(struct aead_request *req)
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
@@ -220,11 +231,14 @@ static int crypto_aegis128_aesni_decrypt(struct aead_request *req)
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
-- 
2.50.1


