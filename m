Return-Path: <stable+bounces-223298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGSqNHw+qmnGNwEAu9opvQ
	(envelope-from <stable+bounces-223298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:39:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB821AA8D
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3920230416C5
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 02:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3093352C39;
	Fri,  6 Mar 2026 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="3SWczC1i"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170725228D;
	Fri,  6 Mar 2026 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764777; cv=none; b=JwzQG9z9Bt8cwZtiqJ5808kO72BSnWDyAxiONZ6O7W25QTAWH9N6P26uWFwXKUJqGlrlASAFm+5tcypLYSoG/6ZYitb3BH34zVC/m2jTbubg8ZgeGivxs0tOPojet8e5KZEMPVZ3ASkH10XVMqsZtIl8m00N+QFIb6w0haqY2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764777; c=relaxed/simple;
	bh=qKHjz5SOFe+oiDo2v+rChvn+gpwiRe6obrGWjO8qHR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L9gKdDtWU1d0iWee7JdLvFTAcs4WHINwz7np6QrHzURfQRW4UgPaQfSq/ZHFgNUrYc3fl3ETeegp54RRxdVrOg1Itf+P0MSuNw+Rmeh23JYGpux6NquxIUih+LiC4TbMd2ynHnG94gvlWNq/UI9SLFR+9VmZn/8NzMpL1ztCa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=3SWczC1i; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=3SWczC1ikdpQGP91BT7wBf8haOS4f7GVb00ln+9GL4iaZSiIHizVNWKSuhfDIBYVsW35Y/3stzNkn
	 oh1nV5TzSGzksGqgygvJo25ndQTDspGHhQaYEVyWlRdu7Z65YEhD0mFeNDf/UbEupmIYW0zEA1dBrw
	 iKPsDCMx/uEbdLD0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-139-kernel-team (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-02-12080 (RichMail) with SMTP id 2f3069aa3e4f83a-058ae;
	Fri, 06 Mar 2026 10:39:23 +0800 (CST)
X-RM-TRANSID:2f3069aa3e4f83a-058ae
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Baocong Liu <baocong.liu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.12.y 1/2] f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
Date: Fri,  6 Mar 2026 10:38:45 +0800
Message-Id: <20260306023846.2147903-1-lanbincn@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41CB821AA8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223298-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,unisoc.com,kernel.org,139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.463];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
index 70bb5ded4fd6..60401a43b78d 100644
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
@@ -147,13 +145,13 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
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
@@ -616,6 +614,7 @@ static void *f2fs_vmap(struct page **pages, unsigned int count)
 
 static int f2fs_compress_pages(struct compress_ctx *cc)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
 	const struct f2fs_compress_ops *cops =
 				f2fs_cops[fi->i_compress_algorithm];
@@ -636,7 +635,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
 	cc->valid_nr_cpages = cc->nr_cpages;
 
-	cc->cpages = page_array_alloc(cc->inode, cc->nr_cpages);
+	cc->cpages = page_array_alloc(sbi, cc->nr_cpages);
 	if (!cc->cpages) {
 		ret = -ENOMEM;
 		goto destroy_compress_ctx;
@@ -711,7 +710,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		if (cc->cpages[i])
 			f2fs_compress_free_page(cc->cpages[i]);
 	}
-	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	page_array_free(sbi, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 destroy_compress_ctx:
 	if (cops->destroy_compress_ctx)
@@ -1325,7 +1324,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
 	atomic_set(&cic->pending_pages, cc->valid_nr_cpages);
-	cic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
+	cic->rpages = page_array_alloc(sbi, cc->cluster_size);
 	if (!cic->rpages)
 		goto out_put_cic;
 
@@ -1427,13 +1426,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
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
 
 	for (--i; i >= 0; i--) {
 		if (!cc->cpages[i])
@@ -1454,7 +1453,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		f2fs_compress_free_page(cc->cpages[i]);
 		cc->cpages[i] = NULL;
 	}
-	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	page_array_free(sbi, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 	return -EAGAIN;
 }
@@ -1484,7 +1483,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 		end_page_writeback(cic->rpages[i]);
 	}
 
-	page_array_free(cic->inode, cic->rpages, cic->nr_rpages);
+	page_array_free(sbi, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
 }
 
@@ -1623,7 +1622,7 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 	if (!allow_memalloc_for_decomp(F2FS_I_SB(dic->inode), pre_alloc))
 		return 0;
 
-	dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
+	dic->tpages = page_array_alloc(F2FS_I_SB(dic->inode), dic->cluster_size);
 	if (!dic->tpages)
 		return -ENOMEM;
 
@@ -1683,7 +1682,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
-	dic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
+	dic->rpages = page_array_alloc(sbi, cc->cluster_size);
 	if (!dic->rpages) {
 		kmem_cache_free(dic_entry_slab, dic);
 		return ERR_PTR(-ENOMEM);
@@ -1704,7 +1703,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->rpages[i] = cc->rpages[i];
 	dic->nr_rpages = cc->cluster_size;
 
-	dic->cpages = page_array_alloc(dic->inode, dic->nr_cpages);
+	dic->cpages = page_array_alloc(sbi, dic->nr_cpages);
 	if (!dic->cpages) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -1734,6 +1733,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 		bool bypass_destroy_callback)
 {
 	int i;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
 
 	f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
 
@@ -1745,7 +1745,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 				continue;
 			f2fs_compress_free_page(dic->tpages[i]);
 		}
-		page_array_free(dic->inode, dic->tpages, dic->cluster_size);
+		page_array_free(sbi, dic->tpages, dic->cluster_size);
 	}
 
 	if (dic->cpages) {
@@ -1754,10 +1754,10 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
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



