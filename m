Return-Path: <stable+bounces-196751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C41C81068
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CD23AB52A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B275311959;
	Mon, 24 Nov 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u7wezOZG"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647D30FF3A
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994549; cv=none; b=GKLd4mFArLY+KNKzbDKwIeeaGKyDbz9ghrc50np5+AaDZmW6lJoXUJk/xlYxeGdHnHW5a3vmEA6nxDdyx1mN/Z001i/TpTKqZUHO9J3Uhl5E/yALzmw6Yu7s5HI7gvOMRaLYrBSsR3fjtMMSwPD7RL6BLH8yoiosIEzHNKyJOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994549; c=relaxed/simple;
	bh=Id+g5VXmwq/LmgoXvuQZXthy0Ls3EXx+p0JsrLpzDvM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qeb6563LRAp+SKFsXgZC4vRpGYg99xM4A3dOcUibNpTr2EjMGSiCyx8DYkAP7dzT1VxpJAHOVfG1mkeQXjTxThoQw3JPj+rgNZ9dm9k8ms5FYqnJQcWg+qKsA9YSSlZIfdrLjPSHcCW+yFotT8e1Pq/+6Umw/BIcRW5cnTJEjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u7wezOZG; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763994541; bh=jb0a6asEzvoJ0tG6IQzazAteiqRe1gDXizw7Me/zePg=;
	h=From:To:Cc:Subject:Date;
	b=u7wezOZGHmHdGBWm4fkyNTjhyqZZh7yknQJ8/UNoH2m8PXlqf45DgoKbWmsA8t5k1
	 7iSwrjZWsIUw+nOrQmJmQSaNKt2mql8pYzeBmZStzOgrF2xPFGq6xV1QWD1WZzCaHw
	 4ZcnCsMoVwhvIvkrgcMbbt5FrIrhw2efmZR5CJWk=
Received: from mypc.corp.ad.wrs.com ([120.244.194.181])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 71595E2C; Mon, 24 Nov 2025 22:28:21 +0800
X-QQ-mid: xmsmtpt1763994501t2jrg7cbr
Message-ID: <tencent_1630890D7DB4D635EB1F549270D611385108@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQllxleqecII0HUrnQeJA0PfG8ja4Wdlh7Y/5txVtrXhfhQQgWVgJ
	 NWH062i1xaz8whLHVrmPiJMWEEQhrBwkSTqsswBgxDHUB6UrTc2t2ojBEuobDvxcQ0fgVjUJzsdd
	 q090W+gxrXO8UuZJMniir4PcWjH1157bO49vU0apyc8cvtOdJgUH0b+FHKhgDFtK+4gFqsm4ZRBl
	 sLvt6HvMkm87JX//U1hFZxjhSwu0znTsqnmHujCgvPZy6CgiB/qUPqWLdlS9ISF4BGVcj1VkpOFV
	 f81FfJaPokok0XypEopmZn3Q4YbYsB/YbF5dnW6urZSYJX4JAiiSfTDmiILCtqiMnymvXCmd8m3+
	 jiecjtriBybf3eel18bz8snWPKjOyP0H2gOvK3dd/AKspDjn1tyFZC4AFXOJ2OE3+aHUXibvSXsZ
	 FyuGBI8G5aJqzlKWCe6XrbL1qNt3QCQXZnA2njCIl7TJS0Fs8wJd0ARKXLwAJFjqlOQOmoJmLSQD
	 /5kUmZyuhL+G6sD4dWYzmyfystoZbuqxsuR1RSO1cJHrKYJdIWypf7o3muZCwQlmfAJHidNtzZCd
	 Ypr7+CXotVEiSa/MZXEdMDRvzDkofTbIUzVrO9S7Wn8gTDQqWwsWKLQKBR/O/hfTui6i4YBSENrn
	 3kLqwaCecrxBKoN2m6PzfcePSXuMRUO5wmr/U+Bsa5KfgdxYgotNbQPnkQKz36j+brf1a+hpAD2b
	 BukKy0k9hNuGn94v3hkAyi85QZUmiKI0UUh4U661Na7rs+XKiX5KyDR0WAXnNeKttLX3y8f2i586
	 4kGTWhRQjeW6Hv31EbzoxwCrnT35RkCGOLVarEUKl/+JlizE2XPuNPbZRqlQeqyfC57cQnT0I5LV
	 l92KiNpBavoxMkuEhv6VTm6QmQbA0RaUgY8y3h91vm482T+44TAaYxK7llTEJtuGY7HKc8O49r5P
	 WRQbT6xK4flR2BfFy/dQMNA3ec4ZVmwWq6iK2MoIE7K5UDjvGcsnhSh29LRADvdUOMXQ9WKFS7iT
	 hGJzl9/YtftsA8zzIksb7BgQU23BilcOYrroU4Kzq4SDE3qED6
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: lanbincn@qq.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Baocong Liu <baocong.liu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.6.y 1/2] f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
Date: Mon, 24 Nov 2025 22:28:18 +0800
X-OQ-MSGID: <20251124142819.9043-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
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
Signed-off-by: Bin Lan <lanbincn@qq.com>
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


