Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61A37A77F7
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjITJxP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjITJxN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:53:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB0D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:53:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503ADC433C7;
        Wed, 20 Sep 2023 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203586;
        bh=veSxwJnHhMN4783IiuzozfwJ/ACr8/dSgMBEKI4oNHc=;
        h=Subject:To:Cc:From:Date:From;
        b=frmzj0irqbArjsrk4tjGTcglNrSX5gOvgHtQZ6GJmGbLMpIXZ3qU1wd501fddyRb8
         KfPewDVB/Ma+0+65iB4qeXStIVIfd0ZbZj9IDRc7RF7QnkufMtqhSz0VfeusrerqxX
         DoBN6BgKIcYaIaA8u+ixFakH3R4gCUjM5u1dTcCk=
Subject: FAILED: patch "[PATCH] btrfs: release path before inode lookup during the ino lookup" failed to apply to 4.19-stable tree
To:     fdmanana@suse.com, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:52:56 +0200
Message-ID: <2023092056-manifesto-shame-79c2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ee34a82e890a7babb5585daf1a6dd7d4d1cf142a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092056-manifesto-shame-79c2@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

ee34a82e890a ("btrfs: release path before inode lookup during the ino lookup ioctl")
0202e83fdab0 ("btrfs: simplify iget helpers")
c75e839414d3 ("btrfs: kill the subvol_srcu")
5c8fd99fec9d ("btrfs: make inodes hold a ref on their roots")
7ac8b88ee668 ("btrfs: backref, only collect file extent items matching backref offset")
0024652895e3 ("btrfs: rename btrfs_put_fs_root and btrfs_grab_fs_root")
bd647ce385ec ("btrfs: add a leak check for roots")
8260edba67a2 ("btrfs: make the init of static elements in fs_info separate")
ae18c37ad5a1 ("btrfs: move fs_info init work into it's own helper function")
141386e1a5d6 ("btrfs: free more things in btrfs_free_fs_info")
bc44d7c4b2b1 ("btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root")
81f096edf047 ("btrfs: use btrfs_put_fs_root to free roots always")
0d4b0463011d ("btrfs: export and rename free_fs_info")
fbb0ce40d606 ("btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry")
ca2037fba6af ("btrfs: hold a ref on the root in btrfs_recover_log_trees")
5119cfc36f6d ("btrfs: hold a ref on the root in create_pending_snapshot")
5168489a079a ("btrfs: hold a ref on the root in get_subvol_name_from_objectid")
6f9a3da5da9e ("btrfs: hold a ref on the root in btrfs_ioctl_send")
fd79d43b347e ("btrfs: hold a ref on the root in scrub_print_warning_inode")
0b2dee5cff74 ("btrfs: hold a ref for the root in btrfs_find_orphan_roots")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee34a82e890a7babb5585daf1a6dd7d4d1cf142a Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Sat, 26 Aug 2023 11:28:20 +0100
Subject: [PATCH] btrfs: release path before inode lookup during the ino lookup
 ioctl

During the ino lookup ioctl we can end up calling btrfs_iget() to get an
inode reference while we are holding on a root's btree. If btrfs_iget()
needs to lookup the inode from the root's btree, because it's not
currently loaded in memory, then it will need to lock another or the
same path in the same root btree. This may result in a deadlock and
trigger the following lockdep splat:

  WARNING: possible circular locking dependency detected
  6.5.0-rc7-syzkaller-00004-gf7757129e3de #0 Not tainted
  ------------------------------------------------------
  syz-executor277/5012 is trying to acquire lock:
  ffff88802df41710 (btrfs-tree-01){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

  but task is already holding lock:
  ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #1 (btrfs-tree-00){++++}-{3:3}:
         down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
         __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
         btrfs_search_slot+0x13a4/0x2f80 fs/btrfs/ctree.c:2302
         btrfs_init_root_free_objectid+0x148/0x320 fs/btrfs/disk-io.c:4955
         btrfs_init_fs_root fs/btrfs/disk-io.c:1128 [inline]
         btrfs_get_root_ref+0x5ae/0xae0 fs/btrfs/disk-io.c:1338
         btrfs_get_fs_root fs/btrfs/disk-io.c:1390 [inline]
         open_ctree+0x29c8/0x3030 fs/btrfs/disk-io.c:3494
         btrfs_fill_super+0x1c7/0x2f0 fs/btrfs/super.c:1154
         btrfs_mount_root+0x7e0/0x910 fs/btrfs/super.c:1519
         legacy_get_tree+0xef/0x190 fs/fs_context.c:611
         vfs_get_tree+0x8c/0x270 fs/super.c:1519
         fc_mount fs/namespace.c:1112 [inline]
         vfs_kern_mount+0xbc/0x150 fs/namespace.c:1142
         btrfs_mount+0x39f/0xb50 fs/btrfs/super.c:1579
         legacy_get_tree+0xef/0x190 fs/fs_context.c:611
         vfs_get_tree+0x8c/0x270 fs/super.c:1519
         do_new_mount+0x28f/0xae0 fs/namespace.c:3335
         do_mount fs/namespace.c:3675 [inline]
         __do_sys_mount fs/namespace.c:3884 [inline]
         __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
         do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

  -> #0 (btrfs-tree-01){++++}-{3:3}:
         check_prev_add kernel/locking/lockdep.c:3142 [inline]
         check_prevs_add kernel/locking/lockdep.c:3261 [inline]
         validate_chain kernel/locking/lockdep.c:3876 [inline]
         __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
         lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
         down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
         __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
         btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
         btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
         btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
         btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
         btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
         btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
         btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
         btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
         btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
         btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
         vfs_ioctl fs/ioctl.c:51 [inline]
         __do_sys_ioctl fs/ioctl.c:870 [inline]
         __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
         do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

  other info that might help us debug this:

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(btrfs-tree-00);
                                 lock(btrfs-tree-01);
                                 lock(btrfs-tree-00);
    rlock(btrfs-tree-01);

   *** DEADLOCK ***

  1 lock held by syz-executor277/5012:
   #0: ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

  stack backtrace:
  CPU: 1 PID: 5012 Comm: syz-executor277 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
   check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
   check_prev_add kernel/locking/lockdep.c:3142 [inline]
   check_prevs_add kernel/locking/lockdep.c:3261 [inline]
   validate_chain kernel/locking/lockdep.c:3876 [inline]
   __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
   lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
   down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
   __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
   btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
   btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
   btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
   btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
   btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
   btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
   btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
   btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
   btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
   btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7f0bec94ea39

Fix this simply by releasing the path before calling btrfs_iget() as at
point we don't need the path anymore.

Reported-by: syzbot+bf66ad948981797d2f1d@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000045fa140603c4a969@google.com/
Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a895d105464b..d27b0d86b8e2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1958,6 +1958,13 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				goto out_put;
 			}
 
+			/*
+			 * We don't need the path anymore, so release it and
+			 * avoid deadlocks and lockdep warnings in case
+			 * btrfs_iget() needs to lookup the inode from its root
+			 * btree and lock the same leaf.
+			 */
+			btrfs_release_path(path);
 			temp_inode = btrfs_iget(sb, key2.objectid, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
@@ -1978,7 +1985,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				goto out_put;
 			}
 
-			btrfs_release_path(path);
 			key.objectid = key.offset;
 			key.offset = (u64)-1;
 			dirid = key.objectid;

