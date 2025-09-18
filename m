Return-Path: <stable+bounces-176766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FCB3D4E1
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 21:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71D7179D67
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B896271451;
	Sun, 31 Aug 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JM8QtpZ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF338DD3;
	Sun, 31 Aug 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668020; cv=none; b=ifM4NZle5mTQF+ZHxNqf0uOnn2sAc9LC6D1qB8gxVJButnolgbv0kJ43H5tyfPBIG5UmLC95oxbWoQIYX7lj2hoSIA32/DW9SyCnSqTir+X0qKfNWHrA0PNns4OWZwCpQLexWzxkh+pOAM8pBolgV7VxJJQsr1a0kopZDs/gqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668020; c=relaxed/simple;
	bh=NvoC5GTx7ZHJn9eVw1t2TLXwDdJn92yLIRqCL4w34U4=;
	h=Date:To:From:Subject:Message-Id; b=hkELPzrIkzpWOTSZx0wEgkza9p0N0E8RMYTWPRQVXi1GsocwfAQJr8suXwY9krkBR4KDCd9qT0QGboP4OP+tUE+O3c+dbvNG8IWP0aRmT3txIzdQgt5HqEzOkPtU7WtkFm31Oek0CMGs6mKC7zvrkZYG2FouK/rGXYo9aWLJoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JM8QtpZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BAEC4CEED;
	Sun, 31 Aug 2025 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756668018;
	bh=NvoC5GTx7ZHJn9eVw1t2TLXwDdJn92yLIRqCL4w34U4=;
	h=Date:To:From:Subject:From;
	b=JM8QtpZ/UHI752gS+MMr+fl2eyM/LUd1V+SStZASMzkfCZbwevoc0ghEgI6nFAFhj
	 2hSrXrA58tbTlejI/8QBTN68uOYBCmq4i6PFNPuqEin93XHIjUA3fTS/DM1oROglMa
	 u4ONZzJZly1H+jPvp8j0qpeD0/I9s8/AAVUgvTNw=
Date: Sun, 31 Aug 2025 12:20:17 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,gechangwei@live.cn,mark.tinguely@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-fix-recursive-semaphore-deadlock-in-fiemap-call.patch added to mm-hotfixes-unstable branch
Message-Id: <20250831192018.79BAEC4CEED@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: ocfs2: fix recursive semaphore deadlock in fiemap call
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     ocfs2-fix-recursive-semaphore-deadlock-in-fiemap-call.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-fix-recursive-semaphore-deadlock-in-fiemap-call.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Mark Tinguely <mark.tinguely@oracle.com>
Subject: ocfs2: fix recursive semaphore deadlock in fiemap call
Date: Fri, 29 Aug 2025 10:18:15 -0500

syzbot detected a OCFS2 hang due to a recursive semaphore on a
FS_IOC_FIEMAP of the extent list on a specially crafted mmap file.

context_switch kernel/sched/core.c:5357 [inline]
   __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
   __schedule_loop kernel/sched/core.c:7043 [inline]
   schedule+0x165/0x360 kernel/sched/core.c:7058
   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
   rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
   __down_write_common kernel/locking/rwsem.c:1317 [inline]
   __down_write kernel/locking/rwsem.c:1326 [inline]
   down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1591
   ocfs2_page_mkwrite+0x2ff/0xc40 fs/ocfs2/mmap.c:142
   do_page_mkwrite+0x14d/0x310 mm/memory.c:3361
   wp_page_shared mm/memory.c:3762 [inline]
   do_wp_page+0x268d/0x5800 mm/memory.c:3981
   handle_pte_fault mm/memory.c:6068 [inline]
   __handle_mm_fault+0x1033/0x5440 mm/memory.c:6195
   handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
   do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
   handle_page_fault arch/x86/mm/fault.c:1476 [inline]
   exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
