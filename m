Return-Path: <stable+bounces-204241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50ECEA23F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 427993018D48
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6823D291;
	Tue, 30 Dec 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnuMQ53p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1913595B
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111329; cv=none; b=GkC8dYQjc7TkHTI4DY+R9Ony7CipLBK9DwQxOMNHoY4Lz57nJM9SZgqwXF+pPEGtfFhjafwyC4i3CHL5zE+Uuw6T6xsXTqSn5EN4Uc9L4kT2LbRKBnuV9lVI6FVPvifQO1A+ZA2glKjDWlChw6NSUBcjMleUVtdGBDCvEpr3J48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111329; c=relaxed/simple;
	bh=X9ETkSEXcv/HX50IiceND324KGHHf2GX+i0k1ybU9Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KarhJNUqFrLeZ+TVd4xdNYkg9JsKKRQ/PofMTDWeIIQxY3/+ojh8iHxYNvve7l3xewR1z2gLDWYIlIVLZ9K/Xq0uyzc1VLnENfLP591FEfT77v6tyYj+cN7JPjJYNJtf9JxhSPo9Y/hVm65EJBh4fp1BP9hu3p2Nt/WxqyqHfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnuMQ53p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CAC4CEFB;
	Tue, 30 Dec 2025 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111329;
	bh=X9ETkSEXcv/HX50IiceND324KGHHf2GX+i0k1ybU9Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnuMQ53poFg7Mri8Zwqq1F+V3oTJ9U5e4BHSybTFac0UFbjTfl/KCTzSnpjiYMbWr
	 WMa5as8A+W/W8gce2FLvaoCeMW4RtLcS4cTHPjKoX4wBfH/6E4MRvi+dDQaMfBCwhJ
	 9A+UVPu4B1VFvGPd8O6FKRy5sOIRjzx6Q4xJTPIF0MvWJ6VHem6jTIEa4Bm7bJAOGH
	 gKa5uVXRvTJjgGMEqytZDa1TN22yqhAzAc6M/5P0pBxQNOGVj44BT5+m9H6hKZmRR1
	 Xqe/3OTrmbHivH9unD5ucUX1EQi4SS5+FdS+sq41Hgp8sOLEkgqRYiQuTqdKJH7tvZ
	 Nh2Sz/r7SsQ3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] f2fs: drop inode from the donation list when the last file is closed
Date: Tue, 30 Dec 2025 11:15:26 -0500
Message-ID: <20251230161527.2300909-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122921-captivate-substance-994f@gregkh>
References: <2025122921-captivate-substance-994f@gregkh>
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
index 695f74875b8f..e190cfa63665 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -853,6 +853,7 @@ struct f2fs_inode_info {
 	/* linked in global inode list for cache donation */
 	struct list_head gdonate_list;
 	pgoff_t donate_start, donate_end; /* inclusive */
+	atomic_t open_count;		/* # of open files */
 
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
@@ -3597,6 +3598,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_update_inode(struct inode *inode, struct page *node_page);
 void f2fs_update_inode_page(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
+void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
 void f2fs_handle_failed_inode(struct inode *inode);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 67053bf6ca3e..e21915c72bc7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -631,7 +631,10 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	return finish_preallocate_blocks(inode);
+	err = finish_preallocate_blocks(inode);
+	if (!err)
+		atomic_inc(&F2FS_I(inode)->open_count);
+	return err;
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
@@ -1989,6 +1992,9 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
+	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
+		f2fs_remove_donate_inode(inode);
+
 	/*
 	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c77184dbc71c..f6ba15c095f8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -807,7 +807,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
-static void f2fs_remove_donate_inode(struct inode *inode)
+void f2fs_remove_donate_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ae7263954404..6fc2f88e544d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1425,6 +1425,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
+	atomic_set(&fi->open_count, 0);
 	init_f2fs_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.51.0


