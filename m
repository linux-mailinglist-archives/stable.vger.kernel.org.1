Return-Path: <stable+bounces-23634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ACF867134
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9990028F8FF
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF91F959;
	Mon, 26 Feb 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0WVFSeCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF201F94B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942918; cv=none; b=BQEHcODYg9j6mpmDH7jfKC+iKb9vyAHbPVt3aAgSO/Fs7fYIziQEgBP1DJVvDSzdQSm0ztaHqk5rGblBPGZYaSaYAZl1W1whH2lgDsS0ObFqr78UazWvu9KZ52wHkWCwTP8mR/k1JeheviKgB3guJpMTlG0OWO8oUGOC1JKgT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942918; c=relaxed/simple;
	bh=KXsEXOaMLNamONkgQU3pe0UglcZscGHfRj9JXlaAbyM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h97DS+kFcoYa7XNbFvZx7C/qHBjwdLkT+tnr75Ugg8EFEloLrp0c75rBmePz+VMjALPyBiJL28uatmGfHCJdntvAgYNT+y2dLsDGxeEq5ny5rqQtJdi1Vcj3OnCEz7oXL7WlBHqMx6RR3HOEMPgjv9kRyqFm78S0alPpKuci87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0WVFSeCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20A9C43390;
	Mon, 26 Feb 2024 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708942918;
	bh=KXsEXOaMLNamONkgQU3pe0UglcZscGHfRj9JXlaAbyM=;
	h=Subject:To:Cc:From:Date:From;
	b=0WVFSeCALhmaYq/gl7xHLqSGQcpFcR4ziG6v2/XjDPhciGMjeIcCcxMdbirscSgyh
	 dJu/VoxTBbAcTPZ3aeqJ93MNHv9ts2L10S+S+BANObu/pbkQvAiPBxQMdMpIMX51Hr
	 kTZILXgNNHCfYMpFtYYhDOrbL5MklxreK4E+4cXg=
Subject: FAILED: patch "[PATCH] btrfs: fix deadlock with fiemap and extent locking" failed to apply to 6.1-stable tree
To: josef@toxicpanda.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:21:55 +0100
Message-ID: <2024022655-fled-exes-9ef4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b0ad381fa7690244802aed119b478b4bdafc31dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022655-fled-exes-9ef4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking")
519b7e13b5ae ("btrfs: lock the inode in shared mode before starting fiemap")
b3e744fe6d28 ("btrfs: use cached state when looking for delalloc ranges with fiemap")
8c6e53a79d16 ("btrfs: allow passing a cached state record to count_range_bits()")
8ddc8274e4be ("btrfs: search for delalloc more efficiently during lseek/fiemap")
af979fd618a4 ("btrfs: skip unnecessary delalloc searches during lseek/fiemap")
40daf3e095db ("btrfs: add an early exit when searching for delalloc range for lseek/fiemap")
af142b6f44d3 ("btrfs: move file prototypes to file.h")
7572dec8f522 ("btrfs: move ioctl prototypes into ioctl.h")
c7a03b524d30 ("btrfs: move uuid tree prototypes to uuid-tree.h")
7c8ede162805 ("btrfs: move file-item prototypes into their own header")
f2b39277b87d ("btrfs: move dir-item prototypes into dir-item.h")
59b818e064ab ("btrfs: move defrag related prototypes to their own header")
a6a01ca61f49 ("btrfs: move the file defrag code into defrag.c")
6e3df18ba7e8 ("btrfs: move the auto defrag code to defrag.c")
2885fd632050 ("btrfs: move inode prototypes to btrfs_inode.h")
911bd75aca73 ("btrfs: remove unused function prototypes")
45c40c8f9541 ("btrfs: move root tree prototypes to their own header")
2839c2c142dd ("btrfs: move delalloc space related prototypes to delalloc-space.h")
a0231804affe ("btrfs: move extent-tree helpers into their own header file")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b0ad381fa7690244802aed119b478b4bdafc31dd Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 12 Feb 2024 11:56:02 -0500
Subject: [PATCH] btrfs: fix deadlock with fiemap and extent locking

While working on the patchset to remove extent locking I got a lockdep
splat with fiemap and pagefaulting with my new extent lock replacement
lock.

This deadlock exists with our normal code, we just don't have lockdep
annotations with the extent locking so we've never noticed it.

Since we're copying the fiemap extent to user space on every iteration
we have the chance of pagefaulting.  Because we hold the extent lock for
the entire range we could mkwrite into a range in the file that we have
mmap'ed.  This would deadlock with the following stack trace

