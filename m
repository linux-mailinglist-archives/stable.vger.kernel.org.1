Return-Path: <stable+bounces-211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10587F7583
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBD1C20FC3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26428E36;
	Fri, 24 Nov 2023 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lyuvGhVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10E28E2C
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED52C433C8;
	Fri, 24 Nov 2023 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833655;
	bh=khw7DP2b0nj/xQ1jir5z4RO9HNa6IuavkMCfUkx1CzM=;
	h=Subject:To:Cc:From:Date:From;
	b=lyuvGhVM1GoR2INB65QnLfDEzWx+bIqrmuqPoduOp10ITwCpYnG8XOirurqlNeZvW
	 OAWtj6GaO1T4ZCzjMHXoy5v9xTlrPjjx9E7oAkbITabG+IQbKoyAF8701THMUDs3ek
	 4114XznC30VKY089OhKVMa5uTnNfJA+K3/DqzAtQ=
Subject: FAILED: patch "[PATCH] ext4: no need to generate from free list in mballoc" failed to apply to 4.14-stable tree
To: wangjianjian0@foxmail.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:47:21 +0000
Message-ID: <2023112421-hunchback-jinx-7a88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x ebf6cb7c6e1241984f75f29f1bdbfa2fe7168f88
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112421-hunchback-jinx-7a88@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

ebf6cb7c6e12 ("ext4: no need to generate from free list in mballoc")
ad635507b5b2 ("ext4: remove unnecessary return for void function")
5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
fa08a7b61dff ("ext4: fix WARNING in mb_find_extent")
01e4ca294517 ("ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set")
123e3016ee9b ("ext4: rename ext4_set_bits to mb_set_bits")
8ac3939db99f ("ext4: refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()")
bfdc502a4a4c ("ext4: fix ext4_mb_mark_bb() with flex_bg with fast_commit")
a5c0e2fdf7ce ("ext4: correct cluster len and clusters changed accounting in ext4_mb_mark_bb")
196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
4b68f6df1059 ("ext4: add MB_NUM_ORDERS macro")
a6c75eaf1103 ("ext4: add mballoc stats proc file")
b237e3044450 ("ext4: add ability to return parsed options from parse_options")
67d251860461 ("ext4: drop s_mb_bal_lock and convert protected fields to atomic")
a72b38eebea4 ("ext4: handle dax mount option collision")
99c880decf27 ("ext4: cleanup fast commit mount options")
0f0672ffb61a ("ext4: add a mount opt to forcefully turn fast commits on")
8016e29f4362 ("ext4: fast commit recovery path")
5b849b5f96b4 ("jbd2: fast commit recovery path")
aa75f4d3daae ("ext4: main fast-commit commit path")

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


