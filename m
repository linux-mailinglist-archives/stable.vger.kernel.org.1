Return-Path: <stable+bounces-129512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2352A7FFED
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763CC1898D6E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B832686B1;
	Tue,  8 Apr 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="movZkeSC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2E207E14;
	Tue,  8 Apr 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111229; cv=none; b=a0bgYOvcwVAVnjAyNw3tk32NZ1qlwazOcjQTx5r3N6tgrPvRNVs3cvbnZva2MGfxrynvpePeSyupK64nSg8WMesfnc0GB8cqewUVg13l9PFBQ3mAOpvOtq4+kcVWnykADOyvEC8GKoRSKIJQ3s7ph5qiK5zRKTR9JIENJM9bnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111229; c=relaxed/simple;
	bh=6pLw9YfeNTjKeX3f2b+S35fCj4jRvmtzBaFogPpXdHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSk5nPNhKn4RVDCmV0R2bN/WQoMn04oNRsgPLu9m5nhdH0l+FJH40bjA9fF5yUqLsg0ervdsYua9JkCfAm2ITEvCmUrVn60Hk10dTE9NeDiYbmQzE/o5O+Z/wC/r4sgzb9KbmVHUsIt4qzpy/8eUlhPYq/rM/ep+aJuJIeYvuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=movZkeSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45920C4CEE5;
	Tue,  8 Apr 2025 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111229;
	bh=6pLw9YfeNTjKeX3f2b+S35fCj4jRvmtzBaFogPpXdHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=movZkeSCWLi5veBYvHLmIGQnH+NWsBpPBs8ewNpEE7cvirg+2podLgF4mktF1ENMM
	 2r097RKn5fT4IonB/024RN0ur3exTWojc1Qv2bSKTcG0atnWCahDu9ikfK3l/p1bcX
	 mVbcb8sJt+bBtKE2h37ZSCF8DJtSRxrK/Mqxj7os=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 356/731] crypto: tegra - Transfer HASH init function to crypto engine
Date: Tue,  8 Apr 2025 12:44:13 +0200
Message-ID: <20250408104922.553586382@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit 97ee15ea101629d2ffe21d3c5dc03b8d8be43603 ]

Ahash init() function was called asynchronous to the crypto engine queue.
This could corrupt the request context if there is any ongoing operation
for the same request. Queue the init function as well to the crypto
engine queue so that this scenario can be avoided.

Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: ff4b7df0b511 ("crypto: tegra - Fix HASH intermediate result handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/tegra/tegra-se-aes.c  |  81 ++++++++++++---------
 drivers/crypto/tegra/tegra-se-hash.c | 101 +++++++++++++++------------
 drivers/crypto/tegra/tegra-se.h      |   5 +-
 3 files changed, 109 insertions(+), 78 deletions(-)

diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index dd147fa4af977..5d8237cda58f0 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -1453,6 +1453,34 @@ static void tegra_cmac_paste_result(struct tegra_se *se, struct tegra_cmac_reqct
 		       se->base + se->hw->regs->result + (i * 4));
 }
 
