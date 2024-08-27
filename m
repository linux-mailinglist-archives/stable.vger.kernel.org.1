Return-Path: <stable+bounces-71045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A056F961162
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D441F21075
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3381CDA27;
	Tue, 27 Aug 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X/ZXwRLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C61C93A3;
	Tue, 27 Aug 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771915; cv=none; b=LH9UM5QI/Fwm/WAT4jzuJ2r74YT1y4zIWLBP8cbdxhl+Vq6tbiIF3+Y0XNHmko6sQsoaytxzOni2rE6t5L4liuougkuG+WAekdophGzfvqLVrpY193QnMjwo7alekGd7ZL7S5Q/R3vB69sZ7fdgUL9v7CcUtBKq9WAtvFFlWjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771915; c=relaxed/simple;
	bh=559kVkvodth0Y4+uPQpX24YKQpqxoI6vxl+9CQb8bPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5MNZoAoHC/X/0PziDuip3JfyRUqAlsmTfoc4au11NYFZCwkGOUK2B7KmbpvqIAX3x3Ou4GOn/jHXj09Wp9+uaZaCigl2ftGvJRAnK86CdTZsS8W9JDYxLeALylR43Ndset8/bvdPXb8UJJd7KYJhW44rU2MpJvR6WRFN+cgkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X/ZXwRLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DD3C4AF48;
	Tue, 27 Aug 2024 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771914;
	bh=559kVkvodth0Y4+uPQpX24YKQpqxoI6vxl+9CQb8bPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/ZXwRLDcAWmv05WbYJH9PX+l//YRs9RndkoBpQOflFP/vOMO1J+Bhv3h3WCTYAl8
	 2etyEVBhIbQaQ8YP50KplQZIdaZ/A6SXNpVqr6f95p7knF3V6DDRkraVFN7yjskP8w
	 ff6QzF19uMdErypu4dPtH9ghIkRoY1oimmbPjdgQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/321] quota: Detect loops in quota tree
Date: Tue, 27 Aug 2024 16:36:06 +0200
Message-ID: <20240827143840.444597253@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit a898cb621ac589b0b9e959309689a027e765aa12 ]

Syzbot has found that when it creates corrupted quota files where the
quota tree contains a loop, we will deadlock when tryling to insert a
dquot. Add loop detection into functions traversing the quota tree.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/quota_tree.c | 128 +++++++++++++++++++++++++++++++-----------
 fs/quota/quota_v2.c   |  15 +++--
 2 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 0f1493e0f6d05..254f6359b287f 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -21,6 +21,12 @@ MODULE_AUTHOR("Jan Kara");
 MODULE_DESCRIPTION("Quota trie support");
 MODULE_LICENSE("GPL");
 
+/*
+ * Maximum quota tree depth we support. Only to limit recursion when working
+ * with the tree.
+ */
+#define MAX_QTREE_DEPTH 6
+
 #define __QUOTA_QT_PARANOIA
 
 static int __get_index(struct qtree_mem_dqinfo *info, qid_t id, int depth)
@@ -327,27 +333,36 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 
 /* Insert reference to structure into the trie */
 static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
-			  uint *treeblk, int depth)
+			  uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0, newson = 0, newact = 0;
 	__le32 *ref;
 	uint newblk;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	if (!*treeblk) {
+	if (!blks[depth]) {
 		ret = get_free_dqblk(info);
 		if (ret < 0)
 			goto out_buf;
-		*treeblk = ret;
+		for (i = 0; i < depth; i++)
+			if (ret == blks[i]) {
+				quota_error(dquot->dq_sb,
+					"Free block already used in tree: block %u",
+					ret);
+				ret = -EIO;
+				goto out_buf;
+			}
+		blks[depth] = ret;
 		memset(buf, 0, info->dqi_usable_bs);
 		newact = 1;
 	} else {
-		ret = read_blk(info, *treeblk, buf);
+		ret = read_blk(info, blks[depth], buf);
 		if (ret < 0) {
 			quota_error(dquot->dq_sb, "Can't read tree quota "
-				    "block %u", *treeblk);
+				    "block %u", blks[depth]);
 			goto out_buf;
 		}
 	}
