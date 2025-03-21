Return-Path: <stable+bounces-125737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149AA6B61E
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 09:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A883B63E3
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D01E5739;
	Fri, 21 Mar 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="EPq5Yyie"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53D1EE7DF
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546374; cv=none; b=gJI67L4C2KRDAf5mA+bdjs8OpGyB1dJh3cbnvEwgmbzsioBlhgWHwoM7clrVFFxQ9DuZG4kewmhwbtpBxOjYfl9lkJTzOC1YWohcIu2VYbCN+yE/lquzxYuEXaoZ6zm1KAHgyUonSTE+LIsyUvJSY/yt9BrbCfMVkA9AKvsv5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546374; c=relaxed/simple;
	bh=LIq1S1ILBLLIzVha56l3SAJ1S2bxK//QwnsNkxnYi74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E3l116xGjjui5MfQOiILAD8nR+Y53gZAN1XXBPTmX6L9u3mqSkZTAF9btAumlF+jJfXQY8xgk2X2x128+5ZvgATsaLI9fvqrU0FZpJcu9ouHcA3DaGTPhpp0EmU19bV4SsHUCFcE+XlVMRI8ppAXaGTWyMjCy52rIcg2ndjLWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=EPq5Yyie; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 413364487864;
	Fri, 21 Mar 2025 08:39:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 413364487864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742546362;
	bh=2r+4gfBQyjL5QgBT+TakcGLN/vzrml7dxD2R6DVK+HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EPq5YyieDiBfyefo2lcU56bKJEf+o+YNn8jrvyAy/1r3pIHWCJPSzbpeNRllyQgaH
	 qhkaJVznpxdMUZ6R5YdLVNZ9MnKW5NtKi5I6IMsLIioyRmulxYq0vgrb2mKTlIxL3z
	 k2ETrgzV0c0HUvHgmdA7wxv8JsFmBX72r8C+GSoA=
Date: Fri, 21 Mar 2025 11:39:22 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
Message-ID: <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313202550.2257219-15-leah.rumancik@gmail.com>

Hi,

Leah Rumancik wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit 03f7767c9f6120ac933378fdec3bfd78bf07bc11 ]

Commit 03f7767c9f6120ac933378fdec3bfd78bf07bc11 leads to a kernel crash
during the xfs/235 test execution on 6.1.

Bisecting this on the mainline shows it is resolved by

e5f1a5146ec3 ("xfs: use xfs_defer_finish_one to finish recovered work items")

which was a part of the same patchset [1] with intent recovery changes but
is not included into the current 6.1 backport-series.

[1]: https://lore.kernel.org/linux-xfs/170120318847.13206.17051442307252477333.stgit@frogsfrogsfrogs/



$ cat local.config
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt/scratch
export SCRATCH_LOGDEV=/dev/loop2
export SCRATCH_RTDEV=/dev/loop3
export MKFS_OPTIONS="-m rmapbt=1"
$ ./check xfs/235
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 pserver 6.1.131+ #5 SMP PREEMPT_DYNAMIC Fri Mar 21 00:23:33 2025
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/loop1
MOUNT_OPTIONS -- -o context=unconfined_u:object_r:root_t:s0 /dev/loop1 /mnt/scratch

xfs/235 6s ...


Kernel log taken with "xfs: use xfs_defer_pending objects to recover intent items"
as HEAD commit in stable 6.1-queue

