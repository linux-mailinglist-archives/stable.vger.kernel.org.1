Return-Path: <stable+bounces-204252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC7CEA469
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D094E304A8CC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC732E696;
	Tue, 30 Dec 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBDtpmB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B032E15B
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114345; cv=none; b=QL91UHzytiRw9MwCjIwo77YAI0Z+sKnQ6IUwwrlY8cuINU3hA21PnmSbsdH8olT1WB/GsezwLv0FbBdL3aCE/Yknbx/+d+rRAW2LV+RRE1pbZ5U+KhQGxZ26KVcw44IbK+mPzRJ6TyRgoFLl8UcNJqPfif8ElgQnlwbpr8fo/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114345; c=relaxed/simple;
	bh=7GOSs5GY8yLgj4JQJJIXNZyLv95ZGf7bWScDjMhcea4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4p8JsS8g5GBA+6bCK/Tg+A4FSZh+KEYfQa8iiAKQj9MZxiVY1gv+/GXyIHDxMgwPLtLl/pMsO2WF/Gd8cStqw/qKKqr0rtHlyUR5rqaGDV7zPnmu8NOgs7I5X4bu6UNP+sZU3XFJAlH4Yai9QK7GVVCsGmoYU4qLBhStqDpTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBDtpmB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789DBC19422;
	Tue, 30 Dec 2025 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114345;
	bh=7GOSs5GY8yLgj4JQJJIXNZyLv95ZGf7bWScDjMhcea4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBDtpmB6uoLI4yFF1Di9Ec2KfKhwsgzCB4jq9ctAUq/hOPW9DI9WQ8/HWg/6zhR09
	 dpNgrPhTfs+whi0HaKZYxm8HbWwny1jXJUAhSHNaSfnCi3Axl78bgJ82kaN8z3xMhV
	 DzgD2Rhmqi7btpEbRKMoGtVva23Z6bRE6C4c434EVNuxaKtLAIsdV84OmEf1Cq83+L
	 bDCHQSoGpsYOC56rxa7yGqc78Z23Beqil8BPL7vlocm+cpBczLoCUOs9o+butJeZK+
	 UFxB4SQyT7Id7fbO3bUbCOdhAgNwubpsKBnxbFBAzPYl4PzfZ7k4Rznt3svc/biOg7
	 TZ7xqNUd2Ce0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] f2fs: keep POSIX_FADV_NOREUSE ranges
Date: Tue, 30 Dec 2025 12:05:38 -0500
Message-ID: <20251230170540.2336679-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230170540.2336679-1-sashal@kernel.org>
References: <2025122922-tyke-slip-919d@gregkh>
 <20251230170540.2336679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit ef0c333cad8d1940f132a7ce15f15920216a3bd5 ]

This patch records POSIX_FADV_NOREUSE ranges for users to reclaim the caches
instantly off from LRU.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 10b591e7fb7c ("f2fs: fix to avoid updating compression context during writeback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/debug.c |  3 +++
 fs/f2fs/f2fs.h  | 12 +++++++++-
 fs/f2fs/file.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/inode.c | 14 ++++++++++++
 fs/f2fs/super.c |  1 +
 5 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 0d02224b99b7..68773b48ed4d 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -100,6 +100,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
 	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
+	si->ndonate_files = sbi->donate_files;
 	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->aw_cnt = atomic_read(&sbi->atomic_files);
@@ -436,6 +437,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->compr_inode, si->compr_blocks);
 		seq_printf(s, "  - Swapfile Inode: %u\n",
 			   si->swapfile_inode);
