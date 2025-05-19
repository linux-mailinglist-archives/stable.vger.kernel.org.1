Return-Path: <stable+bounces-144794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E9ABBDC7
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17E8169921
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74A1F4717;
	Mon, 19 May 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/SSBrNs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6991C5485
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657858; cv=none; b=haM/7FNmtKyH01maIdk00LimQufKzeeSuz66fOTFyFgfm3pQ23eatZhwBfdS1mlibiPZlLLV0pU1TdfO+cebB7yrROHU7UnGRCLCvAS03y+JzyWenqwd/paowxJSS6HeLiMo01rGERiY2KRqUqnsqlj9uixl6jmQHhC7SK/4WbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657858; c=relaxed/simple;
	bh=wXEGCg5jgUupvK/6PrbD4RAgGBXqMz3W+Oy0o2ce9pQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S58q6Z7JMjTeg+UrV28dAcedmMAvG6m7qqH/LhYiSvkTJG+o0Pq5HWtheKKVDYqTvCHd0+jWl+0k89kNF1x6yiiG0UKb3/4A2eJTxPw7i41XivaYh8tH3IUE7QO8Jn/D1Mi3vcO8JJRxdHy47LlyUB1iXqakbkquZGJLidlkEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/SSBrNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0E4C4CEE9;
	Mon, 19 May 2025 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747657857;
	bh=wXEGCg5jgUupvK/6PrbD4RAgGBXqMz3W+Oy0o2ce9pQ=;
	h=Subject:To:Cc:From:Date:From;
	b=C/SSBrNsbHm5CcMOjQGVE2abv8AqiI8Fbx3QwOoG1mq6c01heC50ZYCQDObZzkRj7
	 EirjGEbEKWusKjtJEXNZu7rvuYCQW5c4/NFsRWZDhodzxGiM/wNvR/qvj89dRA8Wer
	 yTlY1hWrkAT5jj9gdBsoq+XuJnG9sa13qzJjv/I8=
Subject: FAILED: patch "[PATCH] btrfs: fix discard worker infinite loop after disabling" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com,neelx@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:30:54 +0200
Message-ID: <2025051954-gratified-manager-da96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 54db6d1bdd71fa90172a2a6aca3308bbf7fa7eb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051954-gratified-manager-da96@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54db6d1bdd71fa90172a2a6aca3308bbf7fa7eb5 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 5 May 2025 16:03:16 +0100
Subject: [PATCH] btrfs: fix discard worker infinite loop after disabling
 discard

If the discard worker is running and there's currently only one block
group, that block group is a data block group, it's in the unused block
groups discard list and is being used (it got an extent allocated from it
after becoming unused), the worker can end up in an infinite loop if a
transaction abort happens or the async discard is disabled (during remount
or unmount for example).

This happens like this:

1) Task A, the discard worker, is at peek_discard_list() and
   find_next_block_group() returns block group X;

2) Block group X is in the unused block groups discard list (its discard
   index is BTRFS_DISCARD_INDEX_UNUSED) since at some point in the past
   it become an unused block group and was added to that list, but then
   later it got an extent allocated from it, so its ->used counter is not
   zero anymore;

3) The current transaction is aborted by task B and we end up at
   __btrfs_handle_fs_error() in the transaction abort path, where we call
   btrfs_discard_stop(), which clears BTRFS_FS_DISCARD_RUNNING from
   fs_info, and then at __btrfs_handle_fs_error() we set the fs to RO mode
   (setting SB_RDONLY in the super block's s_flags field);

4) Task A calls __add_to_discard_list() with the goal of moving the block
   group from the unused block groups discard list into another discard
   list, but at __add_to_discard_list() we end up doing nothing because
   btrfs_run_discard_work() returns false, since the super block has
   SB_RDONLY set in its flags and BTRFS_FS_DISCARD_RUNNING is not set
   anymore in fs_info->flags. So block group X remains in the unused block
   groups discard list;

5) Task A then does a goto into the 'again' label, calls
   find_next_block_group() again we gets block group X again. Then it
   repeats the previous steps over and over since there are not other
   block groups in the discard lists and block group X is never moved
   out of the unused block groups discard list since
   btrfs_run_discard_work() keeps returning false and therefore
   __add_to_discard_list() doesn't move block group X out of that discard
   list.

