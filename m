Return-Path: <stable+bounces-16104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB483F052
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8269283CAB
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C91B7E4;
	Sat, 27 Jan 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TY7/x7x+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AC1B7E1
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392672; cv=none; b=Amq3OUZqsw5wqmzJOrRTmjnRS1ZBxKg2S9O5fyw4k7SUxMsFVoaRMNBmxKcDi8M/0eY9m4Wav+AYbbMJ/CcEAUTPoWzeKG0qaVxi7OHd5TazT5r5DnkeRhi68QAbSl9R4zqe7+kGhH+6vVE71YzeS1F2AhEow4pRfTe1rUxoHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392672; c=relaxed/simple;
	bh=BXRQINPKHaUBFVGy2nWYQScYeTNeBkZuzk+D1q1lqMk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mdNOT1ArZEVtMO3EwZpkbqlYB0EclC9Yp0NhxH+BMWu0nANzGh4PU5HzWGIu+W50bMOxN1AAt7IfU9hiWEcPken3kS4Oe5WwXGbxtpha6C2WJuRoTGprdecfYaoc+7GusZ4yzyP8yr3xmegeSYAhn2sOGUxUTpegZSWjuFpWn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TY7/x7x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E02C433C7;
	Sat, 27 Jan 2024 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706392672;
	bh=BXRQINPKHaUBFVGy2nWYQScYeTNeBkZuzk+D1q1lqMk=;
	h=Subject:To:Cc:From:Date:From;
	b=TY7/x7x+auhmX0rk8TIcnYT4tmEoX9lTHm5foj+JBQQiPlb3uQcRhllpvrEmiaNlY
	 WEiVSWFRhmLPNWVHTw4DxlwHskjuk3ivt/inMChcWie3+Mmav3HXDS5NSDShlL6PZ2
	 GAU7C5VEIBNntUGHZGax57dj9oA7aoKL+mj210xY=
Subject: FAILED: patch "[PATCH] btrfs: don't abort filesystem when attempting to snapshot" failed to apply to 4.19-stable tree
To: osandov@fb.com,anand.jain@oracle.com,dsterba@suse.com,sweettea-kernel@dorminy.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 13:57:50 -0800
Message-ID: <2024012750-shore-gradually-d4bb@gregkh>
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
git cherry-pick -x 7081929ab2572920e94d70be3d332e5c9f97095a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012750-shore-gradually-d4bb@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

7081929ab257 ("btrfs: don't abort filesystem when attempting to snapshot deleted subvolume")
813febdbe6c9 ("btrfs: disable snapshot creation/deletion for extent tree v2")
4467af880929 ("btrfs: remove root argument from btrfs_unlink_inode()")
bd54f381a12a ("btrfs: do not pin logs too early during renames")
9a56fcd15a9c ("btrfs: make btrfs_update_inode take btrfs_inode")
76aea5379678 ("btrfs: make btrfs_inode_safe_disk_i_size_write take btrfs_inode")
2766ff61762c ("btrfs: update the number of bytes used by an inode atomically")
5893dfb98f25 ("btrfs: refactor btrfs_drop_extents() to make it easier to extend")
ac5887c8e013 ("btrfs: locking: remove all the blocking helpers")
a14b78ad06ab ("btrfs: introduce btrfs_inode_lock()/unlock()")
b8d8e1fd570a ("btrfs: introduce btrfs_write_check()")
c86537a42f86 ("btrfs: check FS error state bit early during write")
5e8b9ef30392 ("btrfs: move pos increment and pagecache extension to btrfs_buffered_write")
4e4cabece9f9 ("btrfs: split btrfs_direct_IO to read and write")
196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")
0425e7badbdc ("btrfs: don't fallback to buffered read if we don't need to")
3c38c877fcb9 ("btrfs: sink inode argument in insert_ordered_extent_file_extent")
fc0d82e103c7 ("btrfs: sink total_data parameter in setup_items_for_insert")
3dc9dc8969dc ("btrfs: eliminate total_size parameter from setup_items_for_insert")
0cbb5bdfea26 ("btrfs: rename btrfs_insert_clone_extent() to a more generic name")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7081929ab2572920e94d70be3d332e5c9f97095a Mon Sep 17 00:00:00 2001
From: Omar Sandoval <osandov@fb.com>
Date: Thu, 4 Jan 2024 11:48:46 -0800
Subject: [PATCH] btrfs: don't abort filesystem when attempting to snapshot
 deleted subvolume

