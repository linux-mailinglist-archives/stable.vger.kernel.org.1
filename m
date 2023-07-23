Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33B75E231
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGWN6l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGWN6l (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 09:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67310FA
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 06:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D027E60CA3
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0454C433C8;
        Sun, 23 Jul 2023 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120717;
        bh=ZJuKgSZ/4CsMBKWerrMvxtiG4Acy2PuyzlbITDUoJpo=;
        h=Subject:To:Cc:From:Date:From;
        b=SFs5jtBWB6cfTDC5rnTDhqzcmuJACp6Zf+3Mau7ra3n+CMafSLPW4b6xfDUF36lkM
         QsWDAgGHrutS6d3i5P3QGJiWo7RoIgAwpns+LmQdoveUg8M4u87TX6K1Fxjyp0cxBK
         R5mbNnyZTLsM6innZIaPEimFiHGoBJaPxYibK4vQ=
Subject: FAILED: patch "[PATCH] btrfs: fix use-after-free of new block group that became" failed to apply to 6.1-stable tree
To:     fdmanana@suse.com, dsterba@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 15:58:17 +0200
Message-ID: <2023072317-grandkid-uncommon-ca27@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0657b20c5a76c938612f8409735a8830d257866e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072317-grandkid-uncommon-ca27@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
a9f189716cf1 ("btrfs: move out now unused BG from the reclaim list")
961f5b8bf48a ("btrfs: convert btrfs_block_group::seq_zone to runtime flag")
0d7764ff58b4 ("btrfs: convert btrfs_block_group::needs_free_space to runtime flag")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0657b20c5a76c938612f8409735a8830d257866e Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 28 Jun 2023 17:13:37 +0100
Subject: [PATCH] btrfs: fix use-after-free of new block group that became
 unused

If a task creates a new block group and that block group becomes unused
before we finish its creation, at btrfs_create_pending_block_groups(),
then when btrfs_mark_bg_unused() is called against the block group, we
assume that the block group is currently in the list of block groups to
reclaim, and we move it out of the list of new block groups and into the
list of unused block groups. This has two consequences:

1) We move it out of the list of new block groups associated to the
   current transaction. So the block group creation is not finished and
   if we attempt to delete the bg because it's unused, we will not find
   the block group item in the extent tree (or the new block group tree),
   its device extent items in the device tree etc, resulting in the
   deletion to fail due to the missing items;

2) We don't increment the reference count on the block group when we
   move it to the list of unused block groups, because we assumed the
   block group was on the list of block groups to reclaim, and in that
   case it already has the correct reference count. However the block
   group was on the list of new block groups, in which case no extra
   reference was taken because it's local to the current task. This
   later results in doing an extra reference count decrement when
   removing the block group from the unused list, eventually leading the
   reference count to 0.

