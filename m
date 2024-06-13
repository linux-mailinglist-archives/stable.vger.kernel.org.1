Return-Path: <stable+bounces-51223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E7906EE1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC5A1F20FDF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A34145A05;
	Thu, 13 Jun 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PelnpW9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B213D881;
	Thu, 13 Jun 2024 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280668; cv=none; b=p5JOM26zpxyJ7Fbyd1zdCkNftzdeNbw7QlaZFbE5rEl+Sp/G7c7VO8cLKTPPer4TiWkSmltheDnIAV9ue7NHJhd9IraBazb24jFhhfcFp2BSGf4TCfb329SH7FOd3nZzTGkmhKMlEjfULiIL+py4U/9RKY4nK9tQw34yRxMA9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280668; c=relaxed/simple;
	bh=XfrDm7Zwa4GjUzR/wmsN5qwPLRiDXPmkbutAZc3fhLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esb+jvDua6H/7RPw/RiPsKLygbU4VcJH5NTulJ4l7a3BdEChaa3W6r+MOgztCfVfG1eBminmqbFdkhxtQWj5o9qaAvRJJcfANM+OqSPMDiRJerZX3v1FCvRIFCskgeQjAP2XKmI7YaXGvJEIUqj+8HyL2Y24skWfSafQBaCt8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PelnpW9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67731C2BBFC;
	Thu, 13 Jun 2024 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280667;
	bh=XfrDm7Zwa4GjUzR/wmsN5qwPLRiDXPmkbutAZc3fhLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PelnpW9Kkadetqv0p73cEklzpweOs8C2H5sNMZHjV9IGO5+RfVg0NqiztbZv07/Xn
	 SfOyYntcYykvQZAcHVC9+nC08oe58MWRIjJKDoJjxD5JVG6wSsuftf+bfJ1NXmvtCR
	 4/N+fWT4FhlXYDYQkkqBrnxA2Uw4i9Y8hzEY9EQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Omar Sandoval <osandov@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 131/137] btrfs: fix crash on racing fsync and size-extending write into prealloc
Date: Thu, 13 Jun 2024 13:35:11 +0200
Message-ID: <20240613113228.381504536@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit 9d274c19a71b3a276949933859610721a453946b upstream.

We have been seeing crashes on duplicate keys in
btrfs_set_item_key_safe():

  BTRFS critical (device vdb): slot 4 key (450 108 8192) new key (450 108 8192)
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.c:2620!
  invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 3139 Comm: xfs_io Kdump: loaded Not tainted 6.9.0 #6
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:btrfs_set_item_key_safe+0x11f/0x290 [btrfs]

With the following stack trace:

  #0  btrfs_set_item_key_safe (fs/btrfs/ctree.c:2620:4)
  #1  btrfs_drop_extents (fs/btrfs/file.c:411:4)
  #2  log_one_extent (fs/btrfs/tree-log.c:4732:9)
  #3  btrfs_log_changed_extents (fs/btrfs/tree-log.c:4955:9)
  #4  btrfs_log_inode (fs/btrfs/tree-log.c:6626:9)
  #5  btrfs_log_inode_parent (fs/btrfs/tree-log.c:7070:8)
  #6  btrfs_log_dentry_safe (fs/btrfs/tree-log.c:7171:8)
  #7  btrfs_sync_file (fs/btrfs/file.c:1933:8)
  #8  vfs_fsync_range (fs/sync.c:188:9)
  #9  vfs_fsync (fs/sync.c:202:9)
  #10 do_fsync (fs/sync.c:212:9)
  #11 __do_sys_fdatasync (fs/sync.c:225:9)
  #12 __se_sys_fdatasync (fs/sync.c:223:1)
  #13 __x64_sys_fdatasync (fs/sync.c:223:1)
  #14 do_syscall_x64 (arch/x86/entry/common.c:52:14)
  #15 do_syscall_64 (arch/x86/entry/common.c:83:7)
  #16 entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)

So we're logging a changed extent from fsync, which is splitting an
extent in the log tree. But this split part already exists in the tree,
triggering the BUG().