@@ -357,8 +372,20 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			     info->dqi_blocks - 1);
 	if (ret)
 		goto out_buf;
-	if (!newblk)
+	if (!newblk) {
 		newson = 1;
+	} else {
+		for (i = 0; i <= depth; i++)
+			if (newblk == blks[i]) {
+				quota_error(dquot->dq_sb,
+					"Cycle in quota tree detected: block %u index %u",
+					blks[depth],
+					get_index(info, dquot->dq_id, depth));
+				ret = -EIO;
+				goto out_buf;
+			}
+	}
+	blks[depth + 1] = newblk;
 	if (depth == info->dqi_qtree_depth - 1) {
 #ifdef __QUOTA_QT_PARANOIA
 		if (newblk) {
@@ -370,16 +397,16 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			goto out_buf;
 		}
 #endif
-		newblk = find_free_dqentry(info, dquot, &ret);
+		blks[depth + 1] = find_free_dqentry(info, dquot, &ret);
 	} else {
-		ret = do_insert_tree(info, dquot, &newblk, depth+1);
+		ret = do_insert_tree(info, dquot, blks, depth + 1);
 	}
 	if (newson && ret >= 0) {
 		ref[get_index(info, dquot->dq_id, depth)] =
-							cpu_to_le32(newblk);
-		ret = write_blk(info, *treeblk, buf);
+						cpu_to_le32(blks[depth + 1]);
+		ret = write_blk(info, blks[depth], buf);
 	} else if (newact && ret < 0) {
-		put_free_dqblk(info, buf, *treeblk);
+		put_free_dqblk(info, buf, blks[depth]);
 	}
 out_buf:
 	kfree(buf);
@@ -390,7 +417,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
 				 struct dquot *dquot)
 {
-	int tmp = QT_TREEOFF;
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
 
 #ifdef __QUOTA_QT_PARANOIA
 	if (info->dqi_blocks <= QT_TREEOFF) {
@@ -398,7 +425,11 @@ static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
 		return -EIO;
 	}
 #endif
-	return do_insert_tree(info, dquot, &tmp, 0);
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return do_insert_tree(info, dquot, blks, 0);
 }
 
 /*
@@ -511,19 +542,20 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 
 /* Remove reference to dquot from tree */
 static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
-		       uint *blk, int depth)
+		       uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0;
 	uint newblk;
 	__le32 *ref = (__le32 *)buf;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	ret = read_blk(info, *blk, buf);
+	ret = read_blk(info, blks[depth], buf);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota data block %u",
-			    *blk);
+			    blks[depth]);
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
@@ -532,29 +564,38 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 	if (ret)
 		goto out_buf;
 
+	for (i = 0; i <= depth; i++)
+		if (newblk == blks[i]) {
+			quota_error(dquot->dq_sb,
+				"Cycle in quota tree detected: block %u index %u",
+				blks[depth],
+				get_index(info, dquot->dq_id, depth));
+			ret = -EIO;
+			goto out_buf;
+		}
 	if (depth == info->dqi_qtree_depth - 1) {
 		ret = free_dqentry(info, dquot, newblk);
-		newblk = 0;
+		blks[depth + 1] = 0;
 	} else {
-		ret = remove_tree(info, dquot, &newblk, depth+1);
+		blks[depth + 1] = newblk;
+		ret = remove_tree(info, dquot, blks, depth + 1);
 	}
-	if (ret >= 0 && !newblk) {
-		int i;
+	if (ret >= 0 && !blks[depth + 1]) {
 		ref[get_index(info, dquot->dq_id, depth)] = cpu_to_le32(0);
 		/* Block got empty? */
 		for (i = 0; i < (info->dqi_usable_bs >> 2) && !ref[i]; i++)
 			;
 		/* Don't put the root block into the free block list */
 		if (i == (info->dqi_usable_bs >> 2)
-		    && *blk != QT_TREEOFF) {
-			put_free_dqblk(info, buf, *blk);
-			*blk = 0;
+		    && blks[depth] != QT_TREEOFF) {
+			put_free_dqblk(info, buf, blks[depth]);
+			blks[depth] = 0;
 		} else {
-			ret = write_blk(info, *blk, buf);
+			ret = write_blk(info, blks[depth], buf);
 			if (ret < 0)
 				quota_error(dquot->dq_sb,
 					    "Can't write quota tree block %u",
-					    *blk);
+					    blks[depth]);
 		}
 	}
 out_buf:
