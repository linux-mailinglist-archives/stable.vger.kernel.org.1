Return-Path: <stable+bounces-69533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E39567A4
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67A51C21A34
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07015B97A;
	Mon, 19 Aug 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gaV96gf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0215B14E
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061328; cv=none; b=eGPnac56JZxHF9ZhrwdjUTUfiZWaHtKQDkQOIMMF7P9KCeMXfqRmIwj13V1+uCidDnhbpBPjg5bqdjZiKeUBrPLYGlKsOlUZP4HL0UgTYPLRtE6BEJPYQidDtp59J+ersxn7kigMrnMkAmtUmFTIR40O5tTu1LmZ3gLzNoDZwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061328; c=relaxed/simple;
	bh=4S/mHI5oz65ADTLUXV3fsU+yicgQ72L8Htr7XuvMFAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sr9tJdjhnGCguiljdcpF42KGgRkoy1PEonIf5xkZXgWbhSrqjaFq0/irQ1ZZn0Sc6LTz8rSsU1ouJZEW+NDmoIQHNs2+WMT739UJ4jYhdHp3iWI5GTN4j4c/mrJzmYwGMl16U+MDu6IDZ6nQnilDYrrgZVxp7weeg2WIIp5FHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gaV96gf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93AAC4AF0C;
	Mon, 19 Aug 2024 09:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061328;
	bh=4S/mHI5oz65ADTLUXV3fsU+yicgQ72L8Htr7XuvMFAc=;
	h=Subject:To:Cc:From:Date:From;
	b=gaV96gf7vfigLQiftO4Fgcy2DuHPd1tUyRirBnVb8F6Q/rowhzECncxFaBagbC0lX
	 7mnr1F5fGg2tcO9Tr/MxDH91xvAni4Ob0lCyH7IWRedrMzuxYFK1a5oHgcy+Z6tKxx
	 HwEty7jG2rCuZ+sQJpsv3UewVQKRHuzwL5t/Igco=
Subject: FAILED: patch "[PATCH] btrfs: check delayed refs when we're checking if a ref exists" failed to apply to 6.6-stable tree
To: josef@toxicpanda.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:55:25 +0200
Message-ID: <2024081925-knoll-dropkick-f11a@gregkh>
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
git cherry-pick -x 42fac187b5c746227c92d024f1caf33bc1d337e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081925-knoll-dropkick-f11a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

42fac187b5c7 ("btrfs: check delayed refs when we're checking if a ref exists")
e094f48040cd ("btrfs: change root->root_key.objectid to btrfs_root_id()")
44cc2e38e67b ("btrfs: stop referencing btrfs_delayed_data_ref directly")
cf4f04325b2b ("btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node")
12390e42b69d ("btrfs: rename ->len to ->num_bytes in btrfs_ref")
1bff6d4f8737 ("btrfs: simplify delayed ref tracepoints")
0ea4703cc27e ("btrfs: move ref specific initialization into init_delayed_ref_common")
0509cc56619d ("btrfs: initialize btrfs_delayed_ref_head with btrfs_ref")
da3c54854197 ("btrfs: pass btrfs_ref to init_delayed_ref_common")
f2e69a77aa51 ("btrfs: move ref_root into btrfs_ref")
4d09b4e942bc ("btrfs: do not use a function to initialize btrfs_ref")
d3fbb00f5e21 ("btrfs: embed data_ref and tree_ref in btrfs_delayed_ref_node")
0eea355fc0f4 ("btrfs: add a helper to get the delayed ref node from the data/tree ref")
6de3595473b0 ("btrfs: compression: add error handling for missed page cache")
01b69bf9906b ("btrfs: convert put_file_data() to folios")
073bda7a5417 ("btrfs: zoned: add ASSERT and WARN for EXTENT_BUFFER_ZONED_ZEROOUT handling")
141fb8cd206a ("btrfs: qgroup: correctly model root qgroup rsv in convert")
ef5a05c55704 ("btrfs: remove SLAB_MEM_SPREAD flag use")
06c9564980f1 ("btrfs: use KMEM_CACHE() to create btrfs_free_space cache")
b2c7d55e4c4c ("btrfs: use KMEM_CACHE() to create delayed ref caches")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42fac187b5c746227c92d024f1caf33bc1d337e4 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 11 Apr 2024 16:41:20 -0400
Subject: [PATCH] btrfs: check delayed refs when we're checking if a ref exists

