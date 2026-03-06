Return-Path: <stable+bounces-223299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODGQAYM+qmnGNwEAu9opvQ
	(envelope-from <stable+bounces-223299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:40:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60E21AA94
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79F3304E701
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 02:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD60353ED9;
	Fri,  6 Mar 2026 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="QvMc7ZEo"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930033ADA7;
	Fri,  6 Mar 2026 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764777; cv=none; b=FP1UMBRQlqZWSTqF/lNDf91fXc45EKPwqkkVxuGsrXw9byxRO+RNS5MCD8s232TAMhrEaGOCyNsPiiTCNWqBO2rPR8ZJfO5qSgpM37+weL11s7/QKgIpx1mW+gUmh1X8GUK7+0yr3NiiyZHMa/JOqy7CCRi8FcSzQU6URruHapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764777; c=relaxed/simple;
	bh=LHsKBcwmd53zqBIre+iA0x8ljilUSFlnJGGmBum3NhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOsuYGuLi6OlztoidSnivIdh8MamQlhdNJHStLonnD5NPdI5OrS3aV9X6jrq/qot4cbgg+6aTDfnot53r784m8JbbhjHvwnseSwbXuJrZsuNHDMpVfj/idJv1HnkHBXa+1teEGz24QLTIm8JzPNZ6pwTXXudS4vJAM+alGRr5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=QvMc7ZEo; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QvMc7ZEoHolohBPRfdI0/KXBJ25OmEr3lKaTcoT/8dBRIXPzDpHpxY40Wo6SaRscx381fmM9irZ1Z
	 nYgQzhSQ/H1cw9nuDhABGs2NjRfgoZQWy5hSBJgZDGPfCUv9zx1YxEJvA9ZR/CXSPxqbbtKxvtr3jt
	 ZmH+ZcS4jGlScYFw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-02-12080 (RichMail) with SMTP id 2f3069aa3e4f83a-058b6;
	Fri, 06 Mar 2026 10:39:26 +0800 (CST)
X-RM-TRANSID:2f3069aa3e4f83a-058b6
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Daeho Jeong <daehojeong@google.com>,
	Baocong Liu <baocong.liu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.12.y 2/2] f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
Date: Fri,  6 Mar 2026 10:38:46 +0800
Message-Id: <20260306023846.2147903-2-lanbincn@139.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306023846.2147903-1-lanbincn@139.com>
References: <20260306023846.2147903-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A60E21AA94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	TAGGED_FROM(0.00)[bounces-223299-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,unisoc.com,google.com,kernel.org,139.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.117];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
[ Keep the original f2fs_vmalloc(workspace_size) in v6.12.y instead of
f2fs_vmalloc(dic->sbi, workspace_size) per commit
54ca9be0bc58 ("f2fs: introduce FAULT_VMALLOC"). ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/f2fs/compress.c | 38 +++++++++++++++++++-------------------
 fs/f2fs/f2fs.h     |  2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 60401a43b78d..cda7952526aa 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -211,13 +211,13 @@ static int lzo_decompress_pages(struct decompress_io_ctx *dic)
 	ret = lzo1x_decompress_safe(dic->cbuf->cdata, dic->clen,
 						dic->rbuf, &dic->rlen);
 	if (ret != LZO_E_OK) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"lzo decompress failed, ret:%d", ret);
 		return -EIO;
 	}
 
 	if (dic->rlen != PAGE_SIZE << dic->log_cluster_size) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"lzo invalid rlen:%zu, expected:%lu",
 				dic->rlen, PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
@@ -291,13 +291,13 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	ret = LZ4_decompress_safe(dic->cbuf->cdata, dic->rbuf,
 						dic->clen, dic->rlen);
 	if (ret < 0) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"lz4 decompress failed, ret:%d", ret);
 		return -EIO;
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"lz4 invalid ret:%d, expected:%lu",
 				ret, PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
@@ -425,7 +425,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 
 	stream = zstd_init_dstream(max_window_size, workspace, workspace_size);
 	if (!stream) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"%s zstd_init_dstream failed", __func__);
 		vfree(workspace);
 		return -EIO;
@@ -461,14 +461,14 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 
 	ret = zstd_decompress_stream(stream, &outbuf, &inbuf);
 	if (zstd_is_error(ret)) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"%s zstd_decompress_stream failed, ret: %d",
 				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
 
 	if (dic->rlen != outbuf.pos) {
-		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+		f2fs_err_ratelimited(dic->sbi,
 				"%s ZSTD invalid rlen:%zu, expected:%lu",
 				__func__, dic->rlen,
 				PAGE_SIZE << dic->log_cluster_size);
@@ -728,7 +728,7 @@ static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
 
 void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	struct f2fs_sb_info *sbi = dic->sbi;
 	struct f2fs_inode_info *fi = F2FS_I(dic->inode);
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
@@ -798,7 +798,7 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 {
 	struct decompress_io_ctx *dic =
 			(struct decompress_io_ctx *)page_private(page);
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	struct f2fs_sb_info *sbi = dic->sbi;
 
 	dec_page_count(sbi, F2FS_RD_DATA);
 
@@ -1615,14 +1615,13 @@ static inline bool allow_memalloc_for_decomp(struct f2fs_sb_info *sbi,
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
 
@@ -1652,10 +1651,9 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
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
@@ -1690,6 +1688,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 
 	dic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	dic->inode = cc->inode;
+	dic->sbi = sbi;
+	dic->compress_algorithm = F2FS_I(cc->inode)->i_compress_algorithm;
 	atomic_set(&dic->remaining_pages, cc->nr_cpages);
 	dic->cluster_idx = cc->cluster_idx;
 	dic->cluster_size = cc->cluster_size;
@@ -1733,7 +1733,8 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 		bool bypass_destroy_callback)
 {
 	int i;
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	/* use sbi in dic to avoid UFA of dic->inode*/
+	struct f2fs_sb_info *sbi = dic->sbi;
 
 	f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
 
@@ -1776,8 +1777,7 @@ static void f2fs_put_dic(struct decompress_io_ctx *dic, bool in_task)
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
index 998ac993543e..a6b06ac2751d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1525,6 +1525,7 @@ struct compress_io_ctx {
 struct decompress_io_ctx {
 	u32 magic;			/* magic number to indicate page is compressed */
 	struct inode *inode;		/* inode the context belong to */
+	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	pgoff_t cluster_idx;		/* cluster index number */
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
@@ -1565,6 +1566,7 @@ struct decompress_io_ctx {
 
 	bool failed;			/* IO error occurred before decompression? */
 	bool need_verity;		/* need fs-verity verification after decompression? */
+	unsigned char compress_algorithm;	/* backup algorithm type */
 	void *private;			/* payload buffer for specified decompression algorithm */
 	void *private2;			/* extra payload buffer */
 	struct work_struct verity_work;	/* work to verify the decompressed pages */
-- 
2.43.0



