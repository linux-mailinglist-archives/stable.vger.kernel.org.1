Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D837037C8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbjEORYO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbjEORXo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94463E738
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1587B62C7A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F4C4339B;
        Mon, 15 May 2023 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171338;
        bh=pH0t4nI0eBGC4akHnB/uS6AKa6ck3vi4yU3de+OCVc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1iFqfqMF4W533ogv24rxff5C9S4gZxuWapN2sMqHvzO/P96VhfT805wKrdnPBjdHM
         b0Mev+FDEyyPLZkdgv8juNLLRKxEXy1DvWOrJk1eyq5+jsmiMPx6V6YWuHcAKK9Ofs
         uG4Bx29bfS9QpCZpQR7Sw77OvPDO+glW1ITHTqqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.2 178/242] f2fs: factor out victim_entry usage from general rb_tree use
Date:   Mon, 15 May 2023 18:28:24 +0200
Message-Id: <20230515161727.216610538@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 043d2d00b44310f84c0593c63e51fae88c829cdd upstream.

Let's reduce the complexity of mixed use of rb_tree in victim_entry from
extent_cache and discard_cmd.

This should fix arm32 memory alignment issue caused by shared rb_entry.

[struct victim_entry]              [struct rb_entry]
[0] struct rb_node rb_node;        [0] struct rb_node rb_node;
                                       union {
                                         struct {
                                           unsigned int ofs;
                                           unsigned int len;
                                         };
[16] unsigned long long mtime;     [12] unsigned long long key;
                                       } __packed;

Cc: <stable@vger.kernel.org>
Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/extent_cache.c |   36 ------------
 fs/f2fs/f2fs.h         |   15 +----
 fs/f2fs/gc.c           |  139 +++++++++++++++++++++++++++++--------------------
 fs/f2fs/gc.h           |   14 ----
 fs/f2fs/segment.c      |    4 -
 5 files changed, 93 insertions(+), 115 deletions(-)

--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -179,29 +179,6 @@ struct rb_entry *f2fs_lookup_rb_tree(str
 	return re;
 }
 
-struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
-					struct rb_root_cached *root,
-					struct rb_node **parent,
-					unsigned long long key, bool *leftmost)
-{
-	struct rb_node **p = &root->rb_root.rb_node;
-	struct rb_entry *re;
-
-	while (*p) {
-		*parent = *p;
-		re = rb_entry(*parent, struct rb_entry, rb_node);
-
-		if (key < re->key) {
-			p = &(*p)->rb_left;
-		} else {
-			p = &(*p)->rb_right;
-			*leftmost = false;
-		}
-	}
-
-	return p;
-}
-
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -310,7 +287,7 @@ lookup_neighbors:
 }
 
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root, bool check_key)
+				struct rb_root_cached *root)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
 	struct rb_node *cur = rb_first_cached(root), *next;
@@ -327,23 +304,12 @@ bool f2fs_check_rb_tree_consistence(stru
 		cur_re = rb_entry(cur, struct rb_entry, rb_node);
 		next_re = rb_entry(next, struct rb_entry, rb_node);
 
-		if (check_key) {
-			if (cur_re->key > next_re->key) {
-				f2fs_info(sbi, "inconsistent rbtree, "
-					"cur(%llu) next(%llu)",
-					cur_re->key, next_re->key);
-				return false;
-			}
-			goto next;
-		}
-
 		if (cur_re->ofs + cur_re->len > next_re->ofs) {
 			f2fs_info(sbi, "inconsistent rbtree, cur(%u, %u) next(%u, %u)",
 				  cur_re->ofs, cur_re->len,
 				  next_re->ofs, next_re->len);
 			return false;
 		}
-next:
 		cur = next;
 	}
 #endif
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -629,13 +629,8 @@ enum extent_type {
 
 struct rb_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			unsigned int ofs;	/* start offset of the entry */
-			unsigned int len;	/* length of the entry */
-		};
-		unsigned long long key;		/* 64-bits key */
-	} __packed;
+	unsigned int ofs;		/* start offset of the entry */
+	unsigned int len;		/* length of the entry */
 };
 
 struct extent_info {
@@ -4164,10 +4159,6 @@ void f2fs_leave_shrinker(struct f2fs_sb_
  */
 struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs);
-struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root,
-				struct rb_node **parent,
-				unsigned long long key, bool *left_most);
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -4178,7 +4169,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
 		bool force, bool *leftmost);
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root, bool check_key);
+				struct rb_root_cached *root);
 void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -392,40 +392,95 @@ static unsigned int count_bits(const uns
 	return sum;
 }
 