In the patch 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete
resume") I added some code to handle file systems that had been
corrupted by a bug that incorrectly skipped updating the drop progress
key while dropping a snapshot.  This code would check to see if we had
already deleted our reference for a child block, and skip the deletion
if we had already.

Unfortunately there is a bug, as the check would only check the on-disk
references.  I made an incorrect assumption that blocks in an already
deleted snapshot that was having the deletion resume on mount wouldn't
be modified.

If we have 2 pending deleted snapshots that share blocks, we can easily
modify the rules for a block.  Take the following example

subvolume a exists, and subvolume b is a snapshot of subvolume a.  They
share references to block 1.  Block 1 will have 2 full references, one
for subvolume a and one for subvolume b, and it belongs to subvolume a
(btrfs_header_owner(block 1) == subvolume a).

When deleting subvolume a, we will drop our full reference for block 1,
and because we are the owner we will drop our full reference for all of
block 1's children, convert block 1 to FULL BACKREF, and add a shared
reference to all of block 1's children.

Then we will start the snapshot deletion of subvolume b.  We look up the
extent info for block 1, which checks delayed refs and tells us that
FULL BACKREF is set, so sets parent to the bytenr of block 1.  However
because this is a resumed snapshot deletion, we call into
check_ref_exists().  Because check_ref_exists() only looks at the disk,
it doesn't find the shared backref for the child of block 1, and thus
returns 0 and we skip deleting the reference for the child of block 1
and continue.  This orphans the child of block 1.

The fix is to lookup the delayed refs, similar to what we do in
btrfs_lookup_extent_info().  However we only care about whether the
reference exists or not.  If we fail to find our reference on disk, go
look up the bytenr in the delayed refs, and if it exists look for an
existing ref in the delayed ref head.  If that exists then we know we
can delete the reference safely and carry on.  If it doesn't exist we
know we have to skip over this block.

This bug has existed since I introduced this fix, however requires
having multiple deleted snapshots pending when we unmount.  We noticed
this in production because our shutdown path stops the container on the
system, which deletes a bunch of subvolumes, and then reboots the box.
This gives us plenty of opportunities to hit this issue.  Looking at the
history we've seen this occasionally in production, but we had a big
spike recently thanks to faster machines getting jobs with multiple
subvolumes in the job.

Chris Mason wrote a reproducer which does the following

mount /dev/nvme4n1 /btrfs
btrfs subvol create /btrfs/s1
simoop -E -f 4k -n 200000 -z /btrfs/s1
while(true) ; do
	btrfs subvol snap /btrfs/s1 /btrfs/s2
	simoop -f 4k -n 200000 -r 10 -z /btrfs/s2
	btrfs subvol snap /btrfs/s2 /btrfs/s3
	btrfs balance start -dusage=80 /btrfs
	btrfs subvol del /btrfs/s2 /btrfs/s3
	umount /btrfs
	btrfsck /dev/nvme4n1 || exit 1
	mount /dev/nvme4n1 /btrfs
done

On the second loop this would fail consistently, with my patch it has
been running for hours and hasn't failed.

I also used dm-log-writes to capture the state of the failure so I could
debug the problem.  Using the existing failure case to test my patch
validated that it fixes the problem.

Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 2ac9296edccb..06a9e0542d70 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1134,6 +1134,73 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 byt
 	return find_ref_head(delayed_refs, bytenr, false);
 }
 