+static int tegra_cmac_do_init(struct ahash_request *req)
+{
+	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct tegra_se *se = ctx->se;
+	int i;
+
+	rctx->total_len = 0;
+	rctx->datbuf.size = 0;
+	rctx->residue.size = 0;
+	rctx->task |= SHA_FIRST;
+	rctx->blk_size = crypto_ahash_blocksize(tfm);
+
+	rctx->residue.buf = dma_alloc_coherent(se->dev, rctx->blk_size * 2,
+					       &rctx->residue.addr, GFP_KERNEL);
+	if (!rctx->residue.buf)
+		return -ENOMEM;
+
+	rctx->residue.size = 0;
+
+	/* Clear any previous result */
+	for (i = 0; i < CMAC_RESULT_REG_COUNT; i++)
+		writel(0, se->base + se->hw->regs->result + (i * 4));
+
+	return 0;
+}
+
 static int tegra_cmac_do_update(struct ahash_request *req)
 {
 	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
@@ -1598,6 +1626,14 @@ static int tegra_cmac_do_one_req(struct crypto_engine *engine, void *areq)
 	struct tegra_se *se = ctx->se;
 	int ret = 0;
 
+	if (rctx->task & SHA_INIT) {
+		ret = tegra_cmac_do_init(req);
+		if (ret)
+			goto out;
+
+		rctx->task &= ~SHA_INIT;
+	}
+
 	if (rctx->task & SHA_UPDATE) {
 		ret = tegra_cmac_do_update(req);
 		if (ret)
@@ -1678,34 +1714,6 @@ static void tegra_cmac_cra_exit(struct crypto_tfm *tfm)
 	tegra_key_invalidate(ctx->se, ctx->key_id, ctx->alg);
 }
 
-static int tegra_cmac_init(struct ahash_request *req)
-{
-	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct tegra_se *se = ctx->se;
-	int i;
-
-	rctx->total_len = 0;
-	rctx->datbuf.size = 0;
-	rctx->residue.size = 0;
-	rctx->task = SHA_FIRST;
-	rctx->blk_size = crypto_ahash_blocksize(tfm);
-
-	rctx->residue.buf = dma_alloc_coherent(se->dev, rctx->blk_size * 2,
-					       &rctx->residue.addr, GFP_KERNEL);
-	if (!rctx->residue.buf)
-		return -ENOMEM;
-
-	rctx->residue.size = 0;
-
-	/* Clear any previous result */
-	for (i = 0; i < CMAC_RESULT_REG_COUNT; i++)
-		writel(0, se->base + se->hw->regs->result + (i * 4));
-
-	return 0;
-}
-
 static int tegra_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 			     unsigned int keylen)
 {
@@ -1722,6 +1730,17 @@ static int tegra_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 	return tegra_key_submit(ctx->se, key, keylen, ctx->alg, &ctx->key_id);
 }
 
+static int tegra_cmac_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
+
+	rctx->task = SHA_INIT;
+
+	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
+}
+
 static int tegra_cmac_update(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -1760,13 +1779,9 @@ static int tegra_cmac_digest(struct ahash_request *req)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
-	int ret;
 
-	ret = tegra_cmac_init(req);
-	if (ret)
-		return ret;
+	rctx->task |= SHA_INIT | SHA_UPDATE | SHA_FINAL;
 
-	rctx->task |= SHA_UPDATE | SHA_FINAL;
 	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
 }
 
diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 0ae5ce67bdd04..07e4c7320ec8d 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -296,6 +296,44 @@ static void tegra_sha_paste_hash_result(struct tegra_se *se, struct tegra_sha_re
 		       se->base + se->hw->regs->result + (i * 4));
 }
 
+static int tegra_sha_do_init(struct ahash_request *req)
+{
+	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct tegra_se *se = ctx->se;
+
+	if (ctx->fallback)
+		return tegra_sha_fallback_init(req);
+
+	rctx->total_len = 0;
+	rctx->datbuf.size = 0;
+	rctx->residue.size = 0;
+	rctx->key_id = ctx->key_id;
+	rctx->task |= SHA_FIRST;
+	rctx->alg = ctx->alg;
+	rctx->blk_size = crypto_ahash_blocksize(tfm);
+	rctx->digest.size = crypto_ahash_digestsize(tfm);
+
+	rctx->digest.buf = dma_alloc_coherent(se->dev, rctx->digest.size,
+					      &rctx->digest.addr, GFP_KERNEL);
+	if (!rctx->digest.buf)
+		goto digbuf_fail;
+
+	rctx->residue.buf = dma_alloc_coherent(se->dev, rctx->blk_size,
+					       &rctx->residue.addr, GFP_KERNEL);
+	if (!rctx->residue.buf)
+		goto resbuf_fail;
+
+	return 0;
+
+resbuf_fail:
+	dma_free_coherent(se->dev, rctx->digest.size, rctx->digest.buf,
+			  rctx->digest.addr);
+digbuf_fail:
+	return -ENOMEM;
+}
+
 static int tegra_sha_do_update(struct ahash_request *req)
 {
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
@@ -435,6 +473,14 @@ static int tegra_sha_do_one_req(struct crypto_engine *engine, void *areq)
 	struct tegra_se *se = ctx->se;
 	int ret = 0;
 
+	if (rctx->task & SHA_INIT) {
+		ret = tegra_sha_do_init(req);
+		if (ret)
+			goto out;
+
+		rctx->task &= ~SHA_INIT;
+	}
+
 	if (rctx->task & SHA_UPDATE) {
 		ret = tegra_sha_do_update(req);
 		if (ret)
@@ -525,44 +571,6 @@ static void tegra_sha_cra_exit(struct crypto_tfm *tfm)
 	tegra_key_invalidate(ctx->se, ctx->key_id, ctx->alg);
 }
 
-static int tegra_sha_init(struct ahash_request *req)
-{
-	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct tegra_se *se = ctx->se;
-
-	if (ctx->fallback)
-		return tegra_sha_fallback_init(req);
-
-	rctx->total_len = 0;
-	rctx->datbuf.size = 0;
-	rctx->residue.size = 0;
-	rctx->key_id = ctx->key_id;
-	rctx->task = SHA_FIRST;
-	rctx->alg = ctx->alg;
-	rctx->blk_size = crypto_ahash_blocksize(tfm);
-	rctx->digest.size = crypto_ahash_digestsize(tfm);
-
-	rctx->digest.buf = dma_alloc_coherent(se->dev, rctx->digest.size,
-					      &rctx->digest.addr, GFP_KERNEL);
-	if (!rctx->digest.buf)
-		goto digbuf_fail;
-
-	rctx->residue.buf = dma_alloc_coherent(se->dev, rctx->blk_size,
-					       &rctx->residue.addr, GFP_KERNEL);
-	if (!rctx->residue.buf)
-		goto resbuf_fail;
-
-	return 0;
-
-resbuf_fail:
-	dma_free_coherent(se->dev, rctx->digest.size, rctx->digest.buf,
-			  rctx->digest.addr);
-digbuf_fail:
-	return -ENOMEM;
-}
-
 static int tegra_hmac_fallback_setkey(struct tegra_sha_ctx *ctx, const u8 *key,
 				      unsigned int keylen)
 {
@@ -588,6 +596,17 @@ static int tegra_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 	return tegra_key_submit(ctx->se, key, keylen, ctx->alg, &ctx->key_id);
 }
 
+static int tegra_sha_init(struct ahash_request *req)
+{
+	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	rctx->task = SHA_INIT;
+
+	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
+}
+
 static int tegra_sha_update(struct ahash_request *req)
 {
 	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
@@ -635,16 +654,12 @@ static int tegra_sha_digest(struct ahash_request *req)
 	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
-	int ret;
 
 	if (ctx->fallback)
 		return tegra_sha_fallback_digest(req);
 
-	ret = tegra_sha_init(req);
-	if (ret)
-		return ret;
+	rctx->task |= SHA_INIT | SHA_UPDATE | SHA_FINAL;
 
-	rctx->task |= SHA_UPDATE | SHA_FINAL;
 	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
 }
 
diff --git a/drivers/crypto/tegra/tegra-se.h b/drivers/crypto/tegra/tegra-se.h
index e196a90eedb92..e1ec37bfb80a8 100644
--- a/drivers/crypto/tegra/tegra-se.h
+++ b/drivers/crypto/tegra/tegra-se.h
@@ -342,8 +342,9 @@
 #define SE_MAX_MEM_ALLOC			SZ_4M
 
 #define SHA_FIRST	BIT(0)
-#define SHA_UPDATE	BIT(1)
-#define SHA_FINAL	BIT(2)
+#define SHA_INIT	BIT(1)
+#define SHA_UPDATE	BIT(2)
+#define SHA_FINAL	BIT(3)
 
 /* Security Engine operation modes */
 enum se_aes_alg {
-- 
2.39.5




