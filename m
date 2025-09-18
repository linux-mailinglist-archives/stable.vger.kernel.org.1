Return-Path: <stable+bounces-173191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481DB35BB2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A57B3B8839
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9712EE296;
	Tue, 26 Aug 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1chLUFt2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA22BE643;
	Tue, 26 Aug 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207607; cv=none; b=cZg4L7kmpcImJDeCdDecqszHJMN/gnJy1LiXpLhq6IkGd0EpXHQmN2JhPHVOe6LrvE6ex1zpQFIUHTCuQIyDa8lb6CNmEds0WGGDmoZIXc1+NKOxgoJ1UsyApj3UQRA595OlcnG3+oolRNmnH6RGogJg+FOc0vK8c/fwfpE8EoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207607; c=relaxed/simple;
	bh=oLQcfOSdNRjEw9DwPoQOwKw/oZR4yS3MztOfc/9Kfbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ/K3XxRL6353XP7d6caqMgMintOXw41KywvhLhMkOcfgvvrWwbGs5IhSd1YTYZMfNBQLQkD4/hDJPWVAdVrZz4/b8/eUB6PK5VRqSe4TEABGZZAh3n9UQ63yviPqJ6O6mg9ja9SP4FiS0RGgpVdX/QETpUTbv3NBAaiycPEQsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1chLUFt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F50C4CEF1;
	Tue, 26 Aug 2025 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207606;
	bh=oLQcfOSdNRjEw9DwPoQOwKw/oZR4yS3MztOfc/9Kfbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1chLUFt2OXLC8Rsb839h8YA84lnDyvxKsMSdIJBEWzZeSFs2CDGiTu8o5MTrph7ZH
	 dh7imMYbxpacFHiXzi/OgeJVKW0Ukco54WOe4AcxHZw9jyRMY3OgAbePFMt5iW8zAU
	 fNPciB4yHHGAr7ITbh8gkCMtLSyQRIPnno6W27PM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 217/457] btrfs: use refcount_t type for the extent buffer reference counter
Date: Tue, 26 Aug 2025 13:08:21 +0200
Message-ID: <20250826110942.726789048@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit b769777d927af168b1389388392bfd7dc4e38399 ]

Instead of using a bare atomic, use the refcount_t type, which despite
being a structure that contains only an atomic, has an API that checks
for underflows and other hazards. This doesn't change the size of the
extent_buffer structure.

This removes the need to do things like this:

    WARN_ON(atomic_read(&eb->refs) == 0);
    if (atomic_dec_and_test(&eb->refs)) {
        (...)
    }

And do just:

    if (refcount_dec_and_test(&eb->refs)) {
        (...)
    }

