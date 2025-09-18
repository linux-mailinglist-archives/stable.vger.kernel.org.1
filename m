Return-Path: <stable+bounces-175314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9ECB367AF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A521BC499D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABF350D7B;
	Tue, 26 Aug 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TX6cjek7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8E34F496;
	Tue, 26 Aug 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216708; cv=none; b=kWWqhyBIGiO/zsS8ezggkRNOi2d7EWnisyndyQ/S9aoWPGBo7zwOTTcbQJkwb16p/ERrSXD7eArVSIOsizHSc1ucv+Dx3Xay8XMg7tlY1IHqlf4bgboX9owoUobK6QyjE/5WBFzCn/sk01XHxO5MM+RUdOx8Jq2MBhv7cergzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216708; c=relaxed/simple;
	bh=WVKx/qrpa4qFcn6TgYN8TPzOPiD+RML8DqKkjvA+qtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGraTa9BcEf6H7GOLleI87imWEnkXG9VZG1tLVznltrLvR9WdgjeOp0709dNdisT33ISAi15tDrC1NQF503vz1WHVSU9nT8HAqqPl3CnC2j0abJgjPpOh7lgJojJMJ6bVuYWjouYuMFRT6PE7/lpPe9yKLAIwOeN1AOy93JudlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TX6cjek7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F194DC4CEF1;
	Tue, 26 Aug 2025 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216708;
	bh=WVKx/qrpa4qFcn6TgYN8TPzOPiD+RML8DqKkjvA+qtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TX6cjek7vJ4hBswKQE75xoCQLmNhG9aDalNDw5TRlT/hu4n+8n/ahesMs3XCRO8NU
	 k+V/JWSDwFOaQvxWLyJn2qpKpOviCF11sEPz9cp3fUsVF++jy5fl4OvrGbnWcGkJjl
	 39LyaSWysAor5udeEr5rABU0dOI+s+nQl3O/JMI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cc448dcdc7ae0b4e4ffa@syzkaller.appspotmail.com,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 514/644] f2fs: fix to do sanity check on ino and xnid
Date: Tue, 26 Aug 2025 13:10:05 +0200
Message-ID: <20250826110959.242116635@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -226,6 +226,13 @@ static bool sanity_check_inode(struct in
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



