Return-Path: <stable+bounces-113290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE3A290ED
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3348188ACE1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F618A6B7;
	Wed,  5 Feb 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8AOvlS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B025189F56;
	Wed,  5 Feb 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766460; cv=none; b=DRPYgzuzWi6XHrnLFt4aqfpmJza3ZZl6eeK5ba4hlF3xZvNG88RCp1XnAsz2ioYTUlhLjSBiItBxd4fssDJN8RialH4scT8ppenwooazQnHb2K90pVc0xYEuSVHUTlJw9pc8qBqpxmXNvtp/jgKSFq/+Pp9TYbnHsangWRC45lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766460; c=relaxed/simple;
	bh=cGARthTWtcZuB2szuHL7yWQXafd7f1Z//jM21XRn3VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDxUE0whaoPFdrGCrnfuTkiFIPqgzYyJUcR3PNuA8eQGtWzPw3h6lYeg3cZWwNZbAIlck9Nni4Xd8TWDX8YbOhwF7hWYNuef/sR2XzJ4DoMpObv/mHh49wE0kJ60Gjj1rub+mdRUFK/UVZHQvjEHQtHfKNHObRER3Colu5QtWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h8AOvlS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6553CC4CED6;
	Wed,  5 Feb 2025 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766459;
	bh=cGARthTWtcZuB2szuHL7yWQXafd7f1Z//jM21XRn3VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8AOvlS3XxXFM7/emqIoeplqmDdPUHkeXm/vgrmw8t8jM8XZLiUUP+LxqFssj1OOe
	 0M+ZJ4S7aqus+zAsJ2SWthNZ6rfEfAwgAu2r9tMcshVxHxK+r3vuCWu/NW/jxH+Zbc
	 9cCF/NXad9tQPrWfzLMFcIhcZhwKC5VpM6Zo/cQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenkai Lin <linwenkai6@hisilicon.com>,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 278/623] crypto: hisilicon/sec2 - fix for aead invalid authsize
Date: Wed,  5 Feb 2025 14:40:20 +0100
Message-ID: <20250205134506.865816207@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenkai Lin <linwenkai6@hisilicon.com>

[ Upstream commit a5a9d959936499a3106a1bf3b9070875d0d3dec4 ]

When the digest alg is HMAC-SHAx or another, the authsize may be less
than 4 bytes and mac_len of the BD is set to zero, the hardware considers
it a BD configuration error and reports a ras error, so the sec driver
needs to switch to software calculation in this case, this patch add a
check for it and remove unnecessary check that has been done by crypto.

Fixes: 2f072d75d1ab ("crypto: hisilicon - Add aead support on SEC2")
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  2 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 64 +++++++++++-----------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 70c3bdedb6baf..4b99702308228 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -37,6 +37,7 @@ struct sec_aead_req {
 	u8 *a_ivin;
 	dma_addr_t a_ivin_dma;
 	struct aead_request *aead_req;
+	bool fallback;
 };
 
 /* SEC request of Crypto */
@@ -91,7 +92,6 @@ struct sec_auth_ctx {
 	u8 *a_key;
 	u8 a_key_len;
 	u8 a_alg;
-	bool fallback;
 	struct crypto_shash *hash_tfm;
 	struct crypto_aead *fallback_aead_tfm;
 };
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 8db995279545c..66bc07da9eb6f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -1119,10 +1119,7 @@ static int sec_aead_setauthsize(struct crypto_aead *aead, unsigned int authsize)
 	struct sec_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	if (unlikely(a_ctx->fallback_aead_tfm))
-		return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
-
-	return 0;
+	return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
 }
 
 static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
@@ -1159,13 +1156,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		}
 		memcpy(c_ctx->c_key, key, keylen);
 
-		if (unlikely(a_ctx->fallback_aead_tfm)) {
-			ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
-			if (ret)
-				return ret;
-		}
-
-		return 0;
+		return sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
 	}
 
 	ret = crypto_authenc_extractkeys(&keys, key, keylen);
@@ -1190,6 +1181,12 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
+	ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
+	if (ret) {
+		dev_err(dev, "set sec fallback key err!\n");
+		goto bad_key;
+	}
+
 	return 0;
 
 bad_key:
