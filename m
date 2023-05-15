Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1374B70353F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbjEOQ5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbjEOQ5L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BF1BC0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1292D62A07
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DEBC433EF;
        Mon, 15 May 2023 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169822;
        bh=IlKFhYqC210kIuMVV6ve1iumjH4diFwiLl9kS8tAag8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohE+BfTpYquBf45DVF3Q7vD0ECn9Lf5qeNLMnpTYlooYU+awU7Qst30ZsuiKGWh37
         tH1AQNRmcelYGUE1PH92mCHaaQmC+ymabUtl2Ku0JEC+aKQT7kXuAJnZvUkBQR4/MZ
         4k2eafqH9o/XMaPzlPLPfcQtw/PDZDjxA+Zw+0zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.3 180/246] f2fs: factor out discard_cmd usage from general rb_tree use
Date:   Mon, 15 May 2023 18:26:32 +0200
Message-Id: <20230515161728.028450488@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit f69475dd4878e5f2e316a6573044d55f294baa51 upstream.

This is a second part to remove the mixed use of rb_tree in discard_cmd from
extent_cache.

This should also fix arm32 memory alignment issue caused by shared rb_entry.

[struct discard_cmd]               [struct rb_entry]
[0] struct rb_node rb_node;        [0] struct rb_node rb_node;
  union {                              union {
    struct {                             struct {
[16]  block_t lstart;              [12]    unsigned int ofs;
      block_t len;                         unsigned int len;
                                         };
                                         unsigned long long key;
                                       } __packed;

Cc: <stable@vger.kernel.org>
Fixes: 004b68621897 ("f2fs: use rb-tree to track pending discard commands")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/extent_cache.c |   36 -------
 fs/f2fs/f2fs.h         |   23 ----
 fs/f2fs/segment.c      |  247 ++++++++++++++++++++++++++++++++-----------------
 3 files changed, 168 insertions(+), 138 deletions(-)

--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -192,7 +192,7 @@ static struct rb_entry *__lookup_rb_tree
 	return NULL;
 }
 
-struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
+static struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs)
 {
 	struct rb_entry *re;
@@ -204,7 +204,7 @@ struct rb_entry *f2fs_lookup_rb_tree(str
 	return re;
 }
 
-struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
+static struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
 				unsigned int ofs, bool *leftmost)
@@ -238,7 +238,7 @@ struct rb_node **f2fs_lookup_rb_tree_for
  * in order to simplify the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
-struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
+static struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 				struct rb_entry *cached_re,
 				unsigned int ofs,
 				struct rb_entry **prev_entry,
@@ -311,36 +311,6 @@ lookup_neighbors:
 	return re;
 }
 
-bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root)
-{
-#ifdef CONFIG_F2FS_CHECK_FS
-	struct rb_node *cur = rb_first_cached(root), *next;
-	struct rb_entry *cur_re, *next_re;
-
-	if (!cur)
-		return true;
-
-	while (cur) {
-		next = rb_next(cur);
-		if (!next)
-			return true;
-
-		cur_re = rb_entry(cur, struct rb_entry, rb_node);
-		next_re = rb_entry(next, struct rb_entry, rb_node);
-
-		if (cur_re->ofs + cur_re->len > next_re->ofs) {
-			f2fs_info(sbi, "inconsistent rbtree, cur(%u, %u) next(%u, %u)",
-				  cur_re->ofs, cur_re->len,
-				  next_re->ofs, next_re->len);
-			return false;
-		}
-		cur = next;
-	}
-#endif
-	return true;
-}
-
 static struct kmem_cache *extent_tree_slab;
 static struct kmem_cache *extent_node_slab;
 
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -353,15 +353,7 @@ struct discard_info {
 
 struct discard_cmd {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			block_t lstart;	/* logical start address */
-			block_t len;	/* length */
-			block_t start;	/* actual start address in dev */
-		};
-		struct discard_info di;	/* discard info */
-
-	};
+	struct discard_info di;		/* discard info */
 	struct list_head list;		/* command list */
 	struct completion wait;		/* compleation */
 	struct block_device *bdev;	/* bdev */
