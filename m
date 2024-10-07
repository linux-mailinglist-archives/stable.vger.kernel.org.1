Return-Path: <stable+bounces-81435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBA9934B5
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96B22844DC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72451DD536;
	Mon,  7 Oct 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hkbnYBIm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF71DD868
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321515; cv=none; b=m8WjS9a762vYrJIx9m4zC88nuLcMd41JsfLRRj5X5d5pdNfXh3hUfKU/Db2T7oAer37CiqanDKYy4w/PFKiXtDDN+Z7al4RMrn8k6+IPDhL3XvSzqimx42qApH//hsDrinPitPVnaWue/clakh1gWxM3PrMoGlcmjIgu4ADjIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321515; c=relaxed/simple;
	bh=NPU4LpYoAym9oeL/u5X2zG5n5EKGH4kBlKCj2qYYr1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M8mCstlf3xQrDM73Q/5oUbc0hquMof+2Y5iWx00Prh7y+dQda+2ANjwGnUE2bxFZjWyRMPyZUcae6J1/VIkl1Ix5mjpttOhZ+b84WaK1woPRkjQEu++OH1Yh4qdrKnd4bwhkj16m5sfqs6pHrxx/cntAlhr7s6KqKZADf4sccuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hkbnYBIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C6EC4CEC6;
	Mon,  7 Oct 2024 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321515;
	bh=NPU4LpYoAym9oeL/u5X2zG5n5EKGH4kBlKCj2qYYr1Q=;
	h=Subject:To:Cc:From:Date:From;
	b=hkbnYBImlNUc6re+jr55yJgcQzN69/p8gqMsTPX2G6O2NMVi0ZqntMsknKohlFrKT
	 DF7crGRPHyMzak765qMNDubTqdOoyDp6JyJM2w8oLf8LvfvgezT1hpuarfklaMn0so
	 1QggvP7QbTYX6sUseKfCBCYA+lSz25qf/AlNjyJ8=
Subject: FAILED: patch "[PATCH] btrfs: drop the backref cache during relocation if we commit" failed to apply to 5.4-stable tree
To: josef@toxicpanda.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:18:22 +0200
Message-ID: <2024100722-wreckage-customs-5310@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x db7e68b522c01eb666cfe1f31637775f18997811
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100722-wreckage-customs-5310@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

db7e68b522c0 ("btrfs: drop the backref cache during relocation if we commit")
ab7c8bbf3a08 ("btrfs: relocation: constify parameters where possible")
32f2abca380f ("btrfs: relocation: return bool from btrfs_should_ignore_reloc_root")
b9a9a85059cd ("btrfs: output affected files when relocation fails")
aa5d3003ddee ("btrfs: move orphan prototypes into orphan.h")
7f0add250f82 ("btrfs: move super_block specific helpers into super.h")
c03b22076bd2 ("btrfs: move super prototypes into super.h")
5c11adcc383a ("btrfs: move verity prototypes into verity.h")
77407dc032e2 ("btrfs: move dev-replace prototypes into dev-replace.h")
2fc6822c99d7 ("btrfs: move scrub prototypes into scrub.h")
677074792a1d ("btrfs: move relocation prototypes into relocation.h")
33cf97a7b658 ("btrfs: move acl prototypes into acl.h")
b538a271ae9b ("btrfs: move the 32bit warn defines into messages.h")
af142b6f44d3 ("btrfs: move file prototypes to file.h")
7572dec8f522 ("btrfs: move ioctl prototypes into ioctl.h")
c7a03b524d30 ("btrfs: move uuid tree prototypes to uuid-tree.h")
7c8ede162805 ("btrfs: move file-item prototypes into their own header")
f2b39277b87d ("btrfs: move dir-item prototypes into dir-item.h")
59b818e064ab ("btrfs: move defrag related prototypes to their own header")
a6a01ca61f49 ("btrfs: move the file defrag code into defrag.c")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db7e68b522c01eb666cfe1f31637775f18997811 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 24 Sep 2024 16:50:22 -0400
Subject: [PATCH] btrfs: drop the backref cache during relocation if we commit

Since the inception of relocation we have maintained the backref cache
across transaction commits, updating the backref cache with the new
bytenr whenever we COWed blocks that were in the cache, and then
updating their bytenr once we detected a transaction id change.

This works as long as we're only ever modifying blocks, not changing the
structure of the tree.

However relocation does in fact change the structure of the tree.  For
example, if we are relocating a data extent, we will look up all the
leaves that point to this data extent.  We will then call
do_relocation() on each of these leaves, which will COW down to the leaf
and then update the file extent location.

But, a key feature of do_relocation() is the pending list.  This is all
the pending nodes that we modified when we updated the file extent item.
We will then process all of these blocks via finish_pending_nodes, which
calls do_relocation() on all of the nodes that led up to that leaf.

The purpose of this is to make sure we don't break sharing unless we
absolutely have to.  Consider the case that we have 3 snapshots that all
point to this leaf through the same nodes, the initial COW would have
created a whole new path.  If we did this for all 3 snapshots we would
end up with 3x the number of nodes we had originally.  To avoid this we
will cycle through each of the snapshots that point to each of these
nodes and update their pointers to point at the new nodes.

