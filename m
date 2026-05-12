Return-Path: <stable+bounces-245419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCUHMcXdAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:59:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA251C4DB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92D343075245
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D3481674;
	Tue, 12 May 2026 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="QMUz3MML"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C8384CDA;
	Tue, 12 May 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572486; cv=none; b=jVFD3DD4IPu+gc99EFeI4kHUCZhkq0kWOqGu/lhTz0FqMQuNXfIyJlqz3mH47vT6i8IHHTWWb3dhH7BgL2o9QvRgOs5psCrn8wRfVXf+gD9ZaXP4eEck6WS1vlqPmqHgMQFPTUXF+PcNXV8G4blAlmYXGRGexJ9HMi0/+hROAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572486; c=relaxed/simple;
	bh=BBd3oPN/GygXJFiJyRdVBk9Kwg5oz3+YzlP56uzXf08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC5mLi7VSfQRwB7WQWvx53vLaKwAMAgXQV/TxrhUxawOi2eRKVJYCIPySHzX8YnQMlUj6M5AZTb0yK91cs6vpL0wx1RMp4axwqYkd3CY3cTn4btthzWNhQjo71H84dhfOzPuynBfejU9N7v9L7Q5SHd/d0OeOuojIEhLpw7CTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=QMUz3MML; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QMUz3MMLPvxdB5oHjT4ogZDWz3xKRGKowz9u/DXHgfZ1+3wxjPXNOX7/QEI2lFz6YCyYdw+0BfGJX
	 BaQlh4DPAJA7pnwAORq5UVC3lpqvsEitZwxrm9js9+NxBDG1LDRb8Jm1T0RY5G8a7j2ZHgeiTGq2sM
	 rwS3WZv9MTXdSk8E=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[183.241.54.211])
	by rmsmtp-lg-appmail-34-12048 (RichMail) with SMTP id 2f106a02dbb77b4-017d8;
	Tue, 12 May 2026 15:50:24 +0800 (CST)
X-RM-TRANSID:2f106a02dbb77b4-017d8
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lanbincn@139.com,
	zhiguo.niu@unisoc.com,
	baocong.liu@unisoc.com,
	chao@kernel.org,
	jaegeuk@kernel.org,
	daehojeong@google.com
Subject: [PATCH 6.1.y 2/2] f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
Date: Tue, 12 May 2026 15:50:10 +0800
Message-ID: <20260512075010.29584-3-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512075010.29584-1-lanbincn@139.com>
References: <20260512075010.29584-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CEA251C4DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,139.com,unisoc.com,kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245419-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_SPAM(0.00)[0.199];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unisoc.com:email,139.com:email,139.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 39868685c2a94a70762bc6d77dc81d781d05bff5 ]

The decompress_io_ctx may be released asynchronously after
I/O completion. If this file is deleted immediately after read,
and the kworker of processing post_read_wq has not been executed yet
due to high workloads, It is possible that the inode(f2fs_inode_info)
is evicted and freed before it is used f2fs_free_dic.

    The UAF case as below:
    Thread A                                      Thread B
    - f2fs_decompress_end_io
     - f2fs_put_dic
      - queue_work
        add free_dic work to post_read_wq
                                                   - do_unlink
                                                    - iput
                                                     - evict
                                                      - call_rcu
    This file is deleted after read.

    Thread C                                 kworker to process post_read_wq
    - rcu_do_batch
     - f2fs_free_inode
      - kmem_cache_free
     inode is freed by rcu
                                             - process_scheduled_works
                                              - f2fs_late_free_dic
                                               - f2fs_free_dic
                                                - f2fs_release_decomp_mem
                                      read (dic->inode)->i_compress_algorithm

This patch store compress_algorithm and sbi in dic to avoid inode UAF.