[   24.491106] loop0: detected capacity change from 0 to 2097152
[   24.497086] loop1: detected capacity change from 0 to 2097152
[   24.502562] loop2: detected capacity change from 0 to 2097152
[   24.507256] loop3: detected capacity change from 0 to 2097152
[   28.801611] XFS (loop0): Mounting V5 Filesystem
[   28.857208] XFS (loop0): Ending clean mount
[   32.056570] XFS (loop1): Mounting V5 Filesystem
[   32.062298] XFS (loop1): Ending clean mount
[   32.068974] XFS (loop1): Unmounting Filesystem
[   32.129230] XFS (loop0): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[   32.242946] XFS (loop0): Unmounting Filesystem
[   32.312170] XFS (loop0): Mounting V5 Filesystem
[   32.317663] XFS (loop0): Ending clean mount
[   32.362570] run fstests xfs/235 at 2025-03-21 08:06:16
[   33.010312] XFS (loop1): Mounting V5 Filesystem
[   33.016581] XFS (loop1): Ending clean mount
[   33.047697] XFS (loop1): Unmounting Filesystem
[   33.124483] XFS (loop1): Mounting V5 Filesystem
[   33.130343] XFS (loop1): Ending clean mount
[   33.200269] cp (1897) used greatest stack depth: 22704 bytes left
[   33.229054] XFS (loop1): Unmounting Filesystem
[   33.348374] XFS (loop1): Mounting V5 Filesystem
[   33.352033] XFS (loop1): Ending clean mount
[   33.363401] XFS (loop1): Metadata CRC error detected at xfs_rmapbt_read_verify+0x28/0x240, xfs_rmapbt block 0x28 
[   33.364028] XFS (loop1): Unmount and run xfs_repair
[   33.364186] XFS (loop1): First 128 bytes of corrupted metadata buffer:
[   33.364387] 00000000: 52 4d 42 33 00 00 00 0b ff ff ff ff ff ff ff ff  RMB3............
[   33.364642] 00000010: 00 00 00 00 00 00 00 28 00 00 00 01 00 00 00 02  .......(........
[   33.364881] 00000020: 85 c5 70 96 4c 65 44 11 bf 35 27 35 35 35 ec 19  ..p.LeD..5'555..
[   33.365173] 00000030: 00 00 00 00 16 08 c6 49 00 00 00 00 00 00 00 01  .......I........
[   33.365484] 00000040: ff ff ff ff ff ff ff fd 00 00 00 00 00 00 00 00  ................
[   33.365854] 00000050: 00 00 00 01 00 00 00 02 ff ff ff ff ff ff ff fb  ................
[   33.366204] 00000060: 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 02  ................
[   33.366435] 00000070: ff ff ff ff ff ff ff fa 00 00 00 00 00 00 00 00  ................
[   33.366694] XFS (loop1): metadata I/O error in "xfs_btree_read_buf_block.constprop.0+0x1ae/0x360" at daddr 0x28 len 8 error 74
[   33.374164] XFS (loop1): Corruption of in-memory data (0x8) detected at xfs_defer_finish_noroll+0xcc3/0x1c10 (fs/xfs/libxfs/xfs_defer.c:596).  Shutting down filesys.
[   33.374863] XFS (loop1): Please unmount the filesystem and rectify the problem(s)
[   33.389190] XFS (loop1): Unmounting Filesystem
[   33.422139] XFS (loop1): Mounting V5 Filesystem
[   33.426543] XFS (loop1): Starting recovery (logdev: internal)
[   33.428526] XFS (loop1): Metadata CRC error detected at xfs_rmapbt_read_verify+0x28/0x240, xfs_rmapbt block 0x28 
[   33.428923] XFS (loop1): Unmount and run xfs_repair
[   33.429147] XFS (loop1): First 128 bytes of corrupted metadata buffer:
[   33.429378] 00000000: 52 4d 42 33 00 00 00 0b ff ff ff ff ff ff ff ff  RMB3............
[   33.429788] 00000010: 00 00 00 00 00 00 00 28 00 00 00 01 00 00 00 02  .......(........
[   33.430087] 00000020: 85 c5 70 96 4c 65 44 11 bf 35 27 35 35 35 ec 19  ..p.LeD..5'555..
[   33.430442] 00000030: 00 00 00 00 16 08 c6 49 00 00 00 00 00 00 00 01  .......I........
[   33.430733] 00000040: ff ff ff ff ff ff ff fd 00 00 00 00 00 00 00 00  ................
[   33.431047] 00000050: 00 00 00 01 00 00 00 02 ff ff ff ff ff ff ff fb  ................
[   33.431350] 00000060: 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 02  ................
[   33.431616] 00000070: ff ff ff ff ff ff ff fa 00 00 00 00 00 00 00 00  ................
[   33.431858] XFS (loop1): metadata I/O error in "xfs_btree_read_buf_block.constprop.0+0x1ae/0x360" at daddr 0x28 len 8 error 74
[   33.432279] 00000000: 87 00 00 00 00 00 00 00 98 00 00 00 00 00 00 00  ................
[   33.432553] 00000010: 00 00 00 00 00 00 00 00 70 00 00 00 01 00 00 20  ........p...... 
[   33.432883] XFS (loop1): Internal error xfs_rui_item_recover at line 573 of file fs/xfs/xfs_rmap_item.c.  Caller xlog_recover_process_intents+0x221/0xbc0
[   33.433397] CPU: 0 PID: 2107 Comm: mount Not tainted 6.1.131+ #5
[   33.433607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[   33.433893] Call Trace:
[   33.433985]  <TASK>
[   33.434065]  dump_stack_lvl+0x91/0xbe
[   33.434204]  xfs_corruption_error+0x139/0x160
[   33.434540]  xfs_rui_item_recover+0x8b2/0xb70
[   33.435985]  xlog_recover_process_intents+0x221/0xbc0
[   33.437896]  xlog_recover_finish+0x8b/0x9f0
[   33.439417]  xfs_log_mount_finish+0x386/0x650
[   33.439565]  xfs_mountfs+0x125c/0x1d90
[   33.440407]  xfs_fs_fill_super+0x1327/0x1ea0
[   33.440547]  get_tree_bdev+0x42c/0x740
[   33.440850]  vfs_get_tree+0x8e/0x2f0
[   33.440969]  path_mount+0x137f/0x1ec0
[   33.441561]  __x64_sys_mount+0x286/0x310
[   33.442210]  do_syscall_64+0x39/0x90
[   33.442340]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   33.444714]  </TASK>
[   33.444947] XFS (loop1): Corruption detected. Unmount and run xfs_repair
[   33.445212] XFS (loop1): Internal error xfs_trans_cancel at line 1096 of file fs/xfs/xfs_trans.c.  Caller xfs_rui_item_recover+0x8de/0xb70
[   33.445667] CPU: 0 PID: 2107 Comm: mount Not tainted 6.1.131+ #5
[   33.445905] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[   33.446225] Call Trace:
[   33.446318]  <TASK>
[   33.446406]  dump_stack_lvl+0x91/0xbe
[   33.446552]  xfs_error_report+0xb7/0xc0
[   33.446875]  xfs_trans_cancel+0x512/0x6d0
[   33.447025]  xfs_rui_item_recover+0x8de/0xb70
[   33.448066]  xlog_recover_process_intents+0x221/0xbc0
[   33.449553]  xlog_recover_finish+0x8b/0x9f0
[   33.450811]  xfs_log_mount_finish+0x386/0x650
[   33.450971]  xfs_mountfs+0x125c/0x1d90
[   33.451866]  xfs_fs_fill_super+0x1327/0x1ea0
[   33.452028]  get_tree_bdev+0x42c/0x740
[   33.452307]  vfs_get_tree+0x8e/0x2f0
[   33.452434]  path_mount+0x137f/0x1ec0
[   33.453011]  __x64_sys_mount+0x286/0x310
[   33.453658]  do_syscall_64+0x39/0x90
[   33.453787]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   33.456137]  </TASK>
[   33.456250] XFS (loop1): Corruption of in-memory data (0x8) detected at xfs_trans_cancel+0x52b/0x6d0 (fs/xfs/xfs_trans.c:1097).  Shutting down filesystem.
[   33.456734] XFS (loop1): Please unmount the filesystem and rectify the problem(s)
[   33.457005] ==================================================================


After there goes KASAN [decoded].

BUG: KASAN: use-after-free in xlog_item_is_intent (fs/xfs/xfs_trans.h:103) 
BUG: KASAN: use-after-free in xlog_recover_cancel_intents (fs/xfs/xfs_log_recover.c:2630) 
Read of size 8 at addr ffff88802c268390 by task mount/2107

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
print_report (mm/kasan/report.c:317 mm/kasan/report.c:427) 
kasan_report (mm/kasan/report.c:194 mm/kasan/report.c:533) 
xlog_item_is_intent (fs/xfs/xfs_trans.h:103 inline)
xlog_recover_cancel_intents (fs/xfs/xfs_log_recover.c:2630) 
xlog_recover_finish (fs/xfs/xfs_log_recover.c:3468) 
xfs_log_mount_finish (fs/xfs/xfs_log.c:796) 
xfs_mountfs (fs/xfs/xfs_mount.c:934) 
xfs_fs_fill_super (fs/xfs/xfs_super.c:1682) 
get_tree_bdev (fs/super.c:1367) 
vfs_get_tree (fs/super.c:1574) 
path_mount (fs/namespace.c:3386) 
__x64_sys_mount (fs/namespace.c:3584) 
do_syscall_64 (arch/x86/entry/common.c:81) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121) 
 </TASK>

