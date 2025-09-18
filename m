Return-Path: <stable+bounces-172025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED593B2F992
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85EF680F40
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E241F4CAC;
	Thu, 21 Aug 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgM1pyD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549031CA59
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781421; cv=none; b=o/qqgyfxowgya3Xq/MfHfmEv8xXItDFqP+7xjTYi0hF4YSmKalCKnvBaUbcrcSlmJoaF8kGKbX7EcwFCWvzNSLV+TM6cHQUk2uuWQBN95IozhiuCO2+v00pbb+QsH2SPyn9gAnw9mDcn/Q7j6DfEb6qP2gNljN/4kha+hR8CMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781421; c=relaxed/simple;
	bh=RfIeXAiXeTsJ3uKc36KcW6LbHJc854phFZDgqD0Jz4M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EDuIx64o6Qfrrncqzx5S1apV+Z4g2M4eWoKFnzgG3yMXwmxPDU2tqbnDjXOdqCIaTKcvccSvCh/dCtNkDnj4a34xWkKAeG74Ip0nIGMNFxoqoWs/12kh2Hcsi0koRbtX+TAoUsX41nEDUKR751EuDQK9RsujAUaSX20f1inK0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgM1pyD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4351C4CEED;
	Thu, 21 Aug 2025 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781421;
	bh=RfIeXAiXeTsJ3uKc36KcW6LbHJc854phFZDgqD0Jz4M=;
	h=Subject:To:Cc:From:Date:From;
	b=RgM1pyD1oskAO8kZCKn02QMl+c5jVZuG/E7J9eHstCIiWd6v3L3Tp07AmhqZBHvHu
	 n5j5ZdBqzYYjaHjAPsN4kbupZwbZap7vqL0aVLvHtnadGJvbkRSU9AUTm4PaWqU5rf
	 s9mb1AT9zbceOZOq4LnkcTlG6IJgyhI1yK4VwyPg=
Subject: FAILED: patch "[PATCH] ext4: fix hole length calculation overflow in non-extent" failed to apply to 5.10-stable tree
To: yi.zhang@huawei.com,tytso@mit.edu,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:03:30 +0200
Message-ID: <2025082130-hunchback-efficient-e925@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 02c7f7219ac0e2277b3379a3a0e9841ef464b6d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082130-hunchback-efficient-e925@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02c7f7219ac0e2277b3379a3a0e9841ef464b6d4 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Mon, 11 Aug 2025 14:45:32 +0800
Subject: [PATCH] ext4: fix hole length calculation overflow in non-extent
 inodes

In a filesystem with a block size larger than 4KB, the hole length
calculation for a non-extent inode in ext4_ind_map_blocks() can easily
exceed INT_MAX. Then it could return a zero length hole and trigger the
following waring and infinite in the iomap infrastructure.

  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 434101 at fs/iomap/iter.c:34 iomap_iter_done+0x148/0x190
  CPU: 3 UID: 0 PID: 434101 Comm: fsstress Not tainted 6.16.0-rc7+ #128 PREEMPT(voluntary)
  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : iomap_iter_done+0x148/0x190
  lr : iomap_iter+0x174/0x230
  sp : ffff8000880af740
  x29: ffff8000880af740 x28: ffff0000db8e6840 x27: 0000000000000000
  x26: 0000000000000000 x25: ffff8000880af830 x24: 0000004000000000
  x23: 0000000000000002 x22: 000001bfdbfa8000 x21: ffffa6a41c002e48
  x20: 0000000000000001 x19: ffff8000880af808 x18: 0000000000000000
  x17: 0000000000000000 x16: ffffa6a495ee6cd0 x15: 0000000000000000
  x14: 00000000000003d4 x13: 00000000fa83b2da x12: 0000b236fc95f18c
  x11: ffffa6a4978b9c08 x10: 0000000000001da0 x9 : ffffa6a41c1a2a44
  x8 : ffff8000880af5c8 x7 : 0000000001000000 x6 : 0000000000000000
  x5 : 0000000000000004 x4 : 000001bfdbfa8000 x3 : 0000000000000000
  x2 : 0000000000000000 x1 : 0000004004030000 x0 : 0000000000000000
  Call trace:
   iomap_iter_done+0x148/0x190 (P)
   iomap_iter+0x174/0x230
   iomap_fiemap+0x154/0x1d8
   ext4_fiemap+0x110/0x140 [ext4]
   do_vfs_ioctl+0x4b8/0xbc0
   __arm64_sys_ioctl+0x8c/0x120
   invoke_syscall+0x6c/0x100
   el0_svc_common.constprop.0+0x48/0xf0
   do_el0_svc+0x24/0x38
   el0_svc+0x38/0x120
   el0t_64_sync_handler+0x10c/0x138
   el0t_64_sync+0x198/0x1a0
  ---[ end trace 0000000000000000 ]---

Cc: stable@kernel.org
Fixes: facab4d9711e ("ext4: return hole from ext4_map_blocks()")
Reported-by: Qu Wenruo <wqu@suse.com>
Closes: https://lore.kernel.org/linux-ext4/9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com/
Tested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250811064532.1788289-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 7de327fa7b1c..d45124318200 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
-	int count = 0;
+	u64 count = 0;
 	ext4_fsblk_t first_block = 0;
 
 	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 		count++;
 		/* Fill in size of a hole we found */
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, count);
+		map->m_len = umin(map->m_len, count);
 		goto cleanup;
 	}
 