-static struct victim_entry *attach_victim_entry(struct f2fs_sb_info *sbi,
-				unsigned long long mtime, unsigned int segno,
-				struct rb_node *parent, struct rb_node **p,
-				bool left_most)
+static bool f2fs_check_victim_tree(struct f2fs_sb_info *sbi,
+				struct rb_root_cached *root)
+{
+#ifdef CONFIG_F2FS_CHECK_FS
+	struct rb_node *cur = rb_first_cached(root), *next;
+	struct victim_entry *cur_ve, *next_ve;
+
+	while (cur) {
+		next = rb_next(cur);
+		if (!next)
+			return true;
+
+		cur_ve = rb_entry(cur, struct victim_entry, rb_node);
+		next_ve = rb_entry(next, struct victim_entry, rb_node);
+
+		if (cur_ve->mtime > next_ve->mtime) {
+			f2fs_info(sbi, "broken victim_rbtree, "
+				"cur_mtime(%llu) next_mtime(%llu)",
+				cur_ve->mtime, next_ve->mtime);
+			return false;
+		}
+		cur = next;
+	}
+#endif
+	return true;
+}
+
+static struct victim_entry *__lookup_victim_entry(struct f2fs_sb_info *sbi,
+					unsigned long long mtime)
+{
+	struct atgc_management *am = &sbi->am;
+	struct rb_node *node = am->root.rb_root.rb_node;
+	struct victim_entry *ve = NULL;
+
+	while (node) {
+		ve = rb_entry(node, struct victim_entry, rb_node);
+
+		if (mtime < ve->mtime)
+			node = node->rb_left;
+		else
+			node = node->rb_right;
+	}
+	return ve;
+}
+
+static struct victim_entry *__create_victim_entry(struct f2fs_sb_info *sbi,
+		unsigned long long mtime, unsigned int segno)
 {
 	struct atgc_management *am = &sbi->am;
 	struct victim_entry *ve;
 
-	ve =  f2fs_kmem_cache_alloc(victim_entry_slab,
-				GFP_NOFS, true, NULL);
+	ve =  f2fs_kmem_cache_alloc(victim_entry_slab, GFP_NOFS, true, NULL);
 
 	ve->mtime = mtime;
 	ve->segno = segno;
 
-	rb_link_node(&ve->rb_node, parent, p);
-	rb_insert_color_cached(&ve->rb_node, &am->root, left_most);
-
 	list_add_tail(&ve->list, &am->victim_list);
-
 	am->victim_count++;
 
 	return ve;
 }
 
