Return-Path: <stable+bounces-171700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBBCB2B5C3
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC651962089
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960A1D514E;
	Tue, 19 Aug 2025 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocrtlWrj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD987261A
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566135; cv=none; b=EoMzJKy29Oep5NKuVPGI6qhq2HU0YUxlu2E+bvAvxHTlrYCQROxfUmdqEBzbgRl3Fvel26pXgyckNUZdyyz14ZArhxi/ODGaQna+o5e9eK73NhTzNF38DktbGNXx/HUWzFukswYhrZCGGF74Beb9+53FuqiZxzIjA0/dQpWcgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566135; c=relaxed/simple;
	bh=AXLNQplL4UvM+p0miATIzsmU2vqLxQuX7lxJ9T/nglw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrgwX7nH4Npn/P3n9EDqFSpMJRsOyr7J+yE+1OPCkSNCV0YnntkM/61QXPRI6Dt/SNVAzyt9F8qDRUmBtU3aP256YabDV5fCqWrotMD9etLs5/xwsqnUdqbAWxRLGtkke0ntyeVUUUaAUtrhFNesOci9ZisiN9dheCJ5pLz+BeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocrtlWrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FE1C116B1;
	Tue, 19 Aug 2025 01:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566135;
	bh=AXLNQplL4UvM+p0miATIzsmU2vqLxQuX7lxJ9T/nglw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocrtlWrj59jlfeM/FnxcIpP9mz7lS5W1D4XD+eXJOS+g001cCpOQPiUYPt2cPjv51
	 VwjmwarkWH2LVfy9xkB4cmtCC09wLRK/4gusblN+dxy9ygEE0rH4fQs2/p9Hbm0O9F
	 8aEhchYCr6JKwPnToM+rJHE4MXZAyma/xwT2eS3ia/v+ASci9BLu5ld7pE5L348ftE
	 bnxdxpGhFzuyz8WQyy9JNx8U9VYPP1Jm3N4WDuL9Glgr8Bh5O446ft+uJHbpdIXlyj
	 KYraWVwWwVcVRLohiYjO3DcfJS5IWIaoWCatTKAB7tdpMUpWCrvEO+KCydsHgp0b3N
	 BhgMvV9dn1eVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/4] btrfs: use refcount_t type for the extent buffer reference counter
Date: Mon, 18 Aug 2025 21:15:30 -0400
Message-ID: <20250819011531.242846-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819011531.242846-1-sashal@kernel.org>
References: <2025081814-monsoon-supermom-44bb@gregkh>
 <20250819011531.242846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/btrfs/ctree.c             | 14 +++++------
 fs/btrfs/extent-tree.c       |  2 +-
 fs/btrfs/extent_io.c         | 45 ++++++++++++++++++------------------
 fs/btrfs/extent_io.h         |  2 +-
 fs/btrfs/fiemap.c            |  2 +-
 fs/btrfs/print-tree.c        |  2 +-
 fs/btrfs/qgroup.c            |  6 ++---
 fs/btrfs/relocation.c        |  4 ++--
 fs/btrfs/tree-log.c          |  4 ++--
 fs/btrfs/zoned.c             |  2 +-
 include/trace/events/btrfs.h |  2 +-
 11 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 648531fe0900..d13be2cd34c3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -198,7 +198,7 @@ struct extent_buffer *btrfs_root_node(struct btrfs_root *root)
 		 * the inc_not_zero dance and if it doesn't work then
 		 * synchronize_rcu and try again.
 		 */
