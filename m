Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00C761133
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGYKsl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjGYKsh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C301173F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B166165E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C42CC433C7;
        Tue, 25 Jul 2023 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282115;
        bh=OOiP1npETSU2Rr+PdIJ6tkix95uz8/D1cO7uRmBMiak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyORU3laIFJ9SNUDhBbu55U1Za589Qjq1DEbzb1xMf2wFxKOEaqK2g4IQ2lxRfj33
         gsn9yCz35dO/Yqv7sYES5IhOC1inxoNe34xEZdNAUg7YAKZBtJrrAhrbr34yYO+4vn
         8/H6Grs3VOqXcbRlCeLeq6/D9X0mGJoUsHpoahhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 014/227] btrfs: fix iput() on error pointer after error during orphan cleanup
Date:   Tue, 25 Jul 2023 12:43:01 +0200
Message-ID: <20230725104515.379469864@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit cbaee87f2ef628c10331b69a2f3def6bc32402d7 upstream.

At btrfs_orphan_cleanup(), if we can't find an inode (btrfs_iget() returns
an -ENOENT error pointer), we proceed with 'ret' set to -ENOENT and the
inode pointer set to ERR_PTR(-ENOENT). Later when we proceed to the body
of the following if statement:

    if (ret == -ENOENT || inode->i_nlink) {
        (...)
        trans = btrfs_start_transaction(root, 1);
        if (IS_ERR(trans)) {
            ret = PTR_ERR(trans);
            iput(inode);
            goto out;
        }
        (...)
        ret = btrfs_del_orphan_item(trans, root,
                                    found_key.objectid);
        btrfs_end_transaction(trans);
        if (ret) {
            iput(inode);
            goto out;
        }
        continue;
    }