This is the state of the log tree at the time of the crash, dumped with
drgn (https://github.com/osandov/drgn/blob/main/contrib/btrfs_tree.py)
to get more details than btrfs_print_leaf() gives us:

  >>> print_extent_buffer(prog.crashed_thread().stack_trace()[0]["eb"])
  leaf 33439744 level 0 items 72 generation 9 owner 18446744073709551610
  leaf 33439744 flags 0x100000000000000
  fs uuid e5bd3946-400c-4223-8923-190ef1f18677
  chunk uuid d58cb17e-6d02-494a-829a-18b7d8a399da
          item 0 key (450 INODE_ITEM 0) itemoff 16123 itemsize 160
                  generation 7 transid 9 size 8192 nbytes 8473563889606862198
                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                  sequence 204 flags 0x10(PREALLOC)
                  atime 1716417703.220000000 (2024-05-22 15:41:43)
                  ctime 1716417704.983333333 (2024-05-22 15:41:44)
                  mtime 1716417704.983333333 (2024-05-22 15:41:44)
                  otime 17592186044416.000000000 (559444-03-08 01:40:16)
          item 1 key (450 INODE_REF 256) itemoff 16110 itemsize 13
                  index 195 namelen 3 name: 193
          item 2 key (450 XATTR_ITEM 1640047104) itemoff 16073 itemsize 37
                  location key (0 UNKNOWN.0 0) type XATTR
                  transid 7 data_len 1 name_len 6
                  name: user.a
                  data a
          item 3 key (450 EXTENT_DATA 0) itemoff 16020 itemsize 53
                  generation 9 type 1 (regular)
                  extent data disk byte 303144960 nr 12288
                  extent data offset 0 nr 4096 ram 12288
                  extent compression 0 (none)
          item 4 key (450 EXTENT_DATA 4096) itemoff 15967 itemsize 53
                  generation 9 type 2 (prealloc)
                  prealloc data disk byte 303144960 nr 12288
                  prealloc data offset 4096 nr 8192
          item 5 key (450 EXTENT_DATA 8192) itemoff 15914 itemsize 53
                  generation 9 type 2 (prealloc)
                  prealloc data disk byte 303144960 nr 12288
                  prealloc data offset 8192 nr 4096
  ...

So the real problem happened earlier: notice that items 4 (4k-12k) and 5
(8k-12k) overlap. Both are prealloc extents. Item 4 straddles i_size and
item 5 starts at i_size.

Here is the state of the filesystem tree at the time of the crash:

  >>> root = prog.crashed_thread().stack_trace()[2]["inode"].root
  >>> ret, nodes, slots = btrfs_search_slot(root, BtrfsKey(450, 0, 0))
  >>> print_extent_buffer(nodes[0])
  leaf 30425088 level 0 items 184 generation 9 owner 5
  leaf 30425088 flags 0x100000000000000
  fs uuid e5bd3946-400c-4223-8923-190ef1f18677
  chunk uuid d58cb17e-6d02-494a-829a-18b7d8a399da
  	...
          item 179 key (450 INODE_ITEM 0) itemoff 4907 itemsize 160
                  generation 7 transid 7 size 4096 nbytes 12288
                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                  sequence 6 flags 0x10(PREALLOC)
                  atime 1716417703.220000000 (2024-05-22 15:41:43)
                  ctime 1716417703.220000000 (2024-05-22 15:41:43)
                  mtime 1716417703.220000000 (2024-05-22 15:41:43)
                  otime 1716417703.220000000 (2024-05-22 15:41:43)
          item 180 key (450 INODE_REF 256) itemoff 4894 itemsize 13
                  index 195 namelen 3 name: 193
          item 181 key (450 XATTR_ITEM 1640047104) itemoff 4857 itemsize 37
                  location key (0 UNKNOWN.0 0) type XATTR
                  transid 7 data_len 1 name_len 6
                  name: user.a
                  data a
          item 182 key (450 EXTENT_DATA 0) itemoff 4804 itemsize 53
                  generation 9 type 1 (regular)
                  extent data disk byte 303144960 nr 12288
                  extent data offset 0 nr 8192 ram 12288
                  extent compression 0 (none)
          item 183 key (450 EXTENT_DATA 8192) itemoff 4751 itemsize 53
                  generation 9 type 2 (prealloc)
                  prealloc data disk byte 303144960 nr 12288
                  prealloc data offset 8192 nr 4096

Item 5 in the log tree corresponds to item 183 in the filesystem tree,
but nothing matches item 4. Furthermore, item 183 is the last item in
the leaf.

btrfs_log_prealloc_extents() is responsible for logging prealloc extents
beyond i_size. It first truncates any previously logged prealloc extents
that start beyond i_size. Then, it walks the filesystem tree and copies
the prealloc extent items to the log tree.

If it hits the end of a leaf, then it calls btrfs_next_leaf(), which
unlocks the tree and does another search. However, while the filesystem
tree is unlocked, an ordered extent completion may modify the tree. In
particular, it may insert an extent item that overlaps with an extent
item that was already copied to the log tree.

This may manifest in several ways depending on the exact scenario,
including an EEXIST error that is silently translated to a full sync,
overlapping items in the log tree, or this crash. This particular crash
is triggered by the following sequence of events:

- Initially, the file has i_size=4k, a regular extent from 0-4k, and a
  prealloc extent beyond i_size from 4k-12k. The prealloc extent item is
  the last item in its B-tree leaf.
- The file is fsync'd, which copies its inode item and both extent items
  to the log tree.
- An xattr is set on the file, which sets the
  BTRFS_INODE_COPY_EVERYTHING flag.
- The range 4k-8k in the file is written using direct I/O. i_size is
  extended to 8k, but the ordered extent is still in flight.
- The file is fsync'd. Since BTRFS_INODE_COPY_EVERYTHING is set, this
  calls copy_inode_items_to_log(), which calls
  btrfs_log_prealloc_extents().
- btrfs_log_prealloc_extents() finds the 4k-12k prealloc extent in the
  filesystem tree. Since it starts before i_size, it skips it. Since it
  is the last item in its B-tree leaf, it calls btrfs_next_leaf().
- btrfs_next_leaf() unlocks the path.
- The ordered extent completion runs, which converts the 4k-8k part of
  the prealloc extent to written and inserts the remaining prealloc part
  from 8k-12k.
- btrfs_next_leaf() does a search and finds the new prealloc extent
  8k-12k.
- btrfs_log_prealloc_extents() copies the 8k-12k prealloc extent into
  the log tree. Note that it overlaps with the 4k-12k prealloc extent
  that was copied to the log tree by the first fsync.
- fsync calls btrfs_log_changed_extents(), which tries to log the 4k-8k
  extent that was written.
- This tries to drop the range 4k-8k in the log tree, which requires
  adjusting the start of the 4k-12k prealloc extent in the log tree to
  8k.
- btrfs_set_item_key_safe() sees that there is already an extent
  starting at 8k in the log tree and calls BUG().

Fix this by detecting when we're about to insert an overlapping file
extent item in the log tree and truncating the part that would overlap.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4800,18 +4800,23 @@ static int btrfs_log_prealloc_extents(st
 			path->slots[0]++;
 			continue;
 		}
-		if (!dropped_extents) {
-			/*
-			 * Avoid logging extent items logged in past fsync calls
-			 * and leading to duplicate keys in the log tree.
-			 */
+		/*
+		 * Avoid overlapping items in the log tree. The first time we
+		 * get here, get rid of everything from a past fsync. After
+		 * that, if the current extent starts before the end of the last
+		 * extent we copied, truncate the last one. This can happen if
+		 * an ordered extent completion modifies the subvolume tree
+		 * while btrfs_next_leaf() has the tree unlocked.
+		 */
+		if (!dropped_extents || key.offset < truncate_offset) {
 			ret = truncate_inode_items(trans, root->log_root, inode,
-						   truncate_offset,
+						   min(key.offset, truncate_offset),
 						   BTRFS_EXTENT_DATA_KEY);
 			if (ret)
 				goto out;
 			dropped_extents = true;
 		}
+		truncate_offset = btrfs_file_extent_end(path);
 		if (ins_nr == 0)
 			start_slot = slot;
 		ins_nr++;



