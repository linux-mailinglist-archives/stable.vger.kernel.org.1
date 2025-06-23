Return-Path: <stable+bounces-156144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4CAE497A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80BB7A9AB4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE7415E5BB;
	Mon, 23 Jun 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="MoQKhguZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8E1B85F8
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694415; cv=none; b=R3PMYKPyvSePBKUtuqK/rsodY1YqW4YyjCuHm0RSDFWtJ25kiEYVAXgJ/qmrUI0GJboJudVCuqwRODW00ylaZfsEYd69ZhNu2RKUjgrJqO4JhCFqdXOF2V11iEkFpo/3CVMco1A+kD/mhrBZ1+o9kTtoZhd6DrWZVOmH6ObHzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694415; c=relaxed/simple;
	bh=KgVneFiwanNdjZmsrTPI3jys2oT5pqdPY+d0+vD6I2I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GYg7nuriDFkF+/Tt3LS5QybbWIzImENwbyJMMGapQCA9Jmj2Qur3fzNaZGT1K+07qpxjBzHZ3/BmhY3JYAF1S2w2F0350WqhQ8GN1sBHM3zL4AGFUaOc7z2UXnc8pl7bZyWT3nAX4+OCfCF7qnYHhnUpJDOWF1FRTNjDaujFyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=MoQKhguZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2453199f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1750694411; x=1751299211; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNmwvQDnjROo/3M6XvH7wKQwGPFqYK4I0GED/lcOc/U=;
        b=MoQKhguZSEV8egGqetE5rubWVVq/w1pWyHVC8eapAc6JZ6coTmzwGGflpP0n94BHzz
         eo5UMbUSojXnU7wYIdwzt5Irb6h/D4pTeheLj79P6EAlKSuAZdsRkGFWpb7hfyxk3kT8
         JYam59q9BfVTAhItfRlG48SEjnt8Dx673UfM2Y1Y8/i1l6mBClQP8U87dIMo/84SnlhM
         3muG15V9H8dov04LRe17234HiBYsuIng7K05WtIfadtuB8BZzSBeCcf6cuaduT5ciIk6
         9D6dbl7NUEa/HEwUz+2WhE9KY9wkLFZy+v2wQDks7BSL9HlT7S7DogUSLoBKC3qX50Z1
         zOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750694411; x=1751299211;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNmwvQDnjROo/3M6XvH7wKQwGPFqYK4I0GED/lcOc/U=;
        b=vFmu1TEelUOlWs9qmh2XPcoalVFS2kDUzOgvkvW97T6MeUzLcg5YxoBtqWPe7JBm+A
         s5wouo+7z6VN52qQrPfI4ynG3GrXAEO9pUP1iVRFjj8ARrbXwOXl2CHFlnpSsOxbuP5H
         IMV/J01SpzmQ4Hw4RxDZGR02HjSZz+Wf1OcjnDak9Ajnb9XJ1acpcPqwycU9ifsg92Qj
         kaVZ4hqrJ0hUfE/0iWUXb8PhYxu2J/jVi4Il4/f3l35kmd9/biS/KH4nY853jddoQgBF
         u1EuynB9MwhPxxMqi1LsWoaPxRBVJU0C3v+EtJoFB4OLXUyWOJED3EWE+jrZX0QMHXOU
         eNcQ==
X-Gm-Message-State: AOJu0Yzi3V6g8Q2MuvqTyvEUMCx/GGA+YHXg2EStpxWRN0mfluqR+eDI
	JZh2IQKLFV1i6M8q11Yymi257zs+FY+hk7hGHdJwzc27riY3DSqRFzp4cUbc16zvfe/NO8v+fTo
	k2vI39Og=
X-Gm-Gg: ASbGncsMN+UeCdQZwQoyWsNIjrCrvxOgQeXC8oTcFby+zeMXnagBrbfeleIgptVxG0i
	pTZEIfSSMLPaJG/Z35ARQN2NK+vKer1oH3xRp88edCMXEVq6i5HjpxH9+ZE6KpHxA6qFCr2sw/F
	faQYnUe79QRaqhjIuZmL+9YjxQ6IZpTvipp02bsEL6I4TXoavwnPYnu3Bt2n6H6RloLN0BLJ70b
	spNWQ2aKdZK2boMYrHp5w6b+MdslCJIrYSp96GdOOL66srlCkWmCoqhdCniAYDa2RUPPQINMLQw
	Nc+LGt3hUdY9BIElAuDxCvFpF7TKHfP9tC5c3nXK/Iede5pxtqXTq1rsM9HSrdg=
X-Google-Smtp-Source: AGHT+IFg34Twct4X9nnoxSvXKz7S9CObVivNwDj1T/mQffDhljsbNTr3vteZUDFtJ5a3qffdXSosVQ==
X-Received: by 2002:a05:6000:4284:b0:3a4:e844:745d with SMTP id ffacd0b85a97d-3a6d13315c2mr11566465f8f.56.1750694410888;
        Mon, 23 Jun 2025 09:00:10 -0700 (PDT)
Received: from localhost.localdomain ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c02fsm9914610f8f.50.2025.06.23.09.00.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:00:10 -0700 (PDT)
From: Alex Lyakas <alex@zadara.com>
To: stable@vger.kernel.org
Cc: alex@zadara.com,
	josef@toxicpanda.com
Subject: [PATCH] btrfs: check delayed refs when we're checking if a ref exists
Date: Mon, 23 Jun 2025 18:58:31 +0300
Message-Id: <1750694311-28848-1-git-send-email-alex@zadara.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

[upstream commit 42fac187b5c746227c92d024f1caf33bc1d337e4]

This is a backport of the above upstream commit by Josef Bacik to the
stable linux-6.6.y branch. I tested it to the best of my abilities.
I was able to test the part where the reference exists in the extent tree,
which means the patch doesn't break existing functionality.
However, I was not able to test the case where we only have the delayed reference.

Josef, I would appreciate if you could review the patch.

Original commit message by Josef:

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

Signed-off-by: Alex Lyakas <alex@zadara.com>
---
 fs/btrfs/delayed-ref.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/extent-tree.c | 53 ++++++++++++++++++++++++++++++++-----
 3 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6f2e48d..b143194 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1115,6 +1115,77 @@ struct btrfs_delayed_ref_head *
 	return find_ref_head(delayed_refs, bytenr, false);
 }
 
+static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64 parent)
+{
+	int type = parent ? BTRFS_SHARED_BLOCK_REF_KEY : BTRFS_TREE_BLOCK_REF_KEY;
+	struct btrfs_delayed_tree_ref *tree_ref;
+
+	if (type < entry->type)
+		return -1;
+	if (type > entry->type)
+		return 1;
+
+	tree_ref = btrfs_delayed_node_to_tree_ref(entry);
+
+	if (type == BTRFS_TREE_BLOCK_REF_KEY) {
+		if (root < tree_ref->root)
+			return -1;
+		if (root > tree_ref->root)
+			return 1;
+	} else {
+		if (parent < tree_ref->parent)
+			return -1;
+		if (parent > tree_ref->parent)
+			return 1;
+	}
+	return 0;
+}
+
+/* btrfs: check delayed refs when we're checking if a ref exists */
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
index fd9bf2b..c4f2495 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -409,6 +409,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       u64 num_bytes);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
+bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
+				 u64 root, u64 parent);
 
 /*
  * helper functions to cast a node into its container
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ef77d42..7e180c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5241,23 +5241,62 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
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
-				    root->root_key.objectid, level, 0);
+				    btrfs_root_id(root), level, 0);
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
-- 
1.9.1


