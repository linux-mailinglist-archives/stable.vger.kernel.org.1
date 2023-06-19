Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B1735291
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFSKg3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjFSKgE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF7E7A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F41CE60B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BADC433C0;
        Mon, 19 Jun 2023 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170947;
        bh=XxdEGGmyLV0LKu8P653UjJoZ6Rz8TrhH59m7uTfAvbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtvNeK5Zm07Lzc0vMZZ0DHKkORnSJiKQLxTXQKy0rtURqpjLjJmuEVTDDC/eEgSIG
         wtqaq6Ch/IhnTeLIvgs/vFvHVQwg4OkYtn7ft6fnuzca8S8DpIjTF1UBtfpVpO9pRd
         Ts4W7w9EeBDAPVJPCd10Dk2mhglSDc6VP6UrrMIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.3 067/187] btrfs: do not ASSERT() on duplicated global roots
Date:   Mon, 19 Jun 2023 12:28:05 +0200
Message-ID: <20230619102200.910402010@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 745806fb4554f334e6406fa82b328562aa48f08f upstream.

[BUG]
Syzbot reports a reproducible ASSERT() when using rescue=usebackuproot
mount option on a corrupted fs.

The full report can be found here:
https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0

  BTRFS error (device loop0: state C): failed to load root csum
  assertion failed: !tmp, in fs/btrfs/disk-io.c:1103
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3664!
  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
  CPU: 1 PID: 3608 Comm: syz-executor356 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
  RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3663
  RSP: 0018:ffffc90003aaf250 EFLAGS: 00010246
  RAX: 0000000000000032 RBX: 0000000000000000 RCX: f21c13f886638400
  RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
  RBP: ffff888021c640a0 R08: ffffffff816bd38d R09: ffffed10173667f1
  R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: dffffc0000000000
  R13: ffff8880229c21f7 R14: ffff888021c64060 R15: ffff8880226c0000
  FS:  0000555556a73300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000055a2637d7a00 CR3: 00000000709c4000 CR4: 00000000003506e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   btrfs_global_root_insert+0x1a7/0x1b0 fs/btrfs/disk-io.c:1103
   load_global_roots_objectid+0x482/0x8c0 fs/btrfs/disk-io.c:2467
   load_global_roots fs/btrfs/disk-io.c:2501 [inline]
   btrfs_read_roots fs/btrfs/disk-io.c:2528 [inline]
   init_tree_roots+0xccb/0x203c fs/btrfs/disk-io.c:2939
   open_ctree+0x1e53/0x33df fs/btrfs/disk-io.c:3574
   btrfs_fill_super+0x1c6/0x2d0 fs/btrfs/super.c:1456
   btrfs_mount_root+0x885/0x9a0 fs/btrfs/super.c:1824
   legacy_get_tree+0xea/0x180 fs/fs_context.c:610
   vfs_get_tree+0x88/0x270 fs/super.c:1530
   fc_mount fs/namespace.c:1043 [inline]
   vfs_kern_mount+0xc9/0x160 fs/namespace.c:1073
   btrfs_mount+0x3d3/0xbb0 fs/btrfs/super.c:1884

[CAUSE]
Since the introduction of global roots, we handle
csum/extent/free-space-tree roots as global roots, even if no
extent-tree-v2 feature is enabled.

So for regular csum/extent/fst roots, we load them into
fs_info::global_root_tree rb tree.

And we should not expect any conflicts in that rb tree, thus we have an
ASSERT() inside btrfs_global_root_insert().

But rescue=usebackuproot can break the assumption, as we will try to
load those trees again and again as long as we have bad roots and have
backup roots slot remaining.

So in that case we can have conflicting roots in the rb tree, and
triggering the ASSERT() crash.

[FIX]
We can safely remove that ASSERT(), as the caller will properly put the
offending root.

To make further debugging easier, also add two explicit error messages:

- Error message for conflicting global roots
- Error message when using backup roots slot

Reported-by: syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space trees in a rb tree")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -996,13 +996,18 @@ int btrfs_global_root_insert(struct btrf
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *tmp;
+	int ret = 0;
 
 	write_lock(&fs_info->global_root_lock);
 	tmp = rb_find_add(&root->rb_node, &fs_info->global_root_tree, global_root_cmp);
 	write_unlock(&fs_info->global_root_lock);
-	ASSERT(!tmp);
 
-	return tmp ? -EEXIST : 0;
+	if (tmp) {
+		ret = -EEXIST;
+		btrfs_warn(fs_info, "global root %llu %llu already exists",
+				root->root_key.objectid, root->root_key.offset);
+	}
+	return ret;
 }
 
 void btrfs_global_root_delete(struct btrfs_root *root)
@@ -2843,6 +2848,7 @@ static int __cold init_tree_roots(struct
 			/* We can't trust the free space cache either */
 			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
 
+			btrfs_warn(fs_info, "try to load backup roots slot %d", i);
 			ret = read_backup_root(fs_info, i);
 			backup_index = ret;
 			if (ret < 0)


