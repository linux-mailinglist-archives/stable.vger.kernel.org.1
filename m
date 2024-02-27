Return-Path: <stable+bounces-25027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B7869765
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC21F21A10
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E471A13DBBC;
	Tue, 27 Feb 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZP4gSxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266513B2B4;
	Tue, 27 Feb 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043652; cv=none; b=eW9teb4Q/WTL8iojQtMjbPjloCjbyM8iHJXiymk6C4LgUDghMI6nSqqL9jtE/pG6R44fZQ+MZPeik6ei4eLkXKsd9MljJxNir5triYj9hvQ2l8uyNSlBME9wyFqTAoTYcZ45gVbvyp/HYCzLhz8dcVZGCtuC8/eJf0b5SR/r/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043652; c=relaxed/simple;
	bh=VdpT+kH6kgKWc017BI9c9ZH/U+2TiD3U2Kb55LdhERI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYv3O1is99Sk27K1g0xhZ4Sqxv5Ujvrsijve/o6td8MS1sBuCwJIcQloUSCsvlS3KhWVdZm8GJpzGYgGyNle41CZrYCwnobxfFgw0N/m1DMe9a1MAIaZofXeVzEV4VczJm9iRCn3OFjRje7n8WdRjoQYwLZzuSoutuOPHj/V3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZP4gSxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DED2C433F1;
	Tue, 27 Feb 2024 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043652;
	bh=VdpT+kH6kgKWc017BI9c9ZH/U+2TiD3U2Kb55LdhERI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZP4gSxgnS/dkkStJ7s7ia6XF+k66lZmB0JzAgAf72nV6A8Ff2y4gXz+Wk19PiUWG
	 xoMv+FEfZ6cnM0gsRlyYJ/XRpwBsGYz1G+6Sy1oVzsKIElsTEeiyQA3ARsERS5cvU4
	 gs2K5wVS2GCQv19cYTGwxJa06KhXsfQ02Gaqb2kE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH 6.1 185/195] erofs: simplify compression configuration parser
Date: Tue, 27 Feb 2024 14:27:26 +0100
Message-ID: <20240227131616.510268400@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit efb4fb02cef3ab410b603c8f0e1c67f61d55f542 upstream.

Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
a callback instead of a hard-coded switch for each algorithm for
simplicity.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231022130957.11398-1-xiang@kernel.org
Stable-dep-of: 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/compress.h          |    4 ++
 fs/erofs/decompressor.c      |   60 ++++++++++++++++++++++++++++++++++-
 fs/erofs/decompressor_lzma.c |    4 +-
 fs/erofs/internal.h          |   28 +---------------
 fs/erofs/super.c             |   72 +++++--------------------------------------
 5 files changed, 76 insertions(+), 92 deletions(-)

--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -21,6 +21,8 @@ struct z_erofs_decompress_req {
 };
 
 struct z_erofs_decompressor {
+	int (*config)(struct super_block *sb, struct erofs_super_block *dsb,
+		      void *data, int size);
 	int (*decompress)(struct z_erofs_decompress_req *rq,
 			  struct page **pagepool);
 	char *name;
@@ -93,6 +95,8 @@ int z_erofs_decompress(struct z_erofs_de
 		       struct page **pagepool);
 
 /* prototypes for specific algorithms */
+int z_erofs_load_lzma_config(struct super_block *sb,
+			struct erofs_super_block *dsb, void *data, int size);
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			    struct page **pagepool);
 #endif
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -24,11 +24,11 @@ struct z_erofs_lz4_decompress_ctx {
 	unsigned int oend;
 };
 
-int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb,
-			    struct z_erofs_lz4_cfgs *lz4, int size)
+static int z_erofs_load_lz4_config(struct super_block *sb,
+			    struct erofs_super_block *dsb, void *data, int size)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct z_erofs_lz4_cfgs *lz4 = data;
 	u16 distance;
 
 	if (lz4) {
@@ -374,17 +374,71 @@ static struct z_erofs_decompressor decom
 		.name = "interlaced"
 	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
+		.config = z_erofs_load_lz4_config,
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
 	[Z_EROFS_COMPRESSION_LZMA] = {
+		.config = z_erofs_load_lzma_config,
 		.decompress = z_erofs_lzma_decompress,
 		.name = "lzma"
 	},
 #endif
 };
 
