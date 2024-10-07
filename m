Return-Path: <stable+bounces-81247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56510992963
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784AB1C21AE1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C31C7612;
	Mon,  7 Oct 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="z6mkKfPj"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0918B476;
	Mon,  7 Oct 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297702; cv=none; b=EePTx0LVbKLlaPdmx+V+GXWuKuFdRJUd0aiz/WiesFVLsTDec70Kyi+6umob8ZN/9RwaMgTBkdP82UBXUUJrK271MVwfnIz9Jwk1vnAkT8U51+x6WB14SvYxDC6uDPCRnVXpFnY/BKUuwvg4U5YauYPfUMU6CoNFpdVqYlPadic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297702; c=relaxed/simple;
	bh=QxaVEo5A9Y2RssgtYEL8gXds9d2bIsw3wC5U/k/1fJQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Yweb7ZwLlmXaU6mvuAZ26mmcwXDXZi3tOQeTpcix05EQmLDjRaL0T2RpJcIPAYnHUlJGrlTNDEACK6bdKuihsko78yUIJth9SnXJP6IOutVCDeqvKh6e/U2uR/NL8c0m3DY5jLkPBm8kB16SYuObrRQifmGjH/gdp+cjw51ApDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=z6mkKfPj; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728297697; bh=9WJ4iJybXHKEXZQYtZKAjgdmtQZ0zUlN2+q5FDhUyP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z6mkKfPj5Vy71dGbr+a3/j906hSpu6nvYvgNgnVtbtfsTZxdXwDdjYV3WBx6umYKB
	 DSgirVRwyxjGawmJM9gf+huQJVwJALzCO/zw3T1GrJI5ouB96hsXQoQ7RcERwxIDmx
	 LXV5j53uBHr49ttSwAFE4jrt5qENybffk8/PuuSk=
Received: from localhost.localdomain ([27.38.127.250])
	by newxmesmtplogicsvrszgpua4-0.qq.com (NewEsmtp) with SMTP
	id 8D93AC05; Mon, 07 Oct 2024 18:35:25 +0800
X-QQ-mid: xmsmtpt1728297325tgf37fc5u
Message-ID: <tencent_E99A2AFA707C7CDC7BDBC175C6AE5B94A70A@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfD+bEfWDkkoSPmOrrbzjDmhhIMN6fv/nwEXm6YouH1slhLxCT4t
	 aaapDZGCNC1ZZmUHi/au0LHX4JFIRLfFk2CpaEdB5uXKqHKufHAadSWHS36utzR01wuF+/Pd4yxt
	 X8HTIZNO/spz1hXQcOTOazOfCfoPLflmW5C/u4VZwt+J6dV2snauakZbg58lUgXVXzVMIXlSV+Yv
	 bc1kQATud6TVGV3r2lY+Iwdfae4yMgn/VntX5I6sw58Q5PgMzfL2o/lnrRn3gB5swmaZH9XxZEo3
	 BXZmALaIFFzJVuXFnwbmJ4HLOhQXORGECo/lFcIQiQPO1iOpqQ6cb9L1jUnoUbOiyKwFqsmwSfid
	 hdAoFq7YkMSfhIb0Su0tYxcuPyjvdkLAQLWcVyHQtusJW5Jwkf9bC8U2PxHZJXiXptqNzVIXiNxg
	 Hk120uuxHrrg+xIOs0glJILEdaTPUr/mvbUlTwQDlPtscjwc63Wo6EOQQTgZ4KJbVKeHlsm1KJL4
	 X4wxZNWSCTCB2aPEVhDoZeUYHF2mFRopCrnaHLa7WV5O61ssARRj323IH0b25fMKqaCPJl5aI6my
	 tP3XSmqt2QjK8cf4qU5WyTItRvF9PX9tROV5ccQEDBkIs3/rkx0vgujRoyqh7VYB9MMyv/cAuB5F
	 QN05vWqdVhHB/mcSCR9coym+RZk+CwqRbA7CTZtqlTobLweXY7oPo+6eyplhXhKG26X9wpTIXx/R
	 IYIPPCXUOZJ/PBp3LyaEjzXB/ImPMRPrIgMDsNlFtXpKBhG2NQPzzO0d4jPjkzbhcp6dxDqWs0PP
	 FIaCs51svarPTLugCjp2eaIhJ+LKIhs+nsisIAoIgCvJR9C4DEzMJcJMt3Cci4Php6+QO4anizks
	 vksBpuVXEAxWAIko3qtpF073cDYzp9J0lNXCKdeDxogPGoHxCwLFJaUr5hme1NIvbqWaGBN2+/A6
	 dcP/Z6qD3DCUSaUHAheGlC2VRQrUoZEZBN8QIcLnSQtN3ycgjwC13Vv7cFhFlwchjNgdO4YPJY8i
	 wkEj4gdg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Li XingYang <lixingyang1@qq.com>
