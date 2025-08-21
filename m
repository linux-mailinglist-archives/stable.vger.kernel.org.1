Return-Path: <stable+bounces-172024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151FB2F98E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0E73A489E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84B2F747E;
	Thu, 21 Aug 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TPprwNWm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF32DA76E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781414; cv=none; b=uhiyyDHOA5O+UIMX6qBQeOKLGzOtF9vL+XTB/r8XG5vmuhds1V04Uo2+UUhONgS7Kk+62xIejYsLz0FW7wAB85IpO6qna5ueMU8drjWOVArs3ekbDYS3kwL9Rpvu0bdR2+D4wsPsNb4FcI+3MEf75kZtCevjiNXVTOgFfbycsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781414; c=relaxed/simple;
	bh=bttscwhz92HTzr5cywGUTxcRDcSw8YiuHpGgwMFHgxk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WNAxCCudAr7nXBjVXXUbHc3t5KD4ngFR5dQETlRTSTQ7D5cjrBSpk4T5+rIIQf8+YUC1YTjnqHVRntWBhp5avB7i/V68j+cdQybyWHM4M+pkraHkJNRwHBnnaSAUX/hl2/SHvXzs6cyLeOq1R5gHO/qzDhTGRlvW5S6pFUX0l3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TPprwNWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A2CC4CEEB;
	Thu, 21 Aug 2025 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781412;
	bh=bttscwhz92HTzr5cywGUTxcRDcSw8YiuHpGgwMFHgxk=;
	h=Subject:To:Cc:From:Date:From;
	b=TPprwNWmkoputvREeEMs71fP7IaR4503I8BVIHAkpK9MeftOVCR0GW6H9EHu/j3kx
	 udvFIc/FwbQ+exRgrhtBgpjlvhWcKrA4d6npXlMJneafpuYdFpqnpg7BnuR7rjBFd4
	 9crYkclVLfSY7xlANNaZ2izQT8CZAyvVzazmo+VI=
Subject: FAILED: patch "[PATCH] ext4: fix hole length calculation overflow in non-extent" failed to apply to 5.4-stable tree
To: yi.zhang@huawei.com,tytso@mit.edu,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:03:29 +0200
Message-ID: <2025082129-kung-accuracy-abdf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 02c7f7219ac0e2277b3379a3a0e9841ef464b6d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082129-kung-accuracy-abdf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


