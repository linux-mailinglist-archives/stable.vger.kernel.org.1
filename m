Return-Path: <stable+bounces-145135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A551DABDA32
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35034A06D0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D386244691;
	Tue, 20 May 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jAf915l6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDA22D78C;
	Tue, 20 May 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749267; cv=none; b=ZbfeEuvwadxauLYsb6zZeBzprT6k/q3LTQQrdtRkoOYv+EfisDVPxCIShQOSbWFBbf1ty9T1JCXt/l4y2OtDiuNqhAhAUbVdJ6lHfV0ut0REkIaphflstaoX0C7PXkXJx6K94V6zu2IYdOwzoAwXjmEGkVJtdp+IxgzZqeBxYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749267; c=relaxed/simple;
	bh=g9qU59v4Y/2a1Hz7Bt5OGIFOGOd7ygFYfLFqVxP4i/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPdYcSjMVx5AMIsJNCKYaQ39mBI58K80VsmcrSbEcCzqjJKx1Im4VGwgj9KLIWCBgpK/ji+Iy28wbTk7Yqs+N1KRSltdpZ4o9Eb29BN+o75ptiWSbDs2QiTX1JZ9Z8B29b2YzVx0Y+SdLE40rLUBtpQKzzATyapyY3pT/DuiL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jAf915l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B231C4CEE9;
	Tue, 20 May 2025 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749266;
	bh=g9qU59v4Y/2a1Hz7Bt5OGIFOGOd7ygFYfLFqVxP4i/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAf915l67q3Le+XiYXAbH7doGrISDIMJDixx9tyC8XPD5PwnN10O/xfun8LMVpGv8
	 5/eeXNP8K43IsP9db04ESrCkz8QFehfzJrwC/HGapi92epcDnVdkGSYaTMHQirzLpz
	 gM4pkLFJ/eWpvIVNYI8Warh6tCv51Gwm2ExL8mIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Daniel Vacek <neelx@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 31/59] btrfs: fix discard worker infinite loop after disabling discard
Date: Tue, 20 May 2025 15:50:22 +0200
Message-ID: <20250520125755.095235604@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 54db6d1bdd71fa90172a2a6aca3308bbf7fa7eb5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/discard.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -78,8 +78,6 @@ static void __add_to_discard_list(struct
 				  struct btrfs_block_group *block_group)
 {
 	lockdep_assert_held(&discard_ctl->lock);
-	if (!btrfs_run_discard_work(discard_ctl))
-		return;
 
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
@@ -102,6 +100,9 @@ static void add_to_discard_list(struct b
 	if (!btrfs_is_block_group_data_only(block_group))
 		return;
 
+	if (!btrfs_run_discard_work(discard_ctl))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 	__add_to_discard_list(discard_ctl, block_group);
 	spin_unlock(&discard_ctl->lock);
@@ -233,6 +234,18 @@ again:
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



