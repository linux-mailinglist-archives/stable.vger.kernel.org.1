Return-Path: <stable+bounces-204259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F3CEA4C7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3786930185D3
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB602E9EC7;
	Tue, 30 Dec 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYMSPuj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E628506A
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115202; cv=none; b=eqp8T1oqPtT7+ky16M18CAhzsluVTg3gf+OFW3SGKMGAPwWiSl5zVFphDtsexHFsajNmgmfDlRLUoxrkpAPcX9QLLtdEY2stEzbARI60nX2/sBT1EdFyJcbNtpjyVdBUEio+Qf6jtS/r0nvakIAx8oEnpUmBQk+8Ih5mXoaBZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115202; c=relaxed/simple;
	bh=roe4BFmVyLc4/n+2GnHYZ5VT/qasKJ6ANFzrxeyCv1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZNV9rJxh668ZDPQRDEtuvAVtm10X5xhg5RNzYN7uJztKtztY43UfAe5kuJPkAusWNArX+pMiHCJ08JjEM05JlYV6JADDaMRs6W8W6ggWkQNNsEfNx3K7ULY3mVAroAPsgT/cS4ba/stbPkYw/DrvDviYnIaiqYSOM+R443WLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYMSPuj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA6EC19421;
	Tue, 30 Dec 2025 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115202;
	bh=roe4BFmVyLc4/n+2GnHYZ5VT/qasKJ6ANFzrxeyCv1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYMSPuj/CH2uhnt1g476UVkRwt1AUurOnM63Hh9BsqT0mzBF+2XNfk3CLuBZlDaOm
	 fOzyzMSRVW4ogswwnP6rOSFSmOFasQsGgN3HI5nsIFhj/0HHermDMe+FNYB32gF+oX
	 y/3ep2cKYMVbivjH+mLHVsm53sIoqoKnP+x1Dws+GcjOamM0LczYLjcfM6sdV186tM
	 KO2u5/+mdcgsUfRGje7wUEL22FhLp7OUD/LjFMuYX8814Q0imBzkv6Fa17ZJ+9/dou
	 BVNGHwUDrnDFwfi2AjUek9jyH+SUIAfH+AhnERuwsd6QH8HPTzMcZW9Bk1K9bgShrb
	 5Y4/pIwdhvB0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] f2fs: drop inode from the donation list when the last file is closed
Date: Tue, 30 Dec 2025 12:19:57 -0500
Message-ID: <20251230171958.2344337-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230171958.2344337-1-sashal@kernel.org>
References: <2025122923-tricycle-avatar-86c9@gregkh>
 <20251230171958.2344337-1-sashal@kernel.org>
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
index 7a3bd05e1ffa..d0ff22ce06e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -824,6 +824,7 @@ struct f2fs_inode_info {
 	/* linked in global inode list for cache donation */
 	struct list_head gdonate_list;
 	pgoff_t donate_start, donate_end; /* inclusive */
+	atomic_t open_count;		/* # of open files */
 
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
@@ -3473,6 +3474,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_update_inode(struct inode *inode, struct page *node_page);
 void f2fs_update_inode_page(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
+void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
 void f2fs_handle_failed_inode(struct inode *inode);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e78b5ffb93da..b59f9929fc07 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -595,7 +595,10 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	return finish_preallocate_blocks(inode);
+	err = finish_preallocate_blocks(inode);
+	if (!err)
+		atomic_inc(&F2FS_I(inode)->open_count);
+	return err;
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
@@ -1921,6 +1924,9 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
+	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
+		f2fs_remove_donate_inode(inode);
+
 	/*
 	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 65ae5b91fdb1..4d97caf04043 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -743,7 +743,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
-static void f2fs_remove_donate_inode(struct inode *inode)
+void f2fs_remove_donate_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8997683c6701..b45bcbf754d7 100644
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


