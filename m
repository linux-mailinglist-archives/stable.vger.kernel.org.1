Return-Path: <stable+bounces-129991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A2A8028F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DFE3AC8B6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A32266583;
	Tue,  8 Apr 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlCkkdeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE78263C78;
	Tue,  8 Apr 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112525; cv=none; b=shj9pP3BHRebAXuFnPqRlW1Q/RSjfMymQlwCT2DptQkCJjG1KJLQ5jQCDZq8/rxdstalovkijs2DSFOf63zFpMb41HXiTWGX1z72bw0AQErBiX1ckesXvYjJ3XZ4weGlqqxAwhGQgqtk77DumBE2Zgj6//Nc97HSj+FsI41XXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112525; c=relaxed/simple;
	bh=bnIYmwIZVWq0nsi7ConK3LYU8IZDwP+E0ZyholjEO3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIH9LA0JGqR+Z0HQA4+RzE9Bf6UDHYHdo+XoT6YxjUAWI1kEf21uJQJ8qFW+Q7ODdUY4035CP82+2H6nzDiKPtg7adIwURZknK7NLjk+kqDxFBQtM00DW1BBvtBkVCX/ZBH4NpI6o2hbNYp6KjcGe1reTxExqV4MAD7NEbHBji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlCkkdeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBE5C4CEE5;
	Tue,  8 Apr 2025 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112524;
	bh=bnIYmwIZVWq0nsi7ConK3LYU8IZDwP+E0ZyholjEO3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlCkkdebj+h54nyWb79VHK8pbaORncD7e4psUzhczJw02XV77MAvB7qJPengwMOHX
	 pUG/1f+tvDwCgAPWjAdbTE+Q+iS2erDa+iE7xwYsF5TEgB4xSoU1YqjfhuxoDCBgFU
	 KOo4p9wnJdDLHQLgHpBd/TJKG4xeZPd0a9Hgw5Vw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 100/279] proc: fix UAF in proc_get_inode()
Date: Tue,  8 Apr 2025 12:48:03 +0200
Message-ID: <20250408104829.049238327@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

From: Ye Bin <yebin10@huawei.com>

commit 654b33ada4ab5e926cd9c570196fefa7bec7c1df upstream.

Fix race between rmmod and /proc/XXX's inode instantiation.

The bug is that pde->proc_ops don't belong to /proc, it belongs to a
module, therefore dereferencing it after /proc entry has been registered
is a bug unless use_pde/unuse_pde() pair has been used.

use_pde/unuse_pde can be avoided (2 atomic ops!) because pde->proc_ops
never changes so information necessary for inode instantiation can be
saved _before_ proc_register() in PDE itself and used later, avoiding
pde->proc_ops->...  dereference.

      rmmod                         lookup
sys_delete_module
                         proc_lookup_de
			   pde_get(de);
			   proc_get_inode(dir->i_sb, de);
  mod->exit()
    proc_remove
      remove_proc_subtree
       proc_entry_rundown(de);
  free_module(mod);

                               if (S_ISREG(inode->i_mode))
	                         if (de->proc_ops->proc_read_iter)
                           --> As module is already freed, will trigger UAF

BUG: unable to handle page fault for address: fffffbfff80a702b
PGD 817fc4067 P4D 817fc4067 PUD 817fc0067 PMD 102ef4067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 26 UID: 0 PID: 2667 Comm: ls Tainted: G
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
RIP: 0010:proc_get_inode+0x302/0x6e0
RSP: 0018:ffff88811c837998 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffffc0538140 RCX: 0000000000000007
RDX: 1ffffffff80a702b RSI: 0000000000000001 RDI: ffffffffc0538158
RBP: ffff8881299a6000 R08: 0000000067bbe1e5 R09: 1ffff11023906f20
R10: ffffffffb560ca07 R11: ffffffffb2b43a58 R12: ffff888105bb78f0
R13: ffff888100518048 R14: ffff8881299a6004 R15: 0000000000000001
FS:  00007f95b9686840(0000) GS:ffff8883af100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff80a702b CR3: 0000000117dd2000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_lookup_de+0x11f/0x2e0
 __lookup_slow+0x188/0x350
 walk_component+0x2ab/0x4f0
 path_lookupat+0x120/0x660
 filename_lookup+0x1ce/0x560
 vfs_statx+0xac/0x150
 __do_sys_newstat+0x96/0x110
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

[adobriyan@gmail.com: don't do 2 atomic ops on the common path]
Link: https://lkml.kernel.org/r/3d25ded0-1739-447e-812b-e34da7990dcf@p183
Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David S. Miller <davem@davemloft.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/generic.c       |   10 +++++++++-
 fs/proc/inode.c         |    6 +++---
 fs/proc/internal.h      |   14 ++++++++++++++
 include/linux/proc_fs.h |    7 +++++--
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -558,10 +558,16 @@ struct proc_dir_entry *proc_create_reg(c
 	return p;
 }
 
-static inline void pde_set_flags(struct proc_dir_entry *pde)
+static void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (pde->proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (pde->proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
@@ -625,6 +631,7 @@ struct proc_dir_entry *proc_create_seq_p
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -655,6 +662,7 @@ struct proc_dir_entry *proc_create_singl
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -670,13 +670,13 @@ struct inode *proc_get_inode(struct supe
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-		if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_read_iter(de))
 			inode->i_fop = &proc_iter_file_ops;
 		else
 			inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (de->proc_ops->proc_compat_ioctl) {
-			if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_compat_ioctl(de)) {
+			if (pde_has_proc_read_iter(de))
 				inode->i_fop = &proc_iter_file_ops_compat;
 			else
 				inode->i_fop = &proc_reg_file_ops_compat;
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -79,6 +79,20 @@ static inline bool pde_is_permanent(cons
 	return pde->flags & PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_has_proc_read_iter(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_read_iter;
+}
+
+static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
+{
+#ifdef CONFIG_COMPAT
+	return pde->flags & PROC_ENTRY_proc_compat_ioctl;
+#else
+	return false;
+#endif
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,10 +20,13 @@ enum {
 	 * If in doubt, ignore this flag.
 	 */
 #ifdef MODULE
-	PROC_ENTRY_PERMANENT = 0U,
+	PROC_ENTRY_PERMANENT		= 0U,
 #else
-	PROC_ENTRY_PERMANENT = 1U << 0,
+	PROC_ENTRY_PERMANENT		= 1U << 0,
 #endif
+
+	PROC_ENTRY_proc_read_iter	= 1U << 1,
+	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
 };
 
 struct proc_ops {



