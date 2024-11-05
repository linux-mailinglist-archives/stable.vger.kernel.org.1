Return-Path: <stable+bounces-89875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC69BD277
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C272845CD
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C51DD0CF;
	Tue,  5 Nov 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqfdZRpe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60001DD0C2
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824573; cv=none; b=TJ2uLbKW8PDIz05/dG5jTQNG9DlFv/rTcIxHEEa1tGg47y0291hS7NAWDLeuKgJoEjr6CjLXs+76CIN/pgPLGJzDAQ1Gd3aFIK62sfiybJ8YtUigAzWAoLe6OJg3ULTZW7G6gZOHA8LBNi+e9FJZ6XbvdDrOJfn+T5D884iaRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824573; c=relaxed/simple;
	bh=Td+mDJrnjRjR6Ncn0nS8rC4+ZqHM8lf6kQpzpaj1pQo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Li5sZxYYpajuQ/4i4aqHdKJFhGJWXbfEYJ+SRw2P+fPIpbBgsrR0UFtI9fO7K0oZQRxs9xd84LDzBU6CJQZ0tFDUhIgmJLfdsf/TiaqLcBq9q9Vtad6uREKWTFk445Y2NSK+uybhIeBqooC6l5jOBNKuGaZF0QR/1p+jgE1IqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqfdZRpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F105C4CECF;
	Tue,  5 Nov 2024 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824572;
	bh=Td+mDJrnjRjR6Ncn0nS8rC4+ZqHM8lf6kQpzpaj1pQo=;
	h=Subject:To:Cc:From:Date:From;
	b=MqfdZRpewStZWQvIIU79kB8Dz7IaXf3WyJwM68vPMj7L1huEAyGeBugfAZMQ0IvsQ
	 zBHeS/qSe/wX9UfsCP69qSmsPdiZSpYb1cnr6WQ35VoAp2sNNo68KyNTm22HYngite
	 FQelwjzIwaEtxPVDtnA6dGnX0DIS9msEKspfgk7c=
Subject: FAILED: patch "[PATCH] mm: shmem: fix data-race in shmem_getattr()" failed to apply to 5.10-stable tree
To: aha310510@gmail.com,akpm@linux-foundation.org,hughd@google.com,stable@vger.kernel.org,syzkaller@googlegroup.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:35:50 +0100
Message-ID: <2024110550-excretory-dig-7bda@gregkh>
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
git cherry-pick -x d949d1d14fa281ace388b1de978e8f2cd52875cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110550-excretory-dig-7bda@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d949d1d14fa281ace388b1de978e8f2cd52875cf Mon Sep 17 00:00:00 2001
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 9 Sep 2024 21:35:58 +0900
Subject: [PATCH] mm: shmem: fix data-race in shmem_getattr()

I got the following KCSAN report during syzbot testing:

==================================================================
BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current

write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
 inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
 inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
 shmem_mknod+0x117/0x180 mm/shmem.c:3443
 shmem_create+0x34/0x40 mm/shmem.c:3497
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0xdbc/0x1f00 fs/namei.c:3883
 do_filp_open+0xf7/0x200 fs/namei.c:3913
 do_sys_openat2+0xab/0x120 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1442
 x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
 inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
 inode_get_ctime include/linux/fs.h:1629 [inline]
 generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
 shmem_getattr+0x17b/0x200 mm/shmem.c:1157
 vfs_getattr_nosec fs/stat.c:166 [inline]
 vfs_getattr+0x19b/0x1e0 fs/stat.c:207
 vfs_statx_path fs/stat.c:251 [inline]
 vfs_statx+0x134/0x2f0 fs/stat.c:315
 vfs_fstatat+0xec/0x110 fs/stat.c:341
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
 x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x2755ae53 -> 0x27ee44d3

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================

When calling generic_fillattr(), if you don't hold read lock, data-race
will occur in inode member variables, which can cause unexpected
behavior.

Since there is no special protection when shmem_getattr() calls
generic_fillattr(), data-race occurs by functions such as shmem_unlink()
or shmem_mknod(). This can cause unexpected results, so commenting it out
is not enough.

Therefore, when calling generic_fillattr() from shmem_getattr(), it is
appropriate to protect the inode using inode_lock_shared() and
inode_unlock_shared() to prevent data-race.

Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gmail.com
Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Reported-by: syzbot <syzkaller@googlegroup.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/shmem.c b/mm/shmem.c
index c5adb987b23c..4ba1d00fabda 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1166,7 +1166,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+	inode_lock_shared(inode);
 	generic_fillattr(idmap, request_mask, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;


