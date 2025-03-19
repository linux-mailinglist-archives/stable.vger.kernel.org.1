Return-Path: <stable+bounces-125570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C92A69396
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049CE1B62720
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F01A4F0A;
	Wed, 19 Mar 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7DfWZFn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905779C0
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397511; cv=none; b=kais3pFKv90xCvJXQ/NF92x65CqyMfNG2uAfZJLfactaR/QSVTorYIVtVlIPZBYiqUxzH+SfODfhHG5L0V2MgEE2nVO9rt51R5d6n7Hb08zYlD20TNgG0hAO+S6WFcjiaLjNuGNptRECBJX1X6JUAciNCygPAbhKsoLfb5Aqnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397511; c=relaxed/simple;
	bh=YGN6QyJZDoLKP59uofopYEgz9BwA9ssqL8BmV64L+is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkbLtwHRZAr6wFutueALUe3aA3/LMOh0JGUDSHOsefw5zofagrjHs3FCS9GOzxB2z8UVY+9Wo0g/lDqPtbwnk9FJoKSBt2yuOzaSEFejv+jbAta3+PUsz4YaWuX6X/HFglpKkZG4TCet7B8598jVzhcsc/Jt3L0GHt9J9rx+k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7DfWZFn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22435603572so116261975ad.1
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742397509; x=1743002309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbUotu/vqP3GQt3KtfXx0aVQy44Yrf8ajQyjJ9TzOiQ=;
        b=Z7DfWZFnFPubAPS9d0+1FcrLaEAIYASC8F8NImAyh/XswCDxthC/f6g5Q6RthQQO54
         Q35jUCuL5HyW5NUAJWq94UBxZmlOw57GIoVyxHweOPN2FF2eZTqSEIdLoErXBnhDH4sI
         dwSz70KMkR3J/vOR51DUfMIs1qgUUrY4MFkU2SFk6o2QcwqdorRNwwjLW+jdMdKvxOhB
         2vgMNIbId3b1rvD8Q0mSRRDlMF0HCBydoCB1ON77jTceYsqJSFPS94Tu6ZpINXhlBYNk
         XZb3YJOd2KNb3G8JKMK6ZnGb6eZtRrKnGSWVtN0QRjwYJWw6CQ7lJnvrSKX/VxxOgwLo
         yRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397509; x=1743002309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbUotu/vqP3GQt3KtfXx0aVQy44Yrf8ajQyjJ9TzOiQ=;
        b=Vcm1FSX1hp7Dcq7jNmiF+FuzvwnMFf7j8Q78Ql/XLHvL4yrMDe5MRpz9rF3MT57qhJ
         uG4AIa4CM12wJg4/t5xrSLy40pmMGLtLm+6ppH84rzjOV1Rer6152gygcjk3VRpQixyx
         x6ECPL/nslLxtUIHAKRr4GGvU/rMSslLPF7EJ6MtchR+fCt23VLvjzhfML+AeHFnxUB7
         ZVyK61Vkq/xeGFLUNvpAil9ybECmjJNJmuQ12TMFSgxCsjcIXcvbIgUubXzKo8XBwyKd
         QsmqlmQXmCZd6SZ9RyKA+6XBl+PHqxt9H6kg0s7dMLS4rWX12fQMuEhi2rH/aPnrjgb/
         QvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRDGlsanMtinXj/dc8pMcE4sh2pFXzXppoR56n9Uo2h/up7DIK1eiMwJe+r4y+/SEpQYzCPlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWu1en6J4WEL7kfDxvz1WRodNHHcJF7esXzSyiSo+JdojR6UEu
	VGviU8cls6SjsuqG/1BfAc6ESt7/JSZxBVXNemAXD58gyup9R4hS
X-Gm-Gg: ASbGncunxlXPYGBtquhFWrN5oHlJn54H6JL4JC2FMArG89ZC2EZbRaucpMvwoYePiTK
	2RZsjPQJeLBt2RUeu2UZbqY4lThFFqGIWcLbQnliPfCOz/D9LyP8M1i7bohVckK4MmNslkIKRLs
	9tnAm+vI8bRl3ajp+aZnE+PTGDI3GJqkOPO3/MsPPyWnTqjK4w/T9tUoWkskr9WuYkv3dQq4wQT
	udTglESsIH+t7c5x4oV+lRSBH5S3KyMI/pBBx2fwEsWoF4W0vLkrrjv2QS2s+He0/AAxqzxFGUu
	AaErzcQ6yuqKpDj4m1ztfpuok1eJDZ5JKdNp+qFlMvptMBZkfQOBksuiCwFcomYlhPqqnvk=
X-Google-Smtp-Source: AGHT+IEUA6Q+FLwmUcRh73XSniFSmlfg9RRll42fjLmuYDTWubgAbWw+cxZoSpeb2Vphg3VV7Ked9w==
X-Received: by 2002:a05:6a00:c84:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-7376d6ff4e1mr5398849b3a.20.1742397508463;
        Wed, 19 Mar 2025 08:18:28 -0700 (PDT)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167dafasm11732774b3a.86.2025.03.19.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:18:27 -0700 (PDT)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: ayaanmirza788@gmail.com
Cc: Ye Bin <yebin10@huawei.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH 01/15] proc: fix UAF in proc_get_inode()
Date: Wed, 19 Mar 2025 20:48:04 +0530
Message-ID: <20250319151818.68140-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

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
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 fs/proc/generic.c       | 10 +++++++++-
 fs/proc/inode.c         |  6 +++---
 fs/proc/internal.h      | 14 ++++++++++++++
 include/linux/proc_fs.h |  7 +++++--
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8ec90826a49e..a3e22803cddf 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -559,10 +559,16 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
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
@@ -626,6 +632,7 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -656,6 +663,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 626ad7bd94f2..a3eb3b740f76 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -656,13 +656,13 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
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
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 1695509370b8..77a517f91821 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -85,6 +85,20 @@ static inline void pde_make_permanent(struct proc_dir_entry *pde)
 	pde->flags |= PROC_ENTRY_PERMANENT;
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
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0b2a89854440..ea62201c74c4 100644
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
-- 
2.48.1


