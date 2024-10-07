Return-Path: <stable+bounces-81430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF99934AA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874822823A7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617E1DC74E;
	Mon,  7 Oct 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n6JZcNBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269FB1DB55D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321480; cv=none; b=l8Mbpc+oee1gA/H7a6JS+iQA3BNIGlFs2g4ilu0vSCM1zM5sk1lpKtwJh9k2pFDfQ3t+0rX0JETD7awA1u/YcCmhtKhQiEhSGyvQ3ZKp1BEJNXYucVMVOX43sPyV4Je5Pns4H/vGs4SVHK6wpkh0a1Mou6M9jm2aG5ejBmYie7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321480; c=relaxed/simple;
	bh=xkwmVaryOWfe2aAbssQ7MTbjbWCibjtSqph8/0oiJAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rn48iQUHsnNk08S9m+zApFLJ114xP9EKdghu5NHyic1PmUUYAozL2h/Pf04S9gTUX3Ojz1ic1y3RA+sJl+/mes0NTwpKjyOxHjCi1b/OPWe7ZXt8gy9vW+iueOgl6WBHbISDXigIEVm1puk+UERipy82/rJ4N1ZUu5h+kXr3uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n6JZcNBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784CDC4CEC6;
	Mon,  7 Oct 2024 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321480;
	bh=xkwmVaryOWfe2aAbssQ7MTbjbWCibjtSqph8/0oiJAs=;
	h=Subject:To:Cc:From:Date:From;
	b=n6JZcNBAVWCRz6vthLe6FzMpDGF64dG0Xsl/JwYS4QqoVi6QRysaE7ARP82foqbai
	 oioSLSGobr7NMZmDUDC9r58SRS+YpkHNLdX9sadQsvL/w16alUdwMvUf2xl8C+Q6YN
	 fS1Wo7ur6idf+TJZ31/rnp4WwTjFUZZ097Rbg3nk=
Subject: FAILED: patch "[PATCH] btrfs: fix a NULL pointer dereference when failed to start a" failed to apply to 4.19-stable tree
To: wqu@suse.com,dsterba@suse.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:17:56 +0200
Message-ID: <2024100756-parasail-agreement-0453@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c3b47f49e83197e8dffd023ec568403bcdbb774b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100756-parasail-agreement-0453@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c3b47f49e831 ("btrfs: fix a NULL pointer dereference when failed to start a new trasacntion")
d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
83354f0772cd ("btrfs: catch cow on deleting snapshots")
61fa90c16b0b ("btrfs: switch BTRFS_ROOT_* to enums")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3b47f49e83197e8dffd023ec568403bcdbb774b Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Sat, 28 Sep 2024 08:05:58 +0930
Subject: [PATCH] btrfs: fix a NULL pointer dereference when failed to start a
 new trasacntion

[BUG]
Syzbot reported a NULL pointer dereference with the following crash:

  FAULT_INJECTION: forcing a failure.
   start_transaction+0x830/0x1670 fs/btrfs/transaction.c:676
   prepare_to_relocate+0x31f/0x4c0 fs/btrfs/relocation.c:3642
   relocate_block_group+0x169/0xd20 fs/btrfs/relocation.c:3678
  ...
  BTRFS info (device loop0): balance: ended with status: -12
  Oops: general protection fault, probably for non-canonical address 0xdffffc00000000cc: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000660-0x0000000000000667]
  RIP: 0010:btrfs_update_reloc_root+0x362/0xa80 fs/btrfs/relocation.c:926
  Call Trace:
   <TASK>
   commit_fs_roots+0x2ee/0x720 fs/btrfs/transaction.c:1496
   btrfs_commit_transaction+0xfaf/0x3740 fs/btrfs/transaction.c:2430
   del_balance_item fs/btrfs/volumes.c:3678 [inline]
   reset_balance_state+0x25e/0x3c0 fs/btrfs/volumes.c:3742
   btrfs_balance+0xead/0x10c0 fs/btrfs/volumes.c:4574
   btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:907 [inline]
   __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

[CAUSE]
The allocation failure happens at the start_transaction() inside
prepare_to_relocate(), and during the error handling we call
unset_reloc_control(), which makes fs_info->balance_ctl to be NULL.

Then we continue the error path cleanup in btrfs_balance() by calling
reset_balance_state() which will call del_balance_item() to fully delete
the balance item in the root tree.

However during the small window between set_reloc_contrl() and
unset_reloc_control(), we can have a subvolume tree update and created a
reloc_root for that subvolume.

Then we go into the final btrfs_commit_transaction() of
del_balance_item(), and into btrfs_update_reloc_root() inside
commit_fs_roots().

That function checks if fs_info->reloc_ctl is in the merge_reloc_tree
stage, but since fs_info->reloc_ctl is NULL, it results a NULL pointer
dereference.

[FIX]
Just add extra check on fs_info->reloc_ctl inside
btrfs_update_reloc_root(), before checking
fs_info->reloc_ctl->merge_reloc_tree.

That DEAD_RELOC_TREE handling is to prevent further modification to the
reloc tree during merge stage, but since there is no reloc_ctl at all,
we do not need to bother that.

Reported-by: syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/66f6bfa7.050a0220.38ace9.0019.GAE@google.com/
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cf1dfeaaf2d8..f3834f8d26b4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -856,7 +856,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	btrfs_grab_root(reloc_root);
 
 	/* root->reloc_root will stay until current relocation finished */
-	if (fs_info->reloc_ctl->merge_reloc_tree &&
+	if (fs_info->reloc_ctl && fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
 		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 		/*


