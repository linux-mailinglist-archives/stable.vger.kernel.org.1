Return-Path: <stable+bounces-115586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE9A34500
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFA618983DE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A7221713;
	Thu, 13 Feb 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAa2YiC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C912036F3;
	Thu, 13 Feb 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458552; cv=none; b=b9vianci3B8NA7bgfrRWu7hiCvmfuPQ3hPM4wQ4pJp4tpRULJr93b3PoP+bhJZHwSPFrpEFdrN9dYuEVI1CPx9uFvei+mrZpFOdbXtQXNBb7feeI5FywzZfr6McTwfdi7YbXhnYf5M33A5+iPC+X9G7VxdZIK7EH/8L5uz/vra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458552; c=relaxed/simple;
	bh=fF1rq2HiwHzjSPlOkrsVEt7GL4X6gTg89cWEYpmjZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwhluuTMe3jFnFsC6SUrXtR0De28nSCFYyjZfng4lC8ofDDuiuqKk5XAxa05DUacfP8Flnw1zdSgmOJy5Y37hvxJGyNnnrh3b5evAXNV0Aju25x8rcM/lYmUKOoq1lya3wI+n8e64M/vB0xtzzncf4dWrvhmcswJhk4pJwoq2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAa2YiC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05CFC4CED1;
	Thu, 13 Feb 2025 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458552;
	bh=fF1rq2HiwHzjSPlOkrsVEt7GL4X6gTg89cWEYpmjZ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yAa2YiC/h+auBXMXwICq5E30A2UM3JEFH1BK0ApW/dOQxFO1oBNgP+BDXhcaEjr7d
	 I/Ujdoz+ax+KsxLEAQMp0m457BHUXjjjc8CoTOBJNKhSNLzbVnMEq0LNXAvpmRKf61
	 cCG8qgCunQkzEw/5ymNojRvXUd/JlTMPUZAKtDe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 011/443] btrfs: dont use btrfs_set_item_key_safe on RAID stripe-extents
Date: Thu, 13 Feb 2025 15:22:56 +0100
Message-ID: <20250213142441.058156001@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit dc14ba10781bd2629835696b7cc1febf914768e9 ]

Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
stripe-tree, as this can lead to corruption of the tree, which is caught
by the checks in btrfs_set_item_key_safe():

 BTRFS info (device nvme1n1): leaf 49168384 gen 15 total ptrs 194 free space 8329 owner 12
 BTRFS info (device nvme1n1): refs 2 lock_owner 1030 current 1030
  [ snip ]
  item 105 key (354549760 230 20480) itemoff 14587 itemsize 16
                  stride 0 devid 5 physical 67502080
  item 106 key (354631680 230 4096) itemoff 14571 itemsize 16
                  stride 0 devid 1 physical 88559616
  item 107 key (354631680 230 32768) itemoff 14555 itemsize 16
                  stride 0 devid 1 physical 88555520
  item 108 key (354717696 230 28672) itemoff 14539 itemsize 16
                  stride 0 devid 2 physical 67604480
  [ snip ]
 BTRFS critical (device nvme1n1): slot 106 key (354631680 230 32768) new key (354635776 230 4096)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.c:2602!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 UID: 0 PID: 1055 Comm: fsstress Not tainted 6.13.0-rc1+ #1464
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 RIP: 0010:btrfs_set_item_key_safe+0xf7/0x270
 Code: <snip>
 RSP: 0018:ffffc90001337ab0 EFLAGS: 00010287
 RAX: 0000000000000000 RBX: ffff8881115fd000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000ffffffff
 RBP: ffff888110ed6f50 R08: 00000000ffffefff R09: ffffffff8244c500
 R10: 00000000ffffefff R11: 00000000ffffffff R12: ffff888100586000
 R13: 00000000000000c9 R14: ffffc90001337b1f R15: ffff888110f23b58
 FS:  00007f7d75c72740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa811652c60 CR3: 0000000111398001 CR4: 0000000000370eb0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x14/0x1a
  ? die+0x2e/0x50
  ? do_trap+0xca/0x110
  ? do_error_trap+0x65/0x80
  ? btrfs_set_item_key_safe+0xf7/0x270
  ? exc_invalid_op+0x50/0x70
  ? btrfs_set_item_key_safe+0xf7/0x270
  ? asm_exc_invalid_op+0x1a/0x20
  ? btrfs_set_item_key_safe+0xf7/0x270
  btrfs_partially_delete_raid_extent+0xc4/0xe0
  btrfs_delete_raid_extent+0x227/0x240
  __btrfs_free_extent.isra.0+0x57f/0x9c0
  ? exc_coproc_segment_overrun+0x40/0x40
  __btrfs_run_delayed_refs+0x2fa/0xe80
  btrfs_run_delayed_refs+0x81/0xe0
  btrfs_commit_transaction+0x2dd/0xbe0
  ? preempt_count_add+0x52/0xb0
  btrfs_sync_file+0x375/0x4c0
  do_fsync+0x39/0x70
  __x64_sys_fsync+0x13/0x20
  do_syscall_64+0x54/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f7d7550ef90
 Code: <snip>
 RSP: 002b:00007ffd70237248 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
 RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d7550ef90
 RDX: 000000000000013a RSI: 000000000040eb28 RDI: 0000000000000004
 RBP: 000000000000001b R08: 0000000000000078 R09: 00007ffd7023725c
 R10: 00007f7d75400390 R11: 0000000000000202 R12: 028f5c28f5c28f5c
 R13: 8f5c28f5c28f5c29 R14: 000000000040b520 R15: 00007f7d75c726c8
  </TASK>

While the root cause of the tree order corruption isn't clear, using
btrfs_duplicate_item() to copy the item and then adjusting both the key
and the per-device physical addresses is a safe way to counter this
problem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9ffc79f250fbb..10781c015ee8d 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -13,12 +13,13 @@
 #include "volumes.h"
 #include "print-tree.h"
 
-static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
+static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 					       struct btrfs_path *path,
 					       const struct btrfs_key *oldkey,
 					       u64 newlen, u64 frontpad)
 {
-	struct btrfs_stripe_extent *extent;
+	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
+	struct btrfs_stripe_extent *extent, *newitem;
 	struct extent_buffer *leaf;
 	int slot;
 	size_t item_size;
@@ -27,23 +28,38 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.type = BTRFS_RAID_STRIPE_KEY,
 		.offset = newlen,
 	};
+	int ret;
 
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
 
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	item_size = btrfs_item_size(leaf, slot);
+
+	newitem = kzalloc(item_size, GFP_NOFS);
+	if (!newitem)
+		return -ENOMEM;
+
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
 
 	for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
 		struct btrfs_raid_stride *stride = &extent->strides[i];
 		u64 phys;
 
-		phys = btrfs_raid_stride_physical(leaf, stride);
-		btrfs_set_raid_stride_physical(leaf, stride, phys + frontpad);
+		phys = btrfs_raid_stride_physical(leaf, stride) + frontpad;
+		btrfs_set_stack_raid_stride_physical(&newitem->strides[i], phys);
 	}
 
-	btrfs_set_item_key_safe(trans, path, &newkey);
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto out;
+
+	btrfs_release_path(path);
+	ret = btrfs_insert_item(trans, stripe_root, &newkey, newitem, item_size);
+
+out:
+	kfree(newitem);
+	return ret;
 }
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
-- 
2.39.5