In addition, the previous solution is deprecated in [1] may cause system hang.
[1] https://lore.kernel.org/all/c36ab955-c8db-4a8b-a9d0-f07b5f426c3f@kernel.org

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ No changes are made to the code logic; F2FS_I_SB(dic->inode) is
replaced with dic->sbi in v6.1. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/f2fs/compress.c | 40 ++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h     |  2 ++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 656c11a821c2..a49baab05013 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -211,14 +211,14 @@ static int lzo_decompress_pages(struct decompress_io_ctx *dic)
 						dic->rbuf, &dic->rlen);
 	if (ret != LZO_E_OK) {
 		printk_ratelimited("%sF2FS-fs (%s): lzo decompress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id, ret);
+				KERN_ERR, dic->sbi->sb->s_id, ret);
 		return -EIO;
 	}
 
 	if (dic->rlen != PAGE_SIZE << dic->log_cluster_size) {
 		printk_ratelimited("%sF2FS-fs (%s): lzo invalid rlen:%zu, "
 					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
+					dic->sbi->sb->s_id,
 					dic->rlen,
 					PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
@@ -307,14 +307,14 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 						dic->clen, dic->rlen);
 	if (ret < 0) {
 		printk_ratelimited("%sF2FS-fs (%s): lz4 decompress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id, ret);
+				KERN_ERR, dic->sbi->sb->s_id, ret);
 		return -EIO;
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
 		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid ret:%d, "
 					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id, ret,
+					dic->sbi->sb->s_id, ret,
 					PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
@@ -437,7 +437,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 
 	workspace_size = zstd_dstream_workspace_bound(max_window_size);
 
-	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
+	workspace = f2fs_kvmalloc(dic->sbi,
 					workspace_size, GFP_NOFS);
 	if (!workspace)
 		return -ENOMEM;
@@ -445,7 +445,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 	stream = zstd_init_dstream(max_window_size, workspace, workspace_size);
 	if (!stream) {
 		printk_ratelimited("%sF2FS-fs (%s): %s zstd_init_dstream failed\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
+				KERN_ERR, dic->sbi->sb->s_id,
 				__func__);
 		kvfree(workspace);
 		return -EIO;
@@ -482,7 +482,7 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 	ret = zstd_decompress_stream(stream, &outbuf, &inbuf);
 	if (zstd_is_error(ret)) {
 		printk_ratelimited("%sF2FS-fs (%s): %s zstd_decompress_stream failed, ret: %d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
+				KERN_ERR, dic->sbi->sb->s_id,
 				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
@@ -490,7 +490,7 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 	if (dic->rlen != outbuf.pos) {
 		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD invalid rlen:%zu, "
 				"expected:%lu\n", KERN_ERR,
-				F2FS_I_SB(dic->inode)->sb->s_id,
+				dic->sbi->sb->s_id,
 				__func__, dic->rlen,
 				PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
@@ -759,7 +759,7 @@ static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
 
 void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	struct f2fs_sb_info *sbi = dic->sbi;
 	struct f2fs_inode_info *fi = F2FS_I(dic->inode);
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
@@ -832,7 +832,7 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 {
 	struct decompress_io_ctx *dic =
 			(struct decompress_io_ctx *)page_private(page);
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	struct f2fs_sb_info *sbi = dic->sbi;
 
 	dec_page_count(sbi, F2FS_RD_DATA);
 
@@ -1585,14 +1585,13 @@ static inline bool allow_memalloc_for_decomp(struct f2fs_sb_info *sbi,
 static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 		bool pre_alloc)
 {
-	const struct f2fs_compress_ops *cops =
-		f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
+	const struct f2fs_compress_ops *cops = f2fs_cops[dic->compress_algorithm];
 	int i;
 
-	if (!allow_memalloc_for_decomp(F2FS_I_SB(dic->inode), pre_alloc))
+	if (!allow_memalloc_for_decomp(dic->sbi, pre_alloc))
 		return 0;
 
-	dic->tpages = page_array_alloc(F2FS_I_SB(dic->inode), dic->cluster_size);
+	dic->tpages = page_array_alloc(dic->sbi, dic->cluster_size);
 	if (!dic->tpages)
 		return -ENOMEM;
 
@@ -1624,10 +1623,9 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
 		bool bypass_destroy_callback, bool pre_alloc)
 {
-	const struct f2fs_compress_ops *cops =
-		f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
+	const struct f2fs_compress_ops *cops = f2fs_cops[dic->compress_algorithm];
 
-	if (!allow_memalloc_for_decomp(F2FS_I_SB(dic->inode), pre_alloc))
+	if (!allow_memalloc_for_decomp(dic->sbi, pre_alloc))
 		return;
 
 	if (!bypass_destroy_callback && cops->destroy_decompress_ctx)
@@ -1662,6 +1660,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 
 	dic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	dic->inode = cc->inode;
+	dic->sbi = sbi;
+	dic->compress_algorithm = F2FS_I(cc->inode)->i_compress_algorithm;
 	atomic_set(&dic->remaining_pages, cc->nr_cpages);
 	dic->cluster_idx = cc->cluster_idx;
 	dic->cluster_size = cc->cluster_size;
@@ -1710,7 +1710,8 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 		bool bypass_destroy_callback)
 {
 	int i;
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	/* use sbi in dic to avoid UFA of dic->inode*/
+	struct f2fs_sb_info *sbi = dic->sbi;
 
 	f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
 
@@ -1753,8 +1754,7 @@ static void f2fs_put_dic(struct decompress_io_ctx *dic, bool in_task)
 			f2fs_free_dic(dic, false);
 		} else {
 			INIT_WORK(&dic->free_work, f2fs_late_free_dic);
-			queue_work(F2FS_I_SB(dic->inode)->post_read_wq,
-					&dic->free_work);
+			queue_work(dic->sbi->post_read_wq, &dic->free_work);
 		}
 	}
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bbb86e215698..faa6efe1ceaf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1546,6 +1546,7 @@ struct compress_io_ctx {
 struct decompress_io_ctx {
 	u32 magic;			/* magic number to indicate page is compressed */
 	struct inode *inode;		/* inode the context belong to */
+	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	pgoff_t cluster_idx;		/* cluster index number */
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
@@ -1586,6 +1587,7 @@ struct decompress_io_ctx {
 
 	bool failed;			/* IO error occurred before decompression? */
 	bool need_verity;		/* need fs-verity verification after decompression? */
+	unsigned char compress_algorithm;	/* backup algorithm type */
 	void *private;			/* payload buffer for specified decompression algorithm */
 	void *private2;			/* extra payload buffer */
 	struct work_struct verity_work;	/* work to verify the decompressed pages */
-- 
2.43.0



