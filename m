Return-Path: <stable+bounces-79097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9698D690
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46196B202CC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F781D0979;
	Wed,  2 Oct 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MakNVudq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50921D0787;
	Wed,  2 Oct 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876431; cv=none; b=dkEmKG9wfgRo2V38KuoEW9LPH+sZowivhR097uo8BB7wT1a0RYgvIt0wXOZ8wUeR1j448WYJAln5PL313237phR5iJZlbui8STVHJyJmFJCUb6bo68S1j3nv/t7pQ/6PXSsk5z4yX4LLTJfxpReQGwFSh0QcVA7ZhUHkKlPu36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876431; c=relaxed/simple;
	bh=tAwUo9fZlYQvlwB8kUkw9m0cCUDEJKCmwb9QhKGDhU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRawAl8260VqbSi+Xk2tBxMFhg7SP/psuKp9kBzZbWsFooCDIjJQk5d1ZGSn8cLAdxUaI44wpLp8CpGue4Pf0d8k80fMdHwSGHGdgyRuCuKlWNwLY/O/JjjDU0rs8PhDJsZb3GVd8oZABysD09qyubxsoGJboTb6hD19+Quw3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MakNVudq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02421C4CEC5;
	Wed,  2 Oct 2024 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876430;
	bh=tAwUo9fZlYQvlwB8kUkw9m0cCUDEJKCmwb9QhKGDhU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MakNVudqmGFZXZLPYWgkIB4dBAQ1AtVyRwwq21f/7zdbIO3hk8MEYbbu7J7s89SsM
	 /sYvcJc2OZK7wHrARsBuukjVrv1akq2IOuHyZTuFqo4Y2hfTETUqHFC9aWyvGJNSdj
	 ObXJYhnTpUTy4DH/yJ/xiLUucujF6WxrM+DlBqP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 441/695] f2fs: compress: dont redirty sparse cluster during {,de}compress
Date: Wed,  2 Oct 2024 14:57:19 +0200
Message-ID: <20241002125840.060806581@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yeongjin Gil <youngjin.gil@samsung.com>

[ Upstream commit f785cec298c95d00058560c0715233294a04b8f3 ]

In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
writepage considering that it has been already truncated.
This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
cleared during the writeback process for a compressed file including
NULL_ADDR in compress_mode=user.

This is the reproduction process:

1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
2. f2fs_io compress testfile
3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
4. f2fs_io decompress testfile

To prevent the problem, let's check whether the cluster is fully
allocated before redirty its pages.

Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Tested-by: Jaewook Kim <jw5454.kim@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 36 ++++++++++++++++++++++++++++--------
 fs/f2fs/f2fs.h     | 12 ++++++++++++
 fs/f2fs/file.c     | 39 +++++++++++++++++++++------------------
 3 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 990b93689b460..f55d54bb12f42 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -945,7 +945,7 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
 	int count, i;
 
-	for (i = 1, count = 1; i < cluster_size; i++) {
+	for (i = 0, count = 0; i < cluster_size; i++) {
 		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
 							dn->ofs_in_node + i);
 
@@ -956,8 +956,8 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	return count;
 }
 
-static int __f2fs_cluster_blocks(struct inode *inode,
-				unsigned int cluster_idx, bool compr_blks)
+static int __f2fs_cluster_blocks(struct inode *inode, unsigned int cluster_idx,
+				enum cluster_check_type type)
 {
 	struct dnode_of_data dn;
 	unsigned int start_idx = cluster_idx <<
@@ -978,10 +978,12 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 	}
 
 	if (dn.data_blkaddr == COMPRESS_ADDR) {
-		if (compr_blks)
-			ret = __f2fs_get_cluster_blocks(inode, &dn);
-		else
+		if (type == CLUSTER_COMPR_BLKS)
+			ret = 1 + __f2fs_get_cluster_blocks(inode, &dn);
+		else if (type == CLUSTER_IS_COMPR)
 			ret = 1;
+	} else if (type == CLUSTER_RAW_BLKS) {
+		ret = __f2fs_get_cluster_blocks(inode, &dn);
 	}
 fail:
 	f2fs_put_dnode(&dn);