[<0>] lock_extent+0x28d/0x2f0
[<0>] btrfs_page_mkwrite+0x273/0x8a0
[<0>] do_page_mkwrite+0x50/0xb0
[<0>] do_fault+0xc1/0x7b0
[<0>] __handle_mm_fault+0x2fa/0x460
[<0>] handle_mm_fault+0xa4/0x330
[<0>] do_user_addr_fault+0x1f4/0x800
[<0>] exc_page_fault+0x7c/0x1e0
[<0>] asm_exc_page_fault+0x26/0x30
[<0>] rep_movs_alternative+0x33/0x70
[<0>] _copy_to_user+0x49/0x70
[<0>] fiemap_fill_next_extent+0xc8/0x120
[<0>] emit_fiemap_extent+0x4d/0xa0
[<0>] extent_fiemap+0x7f8/0xad0
[<0>] btrfs_fiemap+0x49/0x80
[<0>] __x64_sys_ioctl+0x3e1/0xb50
[<0>] do_syscall_64+0x94/0x1a0
[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

I wrote an fstest to reproduce this deadlock without my replacement lock
and verified that the deadlock exists with our existing locking.

To fix this simply don't take the extent lock for the entire duration of
the fiemap.  This is safe in general because we keep track of where we
are when we're searching the tree, so if an ordered extent updates in
the middle of our fiemap call we'll still emit the correct extents
because we know what offset we were on before.

The only place we maintain the lock is searching delalloc.  Since the
delalloc stuff can change during writeback we want to lock the extent
range so we have a consistent view of delalloc at the time we're
checking to see if we need to set the delalloc flag.

With this patch applied we no longer deadlock with my testcase.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a0ffd41c5cc1..61d961a30dee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2689,16 +2689,34 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 	 * it beyond i_size.
 	 */
 	while (cur_offset < end && cur_offset < i_size) {
+		struct extent_state *cached_state = NULL;
 		u64 delalloc_start;
 		u64 delalloc_end;
 		u64 prealloc_start;
+		u64 lockstart;
+		u64 lockend;
 		u64 prealloc_len = 0;
 		bool delalloc;
 
+		lockstart = round_down(cur_offset, inode->root->fs_info->sectorsize);
+		lockend = round_up(end, inode->root->fs_info->sectorsize);
+
+		/*
+		 * We are only locking for the delalloc range because that's the
+		 * only thing that can change here.  With fiemap we have a lock
+		 * on the inode, so no buffered or direct writes can happen.
+		 *
+		 * However mmaps and normal page writeback will cause this to
+		 * change arbitrarily.  We have to lock the extent lock here to
+		 * make sure that nobody messes with the tree while we're doing
+		 * btrfs_find_delalloc_in_range.
+		 */
+		lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
 							delalloc_cached_state,
 							&delalloc_start,
 							&delalloc_end);
+		unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		if (!delalloc)
 			break;
 
@@ -2866,15 +2884,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len)
 {
 	const u64 ino = btrfs_ino(inode);
-	struct extent_state *cached_state = NULL;
 	struct extent_state *delalloc_cached_state = NULL;
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
 	u64 last_extent_end;
 	u64 prev_extent_end;
-	u64 lockstart;
-	u64 lockend;
+	u64 range_start;
+	u64 range_end;
+	const u64 sectorsize = inode->root->fs_info->sectorsize;
 	bool stopped = false;
 	int ret;
 
@@ -2885,12 +2903,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	lockstart = round_down(start, inode->root->fs_info->sectorsize);
-	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
-	prev_extent_end = lockstart;
+	range_start = round_down(start, sectorsize);
+	range_end = round_up(start + len, sectorsize);
+	prev_extent_end = range_start;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -2898,7 +2915,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_release_path(path);
 
 	path->reada = READA_FORWARD;
-	ret = fiemap_search_slot(inode, path, lockstart);
+	ret = fiemap_search_slot(inode, path, range_start);
 	if (ret < 0) {
 		goto out_unlock;
 	} else if (ret > 0) {
@@ -2910,7 +2927,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto check_eof_delalloc;
 	}
 
-	while (prev_extent_end < lockend) {
+	while (prev_extent_end < range_end) {
 		struct extent_buffer *leaf = path->nodes[0];
 		struct btrfs_file_extent_item *ei;
 		struct btrfs_key key;
@@ -2933,19 +2950,19 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		 * The first iteration can leave us at an extent item that ends
 		 * before our range's start. Move to the next item.
 		 */
-		if (extent_end <= lockstart)
+		if (extent_end <= range_start)
 			goto next_item;
 
 		backref_ctx->curr_leaf_bytenr = leaf->start;
 
 		/* We have in implicit hole (NO_HOLES feature enabled). */
 		if (prev_extent_end < key.offset) {
-			const u64 range_end = min(key.offset, lockend) - 1;
+			const u64 hole_end = min(key.offset, range_end) - 1;
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  &delalloc_cached_state,
 						  backref_ctx, 0, 0, 0,
-						  prev_extent_end, range_end);
+						  prev_extent_end, hole_end);
 			if (ret < 0) {
 				goto out_unlock;
 			} else if (ret > 0) {
@@ -2955,7 +2972,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			}
 
 			/* We've reached the end of the fiemap range, stop. */
-			if (key.offset >= lockend) {
+			if (key.offset >= range_end) {
 				stopped = true;
 				break;
 			}
@@ -3049,29 +3066,41 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_free_path(path);
 	path = NULL;
 
-	if (!stopped && prev_extent_end < lockend) {
+	if (!stopped && prev_extent_end < range_end) {
 		ret = fiemap_process_hole(inode, fieinfo, &cache,
 					  &delalloc_cached_state, backref_ctx,
-					  0, 0, 0, prev_extent_end, lockend - 1);
+					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
 			goto out_unlock;
-		prev_extent_end = lockend;
+		prev_extent_end = range_end;
 	}
 
 	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
+			struct extent_state *cached_state = NULL;
 			u64 delalloc_start;
 			u64 delalloc_end;
+			u64 lockstart;
+			u64 lockend;
 			bool delalloc;
 
+			lockstart = round_down(prev_extent_end, sectorsize);
+			lockend = round_up(i_size, sectorsize);
+
+			/*
+			 * See the comment in fiemap_process_hole as to why
+			 * we're doing the locking here.
+			 */
+			lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			delalloc = btrfs_find_delalloc_in_range(inode,
 								prev_extent_end,
 								i_size - 1,
 								&delalloc_cached_state,
 								&delalloc_start,
 								&delalloc_end);
+			unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			if (!delalloc)
 				cache.flags |= FIEMAP_EXTENT_LAST;
 		} else {
@@ -3082,7 +3111,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 
 out_unlock:
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);