To: gregkh@linuxfoundation.org,
	gpiccoli@igalia.com,
	kees@kernel.org,
	tony.luck@intel.com
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lixingyang1@qq.com,
	zachwade.k@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] pstore: Fix uaf when backend is unregistered
Date: Mon,  7 Oct 2024 18:34:06 +0800
X-OQ-MSGID: <20241007103406.52703-1-lixingyang1@qq.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024093032-creamer-backhand-57bb@gregkh>
References: <2024093032-creamer-backhand-57bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when unload pstore_blk, we will unlink the pstore file and
set pos->dentry to NULL, but simple_unlink(d_inode(root), pos->dentry)
may free inode of pos->dentry and free pos by free_pstore_private,
this may trigger uaf. kasan report:

kernel: ==================================================================
kernel: BUG: KASAN: slab-use-after-free in pstore_put_backend_records+0x3a4/0x480
kernel: Write of size 8 at addr ffff8883efbe0390 by task modprobe/4308
kernel:
kernel: CPU: 1 PID: 4308 Comm: modprobe Kdump: loaded Not tainted 6.10.9-arch1-2 #2 5fd36c90225554e2cc88363729bd91e76130a89f
kernel: Hardware name: ASUS System Product Name/TUF GAMING X670E-PLUS, BIOS 3024 08/02/2024
kernel: Call Trace:
kernel:  <TASK>
kernel:  dump_stack_lvl+0x5d/0x80
kernel:  print_report+0x174/0x505
kernel:  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
kernel:  ? pstore_put_backend_records+0x3a4/0x480
kernel:  kasan_report+0xd0/0x150
kernel:  ? pstore_put_backend_records+0x3a4/0x480
kernel:  pstore_put_backend_records+0x3a4/0x480
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  pstore_unregister+0x88/0x1b0
kernel:  unregister_pstore_zone+0x2f/0xd0 [pstore_zone 35171c701a99c31efe207b7a718dc583e4a6503a]
kernel:  pstore_blk_exit+0x30/0x90 [pstore_blk 589d82101219208d8968e3adda9b96a2d42df635]
kernel:  __do_sys_delete_module+0x350/0x560
kernel:  ? __pfx___do_sys_delete_module+0x10/0x10
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __memcg_slab_free_hook+0x28e/0x470
kernel:  ? __pfx___audit_syscall_exit+0x10/0x10
kernel:  do_syscall_64+0x82/0x190
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? seq_read_iter+0x62f/0x1220
kernel:  ? __x64_sys_openat+0x300/0x380
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? kasan_save_track+0x14/0x30
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? vfs_read+0x9a7/0xf00
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __audit_syscall_exit+0x38a/0x520
kernel:  ? __pfx_vfs_read+0x10/0x10
kernel:  ? __pfx___audit_syscall_exit+0x10/0x10
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __audit_syscall_exit+0x38a/0x520
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx___audit_syscall_exit+0x10/0x10
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __x64_sys_read+0x162/0x250
kernel:  ? __pfx___x64_sys_read+0x10/0x10
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? syscall_exit_to_user_mode_prepare+0x148/0x170
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? syscall_exit_to_user_mode+0x73/0x1f0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? syscall_exit_to_user_mode+0x73/0x1f0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: RIP: 0033:0x741f9d72946b
kernel: Code: 73 01 c3 48 8b 0d a5 c8 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 c8 0c 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007ffed7e621f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
kernel: RAX: ffffffffffffffda RBX: 00006455e060ed30 RCX: 0000741f9d72946b
kernel: RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00006455e060ed98
kernel: RBP: 00007ffed7e62220 R08: 1999999999999999 R09: 0000000000000000
kernel: R10: 0000741f9d7a5fe0 R11: 0000000000000206 R12: 0000000000000000
kernel: R13: 00007ffed7e62250 R14: 0000000000000000 R15: 0000000000000000
kernel:  </TASK>
kernel:
kernel: Allocated by task 3957:
kernel:  kasan_save_stack+0x30/0x50
kernel:  kasan_save_track+0x14/0x30
kernel:  __kasan_kmalloc+0xaa/0xb0
kernel:  pstore_mkfile+0x47e/0xbe0
kernel:  pstore_get_backend_records+0x560/0x920
kernel:  pstore_get_records+0xec/0x180
kernel:  pstore_register+0x1c3/0x5a0
kernel:  register_pstore_zone.cold+0x298/0x3d1 [pstore_zone]
kernel:  pstore_blk_init+0x63c/0xff0 [pstore_blk]
kernel:  do_one_initcall+0xa4/0x380
kernel:  do_init_module+0x28a/0x7c0
kernel:  load_module+0x7b57/0xb020
kernel:  init_module_from_file+0xdf/0x150
kernel:  idempotent_init_module+0x23c/0x780
kernel:  __x64_sys_finit_module+0xbe/0x130
kernel:  do_syscall_64+0x82/0x190
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel:
kernel: Freed by task 4308:
kernel:  kasan_save_stack+0x30/0x50
kernel:  kasan_save_track+0x14/0x30
kernel:  kasan_save_free_info+0x3b/0x60
kernel:  __kasan_slab_free+0x12c/0x1b0
kernel:  kfree+0x198/0x3b0
kernel:  evict+0x33d/0xab0
kernel:  __dentry_kill+0x17f/0x590
kernel:  dput+0x2d9/0x810
kernel:  simple_unlink+0xf4/0x140
kernel:  pstore_put_backend_records+0x271/0x480
kernel:  pstore_unregister+0x88/0x1b0
kernel:  unregister_pstore_zone+0x2f/0xd0 [pstore_zone]
kernel:  pstore_blk_exit+0x30/0x90 [pstore_blk]
kernel:  __do_sys_delete_module+0x350/0x560
kernel:  do_syscall_64+0x82/0x190
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel:
kernel: The buggy address belongs to the object at ffff8883efbe0380
                                    which belongs to the cache kmalloc-64 of size 64