@@ -4134,19 +4126,6 @@ void f2fs_leave_shrinker(struct f2fs_sb_
  * extent_cache.c
  */
 bool sanity_check_extent_cache(struct inode *inode);
-struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
-				struct rb_entry *cached_re, unsigned int ofs);
-struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root,
-				struct rb_node **parent,
-				unsigned int ofs, bool *leftmost);
-struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
-		struct rb_entry *cached_re, unsigned int ofs,
-		struct rb_entry **prev_entry, struct rb_entry **next_entry,
-		struct rb_node ***insert_p, struct rb_node **insert_parent,
-		bool force, bool *leftmost);
-bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root);
 void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -939,9 +939,9 @@ static struct discard_cmd *__create_disc
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS, true, NULL);
 	INIT_LIST_HEAD(&dc->list);
 	dc->bdev = bdev;
-	dc->lstart = lstart;
-	dc->start = start;
-	dc->len = len;
+	dc->di.lstart = lstart;
+	dc->di.start = start;
+	dc->di.len = len;
 	dc->ref = 0;
 	dc->state = D_PREP;
 	dc->queued = 0;
@@ -956,20 +956,108 @@ static struct discard_cmd *__create_disc
 	return dc;
 }
 
-static struct discard_cmd *__attach_discard_cmd(struct f2fs_sb_info *sbi,
-				struct block_device *bdev, block_t lstart,
-				block_t start, block_t len,
-				struct rb_node *parent, struct rb_node **p,
-				bool leftmost)
+static bool f2fs_check_discard_tree(struct f2fs_sb_info *sbi)
 {
+#ifdef CONFIG_F2FS_CHECK_FS
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct rb_node *cur = rb_first_cached(&dcc->root), *next;
+	struct discard_cmd *cur_dc, *next_dc;
+
+	while (cur) {
+		next = rb_next(cur);
+		if (!next)
+			return true;
+
+		cur_dc = rb_entry(cur, struct discard_cmd, rb_node);
+		next_dc = rb_entry(next, struct discard_cmd, rb_node);
+
+		if (cur_dc->di.lstart + cur_dc->di.len > next_dc->di.lstart) {
+			f2fs_info(sbi, "broken discard_rbtree, "
+				"cur(%u, %u) next(%u, %u)",
+				cur_dc->di.lstart, cur_dc->di.len,
+				next_dc->di.lstart, next_dc->di.len);
+			return false;
+		}
+		cur = next;
+	}
+#endif
+	return true;
+}
+
+static struct discard_cmd *__lookup_discard_cmd(struct f2fs_sb_info *sbi,
+						block_t blkaddr)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct rb_node *node = dcc->root.rb_root.rb_node;
 	struct discard_cmd *dc;
 
-	dc = __create_discard_cmd(sbi, bdev, lstart, start, len);
+	while (node) {
+		dc = rb_entry(node, struct discard_cmd, rb_node);
 
-	rb_link_node(&dc->rb_node, parent, p);
-	rb_insert_color_cached(&dc->rb_node, &dcc->root, leftmost);
+		if (blkaddr < dc->di.lstart)
+			node = node->rb_left;
+		else if (blkaddr >= dc->di.lstart + dc->di.len)
+			node = node->rb_right;
+		else
+			return dc;
+	}
+	return NULL;
+}
+
+static struct discard_cmd *__lookup_discard_cmd_ret(struct rb_root_cached *root,
+				block_t blkaddr,
+				struct discard_cmd **prev_entry,
+				struct discard_cmd **next_entry,
+				struct rb_node ***insert_p,
+				struct rb_node **insert_parent)
+{
+	struct rb_node **pnode = &root->rb_root.rb_node;
+	struct rb_node *parent = NULL, *tmp_node;
+	struct discard_cmd *dc;
 
+	*insert_p = NULL;
+	*insert_parent = NULL;
+	*prev_entry = NULL;
+	*next_entry = NULL;
+
+	if (RB_EMPTY_ROOT(&root->rb_root))
+		return NULL;
+
+	while (*pnode) {
+		parent = *pnode;
+		dc = rb_entry(*pnode, struct discard_cmd, rb_node);
+
+		if (blkaddr < dc->di.lstart)
+			pnode = &(*pnode)->rb_left;
+		else if (blkaddr >= dc->di.lstart + dc->di.len)
+			pnode = &(*pnode)->rb_right;
+		else
+			goto lookup_neighbors;
+	}
+
+	*insert_p = pnode;
+	*insert_parent = parent;
+
+	dc = rb_entry(parent, struct discard_cmd, rb_node);
+	tmp_node = parent;
+	if (parent && blkaddr > dc->di.lstart)
+		tmp_node = rb_next(parent);
+	*next_entry = rb_entry_safe(tmp_node, struct discard_cmd, rb_node);
+
+	tmp_node = parent;
+	if (parent && blkaddr < dc->di.lstart)
+		tmp_node = rb_prev(parent);
+	*prev_entry = rb_entry_safe(tmp_node, struct discard_cmd, rb_node);
+	return NULL;
+
+lookup_neighbors:
+	/* lookup prev node for merging backward later */
+	tmp_node = rb_prev(&dc->rb_node);
+	*prev_entry = rb_entry_safe(tmp_node, struct discard_cmd, rb_node);
+
+	/* lookup next node for merging frontward later */
+	tmp_node = rb_next(&dc->rb_node);
+	*next_entry = rb_entry_safe(tmp_node, struct discard_cmd, rb_node);
 	return dc;
 }
 