@@ -991,7 +993,16 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 /* return # of compressed blocks in compressed cluster */
 static int f2fs_compressed_blocks(struct compress_ctx *cc)
 {
-	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
+	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx,
+		CLUSTER_COMPR_BLKS);
+}
+
+/* return # of raw blocks in non-compressed cluster */
+static int f2fs_decompressed_blocks(struct inode *inode,
+				unsigned int cluster_idx)
+{
+	return __f2fs_cluster_blocks(inode, cluster_idx,
+		CLUSTER_RAW_BLKS);
 }
 
 /* return whether cluster is compressed one or not */
@@ -999,7 +1010,16 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
 	return __f2fs_cluster_blocks(inode,
 		index >> F2FS_I(inode)->i_log_cluster_size,
-		false);
+		CLUSTER_IS_COMPR);
+}
+
+/* return whether cluster contains non raw blocks or not */
+bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index)
+{
+	unsigned int cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size;
+
+	return f2fs_decompressed_blocks(inode, cluster_idx) !=
+		F2FS_I(inode)->i_cluster_size;
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f4342622dec6a..d40a8d6676f2d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4297,6 +4297,11 @@ static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
  * compress.c
  */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+enum cluster_check_type {
+	CLUSTER_IS_COMPR,   /* check only if compressed cluster */
+	CLUSTER_COMPR_BLKS, /* return # of compressed blocks in a cluster */
+	CLUSTER_RAW_BLKS    /* return # of raw blocks in a cluster */
+};
 bool f2fs_is_compressed_page(struct page *page);
 struct page *f2fs_compress_control_page(struct page *page);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
@@ -4323,6 +4328,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
+bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index);
 void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
 				unsigned int llen, unsigned int c_len);
@@ -4409,6 +4415,12 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
+static inline int f2fs_is_compressed_cluster(
+				struct inode *inode,
+				pgoff_t index) { return 0; }
+static inline bool f2fs_is_sparse_cluster(
+				struct inode *inode,
+				pgoff_t index) { return true; }
 static inline void f2fs_update_read_extent_tree_range_compressed(
 				struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 869f4744b443e..56381a0b63219 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4219,9 +4219,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t page_idx = 0, last_idx;
-	int cluster_size = fi->i_cluster_size;
-	int count, ret;
+	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	int ret;
 
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
@@ -4256,10 +4255,15 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		goto out;
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx >>= fi->i_log_cluster_size;
+
+	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
+		page_idx = cluster_idx << fi->i_log_cluster_size;
+
+		if (!f2fs_is_compressed_cluster(inode, page_idx))
+			continue;
 
-	count = last_idx - page_idx;
-	while (count && count >= cluster_size) {
-		ret = redirty_blocks(inode, page_idx, cluster_size);
+		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4269,9 +4273,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 				break;
 		}
 
-		count -= cluster_size;
-		page_idx += cluster_size;
-
 		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -4298,9 +4299,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	pgoff_t page_idx = 0, last_idx;
-	int cluster_size = F2FS_I(inode)->i_cluster_size;
-	int count, ret;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	int ret;
 
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
@@ -4334,10 +4335,15 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	set_inode_flag(inode, FI_ENABLE_COMPRESS);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx >>= fi->i_log_cluster_size;
 
-	count = last_idx - page_idx;
-	while (count && count >= cluster_size) {
-		ret = redirty_blocks(inode, page_idx, cluster_size);
+	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
+		page_idx = cluster_idx << fi->i_log_cluster_size;
+
+		if (f2fs_is_sparse_cluster(inode, page_idx))
+			continue;
+
+		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4347,9 +4353,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 				break;
 		}
 
-		count -= cluster_size;
-		page_idx += cluster_size;
-
 		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
-- 
2.43.0




