Return-Path: <stable+bounces-163321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F118B09A18
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 05:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329273B8502
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4C191F9C;
	Fri, 18 Jul 2025 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="thI96DA8"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418F1400C
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808326; cv=none; b=fJYfGcMMlDMVOyujXf94uwPM6pvthCbqrsbYdKQGHbS3JECRXRG8nH3q9405S6Bx4aA+XXCYN1PE/KzI3wDfCTnpTCKEPiGCykXBHDcEssgf7APzYqMBzVRW8gm/OzMm6LbxCGBcy+v16KzEu8Non/A8+PMa0G5ahm4uJbPVSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808326; c=relaxed/simple;
	bh=lnSL1thnUIIMXKQSAsBOS/bJouSKf7Wy5Xdo7mvHxIY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=LDTI/RxKbYu3JQ9GXotwdGW0Bim5cBV2X6TD0nYgZ0Eb6DAuAHzylmwRW0ETHEKuOvZkDecpWAr3G+12XBTmHo525XkzMTdslcqojmyGkbCCpy1oT0ujWpzL8+IZVRvQTs1dY5Ln0DcxOx0wc29rEcJBc5s/KYbfWwZeEPuOFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=thI96DA8; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752808007;
	bh=XuAN+NNTJvWvZ0CkhoJWzTzvaltzeWOVNMwueSSIYEY=;
	h=From:To:Cc:Subject:Date;
	b=thI96DA8C9MeXMRFWJyh6rB+3LxnnQpcdsDhtQcrQArNX0zplG4dxgtWQvSqoLyc/
	 CvQPPotkFIv9H81fJhaUVU04016MubKn8nFYUS3+C7lUIkQYjOPs4ozQ8PvqUSBQyc
	 tlqaZweSuxSkQ0N5YlVO0DISYyz/InoqCHTsuV3Q=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.195.86])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id EEBAFCFF; Fri, 18 Jul 2025 10:59:43 +0800
X-QQ-mid: xmsmtpt1752807583tf2r9b72m
Message-ID: <tencent_C3ACCD708660161A98683D6A583E30255109@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XH7VFHtI7rPb9Cow6meGfMF+IkbavX2ahp63qpCjU8wjXn552cQ
	 OFxqXFFQXEh7rSsCIfgbKyiRAmYreD/4RXHYQIl4LkhlIASfb6j8AeVu3yGQOVYdGX24m//9hMiA
	 NlapsunPBTD8/oDU5m+5wjEhMXVvAdNhi6BJK2eA2f3dQtgSIZLSlrftiDSEOR0R27ci3i/W+boR
	 tRiwsvIzTQKBRIOv76eLHlguzvtPQTMaWbYTnQg2dwemG/hqwmAii241kxxfEJa8dhXXsFTuYNpU
	 wBEkxVvTZjsfzV7TAqKe/uJ6yksmYio5pYYGKgDELV89TRNlGkIUpIRT0P+XwVt0B8dWQKkv2P8c
	 85WT0ipDuKp/+TmR00fIY4tQpdezmdYu6yxezzrjCkR+ehd+NH0HikDGX2em+uK011bFxOCBHo57
	 QA5Olnv/ezZG3OM6gea3Doq0RLzfOqhe/VxeTCTsDh7hLYn4HaoBGTFGm1tBS67xcCcdRxVf+mEO
	 kWpS7uetNjgHnbT5IKTnzuqSKsUTaGp9zE36ZTV+iokGrqkkmKfHXQEVhLtKlHXJJqMKnLwFv+uE
	 0M8KxgZXK08ZY1Pj3G3o2yZQ3CuClI38bhxXQe3MVcz5++PVsBVgHctjiYbYcq/6bb0h7Ucu+kUV
	 UVCvRwsVGhIrWb6KLyw1qnfdf9SDCj6ABEPairZyNWSh6oINzDN/4U1TZOviOrk173YH/V0SPKfn
	 KX++tEopgom1D5WgmMzSGJ+HMPFBvekcgVoX+RM5dNlUYFFL72eDlSvQIXQ2SFe2iVtehepg1QM0
	 1lcJtjrIrpwmBC7rQjZDmC+uhGOO9LrGrr/q9QkgLNysbF6DEql6Q3PKMok14xF4S82gu0HD17s9
	 s+w/hDPlSbHQk41EN/N1DfkmVIc33Uw7IvF0idYefm7KuBpFtKnY7WMbyt9EojzeJ/e8Cp6d132r
	 6iCv/lSYMzOYhQBSijrD34Aca30nbMkZGgcIuUNBSAFKhndqsTSqwz/hEm2t3gRZZ7EB8a+sORze
	 Iz0FPTKfSFWKxBvETh
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
Date: Fri, 18 Jul 2025 10:59:42 +0800
X-OQ-MSGID: <20250718025942.1085-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 2d8e5168d48a91e7a802d3003e72afb4304bebfa ]

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
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index aa8656c8b7e7..dd35e29d8082 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2780,8 +2780,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
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
-- 
2.34.1


