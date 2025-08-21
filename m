Return-Path: <stable+bounces-172224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CAFB302CB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E48FAC671E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95BA34DCC0;
	Thu, 21 Aug 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DehRQo3y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B336345742
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804094; cv=none; b=R++P/b4DlCSVZoJxjBa71ajLTEUMD3HgsZM50dk+PahnKYLzQ94ETivAiOIk0V4LtuYd6c6JRfOd0EoCbi+DzPdQiN/UxOUCB+XUpWrToTU7X4znkAbPM7x5mg7U05RfuxCXhKQdwk7aqALG5dZmFn/kKH4TvXdv9mpb/dzHqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804094; c=relaxed/simple;
	bh=l265+3Ip9kG756jNSsMLNgPcI6zyndfjrXgpRK6Vo0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9Bpu/q3wCvru0TKFs4cIsB6tD0Pd1in9v7WHFNggTyltsoNUnvVqfebp6hXogq0fIhzj2bjMFbCs1E6pgaIkjBWRiQi9UTk1p9Old8apFlh3hdtDZmZrE5F0sTuMWxzD94zZ31hQODA/jt4FX3lf+Z66I3dgJ7YwcAn3ZR8woU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DehRQo3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B6BC4CEF4;
	Thu, 21 Aug 2025 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755804093;
	bh=l265+3Ip9kG756jNSsMLNgPcI6zyndfjrXgpRK6Vo0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DehRQo3yY8wj5Zs/B7OZXoCr3UKPzGAcoX2QkODD7ADSHDmEgCc9SCMsScjzretsm
	 x2zYlF9igwmCrSodIPcPWy5YeE7rFWUm63N4dacX8/eYEqCQxRcEhZB+aRJY67AdeL
	 W1oY9mELFXb22wJjh7ah+6aKT1ZMtodkGczRee7EMbht+75WVgl2pc+AKCMOVl6qA/
	 3Jh95fAZX19HabEXqUQETKwHHcIYVQehSirdbiHIqZNbt1vSE7tElsJ2wxyPO/Zsyw
	 5u1+kfVlaYYx8vpA8LyTfgvIj8ZBIrtJoNQrAIht7TFElJY/69kMjo1j1qwAD+qx1D
	 hoQov6DNkmkNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] crypto: zstd - convert to acomp
Date: Thu, 21 Aug 2025 15:21:30 -0400
Message-ID: <20250821192131.923831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082113-buddhism-try-6476@gregkh>
References: <2025082113-buddhism-try-6476@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>

[ Upstream commit f5ad93ffb54119a8dc5e18f070624d4ead586969 ]

Convert the implementation to a native acomp interface using zstd
streaming APIs, eliminating the need for buffer linearization.

This includes:
   - Removal of the scomp interface in favor of acomp
   - Refactoring of stream allocation, initialization, and handling for
     both compression and decompression using Zstandard streaming APIs
   - Replacement of crypto_register_scomp() with crypto_register_acomp()
     for module registration

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 962ddc5a7a4b ("crypto: acomp - Fix CFI failure due to type punning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/zstd.c | 352 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 232 insertions(+), 120 deletions(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index 7570e11b4ee6..657e0cf7b952 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -12,188 +12,300 @@
 #include <linux/net.h>
 #include <linux/vmalloc.h>
 #include <linux/zstd.h>
-#include <crypto/internal/scompress.h>
+#include <crypto/internal/acompress.h>
+#include <crypto/scatterwalk.h>
 
 
-#define ZSTD_DEF_LEVEL	3
+#define ZSTD_DEF_LEVEL		3
+#define ZSTD_MAX_WINDOWLOG	18
+#define ZSTD_MAX_SIZE		BIT(ZSTD_MAX_WINDOWLOG)
 
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
-	void *cwksp;
-	void *dwksp;
+	size_t wksp_size;
+	zstd_parameters params;
+	u8 wksp[0] __aligned(8);
 };
 
-static zstd_parameters zstd_params(void)
-{
-	return zstd_get_params(ZSTD_DEF_LEVEL, 0);
-}
+static DEFINE_MUTEX(zstd_stream_lock);
 
