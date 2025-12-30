Return-Path: <stable+bounces-204254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3880ACEA457
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A67E30028AA
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6187332ED33;
	Tue, 30 Dec 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjbsj9uW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAA7262E
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114348; cv=none; b=I/3FDezU75PF6U1GV/8pkIWxCX+qoDpgE1mavUrv3LSCE+Uld9s+o4xTkPf4m+JNz/mrqk2+z95aYX2fNi4qA8baus2GJx69rrUKzQAtNyK1J2zkH/jU/aV/UWLWQ/G7aoNNgXBMxyDTPkpIWY31/0Ud2/7doi7aO3VrGYVAC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114348; c=relaxed/simple;
	bh=OvLyoQH0xt47RASOd1QHpBz1koIAoW80IN37Dq51jpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f65eBXloGCzJTfudCWbfxfs3SNabuQ4+yrM1Z0OHfR+v0uAyjU+HzvtC35Bs77KxhyS8m5LRcLCqIwbdiN7Rstg1QQz9MMtx/rE/kFpTDcwgvoH4oMAI55W1rO/SGyLXeZcEI1ubkj8dKxr0oV6L5YKf2q9hNCCvOBG0pz4HK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjbsj9uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395E7C116C6;
	Tue, 30 Dec 2025 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114345;
	bh=OvLyoQH0xt47RASOd1QHpBz1koIAoW80IN37Dq51jpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjbsj9uWicsqBH7lkAt61hBVLN8btSpvyZYPYT+01b1dmPlEUhXhPBMqBljMXyj9j
	 BvOdd31BS8IaXy5w45BDI0TNPhvn8VH/IjMV/pX6CObGN0WhawWsid26G7OAPWlYWn
	 nPZtdlbWDl6ohDFkqGykS4k8BdmakEFi6uHYabXX4w4YQ8OWzPTyfQYtBv01SjYwUy
	 WCrFeaYydE/N27BDelaPtgafwEH2YetNfyVU5ipFmkQmsO55Mibd8eUN6/eFgconUW
	 WsZcViBQCr8pAa50vb6zJEx80xVW92cziNF5QwubdUKC1XtyYcF2ylgzf0IlHZCKHO
	 AXxZrrcPE+RkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] f2fs: drop inode from the donation list when the last file is closed
Date: Tue, 30 Dec 2025 12:05:39 -0500
Message-ID: <20251230170540.2336679-3-sashal@kernel.org>
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

[ Upstream commit 078cad8212ce4f4ebbafcc0936475b8215e1ca2a ]

Let's drop the inode from the donation list when there is no other
open file.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 10b591e7fb7c ("f2fs: fix to avoid updating compression context during writeback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 ++
 fs/f2fs/file.c  | 8 +++++++-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/super.c | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 460c29f95c17..4b295671df8b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -835,6 +835,7 @@ struct f2fs_inode_info {
 	/* linked in global inode list for cache donation */
 	struct list_head gdonate_list;
 	pgoff_t donate_start, donate_end; /* inclusive */
+	atomic_t open_count;		/* # of open files */
 
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
@@ -3554,6 +3555,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_update_inode(struct inode *inode, struct page *node_page);
 void f2fs_update_inode_page(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
+void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
 void f2fs_handle_failed_inode(struct inode *inode);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 564d83e67043..7bdf0da5ba69 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -621,7 +621,10 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	return finish_preallocate_blocks(inode);
+	err = finish_preallocate_blocks(inode);
+	if (!err)
+		atomic_inc(&F2FS_I(inode)->open_count);
+	return err;
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
@@ -1963,6 +1966,9 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
+	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
+		f2fs_remove_donate_inode(inode);
+
 	/*
 	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7a961672737e..4ba5642148b5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -811,7 +811,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
-static void f2fs_remove_donate_inode(struct inode *inode)
+void f2fs_remove_donate_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ffff81caa244..0523e21fa951 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1409,6 +1409,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
+	atomic_set(&fi->open_count, 0);
 	init_f2fs_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.51.0


