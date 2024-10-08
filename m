Return-Path: <stable+bounces-82165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B7994B78
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64BB287FC0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53E1DF75D;
	Tue,  8 Oct 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/toktIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EC1DC759;
	Tue,  8 Oct 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391366; cv=none; b=NwPxwVaiZNCVcJSWQU1kWvcQpZRtcdDdLNMEIl3EkNtDszZ8wk06NOK8txQuEO9flAPjwkatoz8uF9MAPQ/6GvIxSsaxI/fKVwptvUNPVC5thowFBJ0ujTCOIxep7fB+DMNz5Da9xWR06SWJbK/VQAOO9eeiYB03ZDvzHuUU/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391366; c=relaxed/simple;
	bh=MT4FXGIiAYEnlj+y0hsv2iNKsQqkwrClc5RDDgnZojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSr83MHJS1iOY6p1qrzJ8J29q8Ay4jCFZ2jL2yWV3qgchF+M+8QVgFXkucEhALvkp+R0NTY1IOAweXzLoClEIXrZgdXHo6TlUf/Ne6s1+eAsypogUju0mZOp8cX0ZPkkuJxGx6iiWpo2v9o6kAk9X2kBj4SZbl9pc+MWXKedoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/toktIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1123FC4CEC7;
	Tue,  8 Oct 2024 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391366;
	bh=MT4FXGIiAYEnlj+y0hsv2iNKsQqkwrClc5RDDgnZojw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/toktIFbmKLVsTcaXx5C5nmeigCDsgsGwV6iFwuh5k8JqzovTquAIwjNSuMDImD1
	 Nx0obuarrtKkwJu6IeVb+rHE2aNEEpQuT+sKLOSAufvuN6auiZ7cnuGG8xFUp0tVGw
	 z/adBklq45EfwtqsNGUDmHbdIJPBV6TlBB58i4BM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 091/558] crypto: octeontx2 - Fix authenc setkey
Date: Tue,  8 Oct 2024 14:02:01 +0200
Message-ID: <20241008115705.951297261@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 7ccb750dcac8abbfc7743aab0db6a72c1c3703c7 ]

Use the generic crypto_authenc_extractkeys helper instead of custom
parsing code that is slightly broken.  Also fix a number of memory
leaks by moving memory allocation from setkey to init_tfm (setkey
can be called multiple times over the life of a tfm).

Finally accept all hash key lengths by running the digest over
extra-long keys.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/otx2_cptvf_algs.c       | 254 +++++++-----------
 1 file changed, 90 insertions(+), 164 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index 1604fc58dc13e..5aa56f20f888c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -11,7 +11,6 @@
 #include <crypto/xts.h>
 #include <crypto/gcm.h>
 #include <crypto/scatterwalk.h>
-#include <linux/rtnetlink.h>
 #include <linux/sort.h>
 #include <linux/module.h>
 #include "otx2_cptvf.h"
@@ -55,6 +54,8 @@ static struct cpt_device_table se_devices = {
 	.count = ATOMIC_INIT(0)
 };
 