+static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64 parent)
+{
+	int type = parent ? BTRFS_SHARED_BLOCK_REF_KEY : BTRFS_TREE_BLOCK_REF_KEY;
+
+	if (type < entry->type)
+		return -1;
+	if (type > entry->type)
+		return 1;
+
+	if (type == BTRFS_TREE_BLOCK_REF_KEY) {
+		if (root < entry->ref_root)
+			return -1;
+		if (root > entry->ref_root)
+			return 1;
+	} else {
+		if (parent < entry->parent)
+			return -1;
+		if (parent > entry->parent)
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Check to see if a given root/parent reference is attached to the head.  This
+ * only checks for BTRFS_ADD_DELAYED_REF references that match, as that
+ * indicates the reference exists for the given root or parent.  This is for
+ * tree blocks only.
+ *
+ * @head: the head of the bytenr we're searching.
+ * @root: the root objectid of the reference if it is a normal reference.
+ * @parent: the parent if this is a shared backref.
+ */
+bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
+				 u64 root, u64 parent)
+{
+	struct rb_node *node;
+	bool found = false;
+
+	lockdep_assert_held(&head->mutex);
+
+	spin_lock(&head->lock);
+	node = head->ref_tree.rb_root.rb_node;
+	while (node) {
+		struct btrfs_delayed_ref_node *entry;
+		int ret;
+
+		entry = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
+		ret = find_comp(entry, root, parent);
+		if (ret < 0) {
+			node = node->rb_left;
+		} else if (ret > 0) {
+			node = node->rb_right;
+		} else {
+			/*
+			 * We only want to count ADD actions, as drops mean the
+			 * ref doesn't exist.
+			 */
+			if (entry->action == BTRFS_ADD_DELAYED_REF)
+				found = true;
+			break;
+		}
+	}
+	spin_unlock(&head->lock);
+	return found;
+}
+
 void __cold btrfs_delayed_ref_exit(void)
 {
 	kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index ef15e998be03..05f634eb472d 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -389,6 +389,8 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
+bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
+				 u64 root, u64 parent);
 
 static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ff9f0d41987e..feec49e6f9c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5472,23 +5472,62 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root, u64 bytenr, u64 parent,
 			    int level)
 {
+	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_head *head;
 	struct btrfs_path *path;
 	struct btrfs_extent_inline_ref *iref;
 	int ret;
+	bool exists = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-
+again:
 	ret = lookup_extent_backref(trans, path, &iref, bytenr,
 				    root->fs_info->nodesize, parent,
 				    btrfs_root_id(root), level, 0);
+	if (ret != -ENOENT) {
+		/*
+		 * If we get 0 then we found our reference, return 1, else
+		 * return the error if it's not -ENOENT;
+		 */
+		btrfs_free_path(path);
+		return (ret < 0 ) ? ret : 1;
+	}
+
+	/*
+	 * We could have a delayed ref with this reference, so look it up while
+	 * we're holding the path open to make sure we don't race with the
+	 * delayed ref running.
+	 */
+	delayed_refs = &trans->transaction->delayed_refs;
+	spin_lock(&delayed_refs->lock);
+	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+	if (!head)
+		goto out;
+	if (!mutex_trylock(&head->mutex)) {
+		/*
+		 * We're contended, means that the delayed ref is running, get a
+		 * reference and wait for the ref head to be complete and then
+		 * try again.
+		 */
+		refcount_inc(&head->refs);
+		spin_unlock(&delayed_refs->lock);
+
+		btrfs_release_path(path);
+
+		mutex_lock(&head->mutex);
+		mutex_unlock(&head->mutex);
+		btrfs_put_delayed_ref_head(head);
+		goto again;
+	}
+
+	exists = btrfs_find_delayed_tree_ref(head, root->root_key.objectid, parent);
+	mutex_unlock(&head->mutex);
+out:
+	spin_unlock(&delayed_refs->lock);
 	btrfs_free_path(path);
-	if (ret == -ENOENT)
-		return 0;
-	if (ret < 0)
-		return ret;
-	return 1;
+	return exists ? 1 : 0;
 }
 
 /*


