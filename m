Return-Path: <stable+bounces-98512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87659E4242
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765FA2853BE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FB233662;
	Wed,  4 Dec 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmTlDX5U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB3207E01;
	Wed,  4 Dec 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332375; cv=none; b=WFJeT+xrl8/g+JNnFg0PMWeqzybVp11tzvpY5s0++xRKDpCtknVjZKdpNWtsvhLT3dImbF6jntsul6BY7y6WVULF8edxvwQrkmYtiz6TKgwItph735IZfF/vUHM2CxCQgZVCpIKw8OtoyKWRiYKvJK3LNsYO4W0631znaYXQ9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332375; c=relaxed/simple;
	bh=uDF5ly0FsJEiGHXV0nkl+/APK79l2V5iLtxfKTkjEi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STUHZMrblZRQHZInJMxCqW3QG4ARqXTgJFPmGzF7fKAmZ0yS6hYbCE02Vx3fQl4KrKO79OCQhKQQMpzBqOxxli+WkcdPzJpqxDaoa2ve1xm57qJ+YdFDDk4OKSqDHqfBqtMNSvmg8UFxIDBotbwxiH43B/r1zNBSNXdt98ElGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmTlDX5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95671C4CED1;
	Wed,  4 Dec 2024 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332375;
	bh=uDF5ly0FsJEiGHXV0nkl+/APK79l2V5iLtxfKTkjEi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YmTlDX5UvSZNfqW7x9BemyqV8TXieVOkgiJp6V9MqX0BAY4WesyX8HAZKWGar+Ica
	 VpOilf/2QCU/+etuKKlZlbNx/1EceaOt/xLskX3qEhn1yVU4fVkxh+mR50BEUHQDa2
	 ZYtobnhVaVIazK09evE7GNbLxz6o/mNhdM3huBTWtjruuULL1eMItQMocKgbzC/Rs1
	 TMMA4pDJ4BDJUAZNRZcE47M8DUqnBSYxc+j2+BK+HMpOEZdd0Vpj6omzs3k36nQxVs
	 Wm+QnEhcgrRRBpzN0ddkdnIHZcfPY1hpzB6xCDWmiZQxGYBB/LWPIdmhPLwMRLBvT0
	 7Ucaa3orqiwaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 12/12] f2fs: fix to shrink read extent node in batches
Date: Wed,  4 Dec 2024 11:01:09 -0500
Message-ID: <20241204160115.2216718-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160115.2216718-1-sashal@kernel.org>
References: <20241204160115.2216718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 3fc5d5a182f6a1f8bd4dc775feb54c369dd2c343 ]

We use rwlock to protect core structure data of extent tree during
its shrink, however, if there is a huge number of extent nodes in
extent tree, during shrink of extent tree, it may hold rwlock for
a very long time, which may trigger kernel hang issue.

This patch fixes to shrink read extent node in batches, so that,
critical region of the rwlock can be shrunk to avoid its extreme
long time hold.

Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1-xiuhong.wang@unisoc.com/
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/extent_cache.c | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d6fb053b6dfbb..bfa2d89dc9ea3 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -347,21 +347,22 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode,
 }
 
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
-					struct extent_tree *et)
+				struct extent_tree *et, unsigned int nr_shrink)
 {
 	struct rb_node *node, *next;
 	struct extent_node *en;
-	unsigned int count = atomic_read(&et->node_cnt);
+	unsigned int count;
 
 	node = rb_first_cached(&et->root);
-	while (node) {
+
+	for (count = 0; node && count < nr_shrink; count++) {
 		next = rb_next(node);
 		en = rb_entry(node, struct extent_node, rb_node);
 		__release_extent_node(sbi, et, en);
 		node = next;
 	}
 
-	return count - atomic_read(&et->node_cnt);
+	return count;
 }
 
 static void __drop_largest_extent(struct extent_tree *et,
@@ -580,6 +581,30 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 	return en;
 }
 
+static unsigned int __destroy_extent_node(struct inode *inode,
+					enum extent_type type)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
+	unsigned int nr_shrink = type == EX_READ ?
+				READ_EXTENT_CACHE_SHRINK_NUMBER :
+				AGE_EXTENT_CACHE_SHRINK_NUMBER;
+	unsigned int node_cnt = 0;
+
+	if (!et || !atomic_read(&et->node_cnt))
+		return 0;
+
+	while (atomic_read(&et->node_cnt)) {
+		write_lock(&et->lock);
+		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
+		write_unlock(&et->lock);
+	}
+
+	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
+
+	return node_cnt;
+}
+
 static void __update_extent_tree_range(struct inode *inode,
 			struct extent_info *tei, enum extent_type type)
 {
@@ -718,9 +743,6 @@ static void __update_extent_tree_range(struct inode *inode,
 		}
 	}
 
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		__free_extent_tree(sbi, et);
-
 	if (et->largest_updated) {
 		et->largest_updated = false;
 		updated = true;
@@ -738,6 +760,9 @@ static void __update_extent_tree_range(struct inode *inode,
 out_read_extent_cache:
 	write_unlock(&et->lock);
 
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		__destroy_extent_node(inode, EX_READ);
+
 	if (updated)
 		f2fs_mark_inode_dirty_sync(inode, true);
 }
@@ -902,10 +927,14 @@ static unsigned int __shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
 	list_for_each_entry_safe(et, next, &eti->zombie_list, list) {
 		if (atomic_read(&et->node_cnt)) {
 			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et);
+			node_cnt += __free_extent_tree(sbi, et,
+					nr_shrink - node_cnt - tree_cnt);
 			write_unlock(&et->lock);
 		}
-		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
+
+		if (atomic_read(&et->node_cnt))
+			goto unlock_out;
+
 		list_del_init(&et->list);
 		radix_tree_delete(&eti->extent_tree_root, et->ino);
 		kmem_cache_free(extent_tree_slab, et);
@@ -1044,23 +1073,6 @@ unsigned int f2fs_shrink_age_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
 	return __shrink_extent_tree(sbi, nr_shrink, EX_BLOCK_AGE);
 }
 
-static unsigned int __destroy_extent_node(struct inode *inode,
-					enum extent_type type)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
-	unsigned int node_cnt = 0;
-
-	if (!et || !atomic_read(&et->node_cnt))
-		return 0;
-
-	write_lock(&et->lock);
-	node_cnt = __free_extent_tree(sbi, et);
-	write_unlock(&et->lock);
-
-	return node_cnt;
-}
-
 void f2fs_destroy_extent_node(struct inode *inode)
 {
 	__destroy_extent_node(inode, EX_READ);
@@ -1069,7 +1081,6 @@ void f2fs_destroy_extent_node(struct inode *inode)
 
 static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	bool updated = false;
 
@@ -1077,7 +1088,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 		return;
 
 	write_lock(&et->lock);
-	__free_extent_tree(sbi, et);
 	if (type == EX_READ) {
 		set_inode_flag(inode, FI_NO_EXTENT);
 		if (et->largest.len) {
@@ -1086,6 +1096,9 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 		}
 	}
 	write_unlock(&et->lock);
+
+	__destroy_extent_node(inode, type);
+
 	if (updated)
 		f2fs_mark_inode_dirty_sync(inode, true);
 }
-- 
2.43.0