+int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	unsigned int algs, alg;
+	erofs_off_t offset;
+	int size, ret = 0;
+
+	if (!erofs_sb_has_compr_cfgs(sbi)) {
+		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
+		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	}
+
+	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
+		erofs_err(sb, "unidentified algorithms %x, please upgrade kernel",
+			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
+		return -EOPNOTSUPP;
+	}
+
+	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
+	alg = 0;
+	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+		void *data;
+
+		if (!(algs & 1))
+			continue;
+
+		data = erofs_read_metadata(sb, &buf, &offset, &size);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			break;
+		}
+
+		if (alg >= ARRAY_SIZE(decompressors) ||
+		    !decompressors[alg].config) {
+			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
+				  alg);
+			ret = -EOPNOTSUPP;
+		} else {
+			ret = decompressors[alg].config(sb,
+					dsb, data, size);
+		}
+
+		kfree(data);
+		if (ret)
+			break;
+	}
+	erofs_put_metabuf(&buf);
+	return ret;
+}
+
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct page **pagepool)
 {
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -72,10 +72,10 @@ int z_erofs_lzma_init(void)
 }
 
 int z_erofs_load_lzma_config(struct super_block *sb,
-			     struct erofs_super_block *dsb,
-			     struct z_erofs_lzma_cfgs *lzma, int size)
+			struct erofs_super_block *dsb, void *data, int size)
 {
 	static DEFINE_MUTEX(lzma_resize_mutex);
+	struct z_erofs_lzma_cfgs *lzma = data;
 	unsigned int dict_size, i;
 	struct z_erofs_lzma *strm, *head = NULL;
 	int err;
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -471,6 +471,8 @@ struct erofs_map_dev {
 
 /* data.c */
 extern const struct file_operations erofs_file_fops;
+void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
+			  erofs_off_t *offset, int *lengthp);
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
 void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
@@ -565,9 +567,7 @@ void z_erofs_exit_zip_subsystem(void);
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
 int erofs_try_to_free_cached_page(struct page *page);
-int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb,
-			    struct z_erofs_lz4_cfgs *lz4, int len);
+int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -575,36 +575,14 @@ static inline int erofs_init_shrinker(vo
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
-static inline int z_erofs_load_lz4_config(struct super_block *sb,
-				  struct erofs_super_block *dsb,
-				  struct z_erofs_lz4_cfgs *lz4, int len)
-{
-	if (lz4 || dsb->u1.lz4_max_distance) {
-		erofs_err(sb, "lz4 algorithm isn't enabled");
-		return -EINVAL;
-	}
-	return 0;
-}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
 int z_erofs_lzma_init(void);
 void z_erofs_lzma_exit(void);
-int z_erofs_load_lzma_config(struct super_block *sb,
-			     struct erofs_super_block *dsb,
-			     struct z_erofs_lzma_cfgs *lzma, int size);
 #else
 static inline int z_erofs_lzma_init(void) { return 0; }
 static inline int z_erofs_lzma_exit(void) { return 0; }
-static inline int z_erofs_load_lzma_config(struct super_block *sb,
-			     struct erofs_super_block *dsb,
-			     struct z_erofs_lzma_cfgs *lzma, int size) {
-	if (lzma) {
-		erofs_err(sb, "lzma algorithm isn't enabled");
-		return -EINVAL;
-	}
-	return 0;
-}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* flags for erofs_fscache_register_cookie() */
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -126,8 +126,8 @@ static bool check_layout_compatibility(s
 
 #ifdef CONFIG_EROFS_FS_ZIP
 /* read variable-sized metadata, offset will be aligned by 4-byte */
-static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
-				 erofs_off_t *offset, int *lengthp)
+void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
+			  erofs_off_t *offset, int *lengthp)
 {
 	u8 *buffer, *ptr;
 	int len, i, cnt;
@@ -159,64 +159,15 @@ static void *erofs_read_metadata(struct
 	}
 	return buffer;
 }
-
-static int erofs_load_compr_cfgs(struct super_block *sb,
-				 struct erofs_super_block *dsb)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int algs, alg;
-	erofs_off_t offset;
-	int size, ret = 0;
-
-	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
-	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
-		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
-			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
-		return -EINVAL;
-	}
-
-	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
-	alg = 0;
-	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
-		void *data;
-
-		if (!(algs & 1))
-			continue;
-
-		data = erofs_read_metadata(sb, &buf, &offset, &size);
-		if (IS_ERR(data)) {
-			ret = PTR_ERR(data);
-			break;
-		}
-
-		switch (alg) {
-		case Z_EROFS_COMPRESSION_LZ4:
-			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
-			break;
-		case Z_EROFS_COMPRESSION_LZMA:
-			ret = z_erofs_load_lzma_config(sb, dsb, data, size);
-			break;
-		default:
-			DBG_BUGON(1);
-			ret = -EFAULT;
-		}
-		kfree(data);
-		if (ret)
-			break;
-	}
-	erofs_put_metabuf(&buf);
-	return ret;
-}
 #else
-static int erofs_load_compr_cfgs(struct super_block *sb,
-				 struct erofs_super_block *dsb)
+static int z_erofs_parse_cfgs(struct super_block *sb,
+			      struct erofs_super_block *dsb)
 {
-	if (dsb->u1.available_compr_algs) {
-		erofs_err(sb, "try to load compressed fs when compression is disabled");
-		return -EINVAL;
-	}
-	return 0;
+	if (!dsb->u1.available_compr_algs)
+		return 0;
+
+	erofs_err(sb, "compression disabled, unable to mount compressed EROFS");
+	return -EOPNOTSUPP;
 }
 #endif
 
@@ -398,10 +349,7 @@ static int erofs_read_superblock(struct
 	}
 
 	/* parse on-disk compression configurations */
-	if (erofs_sb_has_compr_cfgs(sbi))
-		ret = erofs_load_compr_cfgs(sb, dsb);
-	else
-		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
 		goto out;
 



