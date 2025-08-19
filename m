Return-Path: <stable+bounces-171738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAEB2B762
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 05:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BCD4E7976
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51632C3258;
	Tue, 19 Aug 2025 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3p0WzMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336C2C235C
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572675; cv=none; b=q51SVbQaBeL/A445ToGacyr+HaOXlHbaOrmGPH/Z9z3g5qPR4y9TFaMLOQG0XtO69EUhxcvfDQbGfIestvGm8K2QKenIQ6fzme0ea2iNlEIBmYTdsb0ZX5hIQP7QuywAPjKGCtJoU/ps8PMhFRYL1lL6Nrz/85bZ/LLMdRzfdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572675; c=relaxed/simple;
	bh=N3i6BPPYKL7wK48qeYe3HO2sN0zL7US+B+/MyGK1vQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RowVS5WHS1IkFAlSQtmER1QBJOGvsM0jEVo9h1dPLE9fSDGO0SdELF4bcueulybkAO62AqG7BXqzN4iNwzC0rvpaMHvsG1JPB+SxeZus9fPrzpaRNKTfj8HYYf/TmHYzPW+duXl6wBCpwnf49vjSr9QwFSO5NYojmHtNTxvGZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3p0WzMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED2FC4CEEB;
	Tue, 19 Aug 2025 03:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755572675;
	bh=N3i6BPPYKL7wK48qeYe3HO2sN0zL7US+B+/MyGK1vQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3p0WzMQPtcMI7WZGabaJ33Zu+JEbmJDuG89QvMUlN0fnDIFiOiK7JVOdyhM2X38U
	 h/jOMrvqW+Ns3GBFKvzSqF0LhwnBU4u8qby/cMCG6mxc0tbKzv4m8XxhBSB0SBYpUa
	 Dob012BGYkHZgH1YDiFkx9yc/0C5tLMY2v9BvC548i7nJ11VEhcBK45EDcYzTKLdGq
	 A56Ea7WQNze/hkqyk1vH/vO5mMQRT6eE7aMmTiZ9lqQLtVif7OGc/JJIwKq+vqQNB6
	 MPFZ9YxmXRKP7mkOpwUV7Hs13r4u47tLlNDa144sH+eJhU2VTp/fyrY45oEV+7VIew
	 jEc8ZR3kcsmIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] btrfs: open code timespec64 in struct btrfs_inode
Date: Mon, 18 Aug 2025 23:04:31 -0400
Message-ID: <20250819030432.303556-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081854-eject-aloft-03ff@gregkh>
References: <2025081854-eject-aloft-03ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit c6e8f898f56fae2cb5bc4396bec480f23cd8b066 ]

The type of timespec64::tv_nsec is 'unsigned long', while we have only
u32 for on-disk and in-memory. This wastes a few bytes in btrfs_inode.
Add separate members for sec and nsec with the corresponding type width.
This creates a 4 byte hole in btrfs_inode which can be utilized in the
future.

Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 1ef94169db09 ("btrfs: populate otime when logging an inode item")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/btrfs_inode.h   |  3 ++-
 fs/btrfs/delayed-inode.c | 12 ++++--------
 fs/btrfs/inode.c         | 26 ++++++++++++--------------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index c23c56ead6b2..c4968efc3fc4 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -251,7 +251,8 @@ struct btrfs_inode {
 	struct btrfs_delayed_node *delayed_node;
 
 	/* File creation time. */
-	struct timespec64 i_otime;
+	u64 i_otime_sec;
+	u32 i_otime_nsec;
 
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 32c5f5a8a0e9..c39e39142abf 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1849,10 +1849,8 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
 				      inode_get_ctime(inode).tv_nsec);
 
-	btrfs_set_stack_timespec_sec(&inode_item->otime,
-				     BTRFS_I(inode)->i_otime.tv_sec);
-	btrfs_set_stack_timespec_nsec(&inode_item->otime,
-				     BTRFS_I(inode)->i_otime.tv_nsec);
+	btrfs_set_stack_timespec_sec(&inode_item->otime, BTRFS_I(inode)->i_otime_sec);
+	btrfs_set_stack_timespec_nsec(&inode_item->otime, BTRFS_I(inode)->i_otime_nsec);
 }
 
 int btrfs_fill_inode(struct inode *inode, u32 *rdev)