If the source file descriptor to the snapshot ioctl refers to a deleted
subvolume, we get the following abort:

  BTRFS: Transaction aborted (error -2)
  WARNING: CPU: 0 PID: 833 at fs/btrfs/transaction.c:1875 create_pending_snapshot+0x1040/0x1190 [btrfs]
  Modules linked in: pata_acpi btrfs ata_piix libata scsi_mod virtio_net blake2b_generic xor net_failover virtio_rng failover scsi_common rng_core raid6_pq libcrc32c
  CPU: 0 PID: 833 Comm: t_snapshot_dele Not tainted 6.7.0-rc6 #2
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
  RIP: 0010:create_pending_snapshot+0x1040/0x1190 [btrfs]
  RSP: 0018:ffffa09c01337af8 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: ffff9982053e7c78 RCX: 0000000000000027
  RDX: ffff99827dc20848 RSI: 0000000000000001 RDI: ffff99827dc20840
  RBP: ffffa09c01337c00 R08: 0000000000000000 R09: ffffa09c01337998
  R10: 0000000000000003 R11: ffffffffb96da248 R12: fffffffffffffffe
  R13: ffff99820535bb28 R14: ffff99820b7bd000 R15: ffff99820381ea80
  FS:  00007fe20aadabc0(0000) GS:ffff99827dc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000559a120b502f CR3: 00000000055b6000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? __warn+0x81/0x130
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? report_bug+0x171/0x1a0
   ? handle_bug+0x3a/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   create_pending_snapshots+0x92/0xc0 [btrfs]
   btrfs_commit_transaction+0x66b/0xf40 [btrfs]
   btrfs_mksubvol+0x301/0x4d0 [btrfs]
   btrfs_mksnapshot+0x80/0xb0 [btrfs]
   __btrfs_ioctl_snap_create+0x1c2/0x1d0 [btrfs]
   btrfs_ioctl_snap_create_v2+0xc4/0x150 [btrfs]
   btrfs_ioctl+0x8a6/0x2650 [btrfs]
   ? kmem_cache_free+0x22/0x340
   ? do_sys_openat2+0x97/0xe0
   __x64_sys_ioctl+0x97/0xd0
   do_syscall_64+0x46/0xf0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
  RIP: 0033:0x7fe20abe83af
  RSP: 002b:00007ffe6eff1360 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe20abe83af
  RDX: 00007ffe6eff23c0 RSI: 0000000050009417 RDI: 0000000000000003
  RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fe20ad16cd0
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007ffe6eff13c0 R14: 00007fe20ad45000 R15: 0000559a120b6d58
   </TASK>
  ---[ end trace 0000000000000000 ]---
  BTRFS: error (device vdc: state A) in create_pending_snapshot:1875: errno=-2 No such entry
  BTRFS info (device vdc: state EA): forced readonly
  BTRFS warning (device vdc: state EA): Skipping commit of aborted transaction.
  BTRFS: error (device vdc: state EA) in cleanup_transaction:2055: errno=-2 No such entry

This happens because create_pending_snapshot() initializes the new root
item as a copy of the source root item. This includes the refs field,
which is 0 for a deleted subvolume. The call to btrfs_insert_root()
therefore inserts a root with refs == 0. btrfs_get_new_fs_root() then
finds the root and returns -ENOENT if refs == 0, which causes
create_pending_snapshot() to abort.

Fix it by checking the source root's refs before attempting the
snapshot, but after locking subvol_sem to avoid racing with deletion.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4e50b62db2a8..fea5d37528b8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -790,6 +790,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return -ENOENT;
+
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return -EINVAL;
 


