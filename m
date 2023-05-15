Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3977022AB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjEOEHc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOEHb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4BE74
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C08C614D0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF94C433EF;
        Mon, 15 May 2023 04:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684123648;
        bh=kVQAwZtL1+yICJKIUuJPCapJFBFULsLLaj7ZbHUPxs8=;
        h=Subject:To:Cc:From:Date:From;
        b=zFOPVKY2gynxiScS2g4nYrZM6X8uvDvWe531cp2ok9/bj6QhLVkMVvNEf5Z0aA2Kn
         1oLQoI+wo8zvyUZ+WqzXCq0xapYeqdxvTdW1dbX2VvChJqFCI4+u3xEKGmnf+0qX0v
         AHcDa//Zgqz32d0mgia2O+atpMx8LYu2TT32tBlM=
Subject: FAILED: patch "[PATCH] ext4: fix WARNING in mb_find_extent" failed to apply to 4.14-stable tree
To:     yebin10@huawei.com, jack@suse.cz, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 15 May 2023 06:07:25 +0200
Message-ID: <2023051525-uninstall-catacomb-00cd@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x fa08a7b61dff8a4df11ff1e84abfc214b487caf7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051525-uninstall-catacomb-00cd@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

fa08a7b61dff ("ext4: fix WARNING in mb_find_extent")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa08a7b61dff8a4df11ff1e84abfc214b487caf7 Mon Sep 17 00:00:00 2001
From: Ye Bin <yebin10@huawei.com>
Date: Mon, 16 Jan 2023 10:00:15 +0800
Subject: [PATCH] ext4: fix WARNING in mb_find_extent

Syzbot found the following issue:

EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5067 at fs/ext4/mballoc.c:1869 mb_find_extent+0x8a1/0xe30
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor307 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:mb_find_extent+0x8a1/0xe30 fs/ext4/mballoc.c:1869
RSP: 0018:ffffc90003c9e098 EFLAGS: 00010293
RAX: ffffffff82405731 RBX: 0000000000000041 RCX: ffff8880783457c0
RDX: 0000000000000000 RSI: 0000000000000041 RDI: 0000000000000040
RBP: 0000000000000040 R08: ffffffff82405723 R09: ffffed10053c9402
R10: ffffed10053c9402 R11: 1ffff110053c9401 R12: 0000000000000000
R13: ffffc90003c9e538 R14: dffffc0000000000 R15: ffffc90003c9e2cc
FS:  0000555556665300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056312f6796f8 CR3: 0000000022437000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_complex_scan_group+0x353/0x1100 fs/ext4/mballoc.c:2307
 ext4_mb_regular_allocator+0x1533/0x3860 fs/ext4/mballoc.c:2735
 ext4_mb_new_blocks+0xddf/0x3db0 fs/ext4/mballoc.c:5605
 ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4286
 ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:651
 ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:864
 ext4_bread+0x2a/0x170 fs/ext4/inode.c:920
 ext4_quota_write+0x225/0x570 fs/ext4/super.c:7105
 write_blk fs/quota/quota_tree.c:64 [inline]
 get_free_dqblk+0x34a/0x6d0 fs/quota/quota_tree.c:130
 do_insert_tree+0x26b/0x1aa0 fs/quota/quota_tree.c:340
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 dq_insert_tree fs/quota/quota_tree.c:401 [inline]
 qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:420
 v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
 dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
 ext4_acquire_dquot+0x2dc/0x400 fs/ext4/super.c:6740
 dqget+0x999/0xdc0 fs/quota/dquot.c:914
 __dquot_initialize+0x3d0/0xcf0 fs/quota/dquot.c:1492
 ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
 ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5516 [inline]
 ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Add some debug information:
mb_find_extent: mb_find_extent block=41, order=0 needed=64 next=0 ex=0/41/1@3735929054 64 64 7
block_bitmap: ff 3f 0c 00 fc 01 00 00 d2 3d 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Acctually, blocks per group is 64, but block bitmap indicate at least has
128 blocks. Now, ext4_validate_block_bitmap() didn't check invalid block's
bitmap if set.
To resolve above issue, add check like fsck "Padding at end of block bitmap is
not set".

Cc: stable@kernel.org
Reported-by: syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230116020015.1506120-1-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 094269488183..c49e612e3975 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -305,6 +305,22 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
+						    ext4_group_t block_group,
+						    struct buffer_head *bh)
+{
+	ext4_grpblk_t next_zero_bit;
+	unsigned long bitmap_size = sb->s_blocksize * 8;
+	unsigned int offset = num_clusters_in_group(sb, block_group);
+
+	if (bitmap_size <= offset)
+		return 0;
+
+	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, bitmap_size, offset);
+
+	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -402,6 +418,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EFSCORRUPTED;
 	}
+	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
+	if (unlikely(blk != 0)) {
+		ext4_unlock_group(sb, block_group);
+		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
+			   block_group, blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		return -EFSCORRUPTED;
+	}
 	set_buffer_verified(bh);
 verified:
 	ext4_unlock_group(sb, block_group);

