Return-Path: <stable+bounces-196866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D2C8384D
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 07:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96A43AE2FE
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC829ACF7;
	Tue, 25 Nov 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="H+P+AEMp"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A987429992B
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053034; cv=none; b=LaAYkr1i53/BfgmboGK639iDkYj+4Ap9QEt7LHZ9UzGq4Coh9KyAnN0JJoeoJNEbfbEQD6Gm0zQTR7ySwSY83z5S0biWf6yHWrREpkum4lkufjzKrB5zkXa6MfiW7GXv/9mNn5CVoce/4fi5tLVThRZNPiNO67b7EAG5JPwZ1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053034; c=relaxed/simple;
	bh=07stOo+Tqoiwvfe9Dolg2PfK7T8Whl5Btn8i+Nm+Qnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPZR77EUKoxVZWc01GMcNFTi7s0jWLFOH8pQlCzpFIykuZ1IGn/hG/e466bZegCz333+tXs23Z03QwuDlPu7Clyeb2tyDDzjK9w1GPADmeH522jLjWf2bhINN9frvjJuwEHwEhz0IgF5BspJ6FAY7DrV48WT4+rRq8teIs2+7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=H+P+AEMp; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=H+P+AEMp4q96KIXl1+DiqcVYI6S+nY+7YwLf9BB1O8N6bFHLjUXrLwJuXFj3fi8cczHpqPiC+COJI
	 YGGZOCONakcKFy49hElbQnsT2eGoedrbmJ5dQTV4EYzP6tl59LGdLAa+vumi5uc6Xb0/+KNCpmmj9I
	 Q7ug36tBfFCgePHk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.. (unknown[2409:8A00:DD3:9760:BE5:1C94:7DAF:B08E])
	by rmsmtp-lg-appmail-43-12057 (RichMail) with SMTP id 2f1969254f5df31-6f146;
	Tue, 25 Nov 2025 14:40:34 +0800 (CST)
X-RM-TRANSID:2f1969254f5df31-6f146
From: lanbincn@139.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Baocong Liu <baocong.liu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.6.y 1/2] f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
Date: Tue, 25 Nov 2025 06:40:27 +0000
Message-ID: <20251125064028.3295-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 8e2a9b656474d67c55010f2c003ea2cf889a19ff ]

No logic changes, just cleanup and prepare for fixing the UAF issue
in f2fs_free_dic.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/f2fs/compress.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e962de4ecaa2..3a0d0adc4736 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -23,20 +23,18 @@
 static struct kmem_cache *cic_entry_slab;
 static struct kmem_cache *dic_entry_slab;
 
-static void *page_array_alloc(struct inode *inode, int nr)
+static void *page_array_alloc(struct f2fs_sb_info *sbi, int nr)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int size = sizeof(struct page *) * nr;
 
 	if (likely(size <= sbi->page_array_slab_size))
 		return f2fs_kmem_cache_alloc(sbi->page_array_slab,
-					GFP_F2FS_ZERO, false, F2FS_I_SB(inode));
+					GFP_F2FS_ZERO, false, sbi);
 	return f2fs_kzalloc(sbi, size, GFP_NOFS);
 }
 
-static void page_array_free(struct inode *inode, void *pages, int nr)
+static void page_array_free(struct f2fs_sb_info *sbi, void *pages, int nr)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int size = sizeof(struct page *) * nr;
 
 	if (!pages)
@@ -145,13 +143,13 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
 	if (cc->rpages)
 		return 0;
 