kernel: The buggy address is located 16 bytes inside of
                                    freed 64-byte region [ffff8883efbe0380, ffff8883efbe03c0)
kernel:
kernel: The buggy address belongs to the physical page:
kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3efbe0
kernel: memcg:ffff8883ef245801
kernel: flags: 0x2ffff8000000000(node=0|zone=2|lastcpupid=0x1ffff)
kernel: page_type: 0xffffefff(slab)
kernel: raw: 02ffff8000000000 ffff88810004c8c0 ffffea00043dcc40 dead000000000004
kernel: raw: 0000000000000000 0000000000200020 00000001ffffefff ffff8883ef245801
kernel: page dumped because: kasan: bad access detected
kernel:
kernel: Memory state around the buggy address:
kernel:  ffff8883efbe0280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:  ffff8883efbe0300: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
kernel: >ffff8883efbe0380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:                          ^
kernel:  ffff8883efbe0400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:  ffff8883efbe0480: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
kernel: ==================================================================
kernel: Disabling lock debugging due to kernel taint
kernel: pstore: Unregistered pstore_blk as persistent store backend
kernel: ------------[ cut here ]------------

place the pos->dentry = NULL before simple_unlink(d_inode(root), pos->dentry)

Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is unregistered")
Cc: <stable@vger.kernel.org> # v5.8+
Signed-off-by: Li XingYang <lixingyang1@qq.com>
Signed-off-by: Zach Wade <zachwade.k@gmail.com>
---
 fs/pstore/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 56815799ce79..7561693e0f32 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -306,7 +306,7 @@ static struct dentry *psinfo_lock_root(void)
 int pstore_put_backend_records(struct pstore_info *psi)
 {
 	struct pstore_private *pos, *tmp;
-	struct dentry *root;
+	struct dentry *root, *unlink_dentry;
 
 	root = psinfo_lock_root();
 	if (!root)
@@ -316,9 +316,10 @@ int pstore_put_backend_records(struct pstore_info *psi)
 		list_for_each_entry_safe(pos, tmp, &records_list, list) {
 			if (pos->record->psi == psi) {
 				list_del_init(&pos->list);
-				d_invalidate(pos->dentry);
-				simple_unlink(d_inode(root), pos->dentry);
+				unlink_dentry = pos->dentry;
 				pos->dentry = NULL;
+				d_invalidate(unlink_dentry);
+				simple_unlink(d_inode(root), unlink_dentry);
 			}
 		}
 	}
-- 
2.46.2


