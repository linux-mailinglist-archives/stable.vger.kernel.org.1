Return-Path: <stable+bounces-3499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC0C7FF5F5
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A6B21125
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE13AC1A;
	Thu, 30 Nov 2023 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XT2ItjVy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43254F9C;
	Thu, 30 Nov 2023 16:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B746C433C8;
	Thu, 30 Nov 2023 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361986;
	bh=huTe7z2b8kG8LAU8M6FeLNK236e0RPea+jp1RWQfc8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT2ItjVyHYdfTS3JYW0pNfSHMujWIBBIYP803l8+wJzYwQOH60bV4dkp911xQXm/g
	 MyBMXuR8WhLC1no8Q6hZl04F6wdy+Of6mzQGkJ6e5jRgWaLenT4MUzeLrK5oVWHeN+
	 cHhHqcEkZzXxE7fB93zIgu5lKoHJMWdYH9x2dKY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 41/69] ext4: make sure allocate pending entry not fail
Date: Thu, 30 Nov 2023 16:22:38 +0000
Message-ID: <20231130162134.431214209@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 6c55ab427e650..cccbdfd49a86b 100644
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
@@ -450,6 +451,19 @@ static void ext4_es_list_del(struct inode *inode)
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
@@ -841,11 +855,12 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -873,11 +888,17 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
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
@@ -902,13 +923,18 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1316,7 +1342,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				rc->ndelonly--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
-				kmem_cache_free(ext4_pending_cachep, pr);
+				__free_pending(pr);
 				if (!node)
 					break;
 				pr = rb_entry(node, struct pending_reservation,
@@ -1913,11 +1939,13 @@ static struct pending_reservation *__get_pending(struct inode *inode,
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
@@ -1943,10 +1971,15 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
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
 
@@ -1976,7 +2009,7 @@ static void __remove_pending(struct inode *inode, ext4_lblk_t lblk)
 	if (pr != NULL) {
 		tree = &EXT4_I(inode)->i_pending_tree;
 		rb_erase(&pr->rb_node, &tree->root);
-		kmem_cache_free(ext4_pending_cachep, pr);
+		__free_pending(pr);
 	}
 }
 
@@ -2037,10 +2070,10 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 				 bool allocated)
 {
 	struct extent_status newes;
-	int err1 = 0;
-	int err2 = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -2060,6 +2093,8 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && allocated && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
 	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
@@ -2082,11 +2117,18 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2192,21 +2234,24 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2227,7 +2272,9 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2235,9 +2282,11 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2245,18 +2294,24 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
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




