Return-Path: <stable+bounces-77551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0999985E65
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF891F24373
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077A81B982C;
	Wed, 25 Sep 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6QugwMh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFC1B9829;
	Wed, 25 Sep 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266308; cv=none; b=cSDn66+yu9DirFfNa7ma6Uibug40MuipfJVfd5IqCvpltQ9UdDPwIxAAE7njDdWTEccJmJhpm717gMArQzPj9yKjakmjkHzL88l61lRFIQgGsVHI54+p7zbJhRMsNWqXx5HbTrCrdBhK8SNUG6a1P0MFoII3x2N0WkzCbhM2YoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266308; c=relaxed/simple;
	bh=OuZIVQ0KJMjHeQlDxINJ2uKB9FdjQ5w2LkvCx1xhWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+bO7vsnDaXqmwlleJsYRC/9Bu4A4X00smnUA62WM2oB2oI9XijeSws3UHqoX8qzGL4qSLorObIsdR/pCkZKz0Sgqm3w5wynlPPwkB1xjeDwJ9010NrVzT+h6L5StsYTLCa92KFq3z5SbTBJ7izdi9Gb68k0dBMJnwuChXjx53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6QugwMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F9C4CEC7;
	Wed, 25 Sep 2024 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266308;
	bh=OuZIVQ0KJMjHeQlDxINJ2uKB9FdjQ5w2LkvCx1xhWAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6QugwMhZ/iSzh93+B46AmZFUGJs28q2UdiPg5rN3WMc8P6+xxniCfa8X4esA9JIP
	 uq5I4/qmvbAzlkIel7gSm5v+jSvexKUHPGUR/wFZyuwYA50Z96MIUYg/8U5QLDBDhd
	 18TgRnRgi9zFwXfnFX7RGZNBDiWFxaJZg1JR6Ckm7sA9KeuUPSOTaJqPhvF4rlrJ0Y
	 mKMnzHizsyejWVDdcHloDiGwgjhfGTN1i2UlS3+9QQZXKezDVp1v2x5pqOkG586F5+
	 m5HaFNZ1zZL9e6TDM5VlKYczSsKVQMWN1TtvDpkWSxTHJkEAKeHUbn00oWOmv8p7KO
	 33DhnzB5g0aeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	bbrezillon@kernel.org,
	arno@natisbad.org,
	schalla@marvell.com,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 005/139] crypto: octeontx - Fix authenc setkey
Date: Wed, 25 Sep 2024 08:07:05 -0400
Message-ID: <20240925121137.1307574-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 311eea7e37c4c0b44b557d0c100860a03b4eab65 ]

Use the generic crypto_authenc_extractkeys helper instead of custom
parsing code that is slightly broken.  Also fix a number of memory
leaks by moving memory allocation from setkey to init_tfm (setkey
can be called multiple times over the life of a tfm).

Finally accept all hash key lengths by running the digest over
extra-long keys.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/marvell/octeontx/otx_cptvf_algs.c  | 261 +++++++-----------
 1 file changed, 93 insertions(+), 168 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 1c2c870e887aa..f64b72398eced 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -17,7 +17,6 @@
 #include <crypto/sha2.h>
 #include <crypto/xts.h>
 #include <crypto/scatterwalk.h>
-#include <linux/rtnetlink.h>
 #include <linux/sort.h>
 #include <linux/module.h>
 #include "otx_cptvf.h"
@@ -66,6 +65,8 @@ static struct cpt_device_table ae_devices = {
 	.count = ATOMIC_INIT(0)
 };
 