@@ -981,7 +1069,7 @@ static void __detach_discard_cmd(struct
 
 	list_del(&dc->list);
 	rb_erase_cached(&dc->rb_node, &dcc->root);
-	dcc->undiscard_blks -= dc->len;
+	dcc->undiscard_blks -= dc->di.len;
 
 	kmem_cache_free(discard_cmd_slab, dc);
 
@@ -994,7 +1082,7 @@ static void __remove_discard_cmd(struct
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	unsigned long flags;
 
-	trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
+	trace_f2fs_remove_discard(dc->bdev, dc->di.start, dc->di.len);
 
 	spin_lock_irqsave(&dc->lock, flags);
 	if (dc->bio_ref) {
@@ -1012,7 +1100,7 @@ static void __remove_discard_cmd(struct
 		printk_ratelimited(
 			"%sF2FS-fs (%s): Issue discard(%u, %u, %u) failed, ret: %d",
 			KERN_INFO, sbi->sb->s_id,
-			dc->lstart, dc->start, dc->len, dc->error);
+			dc->di.lstart, dc->di.start, dc->di.len, dc->error);
 	__detach_discard_cmd(dcc, dc);
 }
 
@@ -1128,14 +1216,14 @@ static int __submit_discard_cmd(struct f
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		return 0;
 
-	trace_f2fs_issue_discard(bdev, dc->start, dc->len);
+	trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
 
-	lstart = dc->lstart;
-	start = dc->start;
-	len = dc->len;
+	lstart = dc->di.lstart;
+	start = dc->di.start;
+	len = dc->di.len;
 	total_len = len;
 
-	dc->len = 0;
+	dc->di.len = 0;
 
 	while (total_len && *issued < dpolicy->max_requests && !err) {
 		struct bio *bio = NULL;
@@ -1151,7 +1239,7 @@ static int __submit_discard_cmd(struct f
 		if (*issued == dpolicy->max_requests)
 			last = true;
 
-		dc->len += len;
+		dc->di.len += len;
 
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			err = -EIO;
@@ -1213,34 +1301,41 @@ static int __submit_discard_cmd(struct f
 	return err;
 }
 
-static void __insert_discard_tree(struct f2fs_sb_info *sbi,
+static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
-				block_t start, block_t len,
-				struct rb_node **insert_p,
-				struct rb_node *insert_parent)
+				block_t start, block_t len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct rb_node **p;
+	struct rb_node **p = &dcc->root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
+	struct discard_cmd *dc;
 	bool leftmost = true;
 
-	if (insert_p && insert_parent) {
-		parent = insert_parent;
-		p = insert_p;
-		goto do_insert;
+	/* look up rb tree to find parent node */
+	while (*p) {
+		parent = *p;
+		dc = rb_entry(parent, struct discard_cmd, rb_node);
+
+		if (lstart < dc->di.lstart) {
+			p = &(*p)->rb_left;
+		} else if (lstart >= dc->di.lstart + dc->di.len) {
+			p = &(*p)->rb_right;
+			leftmost = false;
+		} else {
+			f2fs_bug_on(sbi, 1);
+		}
 	}
 
-	p = f2fs_lookup_rb_tree_for_insert(sbi, &dcc->root, &parent,
-							lstart, &leftmost);
-do_insert:
-	__attach_discard_cmd(sbi, bdev, lstart, start, len, parent,
-								p, leftmost);
+	dc = __create_discard_cmd(sbi, bdev, lstart, start, len);
+
+	rb_link_node(&dc->rb_node, parent, p);
+	rb_insert_color_cached(&dc->rb_node, &dcc->root, leftmost);
 }
 
 static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
 						struct discard_cmd *dc)
 {
-	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->len)]);
+	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->di.len)]);
 }
 
 static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