@@ -1901,10 +1899,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	inode_set_ctime(inode, btrfs_stack_timespec_sec(&inode_item->ctime),
 			btrfs_stack_timespec_nsec(&inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime.tv_sec =
-		btrfs_stack_timespec_sec(&inode_item->otime);
-	BTRFS_I(inode)->i_otime.tv_nsec =
-		btrfs_stack_timespec_nsec(&inode_item->otime);
+	BTRFS_I(inode)->i_otime_sec = btrfs_stack_timespec_sec(&inode_item->otime);
+	BTRFS_I(inode)->i_otime_nsec = btrfs_stack_timespec_nsec(&inode_item->otime);
 
 	inode->i_generation = BTRFS_I(inode)->generation;
 	BTRFS_I(inode)->index_cnt = (u64)-1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 218d15f5ddf7..4502a474a81d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3785,10 +3785,8 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
 			btrfs_timespec_nsec(leaf, &inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime.tv_sec =
-		btrfs_timespec_sec(leaf, &inode_item->otime);
-	BTRFS_I(inode)->i_otime.tv_nsec =
-		btrfs_timespec_nsec(leaf, &inode_item->otime);
+	BTRFS_I(inode)->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
+	BTRFS_I(inode)->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
 
 	inode_set_bytes(inode, btrfs_inode_nbytes(leaf, inode_item));
 	BTRFS_I(inode)->generation = btrfs_inode_generation(leaf, inode_item);
@@ -3958,10 +3956,8 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
 				      inode_get_ctime(inode).tv_nsec);
 
-	btrfs_set_token_timespec_sec(&token, &item->otime,
-				     BTRFS_I(inode)->i_otime.tv_sec);
-	btrfs_set_token_timespec_nsec(&token, &item->otime,
-				      BTRFS_I(inode)->i_otime.tv_nsec);
+	btrfs_set_token_timespec_sec(&token, &item->otime, BTRFS_I(inode)->i_otime_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->otime, BTRFS_I(inode)->i_otime_nsec);
 
 	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
 	btrfs_set_token_inode_generation(&token, item,
@@ -5644,7 +5640,8 @@ static struct inode *new_simple_dir(struct inode *dir,
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
 	inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_atime = dir->i_atime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	BTRFS_I(inode)->i_otime_sec = inode->i_mtime.tv_sec;
+	BTRFS_I(inode)->i_otime_nsec = inode->i_mtime.tv_nsec;
 	inode->i_uid = dir->i_uid;
 	inode->i_gid = dir->i_gid;
 
@@ -6321,7 +6318,8 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 
 	inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_atime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	BTRFS_I(inode)->i_otime_sec = inode->i_mtime.tv_sec;
+	BTRFS_I(inode)->i_otime_nsec = inode->i_mtime.tv_nsec;
 
 	/*
 	 * We're going to fill the inode item now, so at this point the inode
@@ -8550,8 +8548,8 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 
 	ei->delayed_node = NULL;
 
-	ei->i_otime.tv_sec = 0;
-	ei->i_otime.tv_nsec = 0;
+	ei->i_otime_sec = 0;
+	ei->i_otime_nsec = 0;
 
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
@@ -8703,8 +8701,8 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
 	stat->result_mask |= STATX_BTIME;
-	stat->btime.tv_sec = BTRFS_I(inode)->i_otime.tv_sec;
-	stat->btime.tv_nsec = BTRFS_I(inode)->i_otime.tv_nsec;
+	stat->btime.tv_sec = BTRFS_I(inode)->i_otime_sec;
+	stat->btime.tv_nsec = BTRFS_I(inode)->i_otime_nsec;
 	if (bi_flags & BTRFS_INODE_APPEND)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (bi_flags & BTRFS_INODE_COMPRESS)
-- 
2.50.1