Allocated by task 2107:
kasan_save_stack (mm/kasan/common.c:46) 
kasan_set_track (mm/kasan/common.c:52) 
__kasan_slab_alloc (mm/kasan/common.c:328) 
kmem_cache_alloc (mm/slub.c:3422) 
xfs_rui_init (./include/linux/slab.h:689 fs/xfs/xfs_rmap_item.c:146) 
xlog_recover_rui_commit_pass2 (fs/xfs/xfs_rmap_item.c:683) 
xlog_recover_items_pass2 (fs/xfs/xfs_log_recover.c:1976) 
xlog_recover_commit_trans (fs/xfs/xfs_log_recover.c:2043) 
xlog_recovery_process_trans (fs/xfs/xfs_log_recover.c:2274) 
xlog_recover_process_ophdr (fs/xfs/xfs_log_recover.c:2420) 
xlog_recover_process_data (fs/xfs/xfs_log_recover.c:2467) 
xlog_recover_process (fs/xfs/xfs_log_recover.c:2903) 
xlog_do_recovery_pass (fs/xfs/xfs_log_recover.c:3199) 
xlog_do_log_recovery (fs/xfs/xfs_log_recover.c:3279) 
xlog_do_recover (fs/xfs/xfs_log_recover.c:3306) 
xlog_recover (fs/xfs/xfs_log_recover.c:3439) 
xfs_log_mount (fs/xfs/xfs_log.c:717) 
xfs_mountfs (fs/xfs/xfs_mount.c:822) 
xfs_fs_fill_super (fs/xfs/xfs_super.c:1682) 
get_tree_bdev (fs/super.c:1367) 
vfs_get_tree (fs/super.c:1574) 
path_mount (fs/namespace.c:3057) 
__x64_sys_mount (fs/namespace.c:3584) 
do_syscall_64 (arch/x86/entry/common.c:81) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121) 

Freed by task 2107:
kasan_save_stack (mm/kasan/common.c:46) 
kasan_set_track (mm/kasan/common.c:52) 
kasan_save_free_info (mm/kasan/generic.c:518) 
____kasan_slab_free (mm/kasan/common.c:200) 
kmem_cache_free (mm/slub.c:3683) 
xfs_rui_item_free (fs/xfs/xfs_rmap_item.c:43) 
xfs_rui_release (fs/xfs/xfs_rmap_item.c:61) 
xfs_rud_item_release (fs/xfs/xfs_rmap_item.c:207) 
xfs_trans_free_items (fs/xfs/xfs_trans.c:711) 
xfs_trans_cancel (fs/xfs/xfs_trans.c:1117) 
xfs_rui_item_recover (fs/xfs/xfs_rmap_item.c:586) 
xlog_recover_process_intents (fs/xfs/xfs_log_recover.c:2590) 
xlog_recover_finish (fs/xfs/xfs_log_recover.c:3459) 
xfs_log_mount_finish (fs/xfs/xfs_log.c:796) 
xfs_mountfs (fs/xfs/xfs_mount.c:934) 
xfs_fs_fill_super (fs/xfs/xfs_super.c:1682) 
get_tree_bdev (fs/super.c:1367) 
vfs_get_tree (fs/super.c:1574) 
path_mount (fs/namespace.c:3386) 
__x64_sys_mount (fs/namespace.c:3584) 
do_syscall_64 (arch/x86/entry/common.c:81) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121) 