@@ -1917,8 +1914,10 @@ static void sec_aead_exit(struct crypto_aead *tfm)
 
 static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 {
+	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
-	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
+	const char *aead_name = alg->base.cra_name;
 	int ret;
 
 	ret = sec_aead_init(tfm);
@@ -1927,11 +1926,20 @@ static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 		return ret;
 	}
 
-	auth_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
-	if (IS_ERR(auth_ctx->hash_tfm)) {
+	a_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
+	if (IS_ERR(a_ctx->hash_tfm)) {
 		dev_err(ctx->dev, "aead alloc shash error!\n");
 		sec_aead_exit(tfm);
-		return PTR_ERR(auth_ctx->hash_tfm);
+		return PTR_ERR(a_ctx->hash_tfm);
+	}
+
+	a_ctx->fallback_aead_tfm = crypto_alloc_aead(aead_name, 0,
+						     CRYPTO_ALG_NEED_FALLBACK | CRYPTO_ALG_ASYNC);
+	if (IS_ERR(a_ctx->fallback_aead_tfm)) {
+		dev_err(ctx->dev, "aead driver alloc fallback tfm error!\n");
+		crypto_free_shash(ctx->a_ctx.hash_tfm);
+		sec_aead_exit(tfm);
+		return PTR_ERR(a_ctx->fallback_aead_tfm);
 	}
 
 	return 0;
@@ -1941,6 +1949,7 @@ static void sec_aead_ctx_exit(struct crypto_aead *tfm)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
 
+	crypto_free_aead(ctx->a_ctx.fallback_aead_tfm);
 	crypto_free_shash(ctx->a_ctx.hash_tfm);
 	sec_aead_exit(tfm);
 }
@@ -1967,7 +1976,6 @@ static int sec_aead_xcm_ctx_init(struct crypto_aead *tfm)
 		sec_aead_exit(tfm);
 		return PTR_ERR(a_ctx->fallback_aead_tfm);
 	}
-	a_ctx->fallback = false;
 
 	return 0;
 }
@@ -2226,15 +2234,15 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	struct device *dev = ctx->dev;
 	int ret;
 
-	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
-	    req->assoclen > SEC_MAX_AAD_LEN)) {
-		dev_err(dev, "aead input spec error!\n");
+	/* Hardware does not handle cases where authsize is less than 4 bytes */
+	if (unlikely(sz < MIN_MAC_LEN)) {
+		sreq->aead_req.fallback = true;
 		return -EINVAL;
 	}
 
-	if (unlikely((c_mode == SEC_CMODE_GCM && sz < DES_BLOCK_SIZE) ||
-		     (c_mode == SEC_CMODE_CCM && (sz < MIN_MAC_LEN || sz & MAC_LEN_MASK)))) {
-		dev_err(dev, "aead input mac length error!\n");
+	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
+	    req->assoclen > SEC_MAX_AAD_LEN)) {
+		dev_err(dev, "aead input spec error!\n");
 		return -EINVAL;
 	}
 
@@ -2280,7 +2288,7 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (ctx->sec->qm.ver == QM_HW_V2) {
 		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
 			     req->cryptlen <= authsize))) {
-			ctx->a_ctx.fallback = true;
+			sreq->aead_req.fallback = true;
 			return -EINVAL;
 		}
 	}
@@ -2308,16 +2316,9 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 				bool encrypt)
 {
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
-	struct device *dev = ctx->dev;
 	struct aead_request *subreq;
 	int ret;
 
-	/* Kunpeng920 aead mode not support input 0 size */
-	if (!a_ctx->fallback_aead_tfm) {
-		dev_err(dev, "aead fallback tfm is NULL!\n");
-		return -EINVAL;
-	}
-
 	subreq = aead_request_alloc(a_ctx->fallback_aead_tfm, GFP_KERNEL);
 	if (!subreq)
 		return -ENOMEM;
@@ -2349,10 +2350,11 @@ static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
 	req->aead_req.aead_req = a_req;
 	req->c_req.encrypt = encrypt;
 	req->ctx = ctx;
+	req->aead_req.fallback = false;
 
 	ret = sec_aead_param_check(ctx, req);
 	if (unlikely(ret)) {
-		if (ctx->a_ctx.fallback)
+		if (req->aead_req.fallback)
 			return sec_aead_soft_crypto(ctx, a_req, encrypt);
 		return -EINVAL;
 	}
-- 
2.39.5




