Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A023A75BE3F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGUGGo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGUGGT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0D2D76
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D3861083
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E4CC433C7;
        Fri, 21 Jul 2023 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919533;
        bh=2KEJWSTzpeDC7g4SkVC+e5Yvllyvo1w7KiBX4UvVmhE=;
        h=Subject:To:Cc:From:Date:From;
        b=aYMi5oJqJjT2GnzJ28WHcgLfKb4KcqGLI5MxxnFLKVJWuLFXO2P1D2Rz8p0q+hMyZ
         w8ieceD4PowPskVv1Gx4LrGc81m4hN6ZplRzhNY5t8Xicw4EI1s3/XzEwyHpgjXCD7
         e60PwgRKIQ5DPxQGtxNumm1+Rgh644Uwg29jL+PU=
Subject: FAILED: patch "[PATCH] ext4: turn quotas off if mount failed after enabling quotas" failed to apply to 4.14-stable tree
To:     libaokun1@huawei.com, jack@suse.cz, tytso@mit.edu,
        yi.zhang@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:05:24 +0200
Message-ID: <2023072124-roamer-heftiness-57f3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x d13f99632748462c32fc95d729f5e754bab06064
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072124-roamer-heftiness-57f3@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

d13f99632748 ("ext4: turn quotas off if mount failed after enabling quotas")
a5fc51193507 ("ext4: remove cantfind_ext4 error handler")
02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
25c6d98fc4c2 ("ext4: Move orphan inode handling into a separate file")
188c299e2a26 ("ext4: Support for checksumming from journal triggers")
bd2c38cf1726 ("ext4: Make sure quota files are not grabbed accidentally")
b9a037b7f3c4 ("ext4: cleanup in-core orphan list if ext4_truncate() failed to get a transaction handle")
72ffb49a7b62 ("ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()")
c915fb80eaa6 ("ext4: fix bh ref count on error paths")
a3f5cf14ff91 ("ext4: drop ext4_handle_dirty_super()")
05c2c00f3769 ("ext4: protect superblock modifications with a buffer lock")
4392fbc4bab5 ("ext4: drop sync argument of ext4_commit_super()")
c92dc856848f ("ext4: defer saving error info from atomic context")
02a7780e4d2f ("ext4: simplify ext4 error translation")
4067662388f9 ("ext4: move functions in super.c")
014c9caa29d3 ("ext4: make ext4_abort() use __ext4_error()")
b08070eca9e2 ("ext4: don't remount read-only with errors=continue on reboot")
837c23fbc1b8 ("ext4: use ASSERT() to replace J_ASSERT()")
ca9b404ff137 ("ext4: print quota journalling mode on (re-)mount")
f177ee0882af ("ext4: add helpers for checking whether quota can be enabled/is journalled")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d13f99632748462c32fc95d729f5e754bab06064 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Mon, 27 Mar 2023 22:16:29 +0800
Subject: [PATCH] ext4: turn quotas off if mount failed after enabling quotas

Yi found during a review of the patch "ext4: don't BUG on inconsistent
journal feature" that when ext4_mark_recovery_complete() returns an error
value, the error handling path does not turn off the enabled quotas,
which triggers the following kmemleak:

================================================================
unreferenced object 0xffff8cf68678e7c0 (size 64):
comm "mount", pid 746, jiffies 4294871231 (age 11.540s)
hex dump (first 32 bytes):
00 90 ef 82 f6 8c ff ff 00 00 00 00 41 01 00 00  ............A...
c7 00 00 00 bd 00 00 00 0a 00 00 00 48 00 00 00  ............H...
backtrace:
[<00000000c561ef24>] __kmem_cache_alloc_node+0x4d4/0x880
[<00000000d4e621d7>] kmalloc_trace+0x39/0x140
[<00000000837eee74>] v2_read_file_info+0x18a/0x3a0
[<0000000088f6c877>] dquot_load_quota_sb+0x2ed/0x770
[<00000000340a4782>] dquot_load_quota_inode+0xc6/0x1c0
[<0000000089a18bd5>] ext4_enable_quotas+0x17e/0x3a0 [ext4]
[<000000003a0268fa>] __ext4_fill_super+0x3448/0x3910 [ext4]
[<00000000b0f2a8a8>] ext4_fill_super+0x13d/0x340 [ext4]
[<000000004a9489c4>] get_tree_bdev+0x1dc/0x370
[<000000006e723bf1>] ext4_get_tree+0x1d/0x30 [ext4]
[<00000000c7cb663d>] vfs_get_tree+0x31/0x160
[<00000000320e1bed>] do_new_mount+0x1d5/0x480
[<00000000c074654c>] path_mount+0x22e/0xbe0
[<0000000003e97a8e>] do_mount+0x95/0xc0
[<000000002f3d3736>] __x64_sys_mount+0xc4/0x160
[<0000000027d2140c>] do_syscall_64+0x3f/0x90
================================================================

To solve this problem, we add a "failed_mount10" tag, and call
ext4_quota_off_umount() in this tag to release the enabled qoutas.

Fixes: 11215630aada ("ext4: don't BUG on inconsistent journal feature")
Cc: stable@kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230327141630.156875-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 433550e93561..1cc60a7ae4aa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5577,7 +5577,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount10;
 	}
 
 	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
@@ -5596,7 +5596,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	return 0;
 
-failed_mount9:
+failed_mount10:
+	ext4_quota_off_umount(sb);
+failed_mount9: __maybe_unused
 	ext4_release_orphan_info(sb);
 failed_mount8:
 	ext4_unregister_sysfs(sb);

