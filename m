Return-Path: <stable+bounces-23794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A218686F5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 03:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4845F291A47
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91C1241E7;
	Tue, 27 Feb 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8UzcXSY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9AB51C4B
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000654; cv=none; b=ZQlV7gy7a+vDiK+njchy3jZnumrepB+FZ5auq1dvdUlAV0V5kuG39GhENnZ11/4sbok0fIC+xwK8ylfadfesXhPi23cs3FeY/BbzcNvuncJccsrjBLpgx+I8mZQX1IvppM3bJQXnlG3GE+ic1g9x2Mr6E0CzDp0/SxPkA/jIbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000654; c=relaxed/simple;
	bh=jCp0YB828S4j3Ezz6B/1s5qbpKQ06dBKYiIU+VNJJHE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OJQf8DS6buXY9evs3xiQ8J9vFD1uGLYw+nAEUrNUENWYvlt6gwALbI4/4cLnduzrGt7+JuAZzMeilb7bpvANwSOeZIbmDRbzl/oW35eYRVoieYHRNat9KieDnzMt7f2HkHyXCUGk0uAUU610DbBt7ElVQUNyA0442NRY+iTW0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8UzcXSY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49b00bdbso32639235ad.3
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 18:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709000652; x=1709605452; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6ULuKN4kS8dCJ/7hUI9GNVzpimveZKelUff+llwZ0Y=;
        b=R8UzcXSYUakvTZtgJBJGR7yZq92JPDYVEWTv67VcmwuSXVS1CYMmn8xwkuJCpHC0Mg
         inYc0tSSov2ZvPHSOI2IpA95cE92Z2nuPfvPB/GaEqzzoVQ0nIlVGUNKhbXxFJSYy4kD
         IYAqflwgSmfOQEO8kziRUow9tgv8tdImy/8wWqdDSOcqkcWcdi23vs7Dza8+Hn+MbDyb
         GjlHbMNDaqNF9lgLspPLiZv+mXL/3/e6MfZG1Z2yXEqj8m2UGvEF4cxZRVAyAMq4wM5J
         46vyhTtANdDVOvvPZtyPwU0vd0PpqXiWSeWKaSakvVdnBUnp/KIZVGIQtJciarHv4ue9
         b/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000652; x=1709605452;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6ULuKN4kS8dCJ/7hUI9GNVzpimveZKelUff+llwZ0Y=;
        b=wm0rzIRydCTlDVuNG8m12THNcoH7dx5sIpLzBs3lt97ek8E1Z3g7CSUQVqlkMj8Ya+
         7eSAaSi0KPRESWTgT56Y2AQtRuM5QHuIQdZ2rwl9jJABuD4wrl7iwOwof+oHrLnJ64n0
         WpsNubhjobF+qie9rfMCtkht8RZqPghWS9EWSljOfgpuHal9IdeDWWZgD5N+/3/CrhYR
         8sEU5n1MtNsPLRs3gvsFomTuvziLCqpBvD19T2hZ37mIrbwu3lg6j4ewvXKIg6/1crGR
         Xaifw227wgcyKm2sOoJHAFkgDy/rnJLdS6pi60gwmgZoR/eJ5O4M2OrT/UQh6A/fM8qR
         4t4A==
X-Gm-Message-State: AOJu0YypAjMMIN7mE3xrX7WHTiS/l8R0ABiqoT950f1fYjH1csyfxOqH
	fqd8Y9qNyrPem9KNSegB+Nk/PK9XZBBhH7qkjg7OVxO/WkG/fTTBPjQbS9Esedo=
X-Google-Smtp-Source: AGHT+IH8ICqaWLKqgpuIPudYDXHUstOacTnMbJV74nmBO+ID0OyseAqKQuZD8qHShr+TYlK3tPa2VQ==
X-Received: by 2002:a17:902:aa42:b0:1dc:771f:ae56 with SMTP id c2-20020a170902aa4200b001dc771fae56mr7953199plr.29.1709000651650;
        Mon, 26 Feb 2024 18:24:11 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001db3a0c5299sm357341plb.35.2024.02.26.18.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:24:11 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	zhangwen@coolpad.com,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH 6.1.y 1/2] erofs: simplify compression configuration parser
Date: Tue, 27 Feb 2024 10:22:38 +0800
Message-Id: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit efb4fb02cef3ab410b603c8f0e1c67f61d55f542 ]

Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
a callback instead of a hard-coded switch for each algorithm for
simplicity.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231022130957.11398-1-xiang@kernel.org
Stable-dep-of: 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h          |  4 ++
 fs/erofs/decompressor.c      | 60 ++++++++++++++++++++++++++++--
 fs/erofs/decompressor_lzma.c |  4 +-
 fs/erofs/internal.h          | 28 ++------------
 fs/erofs/super.c             | 72 +++++-------------------------------
 5 files changed, 76 insertions(+), 92 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..c4a3187bdb8f 100644
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
@@ -93,6 +95,8 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct page **pagepool);
 
 /* prototypes for specific algorithms */
+int z_erofs_load_lzma_config(struct super_block *sb,
+			struct erofs_super_block *dsb, void *data, int size);
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			    struct page **pagepool);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 0cfad74374ca..ae3cfd018d99 100644
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
@@ -374,17 +374,71 @@ static struct z_erofs_decompressor decompressors[] = {
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
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 49addc345aeb..970464c4b676 100644
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
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d8d09fc3ed65..79a7a5815ea6 100644
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
@@ -575,36 +575,14 @@ static inline int erofs_init_shrinker(void) { return 0; }
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
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bd8bf8fc2f5d..f2647126cb2f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -126,8 +126,8 @@ static bool check_layout_compatibility(struct super_block *sb,
 
 #ifdef CONFIG_EROFS_FS_ZIP
 /* read variable-sized metadata, offset will be aligned by 4-byte */
-static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
-				 erofs_off_t *offset, int *lengthp)
+void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
+			  erofs_off_t *offset, int *lengthp)
 {
 	u8 *buffer, *ptr;
 	int len, i, cnt;
@@ -159,64 +159,15 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
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
 
@@ -398,10 +349,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	/* parse on-disk compression configurations */
-	if (erofs_sb_has_compr_cfgs(sbi))
-		ret = erofs_load_compr_cfgs(sb, dsb);
-	else
-		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
 		goto out;
 
-- 
2.17.1


