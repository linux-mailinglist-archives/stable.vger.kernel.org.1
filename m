Return-Path: <stable+bounces-148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E187F73EC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391AF1C20F73
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8E15AEB;
	Fri, 24 Nov 2023 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fynJPLWs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8728688
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A727C433CD;
	Fri, 24 Nov 2023 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700829515;
	bh=mws29iLFdF28shjNe/rg7r6xMJAE3p2dfELUjQYqpCk=;
	h=Subject:To:Cc:From:Date:From;
	b=fynJPLWs8toeEif2lPb9UdGxE3QDz7mtaNyNw0vSUJbDRkT8prTJoyIaEN8c+mpiG
	 XxDZ5XmP725Jbdj1TkYVgsW4ylZBTVK8WYImjBWFgcFavY0jEbbG8A7HggAdl38MjB
	 CQc4x7HcZxSXUGDR5jif0A8Qg7rp02UqnAKWp++Q=
Subject: FAILED: patch "[PATCH] f2fs: split initial and dynamic conditions for extent_cache" failed to apply to 6.1-stable tree
To: jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 12:38:24 +0000
Message-ID: <2023112424-pretended-ripple-b884@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f803982190f0265fd36cf84670aa6daefc2b0768
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112424-pretended-ripple-b884@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f803982190f0 ("f2fs: split initial and dynamic conditions for extent_cache")
8375be2b6414 ("f2fs: remove unnessary comment in __may_age_extent_tree")
71644dff4811 ("f2fs: add block_age-based extent cache")
72840cccc0a1 ("f2fs: allocate the extent_cache by default")
e7547daccd6a ("f2fs: refactor extent_cache to support for read and more")
749d543c0d45 ("f2fs: remove unnecessary __init_extent_tree")
3bac20a8f011 ("f2fs: move internal functions into extent_cache.c")
12607c1ba763 ("f2fs: specify extent cache for read explicitly")
8a47d228de6a ("f2fs: introduce discard_urgent_util sysfs node")
1cd2e6d54435 ("f2fs: define MIN_DISCARD_GRANULARITY macro")
66aee5aaa237 ("f2fs: change type for 'sbi->readdir_ra'")
777cd95b8066 ("f2fs: cleanup for 'f2fs_tuning_parameters' function")
b7ad23cec26a ("f2fs: fix to alloc_mode changed after remount on a small volume device")
a3951cd199a5 ("f2fs: introduce gc_mode sysfs node")
c46867e9b9b8 ("f2fs: introduce max_ordered_discard sysfs node")
b5f1a218ae5e ("f2fs: fix normal discard process")
3688cbe39b7a ("f2fs: remove batched_trim_sections node")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f803982190f0265fd36cf84670aa6daefc2b0768 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 7 Sep 2023 11:11:00 -0700
Subject: [PATCH] f2fs: split initial and dynamic conditions for extent_cache

Let's allocate the extent_cache tree without dynamic conditions to avoid a
missing condition causing a panic as below.

 # create a file w/ a compressed flag
 # disable the compression
 # panic while updating extent_cache

F2FS-fs (dm-64): Swapfile: last extent is not aligned to section
F2FS-fs (dm-64): Swapfile (3) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(2097152 * N)
Adding 124996k swap on ./swap-file.  Priority:0 extents:2 across:17179494468k
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write out/common/include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_try_cmpxchg_acquire out/common/include/asm-generic/atomic-instrumented.h:705 [inline]
BUG: KASAN: null-ptr-deref in queued_write_lock out/common/include/asm-generic/qrwlock.h:92 [inline]
BUG: KASAN: null-ptr-deref in __raw_write_lock out/common/include/linux/rwlock_api_smp.h:211 [inline]
BUG: KASAN: null-ptr-deref in _raw_write_lock+0x5a/0x110 out/common/kernel/locking/spinlock.c:295
Write of size 4 at addr 0000000000000030 by task syz-executor154/3327