-static int zstd_comp_init(struct zstd_ctx *ctx)
+static void *zstd_alloc_stream(void)
 {
-	int ret = 0;
-	const zstd_parameters params = zstd_params();
-	const size_t wksp_size = zstd_cctx_workspace_bound(&params.cParams);
+	zstd_parameters params;
+	struct zstd_ctx *ctx;
+	size_t wksp_size;
 
-	ctx->cwksp = vzalloc(wksp_size);
-	if (!ctx->cwksp) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	params = zstd_get_params(ZSTD_DEF_LEVEL, ZSTD_MAX_SIZE);
 
-	ctx->cctx = zstd_init_cctx(ctx->cwksp, wksp_size);
-	if (!ctx->cctx) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-out:
-	return ret;
-out_free:
-	vfree(ctx->cwksp);
-	goto out;
+	wksp_size = max_t(size_t,
+			  zstd_cstream_workspace_bound(&params.cParams),
+			  zstd_dstream_workspace_bound(ZSTD_MAX_SIZE));
+	if (!wksp_size)
+		return ERR_PTR(-EINVAL);
+
+	ctx = kvmalloc(sizeof(*ctx) + wksp_size, GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->params = params;
+	ctx->wksp_size = wksp_size;
+
+	return ctx;
 }
 
-static int zstd_decomp_init(struct zstd_ctx *ctx)
+static struct crypto_acomp_streams zstd_streams = {
+	.alloc_ctx = zstd_alloc_stream,
+	.cfree_ctx = kvfree,
+};
+
+static int zstd_init(struct crypto_acomp *acomp_tfm)
 {
 	int ret = 0;
-	const size_t wksp_size = zstd_dctx_workspace_bound();
 
-	ctx->dwksp = vzalloc(wksp_size);
-	if (!ctx->dwksp) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	mutex_lock(&zstd_stream_lock);
+	ret = crypto_acomp_alloc_streams(&zstd_streams);
+	mutex_unlock(&zstd_stream_lock);
 
-	ctx->dctx = zstd_init_dctx(ctx->dwksp, wksp_size);
-	if (!ctx->dctx) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-out:
 	return ret;
-out_free:
-	vfree(ctx->dwksp);
-	goto out;
 }
 
-static void zstd_comp_exit(struct zstd_ctx *ctx)
+static void zstd_exit(struct crypto_acomp *acomp_tfm)
 {
-	vfree(ctx->cwksp);
-	ctx->cwksp = NULL;
-	ctx->cctx = NULL;
+	crypto_acomp_free_streams(&zstd_streams);
 }
 
-static void zstd_decomp_exit(struct zstd_ctx *ctx)
+static int zstd_compress_one(struct acomp_req *req, struct zstd_ctx *ctx,
+			     const void *src, void *dst, unsigned int *dlen)
 {
-	vfree(ctx->dwksp);
-	ctx->dwksp = NULL;
-	ctx->dctx = NULL;
-}
+	unsigned int out_len;
 
-static int __zstd_init(void *ctx)
-{
-	int ret;
+	ctx->cctx = zstd_init_cctx(ctx->wksp, ctx->wksp_size);
+	if (!ctx->cctx)
+		return -EINVAL;
 
-	ret = zstd_comp_init(ctx);
-	if (ret)
-		return ret;
-	ret = zstd_decomp_init(ctx);
-	if (ret)
-		zstd_comp_exit(ctx);
-	return ret;
+	out_len = zstd_compress_cctx(ctx->cctx, dst, req->dlen, src, req->slen,
+				     &ctx->params);
+	if (zstd_is_error(out_len))
+		return -EINVAL;
+
+	*dlen = out_len;
+
+	return 0;
 }
 
-static void *zstd_alloc_ctx(void)
+static int zstd_compress(struct acomp_req *req)
 {
-	int ret;
+	struct crypto_acomp_stream *s;
+	unsigned int pos, scur, dcur;
+	unsigned int total_out = 0;
+	bool data_available = true;
+	zstd_out_buffer outbuf;
+	struct acomp_walk walk;
+	zstd_in_buffer inbuf;
 	struct zstd_ctx *ctx;
+	size_t pending_bytes;
+	size_t num_bytes;
+	int ret;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
+	s = crypto_acomp_lock_stream_bh(&zstd_streams);
+	ctx = s->ctx;
+
+	ret = acomp_walk_virt(&walk, req, true);
+	if (ret)
+		goto out;
 
-	ret = __zstd_init(ctx);
-	if (ret) {
-		kfree(ctx);
-		return ERR_PTR(ret);
+	ctx->cctx = zstd_init_cstream(&ctx->params, 0, ctx->wksp, ctx->wksp_size);
+	if (!ctx->cctx) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	return ctx;
-}
+	do {
+		dcur = acomp_walk_next_dst(&walk);
+		if (!dcur) {
+			ret = -ENOSPC;
+			goto out;
+		}
 
-static void __zstd_exit(void *ctx)
-{
-	zstd_comp_exit(ctx);
-	zstd_decomp_exit(ctx);
-}
+		outbuf.pos = 0;
+		outbuf.dst = (u8 *)walk.dst.virt.addr;
+		outbuf.size = dcur;
 
-static void zstd_free_ctx(void *ctx)
-{
-	__zstd_exit(ctx);
-	kfree_sensitive(ctx);
-}
+		do {
+			scur = acomp_walk_next_src(&walk);
+			if (dcur == req->dlen && scur == req->slen) {
+				ret = zstd_compress_one(req, ctx, walk.src.virt.addr,
+							walk.dst.virt.addr, &total_out);
+				acomp_walk_done_src(&walk, scur);
+				acomp_walk_done_dst(&walk, dcur);
+				goto out;
+			}
 
-static int __zstd_compress(const u8 *src, unsigned int slen,
-			   u8 *dst, unsigned int *dlen, void *ctx)
-{
-	size_t out_len;
-	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_params();
+			if (scur) {
+				inbuf.pos = 0;
+				inbuf.src = walk.src.virt.addr;
+				inbuf.size = scur;
+			} else {
+				data_available = false;
+				break;
+			}
 
-	out_len = zstd_compress_cctx(zctx->cctx, dst, *dlen, src, slen, &params);
-	if (zstd_is_error(out_len))
-		return -EINVAL;
-	*dlen = out_len;
-	return 0;
-}
+			num_bytes = zstd_compress_stream(ctx->cctx, &outbuf, &inbuf);
+			if (ZSTD_isError(num_bytes)) {
+				ret = -EIO;
+				goto out;
+			}
 
-static int zstd_scompress(struct crypto_scomp *tfm, const u8 *src,
-			  unsigned int slen, u8 *dst, unsigned int *dlen,
-			  void *ctx)
-{
-	return __zstd_compress(src, slen, dst, dlen, ctx);
+			pending_bytes = zstd_flush_stream(ctx->cctx, &outbuf);
+			if (ZSTD_isError(pending_bytes)) {
+				ret = -EIO;
+				goto out;
+			}
+			acomp_walk_done_src(&walk, inbuf.pos);
+		} while (dcur != outbuf.pos);
+
+		total_out += outbuf.pos;
+		acomp_walk_done_dst(&walk, dcur);
+	} while (data_available);
+
+	pos = outbuf.pos;
+	num_bytes = zstd_end_stream(ctx->cctx, &outbuf);
+	if (ZSTD_isError(num_bytes))
+		ret = -EIO;
+	else
+		total_out += (outbuf.pos - pos);
+
+out:
+	if (ret)
+		req->dlen = 0;
+	else
+		req->dlen = total_out;
+
+	crypto_acomp_unlock_stream_bh(s);
+
+	return ret;
 }
 
-static int __zstd_decompress(const u8 *src, unsigned int slen,
-			     u8 *dst, unsigned int *dlen, void *ctx)
+static int zstd_decompress_one(struct acomp_req *req, struct zstd_ctx *ctx,
+			       const void *src, void *dst, unsigned int *dlen)
 {
 	size_t out_len;
-	struct zstd_ctx *zctx = ctx;
 
-	out_len = zstd_decompress_dctx(zctx->dctx, dst, *dlen, src, slen);
+	ctx->dctx = zstd_init_dctx(ctx->wksp, ctx->wksp_size);
+	if (!ctx->dctx)
+		return -EINVAL;
+
+	out_len = zstd_decompress_dctx(ctx->dctx, dst, req->dlen, src, req->slen);
 	if (zstd_is_error(out_len))
 		return -EINVAL;
+
 	*dlen = out_len;
+
 	return 0;
 }
 
-static int zstd_sdecompress(struct crypto_scomp *tfm, const u8 *src,
-			    unsigned int slen, u8 *dst, unsigned int *dlen,
-			    void *ctx)
+static int zstd_decompress(struct acomp_req *req)
 {
-	return __zstd_decompress(src, slen, dst, dlen, ctx);
-}
+	struct crypto_acomp_stream *s;
+	unsigned int total_out = 0;
+	unsigned int scur, dcur;
+	zstd_out_buffer outbuf;
+	struct acomp_walk walk;
+	zstd_in_buffer inbuf;
+	struct zstd_ctx *ctx;
+	size_t pending_bytes;
+	int ret;
 
-static struct scomp_alg scomp = {
-	.alloc_ctx		= zstd_alloc_ctx,
-	.free_ctx		= zstd_free_ctx,
-	.compress		= zstd_scompress,
-	.decompress		= zstd_sdecompress,
-	.base			= {
-		.cra_name	= "zstd",
-		.cra_driver_name = "zstd-scomp",
-		.cra_module	 = THIS_MODULE,
+	s = crypto_acomp_lock_stream_bh(&zstd_streams);
+	ctx = s->ctx;
+
+	ret = acomp_walk_virt(&walk, req, true);
+	if (ret)
+		goto out;
+
+	ctx->dctx = zstd_init_dstream(ZSTD_MAX_SIZE, ctx->wksp, ctx->wksp_size);
+	if (!ctx->dctx) {
+		ret = -EINVAL;
+		goto out;
 	}
+
+	do {
+		scur = acomp_walk_next_src(&walk);
+		if (scur) {
+			inbuf.pos = 0;
+			inbuf.size = scur;
+			inbuf.src = walk.src.virt.addr;
+		} else {
+			break;
+		}
+
+		do {
+			dcur = acomp_walk_next_dst(&walk);
+			if (dcur == req->dlen && scur == req->slen) {
+				ret = zstd_decompress_one(req, ctx, walk.src.virt.addr,
+							  walk.dst.virt.addr, &total_out);
+				acomp_walk_done_dst(&walk, dcur);
+				acomp_walk_done_src(&walk, scur);
+				goto out;
+			}
+
+			if (!dcur) {
+				ret = -ENOSPC;
+				goto out;
+			}
+
+			outbuf.pos = 0;
+			outbuf.dst = (u8 *)walk.dst.virt.addr;
+			outbuf.size = dcur;
+
+			pending_bytes = zstd_decompress_stream(ctx->dctx, &outbuf, &inbuf);
+			if (ZSTD_isError(pending_bytes)) {
+				ret = -EIO;
+				goto out;
+			}
+
+			total_out += outbuf.pos;
+
+			acomp_walk_done_dst(&walk, outbuf.pos);
+		} while (scur != inbuf.pos);
+
+		if (scur)
+			acomp_walk_done_src(&walk, scur);
+	} while (ret == 0);
+
+out:
+	if (ret)
+		req->dlen = 0;
+	else
+		req->dlen = total_out;
+
+	crypto_acomp_unlock_stream_bh(s);
+
+	return ret;
+}
+
+static struct acomp_alg zstd_acomp = {
+	.base = {
+		.cra_name = "zstd",
+		.cra_driver_name = "zstd-generic",
+		.cra_flags = CRYPTO_ALG_REQ_VIRT,
+		.cra_module = THIS_MODULE,
+	},
+	.init = zstd_init,
+	.exit = zstd_exit,
+	.compress = zstd_compress,
+	.decompress = zstd_decompress,
 };
 
 static int __init zstd_mod_init(void)
 {
-	return crypto_register_scomp(&scomp);
+	return crypto_register_acomp(&zstd_acomp);
 }
 
 static void __exit zstd_mod_fini(void)
 {
-	crypto_unregister_scomp(&scomp);
+	crypto_unregister_acomp(&zstd_acomp);
 }
 
 module_init(zstd_mod_init);
-- 
2.50.1