When this happens we can get a soft lockup report like this:

  [71.957] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:3:97]
  [71.957] Modules linked in: xfs af_packet rfkill (...)
  [71.957] CPU: 0 UID: 0 PID: 97 Comm: kworker/u4:3 Tainted: G        W          6.14.2-1-default #1 openSUSE Tumbleweed 968795ef2b1407352128b466fe887416c33af6fa
  [71.957] Tainted: [W]=WARN
  [71.957] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  [71.957] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
  [71.957] RIP: 0010:btrfs_discard_workfn+0xc4/0x400 [btrfs]
  [71.957] Code: c1 01 48 83 (...)
  [71.957] RSP: 0018:ffffafaec03efe08 EFLAGS: 00000246
  [71.957] RAX: ffff897045500000 RBX: ffff8970413ed8d0 RCX: 0000000000000000
  [71.957] RDX: 0000000000000001 RSI: ffff8970413ed8d0 RDI: 0000000a8f1272ad
  [71.957] RBP: 0000000a9d61c60e R08: ffff897045500140 R09: 8080808080808080
  [71.957] R10: ffff897040276800 R11: fefefefefefefeff R12: ffff8970413ed860
  [71.957] R13: ffff897045500000 R14: ffff8970413ed868 R15: 0000000000000000
  [71.957] FS:  0000000000000000(0000) GS:ffff89707bc00000(0000) knlGS:0000000000000000
  [71.957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [71.957] CR2: 00005605bcc8d2f0 CR3: 000000010376a001 CR4: 0000000000770ef0
  [71.957] PKRU: 55555554
  [71.957] Call Trace:
  [71.957]  <TASK>
  [71.957]  process_one_work+0x17e/0x330
  [71.957]  worker_thread+0x2ce/0x3f0
  [71.957]  ? __pfx_worker_thread+0x10/0x10
  [71.957]  kthread+0xef/0x220
  [71.957]  ? __pfx_kthread+0x10/0x10
  [71.957]  ret_from_fork+0x34/0x50
  [71.957]  ? __pfx_kthread+0x10/0x10
  [71.957]  ret_from_fork_asm+0x1a/0x30
  [71.957]  </TASK>
  [71.957] Kernel panic - not syncing: softlockup: hung tasks
  [71.987] CPU: 0 UID: 0 PID: 97 Comm: kworker/u4:3 Tainted: G        W    L     6.14.2-1-default #1 openSUSE Tumbleweed 968795ef2b1407352128b466fe887416c33af6fa
  [71.989] Tainted: [W]=WARN, [L]=SOFTLOCKUP
  [71.989] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  [71.991] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
  [71.992] Call Trace:
  [71.993]  <IRQ>
  [71.994]  dump_stack_lvl+0x5a/0x80
  [71.994]  panic+0x10b/0x2da
  [71.995]  watchdog_timer_fn.cold+0x9a/0xa1
  [71.996]  ? __pfx_watchdog_timer_fn+0x10/0x10
  [71.997]  __hrtimer_run_queues+0x132/0x2a0
  [71.997]  hrtimer_interrupt+0xff/0x230
  [71.998]  __sysvec_apic_timer_interrupt+0x55/0x100
  [71.999]  sysvec_apic_timer_interrupt+0x6c/0x90
  [72.000]  </IRQ>
  [72.000]  <TASK>
  [72.001]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
  [72.002] RIP: 0010:btrfs_discard_workfn+0xc4/0x400 [btrfs]
  [72.002] Code: c1 01 48 83 (...)
  [72.005] RSP: 0018:ffffafaec03efe08 EFLAGS: 00000246
  [72.006] RAX: ffff897045500000 RBX: ffff8970413ed8d0 RCX: 0000000000000000
  [72.006] RDX: 0000000000000001 RSI: ffff8970413ed8d0 RDI: 0000000a8f1272ad
  [72.007] RBP: 0000000a9d61c60e R08: ffff897045500140 R09: 8080808080808080
  [72.008] R10: ffff897040276800 R11: fefefefefefefeff R12: ffff8970413ed860
  [72.009] R13: ffff897045500000 R14: ffff8970413ed868 R15: 0000000000000000
  [72.010]  ? btrfs_discard_workfn+0x51/0x400 [btrfs 23b01089228eb964071fb7ca156eee8cd3bf996f]
  [72.011]  process_one_work+0x17e/0x330
  [72.012]  worker_thread+0x2ce/0x3f0
  [72.013]  ? __pfx_worker_thread+0x10/0x10
  [72.014]  kthread+0xef/0x220
  [72.014]  ? __pfx_kthread+0x10/0x10
  [72.015]  ret_from_fork+0x34/0x50
  [72.015]  ? __pfx_kthread+0x10/0x10
  [72.016]  ret_from_fork_asm+0x1a/0x30
  [72.017]  </TASK>
  [72.017] Kernel Offset: 0x15000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
  [72.019] Rebooting in 90 seconds..

So fix this by making sure we move a block group out of the unused block
groups discard list when calling __add_to_discard_list().

Fixes: 2bee7eb8bb81 ("btrfs: discard one region at a time in async discard")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1242012
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Daniel Vacek <neelx@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index d6eef4bd9e9d..de23c4b3515e 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -94,8 +94,6 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				  struct btrfs_block_group *block_group)
 {
 	lockdep_assert_held(&discard_ctl->lock);
-	if (!btrfs_run_discard_work(discard_ctl))
-		return;
 
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
@@ -118,6 +116,9 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	if (!btrfs_is_block_group_data_only(block_group))
 		return;
 
+	if (!btrfs_run_discard_work(discard_ctl))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 	__add_to_discard_list(discard_ctl, block_group);
 	spin_unlock(&discard_ctl->lock);
@@ -244,6 +245,18 @@ static struct btrfs_block_group *peek_discard_list(
 		    block_group->used != 0) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
+				/*
+				 * The block group must have been moved to other
+				 * discard list even if discard was disabled in
+				 * the meantime or a transaction abort happened,
+				 * otherwise we can end up in an infinite loop,
+				 * always jumping into the 'again' label and
+				 * keep getting this block group over and over
+				 * in case there are no other block groups in
+				 * the discard lists.
+				 */
+				ASSERT(block_group->discard_index !=
+				       BTRFS_DISCARD_INDEX_UNUSED);
 			} else {
 				list_del_init(&block_group->discard_list);
 				btrfs_put_block_group(block_group);