RIP: 0010:raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
RIP: 0010:_inline_copy_to_user include/linux/uaccess.h:197 [inline]
RIP: 0010:_copy_to_user+0x85/0xb0 lib/usercopy.c:26
Code: e8 00 bc f7 fc 4d 39 fc 72 3d 4d 39 ec 77 38 e8 91 b9 f7 fc 4c 89
f7 89 de e8 47 25 5b fd 0f 01 cb 4c 89 ff 48 89 d9 4c 89 f6 <f3> a4 0f
1f 00 48 89 cb 0f 01 ca 48 89 d8 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000403f950 EFLAGS: 00050256
RAX: ffffffff84c7f101 RBX: 0000000000000038 RCX: 0000000000000038
RDX: 0000000000000000 RSI: ffffc9000403f9e0 RDI: 0000200000000060
RBP: ffffc9000403fa90 R08: ffffc9000403fa17 R09: 1ffff92000807f42
R10: dffffc0000000000 R11: fffff52000807f43 R12: 0000200000000098
R13: 00007ffffffff000 R14: ffffc9000403f9e0 R15: 0000200000000060
   copy_to_user include/linux/uaccess.h:225 [inline]
   fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
   ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
   ioctl_fiemap fs/ioctl.c:220 [inline]
   do_vfs_ioctl+0x1173/0x1430 fs/ioctl.c:532
   __do_sys_ioctl fs/ioctl.c:596 [inline]
   __se_sys_ioctl+0x82/0x170 fs/ioctl.c:584
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f13850fd9
RSP: 002b:00007ffe3b3518b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f5f13850fd9
RDX: 0000200000000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 6165627472616568 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3b3518f0
R13: 00007ffe3b351b18 R14: 431bde82d7b634db R15: 00007f5f1389a03b

ocfs2_fiemap() takes a read lock of the ip_alloc_sem semaphore (since
v2.6.22-527-g7307de80510a) and calls fiemap_fill_next_extent() to read the
extent list of this running mmap executable.  The user supplied buffer to
hold the fiemap information page faults calling ocfs2_page_mkwrite() which
will take a write lock (since v2.6.27-38-g00dc417fa3e7) of the same
semaphore.  This recursive semaphore will hold filesystem locks and causes
a hang of the fileystem.

The ip_alloc_sem protects the inode extent list and size.  Release the
read semphore before calling fiemap_fill_next_extent() in ocfs2_fiemap()
and ocfs2_fiemap_inline().  This does an unnecessary semaphore lock/unlock
on the last extent but simplifies the error path.

Link: https://lkml.kernel.org/r/61d1a62b-2631-4f12-81e2-cd689914360b@oracle.com
Fixes: 00dc417fa3e7 ("ocfs2: fiemap support")
Signed-off-by: Mark Tinguely <mark.tinguely@oracle.com>
Reported-by: syzbot+541dcc6ee768f77103e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=541dcc6ee768f77103e7
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/extent_map.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/ocfs2/extent_map.c~ocfs2-fix-recursive-semaphore-deadlock-in-fiemap-call
+++ a/fs/ocfs2/extent_map.c
@@ -706,6 +706,8 @@ out:
  * it not only handles the fiemap for inlined files, but also deals
  * with the fast symlink, cause they have no difference for extent
  * mapping per se.
+ *
+ * Must be called with ip_alloc_sem semaphore held.
  */
 static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 			       struct fiemap_extent_info *fieinfo,
@@ -717,6 +719,7 @@ static int ocfs2_fiemap_inline(struct in
 	u64 phys;
 	u32 flags = FIEMAP_EXTENT_DATA_INLINE|FIEMAP_EXTENT_LAST;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
+	lockdep_assert_held_read(&oi->ip_alloc_sem);
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 	if (ocfs2_inode_is_fast_symlink(inode))
@@ -732,8 +735,11 @@ static int ocfs2_fiemap_inline(struct in
 			phys += offsetof(struct ocfs2_dinode,
 					 id2.i_data.id_data);
 
+		/* Release the ip_alloc_sem to prevent deadlock on page fault */
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, 0, phys, id_count,
 					      flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret < 0)
 			return ret;
 	}
@@ -802,9 +808,11 @@ int ocfs2_fiemap(struct inode *inode, st
 		len_bytes = (u64)le16_to_cpu(rec.e_leaf_clusters) << osb->s_clustersize_bits;
 		phys_bytes = le64_to_cpu(rec.e_blkno) << osb->sb->s_blocksize_bits;
 		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
-
+		/* Release the ip_alloc_sem to prevent deadlock on page fault */
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
 					      len_bytes, fe_flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret)
 			break;
 
_

Patches currently in -mm which might be from mark.tinguely@oracle.com are

ocfs2-fix-recursive-semaphore-deadlock-in-fiemap-call.patch


