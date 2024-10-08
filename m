Return-Path: <stable+bounces-83079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D13995555
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082E8B248FA
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678E1E0E1A;
	Tue,  8 Oct 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqbc2nGm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601037708;
	Tue,  8 Oct 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407421; cv=none; b=LNJZVKhErq/2YxbeLsd94/SHveXSzA65/8L1SoVSAWb2rNatUnDWJ/19nC1zYvxFtpkf4LMAONMdnwf2RJyWtw5IXwY2T4KZ2yWsJrL1mE0P2a3n6gkP4k3+2CwFzx59CPpf9RGIHbv1btiF83ADVq/95w7KnPRg8F2csloEGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407421; c=relaxed/simple;
	bh=gdH4XgRpQ/LMrtbkxnnlhvvbmok3mKxFI0o64TpuFiA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j53JEzJjiD44N0fgtrIYQmrwcAnhRX0Kfy2sBUPbUCgOUm5A0r5XhcSyftmgaCzCRuCtGa0h86z2yZ2GQv8EpxW1b/NZ0RPIJREMPb6mL+e5SnqpJZR9w/VzYmUqysFKxztrhviM8Lyd9/GJpicJTWmPVwmsof6LGvmnu9y3b2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqbc2nGm; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71dfe07489dso2135448b3a.3;
        Tue, 08 Oct 2024 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728407419; x=1729012219; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wquzKmnrqJJ5kPwwZNxPYzxEXUmApBUbr8OYSpfIYE=;
        b=eqbc2nGmwznG5BYBfYITvA/9UC5DjTYcq366bLqLXbMqlfrloZXH6j9MR4CtTFNgRQ
         HHaFQxAn7vCZE2s4VZ1BlEzqsiVCK9vTAWQ+jQz67K8PHmD+xaKzzlFcN3tQOy7zP9kK
         vvEgvCP0VnGJilmMgvRdVOCn/AUdWHaUJjTVy/wmQBgzkH2SMbH8iE1pMYN+qWvUwyq4
         QFcxNYZtIIEtBY7ZvrhZD62KqC6bPXRCsDnjbEAc1t5LYC750WPj4Z4VxLV2Qroy1U8m
         1Fmlf2+NW5SCDNF/LB4uPeOx1pX6TzKPoEKDs0nYlrzyMsS+Op9VP6nFVzYUTrPxnbOC
         e0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407419; x=1729012219;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5wquzKmnrqJJ5kPwwZNxPYzxEXUmApBUbr8OYSpfIYE=;
        b=GqdFUhpYjhtY3ObeHiWqHuWC/hc09ANSS2sClYuJ/VJpvZb8dZLrOTjfrNzAQfaCPY
         6YgmAgh2HqeRTciD416oPOPmk13dbhVE0b+mixmlKeglHqekVGv9wjmvG9FzL2GSXG93
         9yPbfHttl7qiSdUvBtBsWkEjatBjUuCKMeVFGXPtCwWlc4FCsqzE4xeNBAfncDyFFpGW
         IEy/IDqZPJjLxXVoig3ASd6tcESP83WJ48b+5j/kEfF/hjFlXNOZAs3x9soB/+EqLP1/
         1LA264ZRWaJKXjob+twnw19tcZVSTpZITCUd1J6vmN93B9YTaxzRHnDmGwSHH+5xvkse
         U4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU9S+F7WhyBpcI3gpLhect2II8jGcC9Lu6P5IKNSekhgsDEQrv/lxbLPwSmkdbltp7RaaGgGxtGEV8poRw=@vger.kernel.org, AJvYcCX/2rxZBCx5n4VnvBlSO3J9qBVw1YdNUB6Wk+zm5z/lxg2M1jAdwjU20HQdeiuFvqvlQCr7N+gw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5hjWG8cpEORND2zCQ2oH5VF2XOe+GhWxBVDsiEoVcW+7VpvA
	YNddgIziaf37B+cn0b63fDfrmwC+KxDf6RHDOHwMWC9MOVQHubfC
X-Google-Smtp-Source: AGHT+IFUxdPOc8uOK3jWXzQ/caJ4gh0ritqd0RbvAQETdeYwl3VYrdYFy8Xz2dTLSzS9y2ZsfjgPcA==
X-Received: by 2002:a05:6a00:21d2:b0:71e:1e8:8b7c with SMTP id d2e1a72fcca58-71e01e88f11mr12692298b3a.15.1728407418764;
        Tue, 08 Oct 2024 10:10:18 -0700 (PDT)
Received: from [198.18.0.1] (n220246094186.netvigator.com. [220.246.94.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd16a3sm6357959b3a.59.2024.10.08.10.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 10:10:18 -0700 (PDT)
Message-ID: <2bf30957-ad04-473a-a72e-8baab648fb56@gmail.com>
Date: Wed, 9 Oct 2024 01:10:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lixingyang1@qq.com, zachwade.k@gmail.com
From: Zach Wade <zachwade.k@gmail.com>
Subject: [PATCH] pstore: Fix uaf when backend is unregistered
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

when unload pstore_blk, we will unlink the pstore file and
set pos->dentry to NULL, but simple_unlink(d_inode(root), pos->dentry)
may free inode of pos->dentry and free pos by free_pstore_private,
this may trigger uaf. kasan report:

kernel: ==================================================================
kernel: BUG: KASAN: slab-use-after-free in 
pstore_put_backend_records+0x3a4/0x480
kernel: Write of size 8 at addr ffff8883efbe0390 by task modprobe/4308
kernel:
kernel: CPU: 1 PID: 4308 Comm: modprobe Kdump: loaded Not tainted 
6.10.9-arch1-2 #2 5fd36c90225554e2cc88363729bd91e76130a89f
kernel: Hardware name: ASUS System Product Name/TUF GAMING X670E-PLUS, 
BIOS 3024 08/02/2024
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
kernel:  unregister_pstore_zone+0x2f/0xd0 [pstore_zone 
35171c701a99c31efe207b7a718dc583e4a6503a]
kernel:  pstore_blk_exit+0x30/0x90 [pstore_blk 
589d82101219208d8968e3adda9b96a2d42df635]
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
kernel: Code: 73 01 c3 48 8b 0d a5 c8 0c 00 f7 d8 64 89 01 48 83 c8 ff 
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 c8 0c 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007ffed7e621f8 EFLAGS: 00000206 ORIG_RAX: 
00000000000000b0
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
                                     which belongs to the cache 
kmalloc-64 of size 64
kernel: The buggy address is located 16 bytes inside of
                                     freed 64-byte region 
[ffff8883efbe0380, ffff8883efbe03c0)
kernel:
kernel: The buggy address belongs to the physical page:
kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 
pfn:0x3efbe0
kernel: memcg:ffff8883ef245801
kernel: flags: 0x2ffff8000000000(node=0|zone=2|lastcpupid=0x1ffff)
kernel: page_type: 0xffffefff(slab)
kernel: raw: 02ffff8000000000 ffff88810004c8c0 ffffea00043dcc40 
dead000000000004
kernel: raw: 0000000000000000 0000000000200020 00000001ffffefff 
ffff8883ef245801
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

place the pos->dentry = NULL before simple_unlink(d_inode(root), 
pos->dentry)

Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is 
unregistered")
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

