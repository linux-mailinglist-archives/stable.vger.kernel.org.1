Return-Path: <stable+bounces-172261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6CB30C80
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC0586D1A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176728A704;
	Fri, 22 Aug 2025 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFjpDUwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9A28A3EF
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833072; cv=none; b=KhVWyeO9OpAJAjfEEAlGC23VxyXhK2YZiS0pSgqC3b6ec68CqsKGFCMFBbkfumVbtA/f150xXVGo065OcKdoHIWZM2OaZQwKu0i0Y3PG2JcUYBASEiNYijUTCX28ygS7QU72tWXkqTJ9KomiF9MOT09tkOXzss7ABAfO0NlLHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833072; c=relaxed/simple;
	bh=a4TobKdqeODb8Zp3iiaAa5b78PBDH8s2g7l3zKPCt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIWdv+FYlj9fp08enra8esdgiS8RK0eBlqEbdVl1mHozg2s310v5WM0339QZokGyU+plvHWgbLPlkc9Sf0H/V1yv7EWxpriaDYOms68fWg5r2dk9Q+wIlD8dnxDGVScl0jdDdNop1wHdLX8GvdHJWiohh/OBxqdiTzXK1nfX4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFjpDUwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC272C4CEEB;
	Fri, 22 Aug 2025 03:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833072;
	bh=a4TobKdqeODb8Zp3iiaAa5b78PBDH8s2g7l3zKPCt5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFjpDUwpE/QU5lAyt5oWkSj2WMUo7/o37Ngxe0C6wM6G3xUe8IdIE0L3C+SOlg91w
	 CKGY1x+IgwN0jjE8zGO2pHvytk8JVLG2dfpIK122AvvPCmtTFrEopigz90DPdDQgsn
	 hJBQk1mgPFwsEdKZ0797B9Jbj8UBsaBWyYgG0McpPlfILjfrxpXP28Xqt+nn9EGuui
	 wHORQK6Jnu/QJX27Bmhkve4ZnwQTJaBpmALBpEsPuIL6pIx0IBM+eap0otyG47vcLH
	 TXrvj2pZWAgBLBHd5xYN2ilLGXKpcmL4CM5lvEcj8K0EtHjNu7USnhlf4vWOaxnLt9
	 9x5X4HwUMB6KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] crypto: x86/aegis - Add missing error checks
Date: Thu, 21 Aug 2025 23:24:25 -0400
Message-ID: <20250822032426.1059866-5-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822032426.1059866-1-sashal@kernel.org>
References: <2025082114-egotistic-train-159d@gregkh>
 <20250822032426.1059866-1-sashal@kernel.org>
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


