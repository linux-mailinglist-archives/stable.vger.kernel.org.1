Return-Path: <stable+bounces-4557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6338047FD
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D7C1C20E6B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7968BF8;
	Tue,  5 Dec 2023 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYHbSQTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BC6FB0;
	Tue,  5 Dec 2023 03:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1158C433C7;
	Tue,  5 Dec 2023 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747876;
	bh=EaXDLPJdBgZfqNdcHxxCuoCVYbLJO8GIhkf2pCbUaaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYHbSQTBKrP700Rd3C07+HHGYe4s9qJBNM5msn7dRqN9XKDoe61i6XduYSzRI4A9B
	 vCl+WnXv12vOuqLtvSHNiKshWhzVHDxYW2NjvKhazfUsQIiiMZoKmbGMR94VoxSfqq
	 51+RfVnAEuH7xXyUEfip4a2aKLqhIXTi5EnFYryw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 31/94] ext4: make sure allocate pending entry not fail
Date: Tue,  5 Dec 2023 12:16:59 +0900
Message-ID: <20231205031524.644869919@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 8e387c89e96b9543a339f84043cf9df15fed2632 ]

__insert_pending() allocate memory in atomic context, so the allocation
could fail, but we are not handling that failure now. It could lead
ext4_es_remove_extent() to get wrong reserved clusters, and the global
data blocks reservation count will be incorrect. The same to
extents_status entry preallocation, preallocate pending entry out of the
i_es_lock with __GFP_NOFAIL, make sure __insert_pending() and
__revise_pending() always succeeds.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230824092619.1327976-3-yi.zhang@huaweicloud.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents_status.c | 123 ++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4b47bccc3834a..3346a9252063b 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -152,8 +152,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
-static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
-			     ext4_lblk_t len);
+static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
+			    ext4_lblk_t len,
+			    struct pending_reservation **prealloc);
 
 int __init ext4_init_es(void)
 {
@@ -441,6 +442,19 @@ static void ext4_es_list_del(struct inode *inode)
 	spin_unlock(&sbi->s_es_lock);
 }
 
+static inline struct pending_reservation *__alloc_pending(bool nofail)
+{
+	if (!nofail)
+		return kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
+
+	return kmem_cache_zalloc(ext4_pending_cachep, GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static inline void __free_pending(struct pending_reservation *pr)
+{
+	kmem_cache_free(ext4_pending_cachep, pr);
+}
+
 /*
  * Returns true if we cannot fail to allocate memory for this extent_status
  * entry and cannot reclaim it until its status changes.
@@ -832,11 +846,12 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
-	int err1 = 0;
-	int err2 = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
+	bool revise_pending = false;
 
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
@@ -861,11 +876,17 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_insert_extent_check(inode, &newes);
 
+	revise_pending = sbi->s_cluster_ratio > 1 &&
+			 test_opt(inode->i_sb, DELALLOC) &&
+			 (status & (EXTENT_STATUS_WRITTEN |
+				    EXTENT_STATUS_UNWRITTEN));
 retry:
 	if (err1 && !es1)
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && revise_pending && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
 	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
@@ -890,13 +911,18 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		es2 = NULL;
 	}
 
-	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
-	    (status & EXTENT_STATUS_WRITTEN ||
-	     status & EXTENT_STATUS_UNWRITTEN))
-		__revise_pending(inode, lblk, len);
+	if (revise_pending) {
+		err3 = __revise_pending(inode, lblk, len, &pr);
+		if (err3 != 0)
+			goto error;
+		if (pr) {
+			__free_pending(pr);
+			pr = NULL;
+		}
+	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2)
+	if (err1 || err2 || err3)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -1298,7 +1324,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				rc->ndelonly--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
-				kmem_cache_free(ext4_pending_cachep, pr);
+				__free_pending(pr);
 				if (!node)
 					break;
 				pr = rb_entry(node, struct pending_reservation,
@@ -1892,11 +1918,13 @@ static struct pending_reservation *__get_pending(struct inode *inode,
  *
  * @inode - file containing the cluster
  * @lblk - logical block in the cluster to be added
+ * @prealloc - preallocated pending entry
  *
  * Returns 0 on successful insertion and -ENOMEM on failure.  If the
  * pending reservation is already in the set, returns successfully.
  */
-static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
+static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
+			    struct pending_reservation **prealloc)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
@@ -1922,10 +1950,15 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	pr = kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
-	if (pr == NULL) {
-		ret = -ENOMEM;
-		goto out;
+	if (likely(*prealloc == NULL)) {
+		pr = __alloc_pending(false);
+		if (!pr) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		pr = *prealloc;
+		*prealloc = NULL;
 	}
 	pr->lclu = lclu;
 
@@ -1955,7 +1988,7 @@ static void __remove_pending(struct inode *inode, ext4_lblk_t lblk)
 	if (pr != NULL) {
 		tree = &EXT4_I(inode)->i_pending_tree;
 		rb_erase(&pr->rb_node, &tree->root);
-		kmem_cache_free(ext4_pending_cachep, pr);
+		__free_pending(pr);
 	}
 }
 
@@ -2016,10 +2049,10 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 				 bool allocated)
 {
 	struct extent_status newes;
-	int err1 = 0;
-	int err2 = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
 
 	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
 		 lblk, inode->i_ino);
