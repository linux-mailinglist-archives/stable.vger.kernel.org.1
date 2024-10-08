Return-Path: <stable+bounces-82008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75B994A98
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1041C24A44
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800661DE4FA;
	Tue,  8 Oct 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i1uJ7ft8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4131D0BAA;
	Tue,  8 Oct 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390867; cv=none; b=lcRUtP1pwaKjppmkK8SHCXDSfUQ4Z3L3SwVFDs1i9Dngq3LVRTL0/6aKtQXvqXtHj8kt1YXdQOmPXNZMWUMIsZc49SFD6dALHZVTJ0Vqb/hUNnvWj6gsR7WacGwupaa0fTPoGxHRUhr+faV7IIwL1jdC7Z4Naw/NCJzxEPE27WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390867; c=relaxed/simple;
	bh=bhQm8Bpz882fX+ShLyXZ6rKNtF3bWMrGdf3oCgGC9z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU6tU4WaM4BhAA01YKg2XqR0ie75fqN8r/bkstkiihWdoC2Kzly12edixQz4Omb9uBrLqt1081eobKZTn8xoPQa1Oq7dKz2S26kX5rxI0RLJvdXEh0e9FNxELI1cqYXTOWy/Q19DlK6P9+V3LtgFV0dnm/lPDJutT3gL1vWjB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i1uJ7ft8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA79C4CEC7;
	Tue,  8 Oct 2024 12:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390867;
	bh=bhQm8Bpz882fX+ShLyXZ6rKNtF3bWMrGdf3oCgGC9z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1uJ7ft8Hct/BcKsbTNMDWYPwWrCJPFRotKq+OpqHXGV2sk7nFIzEgkEX1UEevcMU
	 4itzvPQR6/5iXEPzQOFg+KCrc5cvOPsiAXw495iOf1DFT09ZJvf3lzXCFOHYvqoKKo
	 1Vycs/rvwaDwPHKqpjKP06Vm93qOg85Cc1LvrvkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.10 417/482] btrfs: fix a NULL pointer dereference when failed to start a new trasacntion
Date: Tue,  8 Oct 2024 14:08:00 +0200
Message-ID: <20241008115704.812651727@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit c3b47f49e83197e8dffd023ec568403bcdbb774b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/relocation.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -922,7 +922,7 @@ int btrfs_update_reloc_root(struct btrfs
 	btrfs_grab_root(reloc_root);
 
 	/* root->reloc_root will stay until current relocation finished */
-	if (fs_info->reloc_ctl->merge_reloc_tree &&
+	if (fs_info->reloc_ctl && fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
 		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 		/*



