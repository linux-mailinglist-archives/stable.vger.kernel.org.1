Return-Path: <stable+bounces-164068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56755B0DD1F
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212CC3B53FF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E3245012;
	Tue, 22 Jul 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXL1hi2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546D548EE;
	Tue, 22 Jul 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193146; cv=none; b=VR1duiuNgnAqMmvIF1oCaaONY4qa+jdpO8z9TnvMpP67krS72VvMx9a6D1vGJhWuv+hrS6igFy9b14ofdv4Hl04LP+1JDDLxohhmlgxqAuV2kjuXxB0CMJk/egVKNQVSiuneC9LTWJ4GvLZ9nfxplWGpNPsJJia2RemHN+n+apQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193146; c=relaxed/simple;
	bh=sQldkDg83g79ElwOD7Fcclsx/Ju5I+F0ffsi4eiq3Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfifIcqvOPiAd3oo0eX3vfdb3qA39UytQEB1Hn9T+TmZI0lgA0n5MqvE+pBo5zX1T2Z5dTpkBcRD3332X5ostEqW1FkBwfIKWgO9RmyixUJVrYuT5IEHYMBh3/SjfFc74BIpacXSu0sFclLOcDbU1TXybV+u5SIr42QyJ01VeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXL1hi2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFCFC4CEEB;
	Tue, 22 Jul 2025 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193146;
	bh=sQldkDg83g79ElwOD7Fcclsx/Ju5I+F0ffsi4eiq3Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vXL1hi2jur+1WDpd27wuOGHXyg7u2IiUlPjkeiwhSvu+Vn2vr59Qy2Sb1TrYcsFeD
	 Lnhb7QFAT03ZJZ4a7TNsK49cHEgiOc33tr6gIRTbDvAr59/pI1/Fy2Kjd8ArT9qtjh
	 +r1Mvh6H6WIZatvudvU9yUjxMRF+FRmMGGt5n8dw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12 142/158] btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
Date: Tue, 22 Jul 2025 15:45:26 +0200
Message-ID: <20250722134346.021137671@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit 2d8e5168d48a91e7a802d3003e72afb4304bebfa upstream.

Block group creation is done in two phases, which results in a slightly
unintuitive property: a block group can be allocated/deallocated from
after btrfs_make_block_group() adds it to the space_info with
btrfs_add_bg_to_space_info(), but before creation is completely completed
in btrfs_create_pending_block_groups(). As a result, it is possible for a
block group to go unused and have 'btrfs_mark_bg_unused' called on it
concurrently with 'btrfs_create_pending_block_groups'. This causes a
number of issues, which were fixed with the block group flag
'BLOCK_GROUP_FLAG_NEW'.

However, this fix is not quite complete. Since it does not use the
unused_bg_lock, it is possible for the following race to occur:

btrfs_create_pending_block_groups            btrfs_mark_bg_unused
                                           if list_empty // false
        list_del_init
        clear_bit
                                           else if (test_bit) // true
                                                list_move_tail

And we get into the exact same broken ref count and invalid new_bgs
state for transaction cleanup that BLOCK_GROUP_FLAG_NEW was designed to
prevent.

The broken refcount aspect will result in a warning like:

  [1272.943527] refcount_t: underflow; use-after-free.
  [1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
  [1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid6_pq null_blk [last unloaded: btrfs]
  [1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Tainted: G        W          6.14.0-rc5+ #108
  [1272.946368] Tainted: [W]=WARN
  [1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
  [1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
  [1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
  [1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
  [1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 0000000000000000
  [1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000000ffffdfff
  [1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: ffffffff90526268
  [1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa14b00dc28c0
  [1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 000001285dcd12c0
  [1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) knlGS:0000000000000000
  [1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 00000000000006f0
  [1272.954474] Call Trace:
  [1272.954655]  <TASK>
  [1272.954812]  ? refcount_warn_saturate+0xba/0x110
  [1272.955173]  ? __warn.cold+0x93/0xd7
  [1272.955487]  ? refcount_warn_saturate+0xba/0x110
  [1272.955816]  ? report_bug+0xe7/0x120
  [1272.956103]  ? handle_bug+0x53/0x90
  [1272.956424]  ? exc_invalid_op+0x13/0x60
  [1272.956700]  ? asm_exc_invalid_op+0x16/0x20
  [1272.957011]  ? refcount_warn_saturate+0xba/0x110
  [1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
  [1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
  [1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
  [1272.958729]  process_one_work+0x130/0x290
  [1272.959026]  worker_thread+0x2ea/0x420
  [1272.959335]  ? __pfx_worker_thread+0x10/0x10
  [1272.959644]  kthread+0xd7/0x1c0
  [1272.959872]  ? __pfx_kthread+0x10/0x10
  [1272.960172]  ret_from_fork+0x30/0x50
  [1272.960474]  ? __pfx_kthread+0x10/0x10
  [1272.960745]  ret_from_fork_asm+0x1a/0x30
  [1272.961035]  </TASK>
  [1272.961238] ---[ end trace 0000000000000000 ]---

Though we have seen them in the async discard workfn as well. It is
most likely to happen after a relocation finishes which cancels discard,
tears down the block group, etc.

Fix this fully by taking the lock around the list_del_init + clear_bit
so that the two are done atomically.

Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2780,8 +2780,11 @@ void btrfs_create_pending_block_groups(s
 		/* Already aborted the transaction if it failed. */
 next:
 		btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
 		 * If the block group is still unused, add it to the list of



