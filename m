Return-Path: <stable+bounces-204122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC4CE7F40
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6634430019D4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD72D94AF;
	Mon, 29 Dec 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS+9Jj1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557C285CA9
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034475; cv=none; b=W6bz/6torE5SfqbZg0xlMekA7U7wTljQqincwPWLOpEfBblSsEz3YEhH4EHSW1KxF/KF64UFdTpMsBgVbMAmz8GdpLI4oZfykny687SU4xoZuqodq8RylU5x41BokD1WQ+nIaeRCj/ZEc8d8FxwtKOoOAPWyouk3kzWo+PbS/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034475; c=relaxed/simple;
	bh=z+RHR2pDkkYGDVoKY1ntelu/hN/i54qvlVq9b9KnwO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZxmuj60Ue8OcL0Pvcr8m+2plIda2mmLBBc1pE7Mp+ab/F3qqr/lItdATf9BPvWN+hwNS6JAEuHf4pfikvCHFw3hcLUg8+RXCpbG+UyApMUsNuqm3qP2owIYktPo5QuayH0bgyEr1svMzjJZWRO/Zfx1XJVOp9UDzRBLZBVEaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS+9Jj1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8A0C4CEF7;
	Mon, 29 Dec 2025 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767034474;
	bh=z+RHR2pDkkYGDVoKY1ntelu/hN/i54qvlVq9b9KnwO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VS+9Jj1K1HzvRy762xYPiwDzaSEPUw4IIzI4vjd9PmqbFIeMmIinGUTs6QG2BS/D+
	 gPHdp+lruVxO7rZ4uvRinKimYRlc2NCuNEue0PEJcwh9rSkLqSTM567Cl/nJPsiHCK
	 7KyC8Jl4vBjNFKH0zyrmZZjWs17eaWaIr6xlPiPgYIuv7sglGl+ZbSI7gG22FS7Yoz
	 xwb7B9y3l9Ri2eMkDdTFFxBEl5GCkhoji9efyP8PulMkAt6YTt9yo+Dmyudxc6232I
	 2kSC3ke++Eq/WCKN3DWVCN8oQ8gsZ1iwk/akTqkkmY47WM38wnbvzGvd4Uj0w7MFzC
	 uqMmDVnazCYOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] erofs: improve decompression error reporting
Date: Mon, 29 Dec 2025 13:54:31 -0500
Message-ID: <20251229185432.1616355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122915-kitchen-june-49ec@gregkh>
References: <2025122915-kitchen-june-49ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 831faabed8129246c9802af9ad9581a2c1e9eeb9 ]

Change the return type of decompress() from `int` to `const char *` to
provide more informative error diagnostics:

 - A NULL return indicates successful decompression;

 - If IS_ERR(ptr) is true, the return value encodes a standard negative
   errno (e.g., -ENOMEM, -EOPNOTSUPP) identifying the specific error;

 - Otherwise, a non-NULL return points to a human-readable error string,
   and the corresponding error code should be treated as -EFSCORRUPTED.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: 4012d7856219 ("erofs: fix unexpected EIO under memory pressure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/compress.h             |  4 ++--
 fs/erofs/decompressor.c         | 20 +++++++++-----------
 fs/erofs/decompressor_deflate.c | 10 ++++------
 fs/erofs/decompressor_lzma.c    | 10 ++++------
 fs/erofs/decompressor_zstd.c    | 12 ++++--------
 fs/erofs/zdata.c                | 21 +++++++++++++++++----
 6 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 510e922c5193..1ee4ad934c1f 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -23,8 +23,8 @@ struct z_erofs_decompress_req {
 struct z_erofs_decompressor {
 	int (*config)(struct super_block *sb, struct erofs_super_block *dsb,
 		      void *data, int size);
-	int (*decompress)(struct z_erofs_decompress_req *rq,
-			  struct page **pagepool);
+	const char *(*decompress)(struct z_erofs_decompress_req *rq,
+				  struct page **pagepool);
 	int (*init)(void);
 	void (*exit)(void);
 	char *name;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 354762c9723f..2d6b765dae65 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -228,8 +228,6 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 					  rq->inputsize, rq->outputsize);
 
 	if (ret != rq->outputsize) {
-		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
-			  ret, rq->inputsize, inputmargin, rq->outputsize);
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EFSCORRUPTED;
@@ -250,8 +248,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 	return ret;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
-				  struct page **pagepool)
+static const char *z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
+					  struct page **pagepool)
 {
 	unsigned int dst_maptype;
 	void *dst;
@@ -266,14 +264,14 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 		/* general decoding path which can be used for all cases */
 		ret = z_erofs_lz4_prepare_dstpages(rq, pagepool);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 		if (ret > 0) {
 			dst = page_address(*rq->out);
 			dst_maptype = 1;
 		} else {
 			dst = erofs_vm_map_ram(rq->out, rq->outpages);
 			if (!dst)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 			dst_maptype = 2;
 		}
 	}
@@ -282,11 +280,11 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 		kunmap_local(dst);
 	else if (dst_maptype == 2)
 		vm_unmap_ram(dst, rq->outpages);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