-static void insert_victim_entry(struct f2fs_sb_info *sbi,
+static void __insert_victim_entry(struct f2fs_sb_info *sbi,
 				unsigned long long mtime, unsigned int segno)
 {
 	struct atgc_management *am = &sbi->am;
-	struct rb_node **p;
+	struct rb_root_cached *root = &am->root;
+	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *parent = NULL;
+	struct victim_entry *ve;
 	bool left_most = true;
 
-	p = f2fs_lookup_rb_tree_ext(sbi, &am->root, &parent, mtime, &left_most);
-	attach_victim_entry(sbi, mtime, segno, parent, p, left_most);
+	/* look up rb tree to find parent node */
+	while (*p) {
+		parent = *p;
+		ve = rb_entry(parent, struct victim_entry, rb_node);
+
+		if (mtime < ve->mtime) {
+			p = &(*p)->rb_left;
+		} else {
+			p = &(*p)->rb_right;
+			left_most = false;
+		}
+	}
+
+	ve = __create_victim_entry(sbi, mtime, segno);
+
+	rb_link_node(&ve->rb_node, parent, p);
+	rb_insert_color_cached(&ve->rb_node, root, left_most);
 }
 
 static void add_victim_entry(struct f2fs_sb_info *sbi,
@@ -461,19 +516,7 @@ static void add_victim_entry(struct f2fs
 	if (sit_i->dirty_max_mtime - mtime < p->age_threshold)
 		return;
 
-	insert_victim_entry(sbi, mtime, segno);
-}
-
-static struct rb_node *lookup_central_victim(struct f2fs_sb_info *sbi,
-						struct victim_sel_policy *p)
-{
-	struct atgc_management *am = &sbi->am;
-	struct rb_node *parent = NULL;
-	bool left_most;
-
-	f2fs_lookup_rb_tree_ext(sbi, &am->root, &parent, p->age, &left_most);
-
-	return parent;
+	__insert_victim_entry(sbi, mtime, segno);
 }
 
 static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
@@ -483,7 +526,6 @@ static void atgc_lookup_victim(struct f2
 	struct atgc_management *am = &sbi->am;
 	struct rb_root_cached *root = &am->root;
 	struct rb_node *node;
-	struct rb_entry *re;
 	struct victim_entry *ve;
 	unsigned long long total_time;
 	unsigned long long age, u, accu;
@@ -510,12 +552,10 @@ static void atgc_lookup_victim(struct f2
 
 	node = rb_first_cached(root);
 next:
-	re = rb_entry_safe(node, struct rb_entry, rb_node);
-	if (!re)
+	ve = rb_entry_safe(node, struct victim_entry, rb_node);
+	if (!ve)
 		return;
 
-	ve = (struct victim_entry *)re;
-
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip;
 
@@ -557,8 +597,6 @@ static void atssr_lookup_victim(struct f
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct atgc_management *am = &sbi->am;
-	struct rb_node *node;
-	struct rb_entry *re;
 	struct victim_entry *ve;
 	unsigned long long age;
 	unsigned long long max_mtime = sit_i->dirty_max_mtime;
@@ -568,25 +606,22 @@ static void atssr_lookup_victim(struct f
 	unsigned int dirty_threshold = max(am->max_candidate_count,
 					am->candidate_ratio *
 					am->victim_count / 100);
-	unsigned int cost;
-	unsigned int iter = 0;
+	unsigned int cost, iter;
 	int stage = 0;
 
 	if (max_mtime < min_mtime)
 		return;
 	max_mtime += 1;
 next_stage:
-	node = lookup_central_victim(sbi, p);
+	iter = 0;
+	ve = __lookup_victim_entry(sbi, p->age);
 next_node:
-	re = rb_entry_safe(node, struct rb_entry, rb_node);
-	if (!re) {
-		if (stage == 0)
-			goto skip_stage;
+	if (!ve) {
+		if (stage++ == 0)
+			goto next_stage;
 		return;
 	}
 
-	ve = (struct victim_entry *)re;
-
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip_node;
 
@@ -612,24 +647,20 @@ next_node:
 	}
 skip_node:
 	if (iter < dirty_threshold) {
-		if (stage == 0)
-			node = rb_prev(node);
-		else if (stage == 1)
-			node = rb_next(node);
+		ve = rb_entry(stage == 0 ? rb_prev(&ve->rb_node) :
+					rb_next(&ve->rb_node),
+					struct victim_entry, rb_node);
 		goto next_node;
 	}
-skip_stage:
-	if (stage < 1) {
-		stage++;
-		iter = 0;
+
+	if (stage++ == 0)
 		goto next_stage;
-	}
 }
+
 static void lookup_victim_by_age(struct f2fs_sb_info *sbi,
 						struct victim_sel_policy *p)
 {
-	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-						&sbi->am.root, true));
+	f2fs_bug_on(sbi, !f2fs_check_victim_tree(sbi, &sbi->am.root));
 
 	if (p->gc_mode == GC_AT)
 		atgc_lookup_victim(sbi, p);
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -55,20 +55,10 @@ struct gc_inode_list {
 	struct radix_tree_root iroot;
 };
 
-struct victim_info {
-	unsigned long long mtime;	/* mtime of section */
-	unsigned int segno;		/* section No. */
-};
-
 struct victim_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			unsigned long long mtime;	/* mtime of section */
-			unsigned int segno;		/* segment No. */
-		};
-		struct victim_info vi;	/* victim info */
-	};
+	unsigned long long mtime;	/* mtime of section */
+	unsigned int segno;		/* segment No. */
 	struct list_head list;
 };
 
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1487,7 +1487,7 @@ retry:
 			goto next;
 		if (unlikely(dcc->rbtree_check))
 			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root, false));
+							&dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -3003,7 +3003,7 @@ next:
 	mutex_lock(&dcc->cmd_lock);
 	if (unlikely(dcc->rbtree_check))
 		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root, false));
+							&dcc->root));
 
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,