The buggy address belongs to the object at ffff88802c268330
 which belongs to the cache xfs_rui_item of size 688
The buggy address is located 96 bytes inside of
 688-byte region [ffff88802c268330, ffff88802c2685e0)



I'd say the following 6.1 patches from the current backport-series

[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover
[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop_recover

transform the crash a little bit to a NULL pointer dereference in the same
location but do not suppress the problem. It is reproducible above the
relevant top of queue/6.1 of linux-stable-rc.git


Thanks,
Fedor

> 
> [ 6.1: resovled conflict in xfs_defer.c ]
> 
> One thing I never quite got around to doing is porting the log intent
> item recovery code to reconstruct the deferred pending work state.  As a
> result, each intent item open codes xfs_defer_finish_one in its recovery
> method, because that's what the EFI code did before xfs_defer.c even
> existed.
> 
> This is a gross thing to have left unfixed -- if an EFI cannot proceed
> due to busy extents, we end up creating separate new EFIs for each
> unfinished work item, which is a change in behavior from what runtime
> would have done.
> 
> Worse yet, Long Li pointed out that there's a UAF in the recovery code.
> The ->commit_pass2 function adds the intent item to the AIL and drops
> the refcount.  The one remaining refcount is now owned by the recovery
> mechanism (aka the log intent items in the AIL) with the intent of
> giving the refcount to the intent done item in the ->iop_recover
> function.
> 
> However, if something fails later in recovery, xlog_recover_finish will
> walk the recovered intent items in the AIL and release them.  If the CIL
> hasn't been pushed before that point (which is possible since we don't
> force the log until later) then the intent done release will try to free
> its associated intent, which has already been freed.
> 
> This patch starts to address this mess by having the ->commit_pass2
> functions recreate the xfs_defer_pending state.  The next few patches
> will fix the recovery functions.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> Acked-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_defer.c       | 103 +++++++++++++++++++++--------
>  fs/xfs/libxfs/xfs_defer.h       |   5 ++
>  fs/xfs/libxfs/xfs_log_recover.h |   3 +
>  fs/xfs/xfs_attr_item.c          |  10 +--
>  fs/xfs/xfs_bmap_item.c          |   9 +--
>  fs/xfs/xfs_extfree_item.c       |   9 +--
>  fs/xfs/xfs_log.c                |   1 +
>  fs/xfs/xfs_log_priv.h           |   1 +
>  fs/xfs/xfs_log_recover.c        | 113 ++++++++++++++++----------------
>  fs/xfs/xfs_refcount_item.c      |   9 +--
>  fs/xfs/xfs_rmap_item.c          |   9 +--
>  11 files changed, 157 insertions(+), 115 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
> index 92470ed3fcbd..64005ea1e8af 100644
> --- a/fs/xfs/libxfs/xfs_defer.c
> +++ b/fs/xfs/libxfs/xfs_defer.c
> @@ -243,37 +243,66 @@ xfs_defer_create_intents(
>  		ret |= ret2;
>  	}
>  	return ret;
>  }
>  
> -STATIC void
> +static inline void
>  xfs_defer_pending_abort(
> +	struct xfs_mount		*mp,
> +	struct xfs_defer_pending	*dfp)
> +{
> +	const struct xfs_defer_op_type	*ops = defer_op_types[dfp->dfp_type];
> +
> +	trace_xfs_defer_pending_abort(mp, dfp);
> +
> +	if (dfp->dfp_intent && !dfp->dfp_done) {
> +		ops->abort_intent(dfp->dfp_intent);
> +		dfp->dfp_intent = NULL;
> +	}
> +}
> +
> +static inline void
> +xfs_defer_pending_cancel_work(
> +	struct xfs_mount		*mp,
> +	struct xfs_defer_pending	*dfp)
> +{
> +	const struct xfs_defer_op_type	*ops = defer_op_types[dfp->dfp_type];
> +	struct list_head		*pwi;
> +	struct list_head		*n;
> +
> +	trace_xfs_defer_cancel_list(mp, dfp);
> +
> +	list_del(&dfp->dfp_list);
> +	list_for_each_safe(pwi, n, &dfp->dfp_work) {
> +		list_del(pwi);
> +		dfp->dfp_count--;
> +		ops->cancel_item(pwi);
> +	}
> +	ASSERT(dfp->dfp_count == 0);
> +	kmem_cache_free(xfs_defer_pending_cache, dfp);
> +}
> +
> +STATIC void
> +xfs_defer_pending_abort_list(
>  	struct xfs_mount		*mp,
>  	struct list_head		*dop_list)
>  {
>  	struct xfs_defer_pending	*dfp;
> -	const struct xfs_defer_op_type	*ops;
>  
>  	/* Abort intent items that don't have a done item. */
> -	list_for_each_entry(dfp, dop_list, dfp_list) {
> -		ops = defer_op_types[dfp->dfp_type];
> -		trace_xfs_defer_pending_abort(mp, dfp);
> -		if (dfp->dfp_intent && !dfp->dfp_done) {
> -			ops->abort_intent(dfp->dfp_intent);
> -			dfp->dfp_intent = NULL;
> -		}
> -	}
> +	list_for_each_entry(dfp, dop_list, dfp_list)
> +		xfs_defer_pending_abort(mp, dfp);
>  }
>  
>  /* Abort all the intents that were committed. */
>  STATIC void
>  xfs_defer_trans_abort(
>  	struct xfs_trans		*tp,
>  	struct list_head		*dop_pending)
>  {
>  	trace_xfs_defer_trans_abort(tp, _RET_IP_);
> -	xfs_defer_pending_abort(tp->t_mountp, dop_pending);
> +	xfs_defer_pending_abort_list(tp->t_mountp, dop_pending);
>  }
>  
>  /*
>   * Capture resources that the caller said not to release ("held") when the
>   * transaction commits.  Caller is responsible for zero-initializing @dres.
> @@ -387,30 +416,17 @@ xfs_defer_cancel_list(
>  	struct xfs_mount		*mp,
>  	struct list_head		*dop_list)
>  {
>  	struct xfs_defer_pending	*dfp;
>  	struct xfs_defer_pending	*pli;
> -	struct list_head		*pwi;
> -	struct list_head		*n;
> -	const struct xfs_defer_op_type	*ops;
>  
>  	/*
>  	 * Free the pending items.  Caller should already have arranged
>  	 * for the intent items to be released.
>  	 */
> -	list_for_each_entry_safe(dfp, pli, dop_list, dfp_list) {
> -		ops = defer_op_types[dfp->dfp_type];
> -		trace_xfs_defer_cancel_list(mp, dfp);
> -		list_del(&dfp->dfp_list);
> -		list_for_each_safe(pwi, n, &dfp->dfp_work) {
> -			list_del(pwi);
> -			dfp->dfp_count--;
> -			ops->cancel_item(pwi);
> -		}
> -		ASSERT(dfp->dfp_count == 0);
> -		kmem_cache_free(xfs_defer_pending_cache, dfp);
> -	}
> +	list_for_each_entry_safe(dfp, pli, dop_list, dfp_list)
> +		xfs_defer_pending_cancel_work(mp, dfp);
>  }
>  
>  /*
>   * Prevent a log intent item from pinning the tail of the log by logging a
>   * done item to release the intent item; and then log a new intent item.
> @@ -661,10 +677,43 @@ xfs_defer_add(
>  
>  	list_add_tail(li, &dfp->dfp_work);
>  	dfp->dfp_count++;
>  }
>  
> +/*
> + * Create a pending deferred work item to replay the recovered intent item
> + * and add it to the list.
> + */
> +void
> +xfs_defer_start_recovery(
> +	struct xfs_log_item		*lip,
> +	enum xfs_defer_ops_type		dfp_type,
> +	struct list_head		*r_dfops)
> +{
> +	struct xfs_defer_pending	*dfp;
> +
> +	dfp = kmem_cache_zalloc(xfs_defer_pending_cache,
> +			GFP_NOFS | __GFP_NOFAIL);
> +	dfp->dfp_type = dfp_type;
> +	dfp->dfp_intent = lip;
> +	INIT_LIST_HEAD(&dfp->dfp_work);
> +	list_add_tail(&dfp->dfp_list, r_dfops);
> +}
> +
> +/*
> + * Cancel a deferred work item created to recover a log intent item.  @dfp
> + * will be freed after this function returns.
> + */
> +void
> +xfs_defer_cancel_recovery(
> +	struct xfs_mount		*mp,
> +	struct xfs_defer_pending	*dfp)
> +{
> +	xfs_defer_pending_abort(mp, dfp);
> +	xfs_defer_pending_cancel_work(mp, dfp);
> +}
> +
>  /*
>   * Move deferred ops from one transaction to another and reset the source to
>   * initial state. This is primarily used to carry state forward across
>   * transaction rolls with pending dfops.
>   */
> @@ -765,11 +814,11 @@ xfs_defer_ops_capture_abort(
>  	struct xfs_mount		*mp,
>  	struct xfs_defer_capture	*dfc)
>  {
>  	unsigned short			i;
>  
> -	xfs_defer_pending_abort(mp, &dfc->dfc_dfops);
> +	xfs_defer_pending_abort_list(mp, &dfc->dfc_dfops);
>  	xfs_defer_cancel_list(mp, &dfc->dfc_dfops);
>  
>  	for (i = 0; i < dfc->dfc_held.dr_bufs; i++)
>  		xfs_buf_relse(dfc->dfc_held.dr_bp[i]);
>  
> diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
> index 8788ad5f6a73..5dce938ba3d5 100644
> --- a/fs/xfs/libxfs/xfs_defer.h
> +++ b/fs/xfs/libxfs/xfs_defer.h
> @@ -123,9 +123,14 @@ void xfs_defer_ops_continue(struct xfs_defer_capture *d, struct xfs_trans *tp,
>  		struct xfs_defer_resources *dres);
>  void xfs_defer_ops_capture_abort(struct xfs_mount *mp,
>  		struct xfs_defer_capture *d);
>  void xfs_defer_resources_rele(struct xfs_defer_resources *dres);
>  
> +void xfs_defer_start_recovery(struct xfs_log_item *lip,
> +		enum xfs_defer_ops_type dfp_type, struct list_head *r_dfops);
> +void xfs_defer_cancel_recovery(struct xfs_mount *mp,
> +		struct xfs_defer_pending *dfp);
> +
>  int __init xfs_defer_init_item_caches(void);
>  void xfs_defer_destroy_item_caches(void);
>  
>  #endif /* __XFS_DEFER_H__ */
> diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
> index a5100a11faf9..271a4ce7375c 100644
> --- a/fs/xfs/libxfs/xfs_log_recover.h
> +++ b/fs/xfs/libxfs/xfs_log_recover.h
> @@ -151,6 +151,9 @@ xlog_recover_resv(const struct xfs_trans_res *r)
>  	};
>  
>  	return ret;
>  }
>  
> +void xlog_recover_intent_item(struct xlog *log, struct xfs_log_item *lip,
> +		xfs_lsn_t lsn, unsigned int dfp_type);
> +
>  #endif	/* __XFS_LOG_RECOVER_H__ */
> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
> index 11e88a76a33c..a32716b8cbbd 100644
> --- a/fs/xfs/xfs_attr_item.c
> +++ b/fs/xfs/xfs_attr_item.c
> @@ -770,18 +770,12 @@ xlog_recover_attri_commit_pass2(
>  			attri_formatp->alfi_value_len);
>  
>  	attrip = xfs_attri_init(mp, nv);
>  	memcpy(&attrip->attri_format, attri_formatp, len);
>  
> -	/*
> -	 * The ATTRI has two references. One for the ATTRD and one for ATTRI to
> -	 * ensure it makes it into the AIL. Insert the ATTRI into the AIL
> -	 * directly and drop the ATTRI reference. Note that
> -	 * xfs_trans_ail_update() drops the AIL lock.
> -	 */
> -	xfs_trans_ail_insert(log->l_ailp, &attrip->attri_item, lsn);
> -	xfs_attri_release(attrip);
> +	xlog_recover_intent_item(log, &attrip->attri_item, lsn,
> +			XFS_DEFER_OPS_TYPE_ATTR);
>  	xfs_attri_log_nameval_put(nv);
>  	return 0;
>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
> index 1058603db3ac..8d08252e1953 100644
> --- a/fs/xfs/xfs_bmap_item.c
> +++ b/fs/xfs/xfs_bmap_item.c
> @@ -644,16 +644,13 @@ xlog_recover_bui_commit_pass2(
>  	}
>  
>  	buip = xfs_bui_init(mp);
>  	xfs_bui_copy_format(&buip->bui_format, bui_formatp);
>  	atomic_set(&buip->bui_next_extent, bui_formatp->bui_nextents);
> -	/*
> -	 * Insert the intent into the AIL directly and drop one reference so
> -	 * that finishing or canceling the work will drop the other.
> -	 */
> -	xfs_trans_ail_insert(log->l_ailp, &buip->bui_item, lsn);
> -	xfs_bui_release(buip);
> +
> +	xlog_recover_intent_item(log, &buip->bui_item, lsn,
> +			XFS_DEFER_OPS_TYPE_BMAP);
>  	return 0;
>  }
>  
>  const struct xlog_recover_item_ops xlog_bui_item_ops = {
>  	.item_type		= XFS_LI_BUI,
> diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
> index 3ed25c352269..fd9fe51bcc31 100644
> --- a/fs/xfs/xfs_extfree_item.c
> +++ b/fs/xfs/xfs_extfree_item.c
> @@ -734,16 +734,13 @@ xlog_recover_efi_commit_pass2(
>  	if (error) {
>  		xfs_efi_item_free(efip);
>  		return error;
>  	}
>  	atomic_set(&efip->efi_next_extent, efi_formatp->efi_nextents);
> -	/*
> -	 * Insert the intent into the AIL directly and drop one reference so
> -	 * that finishing or canceling the work will drop the other.
> -	 */
> -	xfs_trans_ail_insert(log->l_ailp, &efip->efi_item, lsn);
> -	xfs_efi_release(efip);
> +
> +	xlog_recover_intent_item(log, &efip->efi_item, lsn,
> +			XFS_DEFER_OPS_TYPE_FREE);
>  	return 0;
>  }
>  
>  const struct xlog_recover_item_ops xlog_efi_item_ops = {
>  	.item_type		= XFS_LI_EFI,
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index ce6b303484cf..d39ee05ac1f2 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -1538,10 +1538,11 @@ xlog_alloc_log(
>  	log->l_logBBstart  = blk_offset;
>  	log->l_logBBsize   = num_bblks;
>  	log->l_covered_state = XLOG_STATE_COVER_IDLE;
>  	set_bit(XLOG_ACTIVE_RECOVERY, &log->l_opstate);
>  	INIT_DELAYED_WORK(&log->l_work, xfs_log_worker);
> +	INIT_LIST_HEAD(&log->r_dfops);
>  
>  	log->l_prev_block  = -1;
>  	/* log->l_tail_lsn = 0x100000000LL; cycle = 1; current block = 0 */
>  	xlog_assign_atomic_lsn(&log->l_tail_lsn, 1, 0);
>  	xlog_assign_atomic_lsn(&log->l_last_sync_lsn, 1, 0);
> diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
> index 1bd2963e8fbd..8677ba92d317 100644
> --- a/fs/xfs/xfs_log_priv.h
> +++ b/fs/xfs/xfs_log_priv.h
> @@ -401,10 +401,11 @@ struct xlog {
>  	struct workqueue_struct	*l_ioend_workqueue; /* for I/O completions */
>  	struct delayed_work	l_work;		/* background flush work */
>  	long			l_opstate;	/* operational state */
>  	uint			l_quotaoffs_flag; /* XFS_DQ_*, for QUOTAOFFs */
>  	struct list_head	*l_buf_cancel_table;
> +	struct list_head	r_dfops;	/* recovered log intent items */
>  	int			l_iclog_hsize;  /* size of iclog header */
>  	int			l_iclog_heads;  /* # of iclog header sectors */
>  	uint			l_sectBBsize;   /* sector size in BBs (2^n) */
>  	int			l_iclog_size;	/* size of log in bytes */
>  	int			l_iclog_bufs;	/* number of iclog buffers */
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index e009bb23d8a2..65041ed7833d 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -1721,34 +1721,28 @@ xlog_clear_stale_blocks(
>   * Release the recovered intent item in the AIL that matches the given intent
>   * type and intent id.
>   */
>  void
>  xlog_recover_release_intent(
> -	struct xlog		*log,
> -	unsigned short		intent_type,
> -	uint64_t		intent_id)
> +	struct xlog			*log,
> +	unsigned short			intent_type,
> +	uint64_t			intent_id)
>  {
> -	struct xfs_ail_cursor	cur;
> -	struct xfs_log_item	*lip;
> -	struct xfs_ail		*ailp = log->l_ailp;
> +	struct xfs_defer_pending	*dfp, *n;
> +
> +	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
> +		struct xfs_log_item	*lip = dfp->dfp_intent;
>  
> -	spin_lock(&ailp->ail_lock);
> -	for (lip = xfs_trans_ail_cursor_first(ailp, &cur, 0); lip != NULL;
> -	     lip = xfs_trans_ail_cursor_next(ailp, &cur)) {
>  		if (lip->li_type != intent_type)
>  			continue;
>  		if (!lip->li_ops->iop_match(lip, intent_id))
>  			continue;
>  
> -		spin_unlock(&ailp->ail_lock);
> -		lip->li_ops->iop_release(lip);
> -		spin_lock(&ailp->ail_lock);
> -		break;
> -	}
> +		ASSERT(xlog_item_is_intent(lip));
>  
> -	xfs_trans_ail_cursor_done(&cur);
> -	spin_unlock(&ailp->ail_lock);
> +		xfs_defer_cancel_recovery(log->l_mp, dfp);
> +	}
>  }
>  
>  int
>  xlog_recover_iget(
>  	struct xfs_mount	*mp,
> @@ -1937,10 +1931,33 @@ xlog_buf_readahead(
>  {
>  	if (!xlog_is_buffer_cancelled(log, blkno, len))
>  		xfs_buf_readahead(log->l_mp->m_ddev_targp, blkno, len, ops);
>  }
>  
> +/*
> + * Create a deferred work structure for resuming and tracking the progress of a
> + * log intent item that was found during recovery.
> + */
> +void
> +xlog_recover_intent_item(
> +	struct xlog			*log,
> +	struct xfs_log_item		*lip,
> +	xfs_lsn_t			lsn,
> +	unsigned int			dfp_type)
> +{
> +	ASSERT(xlog_item_is_intent(lip));
> +
> +	xfs_defer_start_recovery(lip, dfp_type, &log->r_dfops);
> +
> +	/*
> +	 * Insert the intent into the AIL directly and drop one reference so
> +	 * that finishing or canceling the work will drop the other.
> +	 */
> +	xfs_trans_ail_insert(log->l_ailp, lip, lsn);
> +	lip->li_ops->iop_unpin(lip, 0);
> +}
> +
>  STATIC int
>  xlog_recover_items_pass2(
>  	struct xlog                     *log,
>  	struct xlog_recover             *trans,
>  	struct list_head                *buffer_list,
> @@ -2534,104 +2551,88 @@ xlog_abort_defer_ops(
>   * have started recovery on all the pending intents when we find an non-intent
>   * item in the AIL.
>   */
>  STATIC int
>  xlog_recover_process_intents(
> -	struct xlog		*log)
> +	struct xlog			*log)
>  {
>  	LIST_HEAD(capture_list);
> -	struct xfs_ail_cursor	cur;
> -	struct xfs_log_item	*lip;
> -	struct xfs_ail		*ailp;
> -	int			error = 0;
> +	struct xfs_defer_pending	*dfp, *n;
> +	int				error = 0;
>  #if defined(DEBUG) || defined(XFS_WARN)
> -	xfs_lsn_t		last_lsn;
> -#endif
> +	xfs_lsn_t			last_lsn;
>  
> -	ailp = log->l_ailp;
> -	spin_lock(&ailp->ail_lock);
> -#if defined(DEBUG) || defined(XFS_WARN)
>  	last_lsn = xlog_assign_lsn(log->l_curr_cycle, log->l_curr_block);
>  #endif
> -	for (lip = xfs_trans_ail_cursor_first(ailp, &cur, 0);
> -	     lip != NULL;
> -	     lip = xfs_trans_ail_cursor_next(ailp, &cur)) {
> -		const struct xfs_item_ops	*ops;
>  
> -		if (!xlog_item_is_intent(lip))
> -			break;
> +	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
> +		struct xfs_log_item	*lip = dfp->dfp_intent;
> +		const struct xfs_item_ops *ops = lip->li_ops;
> +
> +		ASSERT(xlog_item_is_intent(lip));
>  
>  		/*
>  		 * We should never see a redo item with a LSN higher than
>  		 * the last transaction we found in the log at the start
>  		 * of recovery.
>  		 */
>  		ASSERT(XFS_LSN_CMP(last_lsn, lip->li_lsn) >= 0);
>  
>  		/*
>  		 * NOTE: If your intent processing routine can create more
>  		 * deferred ops, you /must/ attach them to the capture list in
>  		 * the recover routine or else those subsequent intents will be
>  		 * replayed in the wrong order!
>  		 *
>  		 * The recovery function can free the log item, so we must not
>  		 * access lip after it returns.
>  		 */
> -		spin_unlock(&ailp->ail_lock);
> -		ops = lip->li_ops;
>  		error = ops->iop_recover(lip, &capture_list);
> -		spin_lock(&ailp->ail_lock);
>  		if (error) {
>  			trace_xlog_intent_recovery_failed(log->l_mp, error,
>  					ops->iop_recover);
>  			break;
>  		}
> -	}
>  
> -	xfs_trans_ail_cursor_done(&cur);
> -	spin_unlock(&ailp->ail_lock);
> +		/*
> +		 * XXX: @lip could have been freed, so detach the log item from
> +		 * the pending item before freeing the pending item.  This does
> +		 * not fix the existing UAF bug that occurs if ->iop_recover
> +		 * fails after creating the intent done item.
> +		 */
> +		dfp->dfp_intent = NULL;
> +		xfs_defer_cancel_recovery(log->l_mp, dfp);
> +	}
>  	if (error)
>  		goto err;
>  
>  	error = xlog_finish_defer_ops(log->l_mp, &capture_list);
>  	if (error)
>  		goto err;
>  
>  	return 0;
>  err:
>  	xlog_abort_defer_ops(log->l_mp, &capture_list);
>  	return error;
>  }
>  
>  /*
>   * A cancel occurs when the mount has failed and we're bailing out.  Release all
>   * pending log intent items that we haven't started recovery on so they don't
>   * pin the AIL.
>   */
>  STATIC void
>  xlog_recover_cancel_intents(
> -	struct xlog		*log)
> +	struct xlog			*log)
>  {
> -	struct xfs_log_item	*lip;
> -	struct xfs_ail_cursor	cur;
> -	struct xfs_ail		*ailp;
> -
> -	ailp = log->l_ailp;
> -	spin_lock(&ailp->ail_lock);
> -	lip = xfs_trans_ail_cursor_first(ailp, &cur, 0);
> -	while (lip != NULL) {
> -		if (!xlog_item_is_intent(lip))
> -			break;
> +	struct xfs_defer_pending	*dfp, *n;
>  
> -		spin_unlock(&ailp->ail_lock);
> -		lip->li_ops->iop_release(lip);
> -		spin_lock(&ailp->ail_lock);
> -		lip = xfs_trans_ail_cursor_next(ailp, &cur);
> -	}
> +	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
> +		ASSERT(xlog_item_is_intent(dfp->dfp_intent));
>  
> -	xfs_trans_ail_cursor_done(&cur);
> -	spin_unlock(&ailp->ail_lock);
> +		xfs_defer_cancel_recovery(log->l_mp, dfp);
> +	}
>  }
>  
>  /*
>   * This routine performs a transaction to null out a bad inode pointer
>   * in an agi unlinked inode hash bucket.
> diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
> index dfd7b824e32b..1e047107d2f2 100644
> --- a/fs/xfs/xfs_refcount_item.c
> +++ b/fs/xfs/xfs_refcount_item.c
> @@ -666,16 +666,13 @@ xlog_recover_cui_commit_pass2(
>  	}
>  
>  	cuip = xfs_cui_init(mp, cui_formatp->cui_nextents);
>  	xfs_cui_copy_format(&cuip->cui_format, cui_formatp);
>  	atomic_set(&cuip->cui_next_extent, cui_formatp->cui_nextents);
> -	/*
> -	 * Insert the intent into the AIL directly and drop one reference so
> -	 * that finishing or canceling the work will drop the other.
> -	 */
> -	xfs_trans_ail_insert(log->l_ailp, &cuip->cui_item, lsn);
> -	xfs_cui_release(cuip);
> +
> +	xlog_recover_intent_item(log, &cuip->cui_item, lsn,
> +			XFS_DEFER_OPS_TYPE_REFCOUNT);
>  	return 0;
>  }
>  
>  const struct xlog_recover_item_ops xlog_cui_item_ops = {
>  	.item_type		= XFS_LI_CUI,
> diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
> index 2043cea261c0..12ae8ab6a69d 100644
> --- a/fs/xfs/xfs_rmap_item.c
> +++ b/fs/xfs/xfs_rmap_item.c
> @@ -680,16 +680,13 @@ xlog_recover_rui_commit_pass2(
>  	}
>  
>  	ruip = xfs_rui_init(mp, rui_formatp->rui_nextents);
>  	xfs_rui_copy_format(&ruip->rui_format, rui_formatp);
>  	atomic_set(&ruip->rui_next_extent, rui_formatp->rui_nextents);
> -	/*
> -	 * Insert the intent into the AIL directly and drop one reference so
> -	 * that finishing or canceling the work will drop the other.
> -	 */
> -	xfs_trans_ail_insert(log->l_ailp, &ruip->rui_item, lsn);
> -	xfs_rui_release(ruip);
> +
> +	xlog_recover_intent_item(log, &ruip->rui_item, lsn,
> +			XFS_DEFER_OPS_TYPE_RMAP);
>  	return 0;
>  }
>  
>  const struct xlog_recover_item_ops xlog_rui_item_ops = {
>  	.item_type		= XFS_LI_RUI,
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog

