Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C473279BBCC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbjIKVEl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbjIKNxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45CDCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09818C433C9;
        Mon, 11 Sep 2023 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440405;
        bh=7kzzLRjWmwbQq/puYbVmgmuNrMgiORig0M4PoRZ2A+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYjlit6LImnZD9NM/Dl/Nr+SAc67VhhrXuAzejrC+muH7ecnIKtpXs4eQVoCONpm7
         HmRA3Yis7BVLQGkM8TyXFWSXRysOdeMPErN6yCohfXfg4hXDw8Vn0Ddm0Hh1TSnK2Y
         Q3t1d4mNuYIenvvX+arE7N84ckqElPZNnoGmUUnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 023/739] btrfs: zoned: skip splitting and logical rewriting on pre-alloc write
Date:   Mon, 11 Sep 2023 15:37:02 +0200
Message-ID: <20230911134651.696560235@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit c02d35d89b317994bd713ba82e160c5e7f22d9c8 ]

When doing a relocation, there is a chance that at the time of
btrfs_reloc_clone_csums(), there is no checksum for the corresponding
region.

In this case, btrfs_finish_ordered_zoned()'s sum points to an invalid item
and so ordered_extent's logical is set to some invalid value. Then,
btrfs_lookup_block_group() in btrfs_zone_finish_endio() failed to find a
block group and will hit an assert or a null pointer dereference as
following.

This can be reprodcued by running btrfs/028 several times (e.g, 4 to 16
times) with a null_blk setup. The device's zone size and capacity is set to
32 MB and the storage size is set to 5 GB on my setup.

    KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
    CPU: 6 PID: 3105720 Comm: kworker/u16:13 Tainted: G        W          6.5.0-rc6-kts+ #1
    Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
    Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
    RIP: 0010:btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
    Code: 41 54 49 89 fc 55 48 89 f5 53 e8 57 7d fc ff 48 8d b8 88 00 00 00 48 89 c3 48 b8 00 00 00 00 00
    > 3c 02 00 0f 85 02 01 00 00 f6 83 88 00 00 00 01 0f 84 a8 00 00
    RSP: 0018:ffff88833cf87b08 EFLAGS: 00010206
    RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
    RDX: 0000000000000011 RSI: 0000000000000004 RDI: 0000000000000088
    RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed102877b827
    R10: ffff888143bdc13b R11: ffff888125b1cbc0 R12: ffff888143bdc000
    R13: 0000000000007000 R14: ffff888125b1cba8 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:ffff88881e500000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007f3ed85223d5 CR3: 00000001519b4005 CR4: 00000000001706e0
    Call Trace:
     <TASK>
     ? die_addr+0x3c/0xa0
     ? exc_general_protection+0x148/0x220
     ? asm_exc_general_protection+0x22/0x30
     ? btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
     ? btrfs_zone_finish_endio.part.0+0x19/0x160 [btrfs]
     btrfs_finish_one_ordered+0x7b8/0x1de0 [btrfs]
     ? rcu_is_watching+0x11/0xb0
     ? lock_release+0x47a/0x620
     ? btrfs_finish_ordered_zoned+0x59b/0x800 [btrfs]
     ? __pfx_btrfs_finish_one_ordered+0x10/0x10 [btrfs]
     ? btrfs_finish_ordered_zoned+0x358/0x800 [btrfs]
     ? __smp_call_single_queue+0x124/0x350
     ? rcu_is_watching+0x11/0xb0
     btrfs_work_helper+0x19f/0xc60 [btrfs]
     ? __pfx_try_to_wake_up+0x10/0x10
     ? _raw_spin_unlock_irq+0x24/0x50
     ? rcu_is_watching+0x11/0xb0
     process_one_work+0x8c1/0x1430
     ? __pfx_lock_acquire+0x10/0x10
     ? __pfx_process_one_work+0x10/0x10
     ? __pfx_do_raw_spin_lock+0x10/0x10
     ? _raw_spin_lock_irq+0x52/0x60
     worker_thread+0x100/0x12c0
     ? __kthread_parkme+0xc1/0x1f0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x2ea/0x3c0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x30/0x70
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1b/0x30
     </TASK>

On the zoned mode, writing to pre-allocated region means data relocation
write. Such write always uses WRITE command so there is no need of splitting
and rewriting logical address. Thus, we can just skip the function for the
case.

Fixes: cbfce4c7fbde ("btrfs: optimize the logical to physical mapping for zoned writes")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 72b90bc19a191..2490301350015 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1707,10 +1707,21 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_ordered_sum *sum =
-		list_first_entry(&ordered->list, typeof(*sum), list);
-	u64 logical = sum->logical;
-	u64 len = sum->len;
+	struct btrfs_ordered_sum *sum;
+	u64 logical, len;
+
+	/*
+	 * Write to pre-allocated region is for the data relocation, and so
+	 * it should use WRITE operation. No split/rewrite are necessary.
+	 */
+	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered->flags))
+		return;
+
+	ASSERT(!list_empty(&ordered->list));
+	/* The ordered->list can be empty in the above pre-alloc case. */
+	sum = list_first_entry(&ordered->list, struct btrfs_ordered_sum, list);
+	logical = sum->logical;
+	len = sum->len;
 
 	while (len < ordered->disk_num_bytes) {
 		sum = list_next_entry(sum, list);
-- 
2.40.1