+static struct otx2_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg);
+
 static inline int get_se_device(struct pci_dev **pdev, int *cpu_num)
 {
 	int count;
@@ -598,40 +599,56 @@ static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
 
+	switch (ctx->mac_type) {
+	case OTX2_CPT_SHA1:
+		ctx->hashalg = crypto_alloc_shash("sha1", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA256:
+		ctx->hashalg = crypto_alloc_shash("sha256", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA384:
+		ctx->hashalg = crypto_alloc_shash("sha384", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA512:
+		ctx->hashalg = crypto_alloc_shash("sha512", 0, 0);
+		break;
+	}
+
+	if (IS_ERR(ctx->hashalg))
+		return PTR_ERR(ctx->hashalg);
+
+	if (ctx->hashalg) {
+		ctx->sdesc = alloc_sdesc(ctx->hashalg);
+		if (!ctx->sdesc) {
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
+	}
+
 	/*
 	 * When selected cipher is NULL we use HMAC opcode instead of
 	 * FLEXICRYPTO opcode therefore we don't need to use HASH algorithms
 	 * for calculating ipad and opad
 	 */
-	if (ctx->cipher_type != OTX2_CPT_CIPHER_NULL) {
-		switch (ctx->mac_type) {
-		case OTX2_CPT_SHA1:
-			ctx->hashalg = crypto_alloc_shash("sha1", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
-
-		case OTX2_CPT_SHA256:
-			ctx->hashalg = crypto_alloc_shash("sha256", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+	if (ctx->cipher_type != OTX2_CPT_CIPHER_NULL && ctx->hashalg) {
+		int ss = crypto_shash_statesize(ctx->hashalg);
 
-		case OTX2_CPT_SHA384:
-			ctx->hashalg = crypto_alloc_shash("sha384", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->ipad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->ipad) {
+			kfree(ctx->sdesc);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
 
-		case OTX2_CPT_SHA512:
-			ctx->hashalg = crypto_alloc_shash("sha512", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->opad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->opad) {
+			kfree(ctx->ipad);
+			kfree(ctx->sdesc);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
 		}
 	}
 	switch (ctx->cipher_type) {
@@ -713,8 +730,7 @@ static void otx2_cpt_aead_exit(struct crypto_aead *tfm)
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
-	if (ctx->hashalg)
-		crypto_free_shash(ctx->hashalg);
+	crypto_free_shash(ctx->hashalg);
 	kfree(ctx->sdesc);
 
 	if (ctx->fbk_cipher) {
@@ -788,7 +804,7 @@ static inline void swap_data64(void *buf, u32 len)
 		cpu_to_be64s(src);
 }
 
-static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
+static int swap_pad(u8 mac_type, u8 *pad)
 {
 	struct sha512_state *sha512;
 	struct sha256_state *sha256;
@@ -796,22 +812,19 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 	switch (mac_type) {
 	case OTX2_CPT_SHA1:
-		sha1 = (struct sha1_state *) in_pad;
+		sha1 = (struct sha1_state *)pad;
 		swap_data32(sha1->state, SHA1_DIGEST_SIZE);
-		memcpy(out_pad, &sha1->state, SHA1_DIGEST_SIZE);
 		break;
 
 	case OTX2_CPT_SHA256:
-		sha256 = (struct sha256_state *) in_pad;
+		sha256 = (struct sha256_state *)pad;
 		swap_data32(sha256->state, SHA256_DIGEST_SIZE);
-		memcpy(out_pad, &sha256->state, SHA256_DIGEST_SIZE);
 		break;
 
 	case OTX2_CPT_SHA384:
 	case OTX2_CPT_SHA512:
-		sha512 = (struct sha512_state *) in_pad;
+		sha512 = (struct sha512_state *)pad;
 		swap_data64(sha512->state, SHA512_DIGEST_SIZE);
-		memcpy(out_pad, &sha512->state, SHA512_DIGEST_SIZE);
 		break;
 
 	default:
@@ -821,55 +834,54 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 	return 0;
 }
 
-static int aead_hmac_init(struct crypto_aead *cipher)
+static int aead_hmac_init(struct crypto_aead *cipher,
+			  struct crypto_authenc_keys *keys)
 {
 	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
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
+			goto calc_fail;
 
-	ctx->ipad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+		authkeylen = ds;
+	} else
+		memcpy(ctx->key, keys->authkey, authkeylen);
 
-	ctx->opad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	ctx->enc_key_len = keys->enckeylen;
+	ctx->auth_key_len = authkeylen;
 
-	ipad = kzalloc(state_size, GFP_KERNEL);
-	if (!ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	if (ctx->cipher_type == OTX2_CPT_CIPHER_NULL)
+		return keys->enckeylen ? -EINVAL : 0;
 
-	opad = kzalloc(state_size, GFP_KERNEL);
-	if (!opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
+	switch (keys->enckeylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX2_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX2_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX2_CPT_AES_256_BIT;
+		break;
+	default:
+		/* Invalid key length */
+		return -EINVAL;
 	}
 
-	if (authkeylen > bs) {
-		ret = crypto_shash_digest(&ctx->sdesc->shash, ctx->key,
-					  authkeylen, ipad);
-		if (ret)
-			goto calc_fail;
+	memcpy(ctx->key + authkeylen, keys->enckey, keys->enckeylen);
 
-		authkeylen = ds;
-	} else {
-		memcpy(ipad, ctx->key, authkeylen);
-	}
+	ipad = ctx->ipad;
+	opad = ctx->opad;
 
+	memcpy(ipad, ctx->key, authkeylen);
 	memset(ipad + authkeylen, 0, bs - authkeylen);
 	memcpy(opad, ipad, bs);
 
@@ -887,7 +899,7 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, ipad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, ipad);
-	ret = copy_pad(ctx->mac_type, ctx->ipad, ipad);
+	ret = swap_pad(ctx->mac_type, ipad);
 	if (ret)
 		goto calc_fail;
 
@@ -895,25 +907,9 @@ static int aead_hmac_init(struct crypto_aead *cipher)
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
 
@@ -921,87 +917,17 @@ static int otx2_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	int enckeylen = 0, authkeylen = 0;
-	struct rtattr *rta = (void *)key;
-
-	if (!RTA_OK(rta, keylen))
-		return -EINVAL;
+	struct crypto_authenc_keys authenc_keys;
 
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		return -EINVAL;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		return -EINVAL;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (keylen < enckeylen)
-		return -EINVAL;
-
-	if (keylen > OTX2_CPT_MAX_KEY_SIZE)
-		return -EINVAL;
-
-	authkeylen = keylen - enckeylen;
-	memcpy(ctx->key, key, keylen);
-
-	switch (enckeylen) {
-	case AES_KEYSIZE_128:
-		ctx->key_type = OTX2_CPT_AES_128_BIT;
-		break;
-	case AES_KEYSIZE_192:
-		ctx->key_type = OTX2_CPT_AES_192_BIT;
-		break;
-	case AES_KEYSIZE_256:
-		ctx->key_type = OTX2_CPT_AES_256_BIT;
-		break;
-	default:
-		/* Invalid key length */
-		return -EINVAL;
-	}
-
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = authkeylen;
-
-	return aead_hmac_init(cipher);
+	return crypto_authenc_extractkeys(&authenc_keys, key, keylen) ?:
+	       aead_hmac_init(cipher, &authenc_keys);
 }
 
 static int otx2_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					     const unsigned char *key,
 					     unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	struct rtattr *rta = (void *)key;
-	int enckeylen = 0;
-
-	if (!RTA_OK(rta, keylen))
-		return -EINVAL;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		return -EINVAL;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		return -EINVAL;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (enckeylen != 0)
-		return -EINVAL;
-
-	if (keylen > OTX2_CPT_MAX_KEY_SIZE)
-		return -EINVAL;
-
-	memcpy(ctx->key, key, keylen);
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = keylen;
-
-	return 0;
+	return otx2_cpt_aead_cbc_aes_sha_setkey(cipher, key, keylen);
 }
 
 static int otx2_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
-- 
2.43.0