This second case was caught when running generic/297 from fstests, which
produced the following assertion failure and stack trace:

  [589.559] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4299
  [589.559] ------------[ cut here ]------------
  [589.559] kernel BUG at fs/btrfs/block-group.c:4299!
  [589.560] invalid opcode: 0000 [#1] PREEMPT SMP PTI
  [589.560] CPU: 8 PID: 2819134 Comm: umount Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
  [589.560] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
  [589.560] RIP: 0010:btrfs_free_block_groups+0x449/0x4a0 [btrfs]
  [589.561] Code: 68 62 da c0 (...)
  [589.561] RSP: 0018:ffffa55a8c3b3d98 EFLAGS: 00010246
  [589.561] RAX: 0000000000000058 RBX: ffff8f030d7f2000 RCX: 0000000000000000
  [589.562] RDX: 0000000000000000 RSI: ffffffff953f0878 RDI: 00000000ffffffff
  [589.562] RBP: ffff8f030d7f2088 R08: 0000000000000000 R09: ffffa55a8c3b3c50
  [589.562] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8f05850b4c00
  [589.562] R13: ffff8f030d7f2090 R14: ffff8f05850b4cd8 R15: dead000000000100
  [589.563] FS:  00007f497fd2e840(0000) GS:ffff8f09dfc00000(0000) knlGS:0000000000000000
  [589.563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [589.563] CR2: 00007f497ff8ec10 CR3: 0000000271472006 CR4: 0000000000370ee0
  [589.563] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [589.564] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [589.564] Call Trace:
  [589.564]  <TASK>
  [589.565]  ? __die_body+0x1b/0x60
  [589.565]  ? die+0x39/0x60
  [589.565]  ? do_trap+0xeb/0x110
  [589.565]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
  [589.566]  ? do_error_trap+0x6a/0x90
  [589.566]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
  [589.566]  ? exc_invalid_op+0x4e/0x70
  [589.566]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
  [589.567]  ? asm_exc_invalid_op+0x16/0x20
  [589.567]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
  [589.567]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
  [589.567]  close_ctree+0x35d/0x560 [btrfs]
  [589.568]  ? fsnotify_sb_delete+0x13e/0x1d0
  [589.568]  ? dispose_list+0x3a/0x50
  [589.568]  ? evict_inodes+0x151/0x1a0
  [589.568]  generic_shutdown_super+0x73/0x1a0
  [589.569]  kill_anon_super+0x14/0x30
  [589.569]  btrfs_kill_super+0x12/0x20 [btrfs]
  [589.569]  deactivate_locked_super+0x2e/0x70
  [589.569]  cleanup_mnt+0x104/0x160
  [589.570]  task_work_run+0x56/0x90
  [589.570]  exit_to_user_mode_prepare+0x160/0x170
  [589.570]  syscall_exit_to_user_mode+0x22/0x50
  [589.570]  ? __x64_sys_umount+0x12/0x20
  [589.571]  do_syscall_64+0x48/0x90
  [589.571]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
  [589.571] RIP: 0033:0x7f497ff0a567
  [589.571] Code: af 98 0e (...)
  [589.572] RSP: 002b:00007ffc98347358 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
  [589.572] RAX: 0000000000000000 RBX: 00007f49800b8264 RCX: 00007f497ff0a567
  [589.572] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000557f558abfa0
  [589.573] RBP: 0000557f558a6ba0 R08: 0000000000000000 R09: 00007ffc98346100
  [589.573] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  [589.573] R13: 0000557f558abfa0 R14: 0000557f558a6cb0 R15: 0000557f558a6dd0
  [589.573]  </TASK>
  [589.574] Modules linked in: dm_snapshot dm_thin_pool (...)
  [589.576] ---[ end trace 0000000000000000 ]---

Fix this by adding a runtime flag to the block group to tell that the
block group is still in the list of new block groups, and therefore it
should not be moved to the list of unused block groups, at
btrfs_mark_bg_unused(), until the flag is cleared, when we finish the
creation of the block group at btrfs_create_pending_block_groups().

Fixes: a9f189716cf1 ("btrfs: move out now unused BG from the reclaim list")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6753524b146c..f53297726238 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1640,13 +1640,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
-	trace_btrfs_add_unused_block_group(bg);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (list_empty(&bg->bg_list)) {
 		btrfs_get_block_group(bg);
+		trace_btrfs_add_unused_block_group(bg);
 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
-	} else {
+	} else if (!test_bit(BLOCK_GROUP_FLAG_NEW, &bg->runtime_flags)) {
 		/* Pull out the block group from the reclaim_bgs list. */
+		trace_btrfs_add_unused_block_group(bg);
 		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
@@ -2668,6 +2669,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 next:
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
 		list_del_init(&block_group->bg_list);
+		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
 	}
 	btrfs_trans_release_chunk_metadata(trans);
 }
@@ -2707,6 +2709,13 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * Mark it as new before adding it to the rbtree of block groups or any
+	 * list, so that no other task finds it and calls btrfs_mark_bg_unused()
+	 * before the new flag is set.
+	 */
+	set_bit(BLOCK_GROUP_FLAG_NEW, &cache->runtime_flags);
+
 	cache->length = size;
 	set_free_space_tree_thresholds(cache);
 	cache->flags = type;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f204addc3fe8..381c54a56417 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -70,6 +70,11 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
 	/* Indicate that the block group is placed on a sequential zone */
 	BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE,
+	/*
+	 * Indicate that block group is in the list of new block groups of a
+	 * transaction.
+	 */
+	BLOCK_GROUP_FLAG_NEW,
 };
 
 enum btrfs_caching_type {

