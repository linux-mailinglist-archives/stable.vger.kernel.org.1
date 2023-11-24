Return-Path: <stable+bounces-204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138677F757B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BC9281FC5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D528E26;
	Fri, 24 Nov 2023 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xx8rDQXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6B28E2C
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78E9C433C9;
	Fri, 24 Nov 2023 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833638;
	bh=Fsz+mlvlnNSpUfLnca2BiHh94nkdTUqdrcP4vx66G8I=;
	h=Subject:To:Cc:From:Date:From;
	b=Xx8rDQXrs6U5GCOYYmW9blDiqNhKzjxsptIRAcanWJPmfsTOucoM1BDfwNvxK2XKw
	 F+HcpJAUsNVE1UjQWOQ5tHIlLCfQZktKeEvhCuEUh1Of+TthHhuWUK4/g8mgmvUwNL
	 gF7tiBv+O0OiCaSGa3YDJj9UyVi8+eAKjG9T/3Dk=
Subject: FAILED: patch "[PATCH] ext4: no need to generate from free list in mballoc" failed to apply to 6.5-stable tree
To: wangjianjian0@foxmail.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:47:15 +0000
Message-ID: <2023112415-stabilize-splashy-9350@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x ebf6cb7c6e1241984f75f29f1bdbfa2fe7168f88
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112415-stabilize-splashy-9350@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

ebf6cb7c6e12 ("ext4: no need to generate from free list in mballoc")
ad635507b5b2 ("ext4: remove unnecessary return for void function")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebf6cb7c6e1241984f75f29f1bdbfa2fe7168f88 Mon Sep 17 00:00:00 2001
From: Wang Jianjian <wangjianjian0@foxmail.com>
Date: Thu, 24 Aug 2023 23:56:31 +0800
Subject: [PATCH] ext4: no need to generate from free list in mballoc

Commit 7a2fcbf7f85 ("ext4: don't use blocks freed but not yet committed in
buddy cache init") added a code to mark as used blocks in the list of not yet
committed freed blocks during initialization of a buddy page. However
ext4_mb_free_metadata() makes sure buddy page is already loaded and takes a
reference to it so it cannot happen that ext4_mb_init_cache() is called
when efd list is non-empty. Just remove the
ext4_mb_generate_from_freelist() call.

Fixes: 7a2fcbf7f85('ext4: don't use blocks freed but not yet committed in buddy cache init')
Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
Link: https://lore.kernel.org/r/tencent_53CBCB1668358AE862684E453DF37B722008@qq.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1d65c738c4c9..6e304c18d390 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -417,8 +417,6 @@ static const char * const ext4_groupinfo_slab_names[NR_GRPINFO_CACHES] = {
 
 static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 					ext4_group_t group);
-static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
-						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
@@ -1361,17 +1359,17 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		 * We place the buddy block and bitmap block
 		 * close together
 		 */
+		grinfo = ext4_get_group_info(sb, group);
+		if (!grinfo) {
+			err = -EFSCORRUPTED;
+		        goto out;
+		}
 		if ((first_block + i) & 1) {
 			/* this is block of buddy */
 			BUG_ON(incore == NULL);
 			mb_debug(sb, "put buddy for group %u in page %lu/%x\n",
 				group, page->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
-			grinfo = ext4_get_group_info(sb, group);
-			if (!grinfo) {
-				err = -EFSCORRUPTED;
-				goto out;
-			}
 			grinfo->bb_fragments = 0;
 			memset(grinfo->bb_counters, 0,
 			       sizeof(*grinfo->bb_counters) *
@@ -1398,7 +1396,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 
 			/* mark all preallocated blks used in in-core bitmap */
 			ext4_mb_generate_from_pa(sb, data, group);
-			ext4_mb_generate_from_freelist(sb, data, group);
+			WARN_ON_ONCE(!RB_EMPTY_ROOT(&grinfo->bb_free_root));
 			ext4_unlock_group(sb, group);
 
 			/* set incore so that the buddy information can be
@@ -4950,31 +4948,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	return false;
 }
 
-/*
- * the function goes through all block freed in the group
- * but not yet committed and marks them used in in-core bitmap.
- * buddy must be generated from this bitmap
- * Need to be called with the ext4 group lock held
- */
-static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
-						ext4_group_t group)
-{
-	struct rb_node *n;
-	struct ext4_group_info *grp;
-	struct ext4_free_data *entry;
-
-	grp = ext4_get_group_info(sb, group);
-	if (!grp)
-		return;
-	n = rb_first(&(grp->bb_free_root));
-
-	while (n) {
-		entry = rb_entry(n, struct ext4_free_data, efd_node);
-		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
-		n = rb_next(n);
-	}
-}
-
 /*
  * the function goes through all preallocation in this group and marks them
  * used in in-core bitmap. buddy must be generated from this bitmap


