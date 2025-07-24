Return-Path: <stable+bounces-164650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D5B11037
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9222AA8137
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929452E9EBA;
	Thu, 24 Jul 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl+Tsc4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA3285045
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376961; cv=none; b=ml64M2CSD7Gt4Om200Zs9VdkkgItpesG2jQTn2sxVV8GP5sJGnBv4BHvIY7kZeqPMJF6s63AE29wbjxnYEmk7z/9xGj2N4A1cPfI+h53ZclH958OP3wdD11mELT+AxwDSdKRndXTvtLQzUdk3rmNz8GaKte1lLrywAG0xngxQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376961; c=relaxed/simple;
	bh=RSt2oSHPse4W34vy5iiQSfoBabZGKWbNT5nMkJFhT2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Imp2yJwNmICq5G1cXZx34/sxZ+WCnBdRLYi0NYHJL9LEr3hjLQmCk3Y7Ks5hVx+BlnGWfDyC8DlNMGpM3xq5Ottt0ki5p9RCiTaFPG0rNdw0yOIWFhyF/L3XP4yKRwTIGEf4gLVYX53dHPsYZ9mdXMIecco7gA0lvuHCtL3jdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl+Tsc4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1986C4CEED;
	Thu, 24 Jul 2025 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376960;
	bh=RSt2oSHPse4W34vy5iiQSfoBabZGKWbNT5nMkJFhT2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hl+Tsc4b0GBot5+6KyN2DH0pVmzN3XTVJ9nFefVyB+0O9g329+F5HtnFn9PohLiyv
	 YXFtkG3FFYfIuvKZjIA0HtqDVcZV6+gIrg+5nRkyDa9YMuXgeLiiwr9QSvC6W1bYKp
	 L24Pc+WNU6vNrE+0zdcmjMDqgTsOssa8AKMiHxik63sn9VWRnmXdXjwCiLqr/sQJx1
	 q3GpNDJKEDYwQZ5k4k99a9k3mL5ENT13MOCI/a7lHN0sXx/4UJmtXPCgiq9y8SvUAH
	 7znJgp6hXwsXi3JcwsQ3rAUSDuRZuR2JrRO4yI5a3QakpbJ7LXH/RWt4Zyt4ccV1I0
	 NeUuk9ZWODmXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	syzbot+cc448dcdc7ae0b4e4ffa@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to do sanity check on ino and xnid
Date: Thu, 24 Jul 2025 13:09:12 -0400
Message-Id: <20250724170912.1405261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062012-stride-reliance-60ad@gregkh>
References: <2025062012-stride-reliance-60ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 061cf3a84bde038708eb0f1d065b31b7c2456533 ]

syzbot reported a f2fs bug as below:

INFO: task syz-executor140:5308 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc7-syzkaller-00069-g81e4f8d68c66 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor140 state:D stack:24016 pid:5308  tgid:5308  ppid:5306   task_flags:0x400140 flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 io_schedule+0x8d/0x110 kernel/sched/core.c:7690
 folio_wait_bit_common+0x839/0xee0 mm/filemap.c:1317
 __folio_lock mm/filemap.c:1664 [inline]
 folio_lock include/linux/pagemap.h:1163 [inline]
 __filemap_get_folio+0x147/0xb40 mm/filemap.c:1917
 pagecache_get_page+0x2c/0x130 mm/folio-compat.c:87
 find_get_page_flags include/linux/pagemap.h:842 [inline]
 f2fs_grab_cache_page+0x2b/0x320 fs/f2fs/f2fs.h:2776
 __get_node_page+0x131/0x11b0 fs/f2fs/node.c:1463
 read_xattr_block+0xfb/0x190 fs/f2fs/xattr.c:306
 lookup_all_xattrs fs/f2fs/xattr.c:355 [inline]
 f2fs_getxattr+0x676/0xf70 fs/f2fs/xattr.c:533
 __f2fs_get_acl+0x52/0x870 fs/f2fs/acl.c:179
 f2fs_acl_create fs/f2fs/acl.c:375 [inline]
 f2fs_init_acl+0xd7/0x9b0 fs/f2fs/acl.c:418
 f2fs_init_inode_metadata+0xa0f/0x1050 fs/f2fs/dir.c:539
 f2fs_add_inline_entry+0x448/0x860 fs/f2fs/inline.c:666
 f2fs_add_dentry+0xba/0x1e0 fs/f2fs/dir.c:765
 f2fs_do_add_link+0x28c/0x3a0 fs/f2fs/dir.c:808
 f2fs_add_link fs/f2fs/f2fs.h:3616 [inline]
 f2fs_mknod+0x2e8/0x5b0 fs/f2fs/namei.c:766
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4191
 unix_bind_bsd net/unix/af_unix.c:1286 [inline]
 unix_bind+0x563/0xe30 net/unix/af_unix.c:1379
 __sys_bind_socket net/socket.c:1817 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1848
 __do_sys_bind net/socket.c:1853 [inline]
 __se_sys_bind net/socket.c:1851 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1851
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Let's dump and check metadata of corrupted inode, it shows its xattr_nid
is the same to its i_ino.

dump.f2fs -i 3 chaseyu.img.raw
i_xattr_nid                             [0x       3 : 3]

So that, during mknod in the corrupted directory, it tries to get and
lock inode page twice, result in deadlock.

- f2fs_mknod
 - f2fs_add_inline_entry
  - f2fs_get_inode_page --- lock dir's inode page
   - f2fs_init_acl
    - f2fs_acl_create(dir,..)
     - __f2fs_get_acl
      - f2fs_getxattr
       - lookup_all_xattrs
        - __get_node_page --- try to lock dir's inode page

In order to fix this, let's add sanity check on ino and xnid.

Cc: stable@vger.kernel.org
Reported-by: syzbot+cc448dcdc7ae0b4e4ffa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/67e06150.050a0220.21942d.0005.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ add set_sbi_flag(sbi, SBI_NEED_FSCK) to match error handling pattern ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b8296b0414fcb..2ae95bf4162e0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -210,6 +210,13 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (ino_of_node(node_page) == fi->i_xattr_nid) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx, xnid=%x, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	if (f2fs_sb_has_flexible_inline_xattr(sbi)
 			&& !f2fs_has_extra_attr(inode)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-- 
2.39.5