@@ -1250,7 +1345,7 @@ static void __punch_discard_cmd(struct f
 	struct discard_info di = dc->di;
 	bool modified = false;
 
-	if (dc->state == D_DONE || dc->len == 1) {
+	if (dc->state == D_DONE || dc->di.len == 1) {
 		__remove_discard_cmd(sbi, dc);
 		return;
 	}
@@ -1258,23 +1353,22 @@ static void __punch_discard_cmd(struct f
 	dcc->undiscard_blks -= di.len;
 
 	if (blkaddr > di.lstart) {
-		dc->len = blkaddr - dc->lstart;
-		dcc->undiscard_blks += dc->len;
+		dc->di.len = blkaddr - dc->di.lstart;
+		dcc->undiscard_blks += dc->di.len;
 		__relocate_discard_cmd(dcc, dc);
 		modified = true;
 	}
 
 	if (blkaddr < di.lstart + di.len - 1) {
 		if (modified) {
-			__insert_discard_tree(sbi, dc->bdev, blkaddr + 1,
+			__insert_discard_cmd(sbi, dc->bdev, blkaddr + 1,
 					di.start + blkaddr + 1 - di.lstart,
-					di.lstart + di.len - 1 - blkaddr,
-					NULL, NULL);
+					di.lstart + di.len - 1 - blkaddr);
 		} else {
-			dc->lstart++;
-			dc->len--;
-			dc->start++;
-			dcc->undiscard_blks += dc->len;
+			dc->di.lstart++;
+			dc->di.len--;
+			dc->di.start++;
+			dcc->undiscard_blks += dc->di.len;
 			__relocate_discard_cmd(dcc, dc);
 		}
 	}
@@ -1293,17 +1387,14 @@ static void __update_discard_tree_range(
 			SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
 	block_t end = lstart + len;
 
-	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
-					NULL, lstart,
-					(struct rb_entry **)&prev_dc,
-					(struct rb_entry **)&next_dc,
-					&insert_p, &insert_parent, true, NULL);
+	dc = __lookup_discard_cmd_ret(&dcc->root, lstart,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
 	if (dc)
 		prev_dc = dc;
 
 	if (!prev_dc) {
 		di.lstart = lstart;
-		di.len = next_dc ? next_dc->lstart - lstart : len;
+		di.len = next_dc ? next_dc->di.lstart - lstart : len;
 		di.len = min(di.len, len);
 		di.start = start;
 	}
@@ -1314,16 +1405,16 @@ static void __update_discard_tree_range(
 		struct discard_cmd *tdc = NULL;
 
 		if (prev_dc) {
-			di.lstart = prev_dc->lstart + prev_dc->len;
+			di.lstart = prev_dc->di.lstart + prev_dc->di.len;
 			if (di.lstart < lstart)
 				di.lstart = lstart;
 			if (di.lstart >= end)
 				break;
 
-			if (!next_dc || next_dc->lstart > end)
+			if (!next_dc || next_dc->di.lstart > end)
 				di.len = end - di.lstart;
 			else
-				di.len = next_dc->lstart - di.lstart;
+				di.len = next_dc->di.lstart - di.lstart;
 			di.start = start + di.lstart - lstart;
 		}
 
@@ -1356,10 +1447,9 @@ static void __update_discard_tree_range(
 			merged = true;
 		}
 
-		if (!merged) {
-			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
-							di.len, NULL, NULL);
-		}
+		if (!merged)
+			__insert_discard_cmd(sbi, bdev,
+						di.lstart, di.start, di.len);
  next:
 		prev_dc = next_dc;
 		if (!prev_dc)
@@ -1398,15 +1488,11 @@ static void __issue_discard_cmd_orderly(
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	struct discard_cmd *dc;
 	struct blk_plug plug;
-	unsigned int pos = dcc->next_pos;
 	bool io_interrupted = false;
 
 	mutex_lock(&dcc->cmd_lock);
-	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
-					NULL, pos,
-					(struct rb_entry **)&prev_dc,
-					(struct rb_entry **)&next_dc,
-					&insert_p, &insert_parent, true, NULL);
+	dc = __lookup_discard_cmd_ret(&dcc->root, dcc->next_pos,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
 	if (!dc)
 		dc = next_dc;
 
@@ -1424,7 +1510,7 @@ static void __issue_discard_cmd_orderly(
 			break;
 		}
 
-		dcc->next_pos = dc->lstart + dc->len;
+		dcc->next_pos = dc->di.lstart + dc->di.len;
 		err = __submit_discard_cmd(sbi, dpolicy, dc, issued);
 
 		if (*issued >= dpolicy->max_requests)
@@ -1483,8 +1569,7 @@ retry:
 		if (list_empty(pend_list))
 			goto next;
 		if (unlikely(dcc->rbtree_check))
-			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root));
+			f2fs_bug_on(sbi, !f2fs_check_discard_tree(sbi));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -1562,7 +1647,7 @@ static unsigned int __wait_one_discard_b
 	dc->ref--;
 	if (!dc->ref) {
 		if (!dc->error)
-			len = dc->len;
+			len = dc->di.len;
 		__remove_discard_cmd(sbi, dc);
 	}
 	mutex_unlock(&dcc->cmd_lock);
@@ -1585,14 +1670,15 @@ next:
 
 	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(iter, tmp, wait_list, list) {
-		if (iter->lstart + iter->len <= start || end <= iter->lstart)
+		if (iter->di.lstart + iter->di.len <= start ||
+					end <= iter->di.lstart)
 			continue;
-		if (iter->len < dpolicy->granularity)
+		if (iter->di.len < dpolicy->granularity)
 			continue;
 		if (iter->state == D_DONE && !iter->ref) {
 			wait_for_completion_io(&iter->wait);
 			if (!iter->error)
-				trimmed += iter->len;
+				trimmed += iter->di.len;
 			__remove_discard_cmd(sbi, iter);
 		} else {
 			iter->ref++;
@@ -1636,8 +1722,7 @@ static void f2fs_wait_discard_bio(struct
 	bool need_wait = false;
 
 	mutex_lock(&dcc->cmd_lock);
-	dc = (struct discard_cmd *)f2fs_lookup_rb_tree(&dcc->root,
-							NULL, blkaddr);
+	dc = __lookup_discard_cmd(sbi, blkaddr);
 	if (dc) {
 		if (dc->state == D_PREP) {
 			__punch_discard_cmd(sbi, dc, blkaddr);
@@ -2970,24 +3055,20 @@ next:
 
 	mutex_lock(&dcc->cmd_lock);
 	if (unlikely(dcc->rbtree_check))
-		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root));
+		f2fs_bug_on(sbi, !f2fs_check_discard_tree(sbi));
 
-	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
-					NULL, start,
-					(struct rb_entry **)&prev_dc,
-					(struct rb_entry **)&next_dc,
-					&insert_p, &insert_parent, true, NULL);
+	dc = __lookup_discard_cmd_ret(&dcc->root, start,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
 	if (!dc)
 		dc = next_dc;
 
 	blk_start_plug(&plug);
 
-	while (dc && dc->lstart <= end) {
+	while (dc && dc->di.lstart <= end) {
 		struct rb_node *node;
 		int err = 0;
 
-		if (dc->len < dpolicy->granularity)
+		if (dc->di.len < dpolicy->granularity)
 			goto skip;
 
 		if (dc->state != D_PREP) {
@@ -2998,7 +3079,7 @@ next:
 		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
 		if (issued >= dpolicy->max_requests) {
-			start = dc->lstart + dc->len;
+			start = dc->di.lstart + dc->di.len;
 
 			if (err)
 				__remove_discard_cmd(sbi, dc);