Since refcount_dec_and_test() already triggers a warning when we decrement
a ref count that has a value of 0 (or below zero).

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c             |   14 ++++++-------
 fs/btrfs/extent-tree.c       |    2 -
 fs/btrfs/extent_io.c         |   45 +++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h         |    2 -
 fs/btrfs/fiemap.c            |    2 -
 fs/btrfs/print-tree.c        |    2 -
 fs/btrfs/qgroup.c            |    6 ++---
 fs/btrfs/relocation.c        |    4 +--
 fs/btrfs/tree-log.c          |    4 +--
 fs/btrfs/zoned.c             |    2 -
 include/trace/events/btrfs.h |    2 -
 11 files changed, 42 insertions(+), 43 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -198,7 +198,7 @@ struct extent_buffer *btrfs_root_node(st
 		 * the inc_not_zero dance and if it doesn't work then
 		 * synchronize_rcu and try again.
 		 */
-		if (atomic_inc_not_zero(&eb->refs)) {
+		if (refcount_inc_not_zero(&eb->refs)) {
 			rcu_read_unlock();
 			break;
 		}
@@ -556,7 +556,7 @@ int btrfs_force_cow_block(struct btrfs_t
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
-		atomic_inc(&cow->refs);
+		refcount_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
@@ -1088,7 +1088,7 @@ static noinline int balance_level(struct
 	/* update the path */
 	if (left) {
 		if (btrfs_header_nritems(left) > orig_slot) {
-			atomic_inc(&left->refs);
+			refcount_inc(&left->refs);
 			/* left was locked after cow */
 			path->nodes[level] = left;
 			path->slots[level + 1] -= 1;
@@ -1692,7 +1692,7 @@ static struct extent_buffer *btrfs_searc
 
 	if (p->search_commit_root) {
 		b = root->commit_root;
-		atomic_inc(&b->refs);
+		refcount_inc(&b->refs);
 		level = btrfs_header_level(b);
 		/*
 		 * Ensure that all callers have set skip_locking when
@@ -2893,7 +2893,7 @@ static noinline int insert_new_root(stru
 	free_extent_buffer(old);
 
 	add_root_to_dirty_list(root);
-	atomic_inc(&c->refs);
+	refcount_inc(&c->refs);
 	path->nodes[level] = c;
 	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
@@ -4450,7 +4450,7 @@ static noinline int btrfs_del_leaf(struc
 
 	root_sub_used_bytes(root);
 
-	atomic_inc(&leaf->refs);
+	refcount_inc(&leaf->refs);
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
 	if (ret < 0)
@@ -4535,7 +4535,7 @@ int btrfs_del_items(struct btrfs_trans_h
 			 * for possible call to btrfs_del_ptr below
 			 */
 			slot = path->slots[1];
-			atomic_inc(&leaf->refs);
+			refcount_inc(&leaf->refs);
 			/*
 			 * We want to be able to at least push one item to the
 			 * left neighbour leaf, and that's the first item.
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6342,7 +6342,7 @@ int btrfs_drop_subtree(struct btrfs_tran
 
 	btrfs_assert_tree_write_locked(parent);
 	parent_level = btrfs_header_level(parent);
-	atomic_inc(&parent->refs);
+	refcount_inc(&parent->refs);
 	path->nodes[parent_level] = parent;
 	path->slots[parent_level] = btrfs_header_nritems(parent);
 
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -77,7 +77,7 @@ void btrfs_extent_buffer_leak_debug_chec
 				      struct extent_buffer, leak_list);
 		pr_err(
 	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
+		       eb->start, eb->len, refcount_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
 		WARN_ON_ONCE(1);
@@ -1961,7 +1961,7 @@ retry:
 	if (!eb)
 		return NULL;
 
-	if (!atomic_inc_not_zero(&eb->refs)) {
+	if (!refcount_inc_not_zero(&eb->refs)) {
 		xas_reset(xas);
 		goto retry;
 	}
@@ -2012,7 +2012,7 @@ static struct extent_buffer *find_extent
 
 	rcu_read_lock();
 	eb = xa_load(&fs_info->buffer_tree, index);
-	if (eb && !atomic_inc_not_zero(&eb->refs))
+	if (eb && !refcount_inc_not_zero(&eb->refs))
 		eb = NULL;
 	rcu_read_unlock();
 	return eb;
@@ -2842,7 +2842,7 @@ static struct extent_buffer *__alloc_ext
 	btrfs_leak_debug_add_eb(eb);
 
 	spin_lock_init(&eb->refs_lock);
-	atomic_set(&eb->refs, 1);
+	refcount_set(&eb->refs, 1);
 
 	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
 
@@ -2975,13 +2975,13 @@ static void check_buffer_tree_ref(struct
 	 * once io is initiated, TREE_REF can no longer be cleared, so that is
 	 * the moment at which any such race is best fixed.
 	 */
-	refs = atomic_read(&eb->refs);
+	refs = refcount_read(&eb->refs);
 	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
 		return;
 
 	spin_lock(&eb->refs_lock);
 	if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_inc(&eb->refs);
+		refcount_inc(&eb->refs);
 	spin_unlock(&eb->refs_lock);
 }
 
@@ -3047,7 +3047,7 @@ again:
 		return ERR_PTR(ret);
 	}
 	if (exists) {
-		if (!atomic_inc_not_zero(&exists->refs)) {
+		if (!refcount_inc_not_zero(&exists->refs)) {
 			/* The extent buffer is being freed, retry. */
 			xa_unlock_irq(&fs_info->buffer_tree);
 			goto again;
@@ -3092,7 +3092,7 @@ static struct extent_buffer *grab_extent
 	 * just overwrite folio private.
 	 */
 	exists = folio_get_private(folio);
-	if (atomic_inc_not_zero(&exists->refs))
+	if (refcount_inc_not_zero(&exists->refs))
 		return exists;
 
 	WARN_ON(folio_test_dirty(folio));
@@ -3362,7 +3362,7 @@ again:
 		goto out;
 	}
 	if (existing_eb) {
-		if (!atomic_inc_not_zero(&existing_eb->refs)) {
+		if (!refcount_inc_not_zero(&existing_eb->refs)) {
 			xa_unlock_irq(&fs_info->buffer_tree);
 			goto again;
 		}
@@ -3391,7 +3391,7 @@ again:
 	return eb;
 
 out:
-	WARN_ON(!atomic_dec_and_test(&eb->refs));
+	WARN_ON(!refcount_dec_and_test(&eb->refs));
 
 	/*
 	 * Any attached folios need to be detached before we unlock them.  This
@@ -3437,8 +3437,7 @@ static int release_extent_buffer(struct
 {
 	lockdep_assert_held(&eb->refs_lock);
 
-	WARN_ON(atomic_read(&eb->refs) == 0);
-	if (atomic_dec_and_test(&eb->refs)) {
+	if (refcount_dec_and_test(&eb->refs)) {
 		struct btrfs_fs_info *fs_info = eb->fs_info;
 
 		spin_unlock(&eb->refs_lock);
@@ -3484,7 +3483,7 @@ void free_extent_buffer(struct extent_bu
 	if (!eb)
 		return;
 
-	refs = atomic_read(&eb->refs);
+	refs = refcount_read(&eb->refs);
 	while (1) {
 		if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
 			if (refs == 1)
@@ -3494,16 +3493,16 @@ void free_extent_buffer(struct extent_bu
 		}
 
 		/* Optimization to avoid locking eb->refs_lock. */
-		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
+		if (atomic_try_cmpxchg(&eb->refs.refs, &refs, refs - 1))
 			return;
 	}
 
 	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) == 2 &&
+	if (refcount_read(&eb->refs) == 2 &&
 	    test_bit(EXTENT_BUFFER_STALE, &eb->bflags) &&
 	    !extent_buffer_under_io(eb) &&
 	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
+		refcount_dec(&eb->refs);
 
 	/*
 	 * I know this is terrible, but it's temporary until we stop tracking
@@ -3520,9 +3519,9 @@ void free_extent_buffer_stale(struct ext
 	spin_lock(&eb->refs_lock);
 	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
 
-	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
+	if (refcount_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
 	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
+		refcount_dec(&eb->refs);
 	release_extent_buffer(eb);
 }
 
@@ -3580,7 +3579,7 @@ void btrfs_clear_buffer_dirty(struct btr
 			btree_clear_folio_dirty_tag(folio);
 		folio_unlock(folio);
 	}
-	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(refcount_read(&eb->refs) == 0);
 }
 
 void set_extent_buffer_dirty(struct extent_buffer *eb)
@@ -3591,7 +3590,7 @@ void set_extent_buffer_dirty(struct exte
 
 	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
 
-	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(refcount_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
@@ -3717,7 +3716,7 @@ int read_extent_buffer_pages_nowait(stru
 
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
-	atomic_inc(&eb->refs);
+	refcount_inc(&eb->refs);
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_READ | REQ_META, eb->fs_info,
@@ -4312,7 +4311,7 @@ static int try_release_subpage_extent_bu
 		 * won't disappear out from under us.
 		 */
 		spin_lock(&eb->refs_lock);
-		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
 			continue;
 		}
@@ -4378,7 +4377,7 @@ int try_release_extent_buffer(struct fol
 	 * this page.
 	 */
 	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+	if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 		spin_unlock(&eb->refs_lock);
 		spin_unlock(&folio->mapping->i_private_lock);
 		return 0;
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -98,7 +98,7 @@ struct extent_buffer {
 	void *addr;
 
 	spinlock_t refs_lock;
-	atomic_t refs;
+	refcount_t refs;
 	int read_mirror;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -320,7 +320,7 @@ static int fiemap_next_leaf_item(struct
 	 * the cost of allocating a new one.
 	 */
 	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
-	atomic_inc(&clone->refs);
+	refcount_inc(&clone->refs);
 
 	ret = btrfs_next_leaf(inode->root, path);
 	if (ret != 0)
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -223,7 +223,7 @@ static void print_eb_refs_lock(const str
 {
 #ifdef CONFIG_BTRFS_DEBUG
 	btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
-		   atomic_read(&eb->refs), eb->lock_owner, current->pid);
+		   refcount_read(&eb->refs), eb->lock_owner, current->pid);
 #endif
 }
 
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2348,7 +2348,7 @@ static int qgroup_trace_extent_swap(stru
 		btrfs_item_key_to_cpu(dst_path->nodes[dst_level], &key, 0);
 
 	/* For src_path */
-	atomic_inc(&src_eb->refs);
+	refcount_inc(&src_eb->refs);
 	src_path->nodes[root_level] = src_eb;
 	src_path->slots[root_level] = dst_path->slots[root_level];
 	src_path->locks[root_level] = 0;
@@ -2581,7 +2581,7 @@ static int qgroup_trace_subtree_swap(str
 		goto out;
 	}
 	/* For dst_path */
-	atomic_inc(&dst_eb->refs);
+	refcount_inc(&dst_eb->refs);
 	dst_path->nodes[level] = dst_eb;
 	dst_path->slots[level] = 0;
 	dst_path->locks[level] = 0;
@@ -2673,7 +2673,7 @@ int btrfs_qgroup_trace_subtree(struct bt
 	 * walk back up the tree (adjusting slot pointers as we go)
 	 * and restart the search process.
 	 */
-	atomic_inc(&root_eb->refs);	/* For path */
+	refcount_inc(&root_eb->refs);	/* For path */
 	path->nodes[root_level] = root_eb;
 	path->slots[root_level] = 0;
 	path->locks[root_level] = 0; /* so release_path doesn't try to unlock */
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1535,7 +1535,7 @@ static noinline_for_stack int merge_relo
 
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_root_level(root_item);
-		atomic_inc(&reloc_root->node->refs);
+		refcount_inc(&reloc_root->node->refs);
 		path->nodes[level] = reloc_root->node;
 		path->slots[level] = 0;
 	} else {
@@ -4358,7 +4358,7 @@ int btrfs_reloc_cow_block(struct btrfs_t
 		}
 
 		btrfs_backref_drop_node_buffer(node);
-		atomic_inc(&cow->refs);
+		refcount_inc(&cow->refs);
 		node->eb = cow;
 		node->new_bytenr = cow->start;
 
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2747,7 +2747,7 @@ static int walk_log_tree(struct btrfs_tr
 	level = btrfs_header_level(log->node);
 	orig_level = level;
 	path->nodes[level] = log->node;
-	atomic_inc(&log->node->refs);
+	refcount_inc(&log->node->refs);
 	path->slots[level] = 0;
 
 	while (1) {
@@ -3711,7 +3711,7 @@ static int clone_leaf(struct btrfs_path
 	 * Add extra ref to scratch eb so that it is not freed when callers
 	 * release the path, so we can reuse it later if needed.
 	 */
-	atomic_inc(&ctx->scratch_eb->refs);
+	refcount_inc(&ctx->scratch_eb->refs);
 
 	return 0;
 }
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2491,7 +2491,7 @@ void btrfs_schedule_zone_finish_bg(struc
 
 	/* For the work */
 	btrfs_get_block_group(bg);
-	atomic_inc(&eb->refs);
+	refcount_inc(&eb->refs);
 	bg->last_eb = eb;
 	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
 	queue_work(system_unbound_wq, &bg->zone_finish_work);
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1095,7 +1095,7 @@ TRACE_EVENT(btrfs_cow_block,
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->buf_start	= buf->start;
-		__entry->refs		= atomic_read(&buf->refs);
+		__entry->refs		= refcount_read(&buf->refs);
 		__entry->cow_start	= cow->start;
 		__entry->buf_level	= btrfs_header_level(buf);
 		__entry->cow_level	= btrfs_header_level(cow);