-				   struct page **pagepool)
+static const char *z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
+					   struct page **pagepool)
 {
 	const unsigned int nrpages_in = rq->inpages, nrpages_out = rq->outpages;
 	const unsigned int bs = rq->sb->s_blocksize;
@@ -294,7 +292,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	u8 *kin;
 
 	if (rq->outputsize > rq->inputsize)
-		return -EOPNOTSUPP;
+		return ERR_PTR(-EOPNOTSUPP);
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		cur = bs - (rq->pageofs_out & (bs - 1));
 		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
@@ -334,7 +332,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		kunmap_local(kin);
 	}
 	DBG_BUGON(ni > nrpages_in);
-	return 0;
+	return NULL;
 }
 
 int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 6909b2d529c7..e9c4b740ef89 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -157,8 +157,6 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				break;
 			if (zerr == Z_STREAM_END && !rq->outputsize)
 				break;
-			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
-				  zerr, rq->inputsize, rq->outputsize);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -178,8 +176,8 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	return err;
 }
 
-static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-				      struct page **pgpl)
+static const char *z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+					      struct page **pgpl)
 {
 #ifdef CONFIG_EROFS_FS_ZIP_ACCEL
 	int err;
@@ -187,11 +185,11 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	if (!rq->partial_decoding) {
 		err = z_erofs_crypto_decompress(rq, pgpl);
 		if (err != -EOPNOTSUPP)
-			return err;
+			return ERR_PTR(err);
 
 	}
 #endif
-	return __z_erofs_deflate_decompress(rq, pgpl);
+	return ERR_PTR(__z_erofs_deflate_decompress(rq, pgpl));
 }
 
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 832cffb83a66..7784ced90145 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -146,8 +146,8 @@ static int z_erofs_load_lzma_config(struct super_block *sb,
 	return err;
 }
 
-static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-				   struct page **pgpl)
+static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
+					   struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
@@ -162,7 +162,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
 		kunmap_local(dctx.kin);
-		return err;
+		return ERR_PTR(err);
 	}
 
 	/* 2. get an available lzma context */
@@ -207,8 +207,6 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 		if (xz_err != XZ_OK) {
 			if (xz_err == XZ_STREAM_END && !rq->outputsize)
 				break;
-			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
-				  xz_err, rq->inputsize, rq->outputsize);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -223,7 +221,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_lzma_head = strm;
 	spin_unlock(&z_erofs_lzma_lock);
 	wake_up(&z_erofs_lzma_wq);
-	return err;
+	return ERR_PTR(err);
 }
 
 const struct z_erofs_decompressor z_erofs_lzma_decomp = {
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index e38d93bb2104..50fadff89cbc 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -135,8 +135,8 @@ static int z_erofs_load_zstd_config(struct super_block *sb,
 	return strm ? -ENOMEM : 0;
 }
 
-static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
-				   struct page **pgpl)
+static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
+					   struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
@@ -152,7 +152,7 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
 		kunmap_local(dctx.kin);
-		return err;
+		return ERR_PTR(err);
 	}
 
 	/* 2. get an available ZSTD context */
@@ -191,10 +191,6 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 		if (zstd_is_error(zerr) ||
 		    ((rq->outputsize + dctx.avail_out) && (!zerr || (zerr > 0 &&
 				!(rq->inputsize + in_buf.size - in_buf.pos))))) {
-			erofs_err(sb, "failed to decompress in[%u] out[%u]: %s",
-				  rq->inputsize, rq->outputsize,
-				  zstd_is_error(zerr) ? zstd_get_error_name(zerr) :
-					"unexpected end of stream");
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -210,7 +206,7 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_zstd_head = strm;
 	spin_unlock(&z_erofs_zstd_lock);
 	wake_up(&z_erofs_zstd_wq);
-	return err;
+	return ERR_PTR(err);
 }
 
 const struct z_erofs_decompressor z_erofs_zstd_decomp = {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc80cfe482f7..461a929e0825 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1267,12 +1267,13 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	const struct z_erofs_decompressor *decomp =
+	const struct z_erofs_decompressor *alg =
 				z_erofs_decomp[pcl->algorithmformat];
+	bool try_free = true;
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
-	bool try_free = true;
+	const char *reason;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1304,8 +1305,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
 	if (err2)
 		err = err2;
-	if (!err)
-		err = decomp->decompress(&(struct z_erofs_decompress_req) {
+	if (!err) {
+		reason = alg->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
@@ -1322,6 +1323,18 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
+		if (IS_ERR(reason)) {
+			erofs_err(be->sb, "failed to decompress (%s) %ld @ pa %llu size %u => %u",
+				  alg->name, PTR_ERR(reason), pcl->pos,
+				  pcl->pclustersize, pcl->length);
+			err = PTR_ERR(reason);
+		} else if (unlikely(reason)) {
+			erofs_err(be->sb, "failed to decompress (%s) %s @ pa %llu size %u => %u",
+				  alg->name, reason, pcl->pos,
+				  pcl->pclustersize, pcl->length);
+			err = -EFSCORRUPTED;
+		}
+	}
 
 	/* must handle all compressed pages before actual file pages */
 	if (pcl->from_meta) {
-- 
2.51.0