Once we update the pointer to the new node we will drop the node we
removed the link for and all of its children via btrfs_drop_subtree().
This is essentially just btrfs_drop_snapshot(), but for an arbitrary
point in the snapshot.

The problem with this is that we will never reflect this in the backref
cache.  If we do this btrfs_drop_snapshot() for a node that is in the
backref tree, we will leave the node in the backref tree.  This becomes
a problem when we change the transid, as now the backref cache has
entire subtrees that no longer exist, but exist as if they still are
pointed to by the same roots.

In the best case scenario you end up with "adding refs to an existing
tree ref" errors from insert_inline_extent_backref(), where we attempt
to link in nodes on roots that are no longer valid.

Worst case you will double free some random block and re-use it when
there's still references to the block.

This is extremely subtle, and the consequences are quite bad.  There
isn't a way to make sure our backref cache is consistent between
transid's.

In order to fix this we need to simply evict the entire backref cache
anytime we cross transid's.  This reduces performance in that we have to
rebuild this backref cache every time we change transid's, but fixes the
bug.

This has existed since relocation was added, and is a pretty critical
bug.  There's a lot more cleanup that can be done now that this
functionality is going away, but this patch is as small as possible in
order to fix the problem and make it easy for us to backport it to all
the kernels it needs to be backported to.

Followup series will dismantle more of this code and simplify relocation
drastically to remove this functionality.

We have a reproducer that reproduced the corruption within a few minutes
of running.  With this patch it survives several iterations/hours of
running the reproducer.

Fixes: 3fd0a5585eb9 ("Btrfs: Metadata ENOSPC handling for balance")
CC: stable@vger.kernel.org
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e2f478ecd7fd..f8e1d5b2c512 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3179,10 +3179,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 		btrfs_backref_cleanup_node(cache, node);
 	}
 
-	cache->last_trans = 0;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		ASSERT(list_empty(&cache->pending[i]));
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
+		while (!list_empty(&cache->pending[i])) {
+			node = list_first_entry(&cache->pending[i],
+						struct btrfs_backref_node,
+						list);
+			btrfs_backref_cleanup_node(cache, node);
+		}
+	}
 	ASSERT(list_empty(&cache->pending_edge));
 	ASSERT(list_empty(&cache->useless_node));
 	ASSERT(list_empty(&cache->changed));
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ea4ed85919ec..cf1dfeaaf2d8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -232,70 +232,6 @@ static struct btrfs_backref_node *walk_down_backref(
 	return NULL;
 }
 
-static void update_backref_node(struct btrfs_backref_cache *cache,
-				struct btrfs_backref_node *node, u64 bytenr)
-{
-	struct rb_node *rb_node;
-	rb_erase(&node->rb_node, &cache->rb_root);
-	node->bytenr = bytenr;
-	rb_node = rb_simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
-	if (rb_node)
-		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
-}
-
-/*
- * update backref cache after a transaction commit
- */
-static int update_backref_cache(struct btrfs_trans_handle *trans,
-				struct btrfs_backref_cache *cache)
-{
-	struct btrfs_backref_node *node;
-	int level = 0;
-
-	if (cache->last_trans == 0) {
-		cache->last_trans = trans->transid;
-		return 0;
-	}
-
-	if (cache->last_trans == trans->transid)
-		return 0;
-
-	/*
-	 * detached nodes are used to avoid unnecessary backref
-	 * lookup. transaction commit changes the extent tree.
-	 * so the detached nodes are no longer useful.
-	 */
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct btrfs_backref_node, list);
-		btrfs_backref_cleanup_node(cache, node);
-	}
-
-	while (!list_empty(&cache->changed)) {
-		node = list_entry(cache->changed.next,
-				  struct btrfs_backref_node, list);
-		list_del_init(&node->list);
-		BUG_ON(node->pending);
-		update_backref_node(cache, node, node->new_bytenr);
-	}
-
-	/*
-	 * some nodes can be left in the pending list if there were
-	 * errors during processing the pending nodes.
-	 */
-	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
-		list_for_each_entry(node, &cache->pending[level], list) {
-			BUG_ON(!node->pending);
-			if (node->bytenr == node->new_bytenr)
-				continue;
-			update_backref_node(cache, node, node->new_bytenr);
-		}
-	}
-
-	cache->last_trans = 0;
-	return 1;
-}
-
 static bool reloc_root_is_dead(const struct btrfs_root *root)
 {
 	/*
@@ -551,9 +487,6 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_edge *new_edge;
 	struct rb_node *rb_node;
 
-	if (cache->last_trans > 0)
-		update_backref_cache(trans, cache);
-
 	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
@@ -3698,11 +3631,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			break;
 		}
 restart:
-		if (update_backref_cache(trans, &rc->backref_cache)) {
-			btrfs_end_transaction(trans);
-			trans = NULL;
-			continue;
-		}
+		if (rc->backref_cache.last_trans != trans->transid)
+			btrfs_backref_release_cache(&rc->backref_cache);
+		rc->backref_cache.last_trans = trans->transid;
 
 		ret = find_next_extent(rc, path, &key);
 		if (ret < 0)