+static struct otx_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg);
+
 static inline int get_se_device(struct pci_dev **pdev, int *cpu_num)
 {
 	int count, ret = 0;
@@ -515,44 +516,61 @@ static int cpt_aead_init(struct crypto_aead *tfm, u8 cipher_type, u8 mac_type)
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
 
+	switch (ctx->mac_type) {
+	case OTX_CPT_SHA1:
+		ctx->hashalg = crypto_alloc_shash("sha1", 0, 0);
+		break;
+
+	case OTX_CPT_SHA256:
+		ctx->hashalg = crypto_alloc_shash("sha256", 0, 0);
+		break;
+
+	case OTX_CPT_SHA384:
+		ctx->hashalg = crypto_alloc_shash("sha384", 0, 0);
+		break;
+
+	case OTX_CPT_SHA512:
+		ctx->hashalg = crypto_alloc_shash("sha512", 0, 0);
+		break;
+	}
+
+	if (IS_ERR(ctx->hashalg))
+		return PTR_ERR(ctx->hashalg);
+
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct otx_cpt_req_ctx));
+
+	if (!ctx->hashalg)
+		return 0;
+
 	/*
 	 * When selected cipher is NULL we use HMAC opcode instead of
 	 * FLEXICRYPTO opcode therefore we don't need to use HASH algorithms
 	 * for calculating ipad and opad
 	 */
 	if (ctx->cipher_type != OTX_CPT_CIPHER_NULL) {
-		switch (ctx->mac_type) {
-		case OTX_CPT_SHA1:
-			ctx->hashalg = crypto_alloc_shash("sha1", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
-
-		case OTX_CPT_SHA256:
-			ctx->hashalg = crypto_alloc_shash("sha256", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		int ss = crypto_shash_statesize(ctx->hashalg);
 
-		case OTX_CPT_SHA384:
-			ctx->hashalg = crypto_alloc_shash("sha384", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->ipad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->ipad) {
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
 
-		case OTX_CPT_SHA512:
-			ctx->hashalg = crypto_alloc_shash("sha512", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->opad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->opad) {
+			kfree(ctx->ipad);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
 		}
 	}
 
-	crypto_aead_set_reqsize_dma(tfm, sizeof(struct otx_cpt_req_ctx));
+	ctx->sdesc = alloc_sdesc(ctx->hashalg);
+	if (!ctx->sdesc) {
+		kfree(ctx->opad);
+		kfree(ctx->ipad);
+		crypto_free_shash(ctx->hashalg);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -608,8 +626,7 @@ static void otx_cpt_aead_exit(struct crypto_aead *tfm)
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
-	if (ctx->hashalg)
-		crypto_free_shash(ctx->hashalg);
+	crypto_free_shash(ctx->hashalg);
 	kfree(ctx->sdesc);
 }
 
@@ -705,7 +722,7 @@ static inline void swap_data64(void *buf, u32 len)
 		*dst = cpu_to_be64p(src);
 }
 
-static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
+static int swap_pad(u8 mac_type, u8 *pad)
 {
 	struct sha512_state *sha512;
 	struct sha256_state *sha256;
@@ -713,22 +730,19 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 	switch (mac_type) {
 	case OTX_CPT_SHA1:
-		sha1 = (struct sha1_state *) in_pad;
+		sha1 = (struct sha1_state *)pad;
 		swap_data32(sha1->state, SHA1_DIGEST_SIZE);
-		memcpy(out_pad, &sha1->state, SHA1_DIGEST_SIZE);
 		break;
 
 	case OTX_CPT_SHA256:
-		sha256 = (struct sha256_state *) in_pad;
+		sha256 = (struct sha256_state *)pad;
 		swap_data32(sha256->state, SHA256_DIGEST_SIZE);
-		memcpy(out_pad, &sha256->state, SHA256_DIGEST_SIZE);
 		break;
 
 	case OTX_CPT_SHA384:
 	case OTX_CPT_SHA512:
-		sha512 = (struct sha512_state *) in_pad;
+		sha512 = (struct sha512_state *)pad;
 		swap_data64(sha512->state, SHA512_DIGEST_SIZE);
-		memcpy(out_pad, &sha512->state, SHA512_DIGEST_SIZE);
 		break;
 
 	default:
@@ -738,55 +752,53 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 	return 0;
 }
 
-static int aead_hmac_init(struct crypto_aead *cipher)
+static int aead_hmac_init(struct crypto_aead *cipher,
+			  struct crypto_authenc_keys *keys)
 {
 	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	int state_size = crypto_shash_statesize(ctx->hashalg);
 	int ds = crypto_shash_digestsize(ctx->hashalg);
 	int bs = crypto_shash_blocksize(ctx->hashalg);
-	int authkeylen = ctx->auth_key_len;
+	int authkeylen = keys->authkeylen;
 	u8 *ipad = NULL, *opad = NULL;
-	int ret = 0, icount = 0;
+	int icount = 0;
+	int ret;
 
-	ctx->sdesc = alloc_sdesc(ctx->hashalg);
-	if (!ctx->sdesc)
-		return -ENOMEM;
+	if (authkeylen > bs) {
+		ret = crypto_shash_digest(&ctx->sdesc->shash, keys->authkey,
+					  authkeylen, ctx->key);
+		if (ret)
+			return ret;
+		authkeylen = ds;
+	} else
+		memcpy(ctx->key, keys->authkey, authkeylen);
 
-	ctx->ipad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	ctx->enc_key_len = keys->enckeylen;
+	ctx->auth_key_len = authkeylen;
 
-	ctx->opad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	if (ctx->cipher_type == OTX_CPT_CIPHER_NULL)
+		return keys->enckeylen ? -EINVAL : 0;
 
-	ipad = kzalloc(state_size, GFP_KERNEL);
-	if (!ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
+	switch (keys->enckeylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX_CPT_AES_256_BIT;
+		break;
+	default:
+		/* Invalid key length */
+		return -EINVAL;
 	}
 
-	opad = kzalloc(state_size, GFP_KERNEL);
-	if (!opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	memcpy(ctx->key + authkeylen, keys->enckey, keys->enckeylen);
 
-	if (authkeylen > bs) {
-		ret = crypto_shash_digest(&ctx->sdesc->shash, ctx->key,
-					  authkeylen, ipad);
-		if (ret)
-			goto calc_fail;
-
-		authkeylen = ds;
-	} else {
-		memcpy(ipad, ctx->key, authkeylen);
-	}
+	ipad = ctx->ipad;
+	opad = ctx->opad;
 
+	memcpy(ipad, ctx->key, authkeylen);
 	memset(ipad + authkeylen, 0, bs - authkeylen);
 	memcpy(opad, ipad, bs);
 
@@ -804,7 +816,7 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, ipad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, ipad);
-	ret = copy_pad(ctx->mac_type, ctx->ipad, ipad);
+	ret = swap_pad(ctx->mac_type, ipad);
 	if (ret)
 		goto calc_fail;
 
@@ -812,25 +824,9 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, opad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, opad);
-	ret = copy_pad(ctx->mac_type, ctx->opad, opad);
-	if (ret)
-		goto calc_fail;
-
-	kfree(ipad);
-	kfree(opad);
-
-	return 0;
+	ret = swap_pad(ctx->mac_type, opad);
 
 calc_fail:
-	kfree(ctx->ipad);
-	ctx->ipad = NULL;
-	kfree(ctx->opad);
-	ctx->opad = NULL;
-	kfree(ipad);
-	kfree(opad);
-	kfree(ctx->sdesc);
-	ctx->sdesc = NULL;
-
 	return ret;
 }
 
@@ -838,57 +834,15 @@ static int otx_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					   const unsigned char *key,
 					   unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	int enckeylen = 0, authkeylen = 0;
-	struct rtattr *rta = (void *)key;
-	int status = -EINVAL;
-
-	if (!RTA_OK(rta, keylen))
-		goto badkey;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		goto badkey;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		goto badkey;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (keylen < enckeylen)
-		goto badkey;
+	struct crypto_authenc_keys authenc_keys;
+	int status;
 
-	if (keylen > OTX_CPT_MAX_KEY_SIZE)
-		goto badkey;
-
-	authkeylen = keylen - enckeylen;
-	memcpy(ctx->key, key, keylen);
-
-	switch (enckeylen) {
-	case AES_KEYSIZE_128:
-		ctx->key_type = OTX_CPT_AES_128_BIT;
-		break;
-	case AES_KEYSIZE_192:
-		ctx->key_type = OTX_CPT_AES_192_BIT;
-		break;
-	case AES_KEYSIZE_256:
-		ctx->key_type = OTX_CPT_AES_256_BIT;
-		break;
-	default:
-		/* Invalid key length */
-		goto badkey;
-	}
-
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = authkeylen;
-
-	status = aead_hmac_init(cipher);
+	status = crypto_authenc_extractkeys(&authenc_keys, key, keylen);
 	if (status)
 		goto badkey;
 
-	return 0;
+	status = aead_hmac_init(cipher, &authenc_keys);
+
 badkey:
 	return status;
 }
@@ -897,36 +851,7 @@ static int otx_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	struct rtattr *rta = (void *)key;
-	int enckeylen = 0;
-
-	if (!RTA_OK(rta, keylen))
-		goto badkey;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		goto badkey;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		goto badkey;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (enckeylen != 0)
-		goto badkey;
-
-	if (keylen > OTX_CPT_MAX_KEY_SIZE)
-		goto badkey;
-
-	memcpy(ctx->key, key, keylen);
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = keylen;
-	return 0;
-badkey:
-	return -EINVAL;
+	return otx_cpt_aead_cbc_aes_sha_setkey(cipher, key, keylen);
 }
 
 static int otx_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
-- 
2.43.0