@@ -2036,6 +2069,8 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && allocated && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
 	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
@@ -2058,11 +2093,18 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es2 = NULL;
 	}
 
-	if (allocated)
-		__insert_pending(inode, lblk);
+	if (allocated) {
+		err3 = __insert_pending(inode, lblk, &pr);
+		if (err3 != 0)
+			goto error;
+		if (pr) {
+			__free_pending(pr);
+			pr = NULL;
+		}
+	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2)
+	if (err1 || err2 || err3)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -2168,21 +2210,24 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
  * @inode - file containing the range
  * @lblk - logical block defining the start of range
  * @len  - length of range in blocks
+ * @prealloc - preallocated pending entry
  *
  * Used after a newly allocated extent is added to the extents status tree.
  * Requires that the extents in the range have either written or unwritten
  * status.  Must be called while holding i_es_lock.
  */
-static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
-			     ext4_lblk_t len)
+static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
+			    ext4_lblk_t len,
+			    struct pending_reservation **prealloc)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int ret = 0;
 
 	if (len == 0)
-		return;
+		return 0;
 
 	/*
 	 * Two cases - block range within single cluster and block range
@@ -2203,7 +2248,9 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						first, lblk - 1);
 		if (f_del) {
-			__insert_pending(inode, first);
+			ret = __insert_pending(inode, first, prealloc);
+			if (ret < 0)
+				goto out;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2211,9 +2258,11 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				l_del = __es_scan_range(inode,
 							&ext4_es_is_delonly,
 							end + 1, last);
-			if (l_del)
-				__insert_pending(inode, last);
-			else
+			if (l_del) {
+				ret = __insert_pending(inode, last, prealloc);
+				if (ret < 0)
+					goto out;
+			} else
 				__remove_pending(inode, last);
 		}
 	} else {
@@ -2221,18 +2270,24 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 		if (first != lblk)
 			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						first, lblk - 1);
-		if (f_del)
-			__insert_pending(inode, first);
-		else
+		if (f_del) {
+			ret = __insert_pending(inode, first, prealloc);
+			if (ret < 0)
+				goto out;
+		} else
 			__remove_pending(inode, first);
 
 		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
 		if (last != end)
 			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						end + 1, last);
-		if (l_del)
-			__insert_pending(inode, last);
-		else
+		if (l_del) {
+			ret = __insert_pending(inode, last, prealloc);
+			if (ret < 0)
+				goto out;
+		} else
 			__remove_pending(inode, last);
 	}
+out:
+	return ret;
 }
-- 
2.42.0




