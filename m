Return-Path: <stable+bounces-130745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08DFA805EC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BD91B80487
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF326A09B;
	Tue,  8 Apr 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2R9x56N8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77464267393;
	Tue,  8 Apr 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114536; cv=none; b=oNvFawmD/ztJdUGy2sWuA89PAt6O0oBO9i2r8mwygJp9BATvXiy7cvLDUarZJvf585yNxqeRl/I7qGzUczOPQkbkDLXeF94ERfwBEyKfCc8yIyOyNuxxs2gl66H9Iv+dEraUVUWWFP5O2oH3vMmLm970p6iACG52W75ZPDltEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114536; c=relaxed/simple;
	bh=un8KabBsa00BPTMLvRiW0xgQr2wl+CxR6AZHFsBsJDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoogyC0xb/VC45eCTV5x9zi1SRh5d8FI4emnp6fguJ3F7f6fcP+7UXhVsNixwNoU+A2JhGTTV6SmSqU8yjzaZ4aPrIUj0zuma9e/WAPHXggoNLbzN6kjz4tNllXxWqvZyPRKeH2LopDiy0IS3jdXwUvFxltZdu0QmLniYCgXInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2R9x56N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D865C4CEE5;
	Tue,  8 Apr 2025 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114536;
	bh=un8KabBsa00BPTMLvRiW0xgQr2wl+CxR6AZHFsBsJDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2R9x56N8mVyCnU6WuAmYAQPkn6tK23bV5QwuXe/eNlMjI73frHVEq+52Le0wPkg2b
	 zEcAUraOzlzAZplw77p/4iJr0GV92jR0AilISCTEaqC7+T0SyT2mFhlvdhWC7SESwZ
	 WnMVmM5SIB/qMoWEUIriXtibsvoDoojfQE8JVE2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 126/499] crypto: tegra - Fix HASH intermediate result handling
Date: Tue,  8 Apr 2025 12:45:38 +0200
Message-ID: <20250408104854.341938903@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit ff4b7df0b511b6121f3386607f02c16fb5d41192 ]

The intermediate hash values generated during an update task were
handled incorrectly in the driver. The values have a defined format for
each algorithm. Copying and pasting from the HASH_RESULT register
balantly would not work for all the supported algorithms. This incorrect
handling causes failures when there is a context switch between multiple
operations.

To handle the expected format correctly, add a separate buffer for
storing the intermediate results for each request. Remove the previous
copy/paste functions which read/wrote to the registers directly. Instead
configure the hardware to get the intermediate result copied to the
buffer and use host1x path to restore the intermediate hash results.

Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/tegra/tegra-se-hash.c | 149 +++++++++++++++++----------
 drivers/crypto/tegra/tegra-se.h      |   1 +
 2 files changed, 98 insertions(+), 52 deletions(-)

diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 07e4c7320ec8d..8bed13552ab9e 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -34,6 +34,7 @@ struct tegra_sha_reqctx {
 	struct tegra_se_datbuf datbuf;
 	struct tegra_se_datbuf residue;
 	struct tegra_se_datbuf digest;
+	struct tegra_se_datbuf intr_res;
 	unsigned int alg;
 	unsigned int config;
 	unsigned int total_len;
@@ -211,9 +212,62 @@ static int tegra_sha_fallback_export(struct ahash_request *req, void *out)
 	return crypto_ahash_export(&rctx->fallback_req, out);
 }
 
-static int tegra_sha_prep_cmd(struct tegra_se *se, u32 *cpuvaddr,
+static int tegra_se_insert_hash_result(struct tegra_sha_ctx *ctx, u32 *cpuvaddr,
+				       struct tegra_sha_reqctx *rctx)
+{
+	__be32 *res_be = (__be32 *)rctx->intr_res.buf;
+	u32 *res = (u32 *)rctx->intr_res.buf;
+	int i = 0, j;
+
+	cpuvaddr[i++] = 0;
+	cpuvaddr[i++] = host1x_opcode_setpayload(HASH_RESULT_REG_COUNT);
+	cpuvaddr[i++] = se_host1x_opcode_incr_w(SE_SHA_HASH_RESULT);
+
+	for (j = 0; j < HASH_RESULT_REG_COUNT; j++) {
+		int idx = j;
+
+		/*
+		 * The initial, intermediate and final hash value of SHA-384, SHA-512
+		 * in SHA_HASH_RESULT registers follow the below layout of bytes.
+		 *
+		 * +---------------+------------+
+		 * | HASH_RESULT_0 | B4...B7    |
+		 * +---------------+------------+
+		 * | HASH_RESULT_1 | B0...B3    |
+		 * +---------------+------------+
+		 * | HASH_RESULT_2 | B12...B15  |
+		 * +---------------+------------+
+		 * | HASH_RESULT_3 | B8...B11   |
+		 * +---------------+------------+
+		 * |            ......          |
+		 * +---------------+------------+
+		 * | HASH_RESULT_14| B60...B63  |
+		 * +---------------+------------+
+		 * | HASH_RESULT_15| B56...B59  |
+		 * +---------------+------------+
+		 *
+		 */
+		if (ctx->alg == SE_ALG_SHA384 || ctx->alg == SE_ALG_SHA512)
+			idx = (j % 2) ? j - 1 : j + 1;
+
+		/* For SHA-1, SHA-224, SHA-256, SHA-384, SHA-512 the initial
+		 * intermediate and final hash value when stored in
+		 * SHA_HASH_RESULT registers, the byte order is NOT in
+		 * little-endian.
+		 */
+		if (ctx->alg <= SE_ALG_SHA512)
+			cpuvaddr[i++] = be32_to_cpu(res_be[idx]);
+		else
+			cpuvaddr[i++] = res[idx];
+	}
+
+	return i;
+}
+
+static int tegra_sha_prep_cmd(struct tegra_sha_ctx *ctx, u32 *cpuvaddr,
 			      struct tegra_sha_reqctx *rctx)
 {
+	struct tegra_se *se = ctx->se;
 	u64 msg_len, msg_left;
 	int i = 0;
 
@@ -241,7 +295,7 @@ static int tegra_sha_prep_cmd(struct tegra_se *se, u32 *cpuvaddr,
 	cpuvaddr[i++] = upper_32_bits(msg_left);
 	cpuvaddr[i++] = 0;
 	cpuvaddr[i++] = 0;
-	cpuvaddr[i++] = host1x_opcode_setpayload(6);
+	cpuvaddr[i++] = host1x_opcode_setpayload(2);
 	cpuvaddr[i++] = se_host1x_opcode_incr_w(SE_SHA_CFG);
 	cpuvaddr[i++] = rctx->config;
 
@@ -249,15 +303,29 @@ static int tegra_sha_prep_cmd(struct tegra_se *se, u32 *cpuvaddr,
 		cpuvaddr[i++] = SE_SHA_TASK_HASH_INIT;
 		rctx->task &= ~SHA_FIRST;
 	} else {
-		cpuvaddr[i++] = 0;
+		/*
+		 * If it isn't the first task, program the HASH_RESULT register
+		 * with the intermediate result from the previous task
+		 */
+		i += tegra_se_insert_hash_result(ctx, cpuvaddr + i, rctx);
 	}
 
+	cpuvaddr[i++] = host1x_opcode_setpayload(4);
+	cpuvaddr[i++] = se_host1x_opcode_incr_w(SE_SHA_IN_ADDR);
 	cpuvaddr[i++] = rctx->datbuf.addr;
 	cpuvaddr[i++] = (u32)(SE_ADDR_HI_MSB(upper_32_bits(rctx->datbuf.addr)) |
 				SE_ADDR_HI_SZ(rctx->datbuf.size));
-	cpuvaddr[i++] = rctx->digest.addr;
-	cpuvaddr[i++] = (u32)(SE_ADDR_HI_MSB(upper_32_bits(rctx->digest.addr)) |
-				SE_ADDR_HI_SZ(rctx->digest.size));
+
+	if (rctx->task & SHA_UPDATE) {
+		cpuvaddr[i++] = rctx->intr_res.addr;
+		cpuvaddr[i++] = (u32)(SE_ADDR_HI_MSB(upper_32_bits(rctx->intr_res.addr)) |
+					SE_ADDR_HI_SZ(rctx->intr_res.size));
+	} else {
+		cpuvaddr[i++] = rctx->digest.addr;
+		cpuvaddr[i++] = (u32)(SE_ADDR_HI_MSB(upper_32_bits(rctx->digest.addr)) |
+					SE_ADDR_HI_SZ(rctx->digest.size));
+	}
+
 	if (rctx->key_id) {
 		cpuvaddr[i++] = host1x_opcode_setpayload(1);
 		cpuvaddr[i++] = se_host1x_opcode_nonincr_w(SE_SHA_CRYPTO_CFG);
@@ -266,36 +334,18 @@ static int tegra_sha_prep_cmd(struct tegra_se *se, u32 *cpuvaddr,
 
 	cpuvaddr[i++] = host1x_opcode_setpayload(1);
 	cpuvaddr[i++] = se_host1x_opcode_nonincr_w(SE_SHA_OPERATION);
-	cpuvaddr[i++] = SE_SHA_OP_WRSTALL |
-			SE_SHA_OP_START |
+	cpuvaddr[i++] = SE_SHA_OP_WRSTALL | SE_SHA_OP_START |
 			SE_SHA_OP_LASTBUF;
 	cpuvaddr[i++] = se_host1x_opcode_nonincr(host1x_uclass_incr_syncpt_r(), 1);
 	cpuvaddr[i++] = host1x_uclass_incr_syncpt_cond_f(1) |
 			host1x_uclass_incr_syncpt_indx_f(se->syncpt_id);
 
-	dev_dbg(se->dev, "msg len %llu msg left %llu cfg %#x",
-		msg_len, msg_left, rctx->config);
+	dev_dbg(se->dev, "msg len %llu msg left %llu sz %lu cfg %#x",
+		msg_len, msg_left, rctx->datbuf.size, rctx->config);
 
 	return i;
 }
 
-static void tegra_sha_copy_hash_result(struct tegra_se *se, struct tegra_sha_reqctx *rctx)
-{
-	int i;
-
-	for (i = 0; i < HASH_RESULT_REG_COUNT; i++)
-		rctx->result[i] = readl(se->base + se->hw->regs->result + (i * 4));
-}
-
-static void tegra_sha_paste_hash_result(struct tegra_se *se, struct tegra_sha_reqctx *rctx)
-{
-	int i;
-
-	for (i = 0; i < HASH_RESULT_REG_COUNT; i++)
-		writel(rctx->result[i],
-		       se->base + se->hw->regs->result + (i * 4));
-}
-
 static int tegra_sha_do_init(struct ahash_request *req)
 {
 	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
@@ -325,8 +375,17 @@ static int tegra_sha_do_init(struct ahash_request *req)
 	if (!rctx->residue.buf)
 		goto resbuf_fail;
 
+	rctx->intr_res.size = HASH_RESULT_REG_COUNT * 4;
+	rctx->intr_res.buf = dma_alloc_coherent(se->dev, rctx->intr_res.size,
+						&rctx->intr_res.addr, GFP_KERNEL);
+	if (!rctx->intr_res.buf)
+		goto intr_res_fail;
+
 	return 0;
 
+intr_res_fail:
+	dma_free_coherent(se->dev, rctx->residue.size, rctx->residue.buf,
+			  rctx->residue.addr);
 resbuf_fail:
 	dma_free_coherent(se->dev, rctx->digest.size, rctx->digest.buf,
 			  rctx->digest.addr);
@@ -356,7 +415,6 @@ static int tegra_sha_do_update(struct ahash_request *req)
 
 	rctx->src_sg = req->src;
 	rctx->datbuf.size = (req->nbytes + rctx->residue.size) - nresidue;
-	rctx->total_len += rctx->datbuf.size;
 
 	/*
 	 * If nbytes are less than a block size, copy it residue and
@@ -365,12 +423,12 @@ static int tegra_sha_do_update(struct ahash_request *req)
 	if (nblks < 1) {
 		scatterwalk_map_and_copy(rctx->residue.buf + rctx->residue.size,
 					 rctx->src_sg, 0, req->nbytes, 0);
-
 		rctx->residue.size += req->nbytes;
+
 		return 0;
 	}
 
-	rctx->datbuf.buf = dma_alloc_coherent(ctx->se->dev, rctx->datbuf.size,
+	rctx->datbuf.buf = dma_alloc_coherent(se->dev, rctx->datbuf.size,
 					      &rctx->datbuf.addr, GFP_KERNEL);
 	if (!rctx->datbuf.buf)
 		return -ENOMEM;
@@ -387,31 +445,15 @@ static int tegra_sha_do_update(struct ahash_request *req)
 
 	/* Update residue value with the residue after current block */
 	rctx->residue.size = nresidue;
+	rctx->total_len += rctx->datbuf.size;
 
 	rctx->config = tegra_sha_get_config(rctx->alg) |
-			SE_SHA_DST_HASH_REG;
-
-	/*
-	 * If this is not the first 'update' call, paste the previous copied
-	 * intermediate results to the registers so that it gets picked up.
-	 * This is to support the import/export functionality.
-	 */
-	if (!(rctx->task & SHA_FIRST))
-		tegra_sha_paste_hash_result(se, rctx);
-
-	size = tegra_sha_prep_cmd(se, cpuvaddr, rctx);
+			SE_SHA_DST_MEMORY;
 
+	size = tegra_sha_prep_cmd(ctx, cpuvaddr, rctx);
 	ret = tegra_se_host1x_submit(se, se->cmdbuf, size);
 
-	/*
-	 * If this is not the final update, copy the intermediate results
-	 * from the registers so that it can be used in the next 'update'
-	 * call. This is to support the import/export functionality.
-	 */
-	if (!(rctx->task & SHA_FINAL))
-		tegra_sha_copy_hash_result(se, rctx);
-
-	dma_free_coherent(ctx->se->dev, rctx->datbuf.size,
+	dma_free_coherent(se->dev, rctx->datbuf.size,
 			  rctx->datbuf.buf, rctx->datbuf.addr);
 
 	return ret;
@@ -443,8 +485,7 @@ static int tegra_sha_do_final(struct ahash_request *req)
 	rctx->config = tegra_sha_get_config(rctx->alg) |
 		       SE_SHA_DST_MEMORY;
 
-	size = tegra_sha_prep_cmd(se, cpuvaddr, rctx);
-
+	size = tegra_sha_prep_cmd(ctx, cpuvaddr, rctx);
 	ret = tegra_se_host1x_submit(se, se->cmdbuf, size);
 	if (ret)
 		goto out;
@@ -461,6 +502,10 @@ static int tegra_sha_do_final(struct ahash_request *req)
 			  rctx->residue.buf, rctx->residue.addr);
 	dma_free_coherent(se->dev, rctx->digest.size, rctx->digest.buf,
 			  rctx->digest.addr);
+
+	dma_free_coherent(se->dev, rctx->intr_res.size, rctx->intr_res.buf,
+			  rctx->intr_res.addr);
+
 	return ret;
 }
 
diff --git a/drivers/crypto/tegra/tegra-se.h b/drivers/crypto/tegra/tegra-se.h
index e1ec37bfb80a8..0f5bcf27358bd 100644
--- a/drivers/crypto/tegra/tegra-se.h
+++ b/drivers/crypto/tegra/tegra-se.h
@@ -24,6 +24,7 @@
 #define SE_STREAM_ID					0x90
 
 #define SE_SHA_CFG					0x4004
+#define SE_SHA_IN_ADDR					0x400c
 #define SE_SHA_KEY_ADDR					0x4094
 #define SE_SHA_KEY_DATA					0x4098
 #define SE_SHA_KEYMANIFEST				0x409c
-- 
2.39.5