CPU: 0 PID: 3327 Comm: syz-executor154 Tainted: G           O      5.10.185 #1
Hardware name: emulation qemu-x86/qemu-x86, BIOS 2023.01-21885-gb3cc1cd24d 01/01/2023
Call Trace:
 __dump_stack out/common/lib/dump_stack.c:77 [inline]
 dump_stack_lvl+0x17e/0x1c4 out/common/lib/dump_stack.c:118
 __kasan_report+0x16c/0x260 out/common/mm/kasan/report.c:415
 kasan_report+0x51/0x70 out/common/mm/kasan/report.c:428
 kasan_check_range+0x2f3/0x340 out/common/mm/kasan/generic.c:186
 __kasan_check_write+0x14/0x20 out/common/mm/kasan/shadow.c:37
 instrument_atomic_read_write out/common/include/linux/instrumented.h:101 [inline]
 atomic_try_cmpxchg_acquire out/common/include/asm-generic/atomic-instrumented.h:705 [inline]
 queued_write_lock out/common/include/asm-generic/qrwlock.h:92 [inline]
 __raw_write_lock out/common/include/linux/rwlock_api_smp.h:211 [inline]
 _raw_write_lock+0x5a/0x110 out/common/kernel/locking/spinlock.c:295
 __drop_extent_tree+0xdf/0x2f0 out/common/fs/f2fs/extent_cache.c:1155
 f2fs_drop_extent_tree+0x17/0x30 out/common/fs/f2fs/extent_cache.c:1172
 f2fs_insert_range out/common/fs/f2fs/file.c:1600 [inline]
 f2fs_fallocate+0x19fd/0x1f40 out/common/fs/f2fs/file.c:1764
 vfs_fallocate+0x514/0x9b0 out/common/fs/open.c:310
 ksys_fallocate out/common/fs/open.c:333 [inline]
 __do_sys_fallocate out/common/fs/open.c:341 [inline]
 __se_sys_fallocate out/common/fs/open.c:339 [inline]
 __x64_sys_fallocate+0xb8/0x100 out/common/fs/open.c:339
 do_syscall_64+0x35/0x50 out/common/arch/x86/entry/common.c:46

Cc: stable@vger.kernel.org
Fixes: 72840cccc0a1 ("f2fs: allocate the extent_cache by default")
Reported-and-tested-by: syzbot+d342e330a37b48c094b7@syzkaller.appspotmail.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0e2d49140c07..ad8dfac73bd4 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -74,40 +74,14 @@ static void __set_extent_info(struct extent_info *ei,
 	}
 }
 
-static bool __may_read_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, READ_EXTENT_CACHE))
-		return false;
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		return false;
-	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
-			 !f2fs_sb_has_readonly(sbi))
-		return false;
-	return S_ISREG(inode->i_mode);
-}
-
-static bool __may_age_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, AGE_EXTENT_CACHE))
-		return false;
-	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
-		return false;
-	if (file_is_cold(inode))
-		return false;
-
-	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
-}
-
 static bool __init_may_extent_tree(struct inode *inode, enum extent_type type)
 {
 	if (type == EX_READ)
-		return __may_read_extent_tree(inode);
-	else if (type == EX_BLOCK_AGE)
-		return __may_age_extent_tree(inode);
+		return test_opt(F2FS_I_SB(inode), READ_EXTENT_CACHE) &&
+			S_ISREG(inode->i_mode);
+	if (type == EX_BLOCK_AGE)
+		return test_opt(F2FS_I_SB(inode), AGE_EXTENT_CACHE) &&
+			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode));
 	return false;
 }
 
@@ -120,7 +94,22 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 	if (list_empty(&F2FS_I_SB(inode)->s_list))
 		return false;
 
-	return __init_may_extent_tree(inode, type);
+	if (!__init_may_extent_tree(inode, type))
+		return false;
+
+	if (type == EX_READ) {
+		if (is_inode_flag_set(inode, FI_NO_EXTENT))
+			return false;
+		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
+				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
+			return false;
+	} else if (type == EX_BLOCK_AGE) {
+		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
+			return false;
+		if (file_is_cold(inode))
+			return false;
+	}
+	return true;
 }
 
 static void __try_update_largest_extent(struct extent_tree *et,


