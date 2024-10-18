Return-Path: <stable+bounces-86767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C59A3786
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4060287951
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022618C014;
	Fri, 18 Oct 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MQBSKmEk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EB18BC3D
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237653; cv=none; b=BTUrqaMeQGuo0EuCSdpDHnGCG8MgVqo4aj+/Fg/ZBOzcuGFv/z+N4cczLW9/vNt5i8699qZnlOWLc/iLbDKOWd1QHoh/OSmvxFzfAexrN4XlSev+pnX8QB/ojfqkg455FVUzOqkwvXYWf87bs8RdYPeuXFBfNXDqvU7DGDkM12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237653; c=relaxed/simple;
	bh=8G4eOrQj5rMA6Qh7nibm8dFP00HGDip73y48DXAlwDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RKOSq8nXH0CnjYqzx97fv4MiQA7z/wllzdcvUHCg7yuS1Hb6T1s9WC3ZZK9VLXpY6IclhNzkLq3QbzgFCfOd88CNhryBTLgPEMJLuqpIXP+r8v/OL/vDUGpFC/cPY7RUZovCKvqpoIRCHcfoGddUIGL4EQWQZ7O5Zg4rt3mhd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MQBSKmEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD26C4CEC3;
	Fri, 18 Oct 2024 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729237652;
	bh=8G4eOrQj5rMA6Qh7nibm8dFP00HGDip73y48DXAlwDo=;
	h=Subject:To:Cc:From:Date:From;
	b=MQBSKmEk4EppXr1vyNCtTktDm4dmSztNh1vhwndLnJJJEc7To/9aCFtLXR119potg
	 g1Fzgeq5J+lFSFD2inTBoND2dAA5DTS3YPCygpYMl0lg7VTUAUgoLP4JxB3mF5Nhwn
	 4CDEXEGrIuAkcauUTd1hVy+r8VX3kQq7CohOiNvc=
Subject: FAILED: patch "[PATCH] maple_tree: correct tree corruption on spanning store" failed to apply to 6.6-stable tree
To: lorenzo.stoakes@oracle.com,Liam.Howlett@Oracle.com,akpm@linux-foundation.org,mikhail.v.gavrilov@gmail.com,richard.weiyang@gmail.com,sidhartha.kumar@oracle.com,spasswolf@web.de,stable@vger.kernel.org,vbabka@suse.cz,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:47:19 +0200
Message-ID: <2024101818-ducky-dallying-2814@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bea07fd63192b61209d48cbb81ef474cc3ee4c62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101818-ducky-dallying-2814@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bea07fd63192b61209d48cbb81ef474cc3ee4c62 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 7 Oct 2024 16:28:32 +0100
Subject: [PATCH] maple_tree: correct tree corruption on spanning store

Patch series "maple_tree: correct tree corruption on spanning store", v3.

There has been a nasty yet subtle maple tree corruption bug that appears
to have been in existence since the inception of the algorithm.

This bug seems far more likely to happen since commit f8d112a4e657
("mm/mmap: avoid zeroing vma tree in mmap_region()"), which is the point
at which reports started to be submitted concerning this bug.

We were made definitely aware of the bug thanks to the kind efforts of
Bert Karwatzki who helped enormously in my being able to track this down
and identify the cause of it.

The bug arises when an attempt is made to perform a spanning store across
two leaf nodes, where the right leaf node is the rightmost child of the
shared parent, AND the store completely consumes the right-mode node.

This results in mas_wr_spanning_store() mitakenly duplicating the new and
existing entries at the maximum pivot within the range, and thus maple
tree corruption.

The fix patch corrects this by detecting this scenario and disallowing the
mistaken duplicate copy.

The fix patch commit message goes into great detail as to how this occurs.

This series also includes a test which reliably reproduces the issue, and
asserts that the fix works correctly.

Bert has kindly tested the fix and confirmed it resolved his issues.  Also
Mikhail Gavrilov kindly reported what appears to be precisely the same
bug, which this fix should also resolve.


This patch (of 2):

There has been a subtle bug present in the maple tree implementation from
its inception.

This arises from how stores are performed - when a store occurs, it will
overwrite overlapping ranges and adjust the tree as necessary to
accommodate this.

A range may always ultimately span two leaf nodes.  In this instance we
walk the two leaf nodes, determine which elements are not overwritten to
the left and to the right of the start and end of the ranges respectively
and then rebalance the tree to contain these entries and the newly
inserted one.