-		if (atomic_inc_not_zero(&eb->refs)) {
+		if (refcount_inc_not_zero(&eb->refs)) {
 			rcu_read_unlock();
 			break;
 		}
@@ -549,7 +549,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
-		atomic_inc(&cow->refs);
+		refcount_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
@@ -1081,7 +1081,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	/* update the path */
 	if (left) {
 		if (btrfs_header_nritems(left) > orig_slot) {
-			atomic_inc(&left->refs);
+			refcount_inc(&left->refs);
 			/* left was locked after cow */
 			path->nodes[level] = left;
 			path->slots[level + 1] -= 1;
@@ -1685,7 +1685,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 
 	if (p->search_commit_root) {
 		b = root->commit_root;
-		atomic_inc(&b->refs);
+		refcount_inc(&b->refs);
 		level = btrfs_header_level(b);
 		/*
 		 * Ensure that all callers have set skip_locking when
@@ -2885,7 +2885,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	free_extent_buffer(old);
 
 	add_root_to_dirty_list(root);
-	atomic_inc(&c->refs);
+	refcount_inc(&c->refs);
 	path->nodes[level] = c;
 	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
@@ -4442,7 +4442,7 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 
 	root_sub_used_bytes(root);
 
-	atomic_inc(&leaf->refs);
+	refcount_inc(&leaf->refs);
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
 	if (ret < 0)
@@ -4527,7 +4527,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			 * for possible call to btrfs_del_ptr below
 			 */
 			slot = path->slots[1];
-			atomic_inc(&leaf->refs);
+			refcount_inc(&leaf->refs);
 			/*
 			 * We want to be able to at least push one item to the
 			 * left neighbour leaf, and that's the first item.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cb6128778a83..0e8b5aaa78cb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6341,7 +6341,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 
 	btrfs_assert_tree_write_locked(parent);
 	parent_level = btrfs_header_level(parent);
-	atomic_inc(&parent->refs);
+	refcount_inc(&parent->refs);
 	path->nodes[parent_level] = parent;
 	path->slots[parent_level] = btrfs_header_nritems(parent);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9cf37693d609..8549fb4f6dfd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -77,7 +77,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 				      struct extent_buffer, leak_list);
 		pr_err(
 	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
+		       eb->start, eb->len, refcount_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
 		WARN_ON_ONCE(1);
@@ -1961,7 +1961,7 @@ static inline struct extent_buffer *find_get_eb(struct xa_state *xas, unsigned l
 	if (!eb)
 		return NULL;
 
-	if (!atomic_inc_not_zero(&eb->refs)) {
+	if (!refcount_inc_not_zero(&eb->refs)) {
 		xas_reset(xas);
 		goto retry;
 	}
@@ -2012,7 +2012,7 @@ static struct extent_buffer *find_extent_buffer_nolock(
 
 	rcu_read_lock();
 	eb = xa_load(&fs_info->buffer_tree, index);
-	if (eb && !atomic_inc_not_zero(&eb->refs))
+	if (eb && !refcount_inc_not_zero(&eb->refs))
 		eb = NULL;
 	rcu_read_unlock();
 	return eb;
@@ -2842,7 +2842,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	btrfs_leak_debug_add_eb(eb);
 
 	spin_lock_init(&eb->refs_lock);
-	atomic_set(&eb->refs, 1);
+	refcount_set(&eb->refs, 1);
 
 	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
 
@@ -2975,13 +2975,13 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
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
 
@@ -3047,7 +3047,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(ret);
 	}
 	if (exists) {
-		if (!atomic_inc_not_zero(&exists->refs)) {
+		if (!refcount_inc_not_zero(&exists->refs)) {
 			/* The extent buffer is being freed, retry. */
 			xa_unlock_irq(&fs_info->buffer_tree);
 			goto again;
@@ -3092,7 +3092,7 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * just overwrite folio private.
 	 */
 	exists = folio_get_private(folio);
-	if (atomic_inc_not_zero(&exists->refs))
+	if (refcount_inc_not_zero(&exists->refs))
 		return exists;
 
 	WARN_ON(folio_test_dirty(folio));
@@ -3362,7 +3362,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 	if (existing_eb) {
-		if (!atomic_inc_not_zero(&existing_eb->refs)) {
+		if (!refcount_inc_not_zero(&existing_eb->refs)) {
 			xa_unlock_irq(&fs_info->buffer_tree);
 			goto again;
 		}
@@ -3391,7 +3391,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 
 out:
-	WARN_ON(!atomic_dec_and_test(&eb->refs));
+	WARN_ON(!refcount_dec_and_test(&eb->refs));
 
 	/*
 	 * Any attached folios need to be detached before we unlock them.  This
@@ -3437,8 +3437,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 {
 	lockdep_assert_held(&eb->refs_lock);
 
-	WARN_ON(atomic_read(&eb->refs) == 0);
-	if (atomic_dec_and_test(&eb->refs)) {
+	if (refcount_dec_and_test(&eb->refs)) {
 		struct btrfs_fs_info *fs_info = eb->fs_info;
 
 		spin_unlock(&eb->refs_lock);
@@ -3484,7 +3483,7 @@ void free_extent_buffer(struct extent_buffer *eb)
 	if (!eb)
 		return;
 
-	refs = atomic_read(&eb->refs);
+	refs = refcount_read(&eb->refs);
 	while (1) {
 		if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
 			if (refs == 1)
@@ -3494,16 +3493,16 @@ void free_extent_buffer(struct extent_buffer *eb)
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
@@ -3520,9 +3519,9 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	spin_lock(&eb->refs_lock);
 	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
 
-	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
+	if (refcount_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
 	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
+		refcount_dec(&eb->refs);
 	release_extent_buffer(eb);
 }
 
@@ -3580,7 +3579,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			btree_clear_folio_dirty_tag(folio);
 		folio_unlock(folio);
 	}
-	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(refcount_read(&eb->refs) == 0);
 }
 
 void set_extent_buffer_dirty(struct extent_buffer *eb)
@@ -3591,7 +3590,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 
 	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
 
-	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(refcount_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
@@ -3717,7 +3716,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
-	atomic_inc(&eb->refs);
+	refcount_inc(&eb->refs);
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_READ | REQ_META, eb->fs_info,
@@ -4312,7 +4311,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * won't disappear out from under us.
 		 */
 		spin_lock(&eb->refs_lock);
-		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
 			continue;
 		}
@@ -4378,7 +4377,7 @@ int try_release_extent_buffer(struct folio *folio)
 	 * this page.
 	 */
 	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+	if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 		spin_unlock(&eb->refs_lock);
 		spin_unlock(&folio->mapping->i_private_lock);
 		return 0;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e36e8d6a00bc..65bb87f1dce6 100644
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
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index 43bf0979fd53..7935586a9dbd 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -320,7 +320,7 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 	 * the cost of allocating a new one.
 	 */
 	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
-	atomic_inc(&clone->refs);
+	refcount_inc(&clone->refs);
 
 	ret = btrfs_next_leaf(inode->root, path);
 	if (ret != 0)
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index fc821aa446f0..21605b03f511 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -223,7 +223,7 @@ static void print_eb_refs_lock(const struct extent_buffer *eb)
 {
 #ifdef CONFIG_BTRFS_DEBUG
 	btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
-		   atomic_read(&eb->refs), eb->lock_owner, current->pid);
+		   refcount_read(&eb->refs), eb->lock_owner, current->pid);
 #endif
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b3176edbde82..fef74f76ce58 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2341,7 +2341,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		btrfs_item_key_to_cpu(dst_path->nodes[dst_level], &key, 0);
 
 	/* For src_path */
-	atomic_inc(&src_eb->refs);
+	refcount_inc(&src_eb->refs);
 	src_path->nodes[root_level] = src_eb;
 	src_path->slots[root_level] = dst_path->slots[root_level];
 	src_path->locks[root_level] = 0;
@@ -2574,7 +2574,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	/* For dst_path */
-	atomic_inc(&dst_eb->refs);
+	refcount_inc(&dst_eb->refs);
 	dst_path->nodes[level] = dst_eb;
 	dst_path->slots[level] = 0;
 	dst_path->locks[level] = 0;
@@ -2666,7 +2666,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	 * walk back up the tree (adjusting slot pointers as we go)
 	 * and restart the search process.
 	 */
-	atomic_inc(&root_eb->refs);	/* For path */
+	refcount_inc(&root_eb->refs);	/* For path */
 	path->nodes[root_level] = root_eb;
 	path->slots[root_level] = 0;
 	path->locks[root_level] = 0; /* so release_path doesn't try to unlock */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 02086191630d..c9290fc6f15f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1516,7 +1516,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_root_level(root_item);
-		atomic_inc(&reloc_root->node->refs);
+		refcount_inc(&reloc_root->node->refs);
 		path->nodes[level] = reloc_root->node;
 		path->slots[level] = 0;
 	} else {
@@ -4339,7 +4339,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_backref_drop_node_buffer(node);
-		atomic_inc(&cow->refs);
+		refcount_inc(&cow->refs);
 		node->eb = cow;
 		node->new_bytenr = cow->start;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cea8a7e9d6d3..f930a5eaaea6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2720,7 +2720,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 	level = btrfs_header_level(log->node);
 	orig_level = level;
 	path->nodes[level] = log->node;
-	atomic_inc(&log->node->refs);
+	refcount_inc(&log->node->refs);
 	path->slots[level] = 0;
 
 	while (1) {
@@ -3684,7 +3684,7 @@ static int clone_leaf(struct btrfs_path *path, struct btrfs_log_ctx *ctx)
 	 * Add extra ref to scratch eb so that it is not freed when callers
 	 * release the path, so we can reuse it later if needed.
 	 */
-	atomic_inc(&ctx->scratch_eb->refs);
+	refcount_inc(&ctx->scratch_eb->refs);
 
 	return 0;
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9430b34d3cbb..8079c6e1d2b5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2485,7 +2485,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 
 	/* For the work */
 	btrfs_get_block_group(bg);
-	atomic_inc(&eb->refs);
+	refcount_inc(&eb->refs);
 	bg->last_eb = eb;
 	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
 	queue_work(system_unbound_wq, &bg->zone_finish_work);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index bebc252db865..a32305044371 100644
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
-- 
2.50.1