-	cc->rpages = page_array_alloc(cc->inode, cc->cluster_size);
+	cc->rpages = page_array_alloc(F2FS_I_SB(cc->inode), cc->cluster_size);
 	return cc->rpages ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 {
-	page_array_free(cc->inode, cc->rpages, cc->cluster_size);
+	page_array_free(F2FS_I_SB(cc->inode), cc->rpages, cc->cluster_size);
 	cc->rpages = NULL;
 	cc->nr_rpages = 0;
 	cc->nr_cpages = 0;
@@ -614,6 +612,7 @@ static void *f2fs_vmap(struct page **pages, unsigned int count)
 
 static int f2fs_compress_pages(struct compress_ctx *cc)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
 	const struct f2fs_compress_ops *cops =
 				f2fs_cops[fi->i_compress_algorithm];
@@ -634,7 +633,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
 	cc->valid_nr_cpages = cc->nr_cpages;
 
-	cc->cpages = page_array_alloc(cc->inode, cc->nr_cpages);
+	cc->cpages = page_array_alloc(sbi, cc->nr_cpages);
 	if (!cc->cpages) {
 		ret = -ENOMEM;
 		goto destroy_compress_ctx;
@@ -709,7 +708,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		if (cc->cpages[i])
 			f2fs_compress_free_page(cc->cpages[i]);
 	}
-	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	page_array_free(sbi, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 destroy_compress_ctx:
 	if (cops->destroy_compress_ctx)
@@ -1302,7 +1301,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
 	atomic_set(&cic->pending_pages, cc->valid_nr_cpages);
-	cic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
+	cic->rpages = page_array_alloc(sbi, cc->cluster_size);
 	if (!cic->rpages)
 		goto out_put_cic;
 
@@ -1395,13 +1394,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	spin_unlock(&fi->i_size_lock);
 
 	f2fs_put_rpages(cc);
-	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	page_array_free(sbi, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 	f2fs_destroy_compress_ctx(cc, false);
 	return 0;
 
 out_destroy_crypt:
-	page_array_free(cc->inode, cic->rpages, cc->cluster_size);
+	page_array_free(sbi, cic->rpages, cc->cluster_size);
 
 	for (--i; i >= 0; i--)
 		fscrypt_finalize_bounce_page(&cc->cpages[i]);
@@ -1419,7 +1418,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		f2fs_compress_free_page(cc->cpages[i]);
 		cc->cpages[i] = NULL;
 	}
-	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	page_array_free(sbi, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 	return -EAGAIN;
 }
@@ -1449,7 +1448,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 		end_page_writeback(cic->rpages[i]);
 	}
 
-	page_array_free(cic->inode, cic->rpages, cic->nr_rpages);
+	page_array_free(sbi, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
 }
 
@@ -1587,7 +1586,7 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 	if (!allow_memalloc_for_decomp(F2FS_I_SB(dic->inode), pre_alloc))
 		return 0;
 
-	dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
+	dic->tpages = page_array_alloc(F2FS_I_SB(dic->inode), dic->cluster_size);
 	if (!dic->tpages)
 		return -ENOMEM;
 
@@ -1647,7 +1646,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
-	dic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
+	dic->rpages = page_array_alloc(sbi, cc->cluster_size);
 	if (!dic->rpages) {
 		kmem_cache_free(dic_entry_slab, dic);
 		return ERR_PTR(-ENOMEM);
@@ -1668,7 +1667,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->rpages[i] = cc->rpages[i];
 	dic->nr_rpages = cc->cluster_size;
 
-	dic->cpages = page_array_alloc(dic->inode, dic->nr_cpages);
+	dic->cpages = page_array_alloc(sbi, dic->nr_cpages);
 	if (!dic->cpages) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -1698,6 +1697,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 		bool bypass_destroy_callback)
 {
 	int i;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
 
 	f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
 
@@ -1709,7 +1709,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 				continue;
 			f2fs_compress_free_page(dic->tpages[i]);
 		}
-		page_array_free(dic->inode, dic->tpages, dic->cluster_size);
+		page_array_free(sbi, dic->tpages, dic->cluster_size);
 	}
 
 	if (dic->cpages) {
@@ -1718,10 +1718,10 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 				continue;
 			f2fs_compress_free_page(dic->cpages[i]);
 		}
-		page_array_free(dic->inode, dic->cpages, dic->nr_cpages);
+		page_array_free(sbi, dic->cpages, dic->nr_cpages);
 	}
 
-	page_array_free(dic->inode, dic->rpages, dic->nr_rpages);
+	page_array_free(sbi, dic->rpages, dic->nr_rpages);
 	kmem_cache_free(dic_entry_slab, dic);
 }
 
-- 
2.43.0



