Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48375EB66
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGXGTW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 02:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXGTW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 02:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2D1BE
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 23:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63FA060F0C
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 06:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F417C433C8;
        Mon, 24 Jul 2023 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690179559;
        bh=6tTUI1cpQgrYUO9lEzRLEI/79u3tRK9UUWYmwHJSwiU=;
        h=Subject:To:Cc:From:Date:From;
        b=rme4MSAOG+1PUDY91GEWnQ2m0/B9nzRJt/v0Z0IESxaafoAytBczv/qAtPoO9Dibz
         nkwa6jcRFdDEcZax1rpZ/YnsuqeHDbdHvWXtSO1+ldP1pT5ioCweAjHYSoAOT/lde0
         65tiMrWql59LYTGc4NPrh88Wqjp3xLxtqxzO3tT8=
Subject: FAILED: patch "[PATCH] ext4: fix rbtree traversal bug in ext4_mb_use_preallocated" failed to apply to 6.4-stable tree
To:     ojaswin@linux.ibm.com, naresh.kamboju@linaro.org, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 24 Jul 2023 08:19:13 +0200
Message-ID: <2023072413-glamorous-unjustly-bb12@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9d3de7ee192a6a253f475197fe4d2e2af10a731f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072413-glamorous-unjustly-bb12@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d3de7ee192a6a253f475197fe4d2e2af10a731f Mon Sep 17 00:00:00 2001
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date: Sat, 22 Jul 2023 22:45:24 +0530
Subject: [PATCH] ext4: fix rbtree traversal bug in ext4_mb_use_preallocated

During allocations, while looking for preallocations(PA) in the per
inode rbtree, we can't do a direct traversal of the tree because
ext4_mb_discard_group_preallocation() can paralelly mark the pa deleted
and that can cause direct traversal to skip some entries. This was
leading to a BUG_ON() being hit [1] when we missed a PA that could satisfy
our request and ultimately tried to create a new PA that would overlap
with the missed one.

To makes sure we handle that case while still keeping the performance of
the rbtree, we make use of the fact that the only pa that could possibly
overlap the original goal start is the one that satisfies the below
conditions:

  1. It must have it's logical start immediately to the left of
  (ie less than) original logical start.

  2. It must not be deleted

To find this pa we use the following traversal method:

1. Descend into the rbtree normally to find the immediate neighboring
PA. Here we keep descending irrespective of if the PA is deleted or if
it overlaps with our request etc. The goal is to find an immediately
adjacent PA.

2. If the found PA is on right of original goal, use rb_prev() to find
the left adjacent PA.

3. Check if this PA is deleted and keep moving left with rb_prev() until
a non deleted PA is found.

4. This is the PA we are looking for. Now we can check if it can satisfy
the original request and proceed accordingly.

This approach also takes care of having deleted PAs in the tree.

(While we are at it, also fix a possible overflow bug in calculating the
end of a PA)

[1] https://lore.kernel.org/linux-ext4/CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com/

Cc: stable@kernel.org # 6.4
Fixes: 3872778664e3 ("ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Ritesh Harjani (IBM) ritesh.list@gmail.com
Tested-by: Ritesh Harjani (IBM) ritesh.list@gmail.com
Link: https://lore.kernel.org/r/edd2efda6a83e6343c5ace9deea44813e71dbe20.1690045963.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 456150ef6111..21b903fe546e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4765,8 +4765,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	int order, i;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
-	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
+	loff_t tmp_pa_end;
 	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
@@ -4774,47 +4774,151 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
-	/* first, try per-file preallocation */
+	/*
+	 * first, try per-file preallocation by searching the inode pa rbtree.
+	 *
+	 * Here, we can't do a direct traversal of the tree because
+	 * ext4_mb_discard_group_preallocation() can paralelly mark the pa
+	 * deleted and that can cause direct traversal to skip some entries.
+	 */
 	read_lock(&ei->i_prealloc_lock);
+
+	if (RB_EMPTY_ROOT(&ei->i_prealloc_node)) {
+		goto try_group_pa;
+	}
+
+	/*
+	 * Step 1: Find a pa with logical start immediately adjacent to the
+	 * original logical start. This could be on the left or right.
+	 *
+	 * (tmp_pa->pa_lstart never changes so we can skip locking for it).
+	 */
 	for (iter = ei->i_prealloc_node.rb_node; iter;
 	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
-					    tmp_pa_start, iter)) {
+					    tmp_pa->pa_lstart, iter)) {
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
+	}
 