+		seq_printf(s, "  - Donate Inode: %u\n",
+			   si->ndonate_files);
 		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
 			   si->orphans, si->append, si->update);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9112c3140ede..460c29f95c17 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -831,6 +831,11 @@ struct f2fs_inode_info {
 #endif
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
+
+	/* linked in global inode list for cache donation */
+	struct list_head gdonate_list;
+	pgoff_t donate_start, donate_end; /* inclusive */
+
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
 					/* cached extent_tree entry */
@@ -1255,6 +1260,7 @@ enum inode_type {
 	DIR_INODE,			/* for dirty dir inode */
 	FILE_INODE,			/* for dirty regular/symlink inode */
 	DIRTY_META,			/* for all dirtied inode metadata */
+	DONATE_INODE,			/* for all inode to donate pages */
 	NR_INODE_TYPE,
 };
 
@@ -1607,6 +1613,9 @@ struct f2fs_sb_info {
 	unsigned int warm_data_age_threshold;
 	unsigned int last_age_weight;
 
+	/* control donate caches */
+	unsigned int donate_files;
+
 	/* basic filesystem units */
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
@@ -3943,7 +3952,8 @@ struct f2fs_stat_info {
 	unsigned long long allocated_data_blocks;
 	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_imeta;
 	int ndirty_data, ndirty_qdata;
-	unsigned int ndirty_dirs, ndirty_files, nquota_files, ndirty_all;
+	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
+	unsigned int nquota_files, ndonate_files;
 	int nats, dirty_nats, sits, dirty_sits;
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 31d20800b475..564d83e67043 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2432,6 +2432,52 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static void f2fs_keep_noreuse_range(struct inode *inode,
+				loff_t offset, loff_t len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	u64 max_bytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+	u64 start, end;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	if (offset >= max_bytes || len > max_bytes ||
+	    (offset + len) > max_bytes)
+		return;
+
+	start = offset >> PAGE_SHIFT;
+	end = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+
+	inode_lock(inode);
+	if (f2fs_is_atomic_file(inode)) {
+		inode_unlock(inode);
+		return;
+	}
+
+	spin_lock(&sbi->inode_lock[DONATE_INODE]);
+	/* let's remove the range, if len = 0 */
+	if (!len) {
+		if (!list_empty(&F2FS_I(inode)->gdonate_list)) {
+			list_del_init(&F2FS_I(inode)->gdonate_list);
+			sbi->donate_files--;
+		}
+	} else {
+		if (list_empty(&F2FS_I(inode)->gdonate_list)) {
+			list_add_tail(&F2FS_I(inode)->gdonate_list,
+					&sbi->inode_list[DONATE_INODE]);
+			sbi->donate_files++;
+		} else {
+			list_move_tail(&F2FS_I(inode)->gdonate_list,
+					&sbi->inode_list[DONATE_INODE]);
+		}
+		F2FS_I(inode)->donate_start = start;
+		F2FS_I(inode)->donate_end = end - 1;
+	}
+	spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+	inode_unlock(inode);
+}
+
 static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -5075,12 +5121,16 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 	}
 
 	err = generic_fadvise(filp, offset, len, advice);
-	if (!err && advice == POSIX_FADV_DONTNEED &&
-		test_opt(F2FS_I_SB(inode), COMPRESS_CACHE) &&
-		f2fs_compressed_file(inode))
-		f2fs_invalidate_compress_pages(F2FS_I_SB(inode), inode->i_ino);
+	if (err)
+		return err;
 
-	return err;
+	if (advice == POSIX_FADV_DONTNEED &&
+	    (test_opt(F2FS_I_SB(inode), COMPRESS_CACHE) &&
+	     f2fs_compressed_file(inode)))
+		f2fs_invalidate_compress_pages(F2FS_I_SB(inode), inode->i_ino);
+	else if (advice == POSIX_FADV_NOREUSE)
+		f2fs_keep_noreuse_range(inode, offset, len);
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c67dbe4839e7..7a961672737e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -811,6 +811,19 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
+static void f2fs_remove_donate_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (list_empty(&F2FS_I(inode)->gdonate_list))
+		return;
+
+	spin_lock(&sbi->inode_lock[DONATE_INODE]);
+	list_del_init(&F2FS_I(inode)->gdonate_list);
+	sbi->donate_files--;
+	spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero
  */
@@ -844,6 +857,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
 	f2fs_remove_dirty_inode(inode);
+	f2fs_remove_donate_inode(inode);
 
 	f2fs_destroy_extent_tree(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b9913ab526fd..ffff81caa244 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1413,6 +1413,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
+	INIT_LIST_HEAD(&fi->gdonate_list);
 	init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
 	init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
 	init_f2fs_rwsem(&fi->i_xattr_sem);
-- 
2.51.0


