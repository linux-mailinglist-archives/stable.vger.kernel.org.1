Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E67755445
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjGPU2f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjGPU2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76319F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA9360E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F25FC433C8;
        Sun, 16 Jul 2023 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539310;
        bh=MTBNCivBXKRnOkYwE1iFodkR1Bwf93Hyv1s+j6wRzSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrV0ZhX03LOaPN4t58ucBETKZy9fTL4F4jBTEbHzZUxVZWzpaNPpbHzfBkv3qhzMJ
         rh0I3lWI0pKgmrZg56mev4GlEFHi0RHSzYkGPtnnXO4IdcJmpWuDYlnYywRs+5XFNM
         AlKaV9oLew94mw98EzYqdpKwOAX+5IBYOfoKT9fE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 755/800] btrfs: insert tree mod log move in push_node_left
Date:   Sun, 16 Jul 2023 21:50:08 +0200
Message-ID: <20230716195006.674227578@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Boris Burkov <boris@bur.io>

commit 5cead5422a0e3d13b0bcee986c0f5c4ebb94100b upstream.

There is a fairly unlikely race condition in tree mod log rewind that
can result in a kernel panic which has the following trace:

  [530.569] BTRFS critical (device sda3): unable to find logical 0 length 4096
  [530.585] BTRFS critical (device sda3): unable to find logical 0 length 4096
  [530.602] BUG: kernel NULL pointer dereference, address: 0000000000000002
  [530.618] #PF: supervisor read access in kernel mode
  [530.629] #PF: error_code(0x0000) - not-present page
  [530.641] PGD 0 P4D 0
  [530.647] Oops: 0000 [#1] SMP
  [530.654] CPU: 30 PID: 398973 Comm: below Kdump: loaded Tainted: G S         O  K   5.12.0-0_fbk13_clang_7455_gb24de3bdb045 #1
  [530.680] Hardware name: Quanta Mono Lake-M.2 SATA 1HY9U9Z001G/Mono Lake-M.2 SATA, BIOS F20_3A15 08/16/2017
  [530.703] RIP: 0010:__btrfs_map_block+0xaa/0xd00
  [530.755] RSP: 0018:ffffc9002c2f7600 EFLAGS: 00010246
  [530.767] RAX: ffffffffffffffea RBX: ffff888292e41000 RCX: f2702d8b8be15100
  [530.784] RDX: ffff88885fda6fb8 RSI: ffff88885fd973c8 RDI: ffff88885fd973c8
  [530.800] RBP: ffff888292e410d0 R08: ffffffff82fd7fd0 R09: 00000000fffeffff
  [530.816] R10: ffffffff82e57fd0 R11: ffffffff82e57d70 R12: 0000000000000000
  [530.832] R13: 0000000000001000 R14: 0000000000001000 R15: ffffc9002c2f76f0
  [530.848] FS:  00007f38d64af000(0000) GS:ffff88885fd80000(0000) knlGS:0000000000000000
  [530.866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [530.880] CR2: 0000000000000002 CR3: 00000002b6770004 CR4: 00000000003706e0
  [530.896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [530.912] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [530.928] Call Trace:
  [530.934]  ? btrfs_printk+0x13b/0x18c
  [530.943]  ? btrfs_bio_counter_inc_blocked+0x3d/0x130
  [530.955]  btrfs_map_bio+0x75/0x330
  [530.963]  ? kmem_cache_alloc+0x12a/0x2d0
  [530.973]  ? btrfs_submit_metadata_bio+0x63/0x100
  [530.984]  btrfs_submit_metadata_bio+0xa4/0x100
  [530.995]  submit_extent_page+0x30f/0x360
  [531.004]  read_extent_buffer_pages+0x49e/0x6d0
  [531.015]  ? submit_extent_page+0x360/0x360
  [531.025]  btree_read_extent_buffer_pages+0x5f/0x150
  [531.037]  read_tree_block+0x37/0x60
  [531.046]  read_block_for_search+0x18b/0x410
  [531.056]  btrfs_search_old_slot+0x198/0x2f0
  [531.066]  resolve_indirect_ref+0xfe/0x6f0
  [531.076]  ? ulist_alloc+0x31/0x60
  [531.084]  ? kmem_cache_alloc_trace+0x12e/0x2b0
  [531.095]  find_parent_nodes+0x720/0x1830
  [531.105]  ? ulist_alloc+0x10/0x60
  [531.113]  iterate_extent_inodes+0xea/0x370
  [531.123]  ? btrfs_previous_extent_item+0x8f/0x110
  [531.134]  ? btrfs_search_path_in_tree+0x240/0x240
  [531.146]  iterate_inodes_from_logical+0x98/0xd0
  [531.157]  ? btrfs_search_path_in_tree+0x240/0x240
  [531.168]  btrfs_ioctl_logical_to_ino+0xd9/0x180
  [531.179]  btrfs_ioctl+0xe2/0x2eb0

This occurs when logical inode resolution takes a tree mod log sequence
number, and then while backref walking hits a rewind on a busy node
which has the following sequence of tree mod log operations (numbers
filled in from a specific example, but they are somewhat arbitrary)

  REMOVE_WHILE_FREEING slot 532
  REMOVE_WHILE_FREEING slot 531
  REMOVE_WHILE_FREEING slot 530
  ...
  REMOVE_WHILE_FREEING slot 0
  REMOVE slot 455
  REMOVE slot 454
  REMOVE slot 453
  ...
  REMOVE slot 0
  ADD slot 455
  ADD slot 454
  ADD slot 453
  ...
  ADD slot 0
  MOVE src slot 0 -> dst slot 456 nritems 533
  REMOVE slot 455
  REMOVE slot 454
  REMOVE slot 453
  ...
  REMOVE slot 0

When this sequence gets applied via btrfs_tree_mod_log_rewind, it
allocates a fresh rewind eb, and first inserts the correct key info for
the 533 elements, then overwrites the first 456 of them, then decrements
the count by 456 via the add ops, then rewinds the move by doing a
memmove from 456:988->0:532. We have never written anything past 532, so
that memmove writes garbage into the 0:532 range. In practice, this
results in a lot of fully 0 keys. The rewind then puts valid keys into
slots 0:455 with the last removes, but 456:532 are still invalid.

When search_old_slot uses this eb, if it uses one of those invalid
slots, it can then read the extent buffer and issue a bio for offset 0
which ultimately panics looking up extent mappings.

This bad tree mod log sequence gets generated when the node balancing
code happens to do a balance_node_right followed by a push_node_left
while logging in the tree mod log. Illustrated for ebs L and R (left and
right):

	L                 R
  start:
  [XXX|YYY|...]      [ZZZ|...|...]
  balance_node_right:
  [XXX|YYY|...]      [...|ZZZ|...] move Z to make room for Y
  [XXX|...|...]      [YYY|ZZZ|...] copy Y from L to R
  push_node_left:
  [XXX|YYY|...]      [...|ZZZ|...] copy Y from R to L
  [XXX|YYY|...]      [ZZZ|...|...] move Z into emptied space (NOT LOGGED!)

This is because balance_node_right logs a move, but push_node_left
explicitly doesn't. That is because logging the move would remove the
overwritten src < dst range in the right eb, which was already logged
when we called btrfs_tree_mod_log_eb_copy. The correct sequence would
include a move from 456:988 to 0:532 after remove 0:455 and before
removing 0:532. Reversing that sequence would entail creating keys for
0:532, then moving those keys out to 456:988, then creating more keys
for 0:455.

i.e.,

  REMOVE_WHILE_FREEING slot 532
  REMOVE_WHILE_FREEING slot 531
  REMOVE_WHILE_FREEING slot 530
  ...
  REMOVE_WHILE_FREEING slot 0
  MOVE src slot 456 -> dst slot 0 nritems 533
  REMOVE slot 455
  REMOVE slot 454
  REMOVE slot 453
  ...
  REMOVE slot 0
  ADD slot 455
  ADD slot 454
  ADD slot 453
  ...
  ADD slot 0
  MOVE src slot 0 -> dst slot 456 nritems 533
  REMOVE slot 455
  REMOVE slot 454
  REMOVE slot 453
  ...
  REMOVE slot 0

Fix this to log the move but avoid the double remove by putting all the
logging logic in btrfs_tree_mod_log_eb_copy which has enough information
to detect these cases and properly log moves, removes, and adds. Leave
btrfs_tree_mod_log_insert_move to handle insert_ptr and delete_ptr's
tree mod logging.

(Un)fortunately, this is quite difficult to reproduce, and I was only
able to reproduce it by adding sleeps in btrfs_search_old_slot that
would encourage more log rewinding during ino_to_logical ioctls. I was
able to hit the warning in the previous patch in the series without the
fix quite quickly, but not after this patch.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c        |   11 ++++---
 fs/btrfs/tree-mod-log.c |   73 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 71 insertions(+), 13 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2714,8 +2714,8 @@ static int push_node_left(struct btrfs_t
 
 	if (push_items < src_nritems) {
 		/*
-		 * Don't call btrfs_tree_mod_log_insert_move() here, key removal
-		 * was already fully logged by btrfs_tree_mod_log_eb_copy() above.
+		 * btrfs_tree_mod_log_eb_copy handles logging the move, so we
+		 * don't need to do an explicit tree mod log operation for it.
 		 */
 		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(src, 0),
 				      btrfs_node_key_ptr_offset(src, push_items),
@@ -2776,8 +2776,11 @@ static int balance_node_right(struct btr
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-	ret = btrfs_tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
-	BUG_ON(ret < 0);
+
+	/*
+	 * btrfs_tree_mod_log_eb_copy handles logging the move, so we don't
+	 * need to do an explicit tree mod log operation for it.
+	 */
 	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
 				      btrfs_node_key_ptr_offset(dst, 0),
 				      (dst_nritems) *
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -248,6 +248,26 @@ int btrfs_tree_mod_log_insert_key(struct
 	return ret;
 }
 
+static struct tree_mod_elem *tree_mod_log_alloc_move(struct extent_buffer *eb,
+						     int dst_slot, int src_slot,
+						     int nr_items)
+{
+	struct tree_mod_elem *tm;
+
+	tm = kzalloc(sizeof(*tm), GFP_NOFS);
+	if (!tm)
+		return ERR_PTR(-ENOMEM);
+
+	tm->logical = eb->start;
+	tm->slot = src_slot;
+	tm->move.dst_slot = dst_slot;
+	tm->move.nr_items = nr_items;
+	tm->op = BTRFS_MOD_LOG_MOVE_KEYS;
+	RB_CLEAR_NODE(&tm->node);
+
+	return tm;
+}
+
 int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items)
@@ -265,18 +285,13 @@ int btrfs_tree_mod_log_insert_move(struc
 	if (!tm_list)
 		return -ENOMEM;
 
-	tm = kzalloc(sizeof(*tm), GFP_NOFS);
-	if (!tm) {
-		ret = -ENOMEM;
+	tm = tree_mod_log_alloc_move(eb, dst_slot, src_slot, nr_items);
+	if (IS_ERR(tm)) {
+		ret = PTR_ERR(tm);
+		tm = NULL;
 		goto free_tms;
 	}
 
-	tm->logical = eb->start;
-	tm->slot = src_slot;
-	tm->move.dst_slot = dst_slot;
-	tm->move.nr_items = nr_items;
-	tm->op = BTRFS_MOD_LOG_MOVE_KEYS;
-
 	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
 		tm_list[i] = alloc_tree_mod_elem(eb, i + dst_slot,
 				BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING);
@@ -489,6 +504,10 @@ int btrfs_tree_mod_log_eb_copy(struct ex
 	struct tree_mod_elem **tm_list_add, **tm_list_rem;
 	int i;
 	bool locked = false;
+	struct tree_mod_elem *dst_move_tm = NULL;
+	struct tree_mod_elem *src_move_tm = NULL;
+	u32 dst_move_nr_items = btrfs_header_nritems(dst) - dst_offset;
+	u32 src_move_nr_items = btrfs_header_nritems(src) - (src_offset + nr_items);
 
 	if (!tree_mod_need_log(fs_info, NULL))
 		return 0;
@@ -501,6 +520,26 @@ int btrfs_tree_mod_log_eb_copy(struct ex
 	if (!tm_list)
 		return -ENOMEM;
 
+	if (dst_move_nr_items) {
+		dst_move_tm = tree_mod_log_alloc_move(dst, dst_offset + nr_items,
+						      dst_offset, dst_move_nr_items);
+		if (IS_ERR(dst_move_tm)) {
+			ret = PTR_ERR(dst_move_tm);
+			dst_move_tm = NULL;
+			goto free_tms;
+		}
+	}
+	if (src_move_nr_items) {
+		src_move_tm = tree_mod_log_alloc_move(src, src_offset,
+						      src_offset + nr_items,
+						      src_move_nr_items);
+		if (IS_ERR(src_move_tm)) {
+			ret = PTR_ERR(src_move_tm);
+			src_move_tm = NULL;
+			goto free_tms;
+		}
+	}
+
 	tm_list_add = tm_list;
 	tm_list_rem = tm_list + nr_items;
 	for (i = 0; i < nr_items; i++) {
@@ -523,6 +562,11 @@ int btrfs_tree_mod_log_eb_copy(struct ex
 		goto free_tms;
 	locked = true;
 
+	if (dst_move_tm) {
+		ret = tree_mod_log_insert(fs_info, dst_move_tm);
+		if (ret)
+			goto free_tms;
+	}
 	for (i = 0; i < nr_items; i++) {
 		ret = tree_mod_log_insert(fs_info, tm_list_rem[i]);
 		if (ret)
@@ -531,6 +575,11 @@ int btrfs_tree_mod_log_eb_copy(struct ex
 		if (ret)
 			goto free_tms;
 	}
+	if (src_move_tm) {
+		ret = tree_mod_log_insert(fs_info, src_move_tm);
+		if (ret)
+			goto free_tms;
+	}
 
 	write_unlock(&fs_info->tree_mod_log_lock);
 	kfree(tm_list);
@@ -538,6 +587,12 @@ int btrfs_tree_mod_log_eb_copy(struct ex
 	return 0;
 
 free_tms:
+	if (dst_move_tm && !RB_EMPTY_NODE(&dst_move_tm->node))
+		rb_erase(&dst_move_tm->node, &fs_info->tree_mod_log);
+	kfree(dst_move_tm);
+	if (src_move_tm && !RB_EMPTY_NODE(&src_move_tm->node))
+		rb_erase(&src_move_tm->node, &fs_info->tree_mod_log);
+	kfree(src_move_tm);
 	for (i = 0; i < nr_items * 2; i++) {
 		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
 			rb_erase(&tm_list[i]->node, &fs_info->tree_mod_log);