-		/* all fields in this condition don't change,
-		 * so we can skip locking for them */
-		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+	/*
+	 * Step 2: The adjacent pa might be to the right of logical start, find
+	 * the left adjacent pa. After this step we'd have a valid tmp_pa whose
+	 * logical start is towards the left of original request's logical start
+	 */
+	if (tmp_pa->pa_lstart > ac->ac_o_ex.fe_logical) {
+		struct rb_node *tmp;
+		tmp = rb_prev(&tmp_pa->pa_node.inode_node);
 
-		/* original request start doesn't lie in this PA */
-		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
-		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
-			continue;
-
-		/* non-extent files can't have physical blocks past 2^32 */
-		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
-		    (tmp_pa->pa_pstart + EXT4_C2B(sbi, tmp_pa->pa_len) >
-		     EXT4_MAX_BLOCK_FILE_PHYS)) {
+		if (tmp) {
+			tmp_pa = rb_entry(tmp, struct ext4_prealloc_space,
+					    pa_node.inode_node);
+		} else {
 			/*
-			 * Since PAs don't overlap, we won't find any
-			 * other PA to satisfy this.
+			 * If there is no adjacent pa to the left then finding
+			 * an overlapping pa is not possible hence stop searching
+			 * inode pa tree
+			 */
+			goto try_group_pa;
+		}
+	}
+
+	BUG_ON(!(tmp_pa && tmp_pa->pa_lstart <= ac->ac_o_ex.fe_logical));
+
+	/*
+	 * Step 3: If the left adjacent pa is deleted, keep moving left to find
+	 * the first non deleted adjacent pa. After this step we should have a
+	 * valid tmp_pa which is guaranteed to be non deleted.
+	 */
+	for (iter = &tmp_pa->pa_node.inode_node;; iter = rb_prev(iter)) {
+		if (!iter) {
+			/*
+			 * no non deleted left adjacent pa, so stop searching
+			 * inode pa tree
+			 */
+			goto try_group_pa;
+		}
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0) {
+			/*
+			 * We will keep holding the pa_lock from
+			 * this point on because we don't want group discard
+			 * to delete this pa underneath us. Since group
+			 * discard is anyways an ENOSPC operation it
+			 * should be okay for it to wait a few more cycles.
 			 */
 			break;
-		}
-
-		/* found preallocated blocks, use them */
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free &&
-		    likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
-			atomic_inc(&tmp_pa->pa_count);
-			ext4_mb_use_inode_pa(ac, tmp_pa);
+		} else {
 			spin_unlock(&tmp_pa->pa_lock);
-			read_unlock(&ei->i_prealloc_lock);
-			return true;
 		}
-		spin_unlock(&tmp_pa->pa_lock);
 	}
+
+	BUG_ON(!(tmp_pa && tmp_pa->pa_lstart <= ac->ac_o_ex.fe_logical));
+	BUG_ON(tmp_pa->pa_deleted == 1);
+
+	/*
+	 * Step 4: We now have the non deleted left adjacent pa. Only this
+	 * pa can possibly satisfy the request hence check if it overlaps
+	 * original logical start and stop searching if it doesn't.
+	 */
+	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
+		spin_unlock(&tmp_pa->pa_lock);
+		goto try_group_pa;
+	}
+
+	/* non-extent files can't have physical blocks past 2^32 */
+	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
+	    (tmp_pa->pa_pstart + EXT4_C2B(sbi, tmp_pa->pa_len) >
+	     EXT4_MAX_BLOCK_FILE_PHYS)) {
+		/*
+		 * Since PAs don't overlap, we won't find any other PA to
+		 * satisfy this.
+		 */
+		spin_unlock(&tmp_pa->pa_lock);
+		goto try_group_pa;
+	}
+
+	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+		atomic_inc(&tmp_pa->pa_count);
+		ext4_mb_use_inode_pa(ac, tmp_pa);
+		spin_unlock(&tmp_pa->pa_lock);
+		read_unlock(&ei->i_prealloc_lock);
+		return true;
+	} else {
+		/*
+		 * We found a valid overlapping pa but couldn't use it because
+		 * it had no free blocks. This should ideally never happen
+		 * because:
+		 *
+		 * 1. When a new inode pa is added to rbtree it must have
+		 *    pa_free > 0 since otherwise we won't actually need
+		 *    preallocation.
+		 *
+		 * 2. An inode pa that is in the rbtree can only have it's
+		 *    pa_free become zero when another thread calls:
+		 *      ext4_mb_new_blocks
+		 *       ext4_mb_use_preallocated
+		 *        ext4_mb_use_inode_pa
+		 *
+		 * 3. Further, after the above calls make pa_free == 0, we will
+		 *    immediately remove it from the rbtree in:
+		 *      ext4_mb_new_blocks
+		 *       ext4_mb_release_context
+		 *        ext4_mb_put_pa
+		 *
+		 * 4. Since the pa_free becoming 0 and pa_free getting removed
+		 * from tree both happen in ext4_mb_new_blocks, which is always
+		 * called with i_data_sem held for data allocations, we can be
+		 * sure that another process will never see a pa in rbtree with
+		 * pa_free == 0.
+		 */
+		WARN_ON_ONCE(tmp_pa->pa_free == 0);
+	}
+	spin_unlock(&tmp_pa->pa_lock);
+try_group_pa:
 	read_unlock(&ei->i_prealloc_lock);
 
 	/* can we use group allocation? */