If we get an error from btrfs_start_transaction() or from the call to
btrfs_del_orphan_item() we end calling iput() against an inode pointer
that has a value of ERR_PTR(-ENOENT), resulting in a crash with the
following trace:

  [876.667] BUG: kernel NULL pointer dereference, address: 0000000000000096
  [876.667] #PF: supervisor read access in kernel mode
  [876.667] #PF: error_code(0x0000) - not-present page
  [876.667] PGD 0 P4D 0
  [876.668] Oops: 0000 [#1] PREEMPT SMP PTI
  [876.668] CPU: 0 PID: 2356187 Comm: mount Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
  [876.668] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
  [876.668] RIP: 0010:iput+0xa/0x20
  [876.668] Code: ff ff ff 66 (...)
  [876.669] RSP: 0018:ffffafa9c0c9f9d0 EFLAGS: 00010282
  [876.669] RAX: ffffffffffffffe4 RBX: 000000000009453b RCX: 0000000000000000
  [876.669] RDX: 0000000000000001 RSI: ffffafa9c0c9f930 RDI: fffffffffffffffe
  [876.669] RBP: ffff95c612f3b800 R08: 0000000000000001 R09: ffffffffffffffe4
  [876.670] R10: 00018f2a71010000 R11: 000000000ead96e3 R12: ffff95cb7d6909a0
  [876.670] R13: fffffffffffffffe R14: ffff95c60f477000 R15: 00000000ffffffe4
  [876.670] FS:  00007f5fbe30a840(0000) GS:ffff95ccdfa00000(0000) knlGS:0000000000000000
  [876.670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [876.671] CR2: 0000000000000096 CR3: 000000055e9f6004 CR4: 0000000000370ef0
  [876.671] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [876.671] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [876.672] Call Trace:
  [876.744]  <TASK>
  [876.744]  ? __die_body+0x1b/0x60
  [876.744]  ? page_fault_oops+0x15d/0x450
  [876.745]  ? __kmem_cache_alloc_node+0x47/0x410
  [876.745]  ? do_user_addr_fault+0x65/0x8a0
  [876.745]  ? exc_page_fault+0x74/0x170
  [876.746]  ? asm_exc_page_fault+0x22/0x30
  [876.746]  ? iput+0xa/0x20
  [876.746]  btrfs_orphan_cleanup+0x221/0x330 [btrfs]
  [876.746]  btrfs_lookup_dentry+0x58f/0x5f0 [btrfs]
  [876.747]  btrfs_lookup+0xe/0x30 [btrfs]
  [876.747]  __lookup_slow+0x82/0x130
  [876.785]  walk_component+0xe5/0x160
  [876.786]  path_lookupat.isra.0+0x6e/0x150
  [876.786]  filename_lookup+0xcf/0x1a0
  [876.786]  ? mod_objcg_state+0xd2/0x360
  [876.786]  ? obj_cgroup_charge+0xf5/0x110
  [876.787]  ? should_failslab+0xa/0x20
  [876.787]  ? kmem_cache_alloc+0x47/0x450
  [876.787]  vfs_path_lookup+0x51/0x90
  [876.788]  mount_subtree+0x8d/0x130
  [876.788]  btrfs_mount+0x149/0x410 [btrfs]
  [876.788]  ? __kmem_cache_alloc_node+0x47/0x410
  [876.788]  ? vfs_parse_fs_param+0xc0/0x110
  [876.789]  legacy_get_tree+0x24/0x50
  [876.834]  vfs_get_tree+0x22/0xd0
  [876.852]  path_mount+0x2d8/0x9c0
  [876.852]  do_mount+0x79/0x90
  [876.852]  __x64_sys_mount+0x8e/0xd0
  [876.853]  do_syscall_64+0x38/0x90
  [876.899]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
  [876.958] RIP: 0033:0x7f5fbe50b76a
  [876.959] Code: 48 8b 0d a9 (...)
  [876.959] RSP: 002b:00007fff01925798 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
  [876.959] RAX: ffffffffffffffda RBX: 00007f5fbe694264 RCX: 00007f5fbe50b76a
  [876.960] RDX: 0000561bde6c8720 RSI: 0000561bde6bdec0 RDI: 0000561bde6c31a0
  [876.960] RBP: 0000561bde6bdc70 R08: 0000000000000000 R09: 0000000000000001
  [876.960] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  [876.960] R13: 0000561bde6c31a0 R14: 0000561bde6c8720 R15: 0000561bde6bdc70
  [876.960]  </TASK>

So fix this by setting 'inode' to NULL whenever we get an error from
btrfs_iget(), and to make the code simpler, stop testing for 'ret' being
-ENOENT to check if we have an inode - instead test for 'inode' being NULL
or not. Having a NULL 'inode' prevents any iput() call from crashing, as
iput() ignores NULL inode pointers. Also, stop testing for a NULL return
value from btrfs_iget() with PTR_ERR_OR_ZERO(), because btrfs_iget() never
returns NULL - in case an inode is not found, it returns ERR_PTR(-ENOENT),
and in case of memory allocation failure, it returns ERR_PTR(-ENOMEM).
We also don't need the extra iput() calls on the error branches for the
btrfs_start_transaction() and btrfs_del_orphan_item() calls, as we have
already called iput() before, so remove them.

Fixes: a13bb2c03848 ("btrfs: add missing iputs on orphan cleanup failure")
CC: stable@vger.kernel.org # 6.4
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3546,11 +3546,14 @@ int btrfs_orphan_cleanup(struct btrfs_ro
 		found_key.type = BTRFS_INODE_ITEM_KEY;
 		found_key.offset = 0;
 		inode = btrfs_iget(fs_info->sb, last_objectid, root);
-		ret = PTR_ERR_OR_ZERO(inode);
-		if (ret && ret != -ENOENT)
-			goto out;
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
+			inode = NULL;
+			if (ret != -ENOENT)
+				goto out;
+		}
 
-		if (ret == -ENOENT && root == fs_info->tree_root) {
+		if (!inode && root == fs_info->tree_root) {
 			struct btrfs_root *dead_root;
 			int is_dead_root = 0;
 
@@ -3611,8 +3614,8 @@ int btrfs_orphan_cleanup(struct btrfs_ro
 		 * deleted but wasn't. The inode number may have been reused,
 		 * but either way, we can delete the orphan item.
 		 */
-		if (ret == -ENOENT || inode->i_nlink) {
-			if (!ret) {
+		if (!inode || inode->i_nlink) {
+			if (inode) {
 				ret = btrfs_drop_verity_items(BTRFS_I(inode));
 				iput(inode);
 				if (ret)
@@ -3621,7 +3624,6 @@ int btrfs_orphan_cleanup(struct btrfs_ro
 			trans = btrfs_start_transaction(root, 1);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
-				iput(inode);
 				goto out;
 			}
 			btrfs_debug(fs_info, "auto deleting %Lu",
@@ -3629,10 +3631,8 @@ int btrfs_orphan_cleanup(struct btrfs_ro
 			ret = btrfs_del_orphan_item(trans, root,
 						    found_key.objectid);
 			btrfs_end_transaction(trans);
-			if (ret) {
-				iput(inode);
+			if (ret)
 				goto out;
-			}
 			continue;
 		}
 