This kind of store is dubbed a 'spanning store' and is implemented by
mas_wr_spanning_store().

In order to reach this stage, mas_store_gfp() invokes
mas_wr_preallocate(), mas_wr_store_type() and mas_wr_walk() in turn to
walk the tree and update the object (mas) to traverse to the location
where the write should be performed, determining its store type.

When a spanning store is required, this function returns false stopping at
the parent node which contains the target range, and mas_wr_store_type()
marks the mas->store_type as wr_spanning_store to denote this fact.

When we go to perform the store in mas_wr_spanning_store(), we first
determine the elements AFTER the END of the range we wish to store (that
is, to the right of the entry to be inserted) - we do this by walking to
the NEXT pivot in the tree (i.e.  r_mas.last + 1), starting at the node we
have just determined contains the range over which we intend to write.

We then turn our attention to the entries to the left of the entry we are
inserting, whose state is represented by l_mas, and copy these into a 'big
node', which is a special node which contains enough slots to contain two
leaf node's worth of data.

We then copy the entry we wish to store immediately after this - the copy
and the insertion of the new entry is performed by mas_store_b_node().

After this we copy the elements to the right of the end of the range which
we are inserting, if we have not exceeded the length of the node (i.e.
r_mas.offset <= r_mas.end).

Herein lies the bug - under very specific circumstances, this logic can
break and corrupt the maple tree.

Consider the following tree:

Height
  0                             Root Node
                                 /      \
                 pivot = 0xffff /        \ pivot = ULONG_MAX
                               /          \
  1                       A [-----]       ...
                             /   \
             pivot = 0x4fff /     \ pivot = 0xffff
                           /       \
  2 (LEAVES)          B [-----]  [-----] C
                                      ^--- Last pivot 0xffff.

Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
that all ranges expressed in maple tree code are inclusive):

1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
   determines that this is a spanning store across nodes B and C. The mas
   state is set such that the current node from which we traverse further
   is node A.

2. In mas_wr_spanning_store() we try to find elements to the right of pivot
   0xffff by searching for an index of 0x10000:

    - mas_wr_walk_index() invokes mas_wr_walk_descend() and
      mas_wr_node_walk() in turn.

        - mas_wr_node_walk() loops over entries in node A until EITHER it
          finds an entry whose pivot equals or exceeds 0x10000 OR it
          reaches the final entry.

        - Since no entry has a pivot equal to or exceeding 0x10000, pivot
          0xffff is selected, leading to node C.

    - mas_wr_walk_traverse() resets the mas state to traverse node C. We
      loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
      in turn once again.

         - Again, we reach the last entry in node C, which has a pivot of
           0xffff.

3. We then copy the elements to the left of 0x4000 in node B to the big
   node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
   too.

4. We determine whether we have any entries to copy from the right of the
   end of the range via - and with r_mas set up at the entry at pivot
   0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
   pivot 0xffff.

5. BUG! The maple tree is corrupted with a duplicate entry.

This requires a very specific set of circumstances - we must be spanning
the last element in a leaf node, which is the last element in the parent
node.

spanning store across two leaf nodes with a range that ends at that shared
pivot.

A potential solution to this problem would simply be to reset the walk
each time we traverse r_mas, however given the rarity of this situation it
seems that would be rather inefficient.

Instead, this patch detects if the right hand node is populated, i.e.  has
anything we need to copy.

We do so by only copying elements from the right of the entry being
inserted when the maximum value present exceeds the last, rather than
basing this on offset position.

The patch also updates some comments and eliminates the unused bool return
value in mas_wr_walk_index().

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma
tree in mmap_region()") seems to have made the probability of this event
much more likely, which is the point at which reports started to be
submitted concerning this bug.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue
discussed in this commit message was occurring for him.

Link: https://lkml.kernel.org/r/cover.1728314402.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Tested-by: Bert Karwatzki <spasswolf@web.de>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ce7c7a7a8258..3619301dda2e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,
 
 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3532,7 +3534,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
+static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
@@ -3541,11 +3543,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
 		if (ma_is_leaf(wr_mas->type))
-			return true;
+			return;
 		mas_wr_walk_traverse(wr_mas);
-
 	}
-	return true;
 }
 /*
  * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
@@ -3765,8 +3765,8 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
-	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+	/* Copy r_mas into b_node if there is anything to copy. */
+	if (r_mas.max > r_mas.last)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else


