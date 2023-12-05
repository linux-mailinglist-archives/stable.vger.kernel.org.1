Return-Path: <stable+bounces-4384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57708804742
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1212428159C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ACDA59;
	Tue,  5 Dec 2023 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OnJBD7Pj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549F6FB1;
	Tue,  5 Dec 2023 03:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA20EC433C8;
	Tue,  5 Dec 2023 03:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747400;
	bh=inIM4ESm5HhgT2MEtOZkM8Ho0exIPtYB8THJcW14xOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OnJBD7Pj2QtpIUki+VFz3A+M/rOhjzALhFKr6XbX+y243nNLCTYkd6xt+sCLwLHln
	 RTdgKCWGfrsWcEmObQjEttaIzmjcQu63853L3Z1OODCUduF2AoRG3d9UHSNpKPmrnW
	 +U5eTXQocwkRVwXjQRwOHTtoIvdkYfDA1u0WSROM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 038/135] ext4: add a new helper to check if es must be kept
Date: Tue,  5 Dec 2023 12:15:59 +0900
Message-ID: <20231205031533.038943842@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 9649eb18c6288f514cacffdd699d5cd999c2f8f6 ]

In the extent status tree, we have extents which we can just drop without
issues and extents we must not drop - this depends on the extent's status
- currently ext4_es_is_delayed() extents must stay, others may be dropped.

A helper function is added to help determine if the current extent can
be dropped, although only ext4_es_is_delayed() extents cannot be dropped
currently.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230424033846.4732-3-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 8e387c89e96b ("ext4: make sure allocate pending entry not fail")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents_status.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7806adcc41a7a..cf6a21baddbc4 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -448,6 +448,19 @@ static void ext4_es_list_del(struct inode *inode)
 	spin_unlock(&sbi->s_es_lock);
 }
 
+/*
+ * Returns true if we cannot fail to allocate memory for this extent_status
+ * entry and cannot reclaim it until its status changes.
+ */
+static inline bool ext4_es_must_keep(struct extent_status *es)
+{
+	/* fiemap, bigalloc, and seek_data/hole need to use it. */
+	if (ext4_es_is_delayed(es))
+		return true;
+
+	return false;
+}
+
 static struct extent_status *
 ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 		     ext4_fsblk_t pblk)
@@ -460,10 +473,8 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 	es->es_len = len;
 	es->es_pblk = pblk;
 
-	/*
-	 * We don't count delayed extent because we never try to reclaim them
-	 */
-	if (!ext4_es_is_delayed(es)) {
+	/* We never try to reclaim a must kept extent, so we don't count it. */
+	if (!ext4_es_must_keep(es)) {
 		if (!EXT4_I(inode)->i_es_shk_nr++)
 			ext4_es_list_add(inode);
 		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
@@ -481,8 +492,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 	EXT4_I(inode)->i_es_all_nr--;
 	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
 
-	/* Decrease the shrink counter when this es is not delayed */
-	if (!ext4_es_is_delayed(es)) {
+	/* Decrease the shrink counter when we can reclaim the extent. */
+	if (!ext4_es_must_keep(es)) {
 		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
 		if (!--EXT4_I(inode)->i_es_shk_nr)
 			ext4_es_list_del(inode);
@@ -854,7 +865,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
-	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
+	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
 		err = 0;
 
 	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
@@ -1704,11 +1715,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
 
 		(*nr_to_scan)--;
 		node = rb_next(&es->rb_node);
-		/*
-		 * We can't reclaim delayed extent from status tree because
-		 * fiemap, bigallic, and seek_data/hole need to use it.
-		 */
-		if (ext4_es_is_delayed(es))
+
+		if (ext4_es_must_keep(es))
 			goto next;
 		if (ext4_es_is_referenced(es)) {
 			ext4_es_clear_referenced(es);
@@ -1772,7 +1780,7 @@ void ext4_clear_inode_es(struct inode *inode)
 	while (node) {
 		es = rb_entry(node, struct extent_status, rb_node);
 		node = rb_next(node);
-		if (!ext4_es_is_delayed(es)) {
+		if (!ext4_es_must_keep(es)) {
 			rb_erase(&es->rb_node, &tree->root);
 			ext4_es_free_extent(inode, es);
 		}
-- 
2.42.0