@@ -565,11 +606,15 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 /* Delete dquot from tree */
 int qtree_delete_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 {
-	uint tmp = QT_TREEOFF;
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
 
 	if (!dquot->dq_off)	/* Even not allocated? */
 		return 0;
-	return remove_tree(info, dquot, &tmp, 0);
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return remove_tree(info, dquot, blks, 0);
 }
 EXPORT_SYMBOL(qtree_delete_dquot);
 
@@ -613,18 +658,20 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 
 /* Find entry for given id in the tree */
 static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
-				struct dquot *dquot, uint blk, int depth)
+				struct dquot *dquot, uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	loff_t ret = 0;
 	__le32 *ref = (__le32 *)buf;
+	uint blk;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	ret = read_blk(info, blk, buf);
+	ret = read_blk(info, blks[depth], buf);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
-			    blk);
+			    blks[depth]);
 		goto out_buf;
 	}
 	ret = 0;
@@ -636,8 +683,19 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	if (ret)
 		goto out_buf;
 
+	/* Check for cycles in the tree */
+	for (i = 0; i <= depth; i++)
+		if (blk == blks[i]) {
+			quota_error(dquot->dq_sb,
+				"Cycle in quota tree detected: block %u index %u",
+				blks[depth],
+				get_index(info, dquot->dq_id, depth));
+			ret = -EIO;
+			goto out_buf;
+		}
+	blks[depth + 1] = blk;
 	if (depth < info->dqi_qtree_depth - 1)
-		ret = find_tree_dqentry(info, dquot, blk, depth+1);
+		ret = find_tree_dqentry(info, dquot, blks, depth + 1);
 	else
 		ret = find_block_dqentry(info, dquot, blk);
 out_buf:
@@ -649,7 +707,13 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 static inline loff_t find_dqentry(struct qtree_mem_dqinfo *info,
 				  struct dquot *dquot)
 {
-	return find_tree_dqentry(info, dquot, QT_TREEOFF, 0);
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
+
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return find_tree_dqentry(info, dquot, blks, 0);
 }
 
 int qtree_read_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index b1467f3921c28..6921d40645a7e 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -166,14 +166,17 @@ static int v2_read_file_info(struct super_block *sb, int type)
 		    i_size_read(sb_dqopt(sb)->files[type]));
 		goto out_free;
 	}
-	if (qinfo->dqi_free_blk >= qinfo->dqi_blocks) {
-		quota_error(sb, "Free block number too big (%u >= %u).",
-			    qinfo->dqi_free_blk, qinfo->dqi_blocks);
+	if (qinfo->dqi_free_blk && (qinfo->dqi_free_blk <= QT_TREEOFF ||
+	    qinfo->dqi_free_blk >= qinfo->dqi_blocks)) {
+		quota_error(sb, "Free block number %u out of range (%u, %u).",
+			    qinfo->dqi_free_blk, QT_TREEOFF, qinfo->dqi_blocks);
 		goto out_free;
 	}
-	if (qinfo->dqi_free_entry >= qinfo->dqi_blocks) {
-		quota_error(sb, "Block with free entry too big (%u >= %u).",
-			    qinfo->dqi_free_entry, qinfo->dqi_blocks);
+	if (qinfo->dqi_free_entry && (qinfo->dqi_free_entry <= QT_TREEOFF ||
+	    qinfo->dqi_free_entry >= qinfo->dqi_blocks)) {
+		quota_error(sb, "Block with free entry %u out of range (%u, %u).",
+			    qinfo->dqi_free_entry, QT_TREEOFF,
+			    qinfo->dqi_blocks);
 		goto out_free;
 	}
 	ret = 0;
-- 
2.43.0




