Return-Path: <stable+bounces-99282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8C9E7101
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0841B162F91
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44532149C69;
	Fri,  6 Dec 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XuXp60U3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FE32C8B;
	Fri,  6 Dec 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496624; cv=none; b=hTMB6J95JZE88JR94sf3BzlL+nBBWjtQ5tEAfORtSjSF2CtvvY+4RyPWIfNXOsiTKFAnF/+3i7QBuqoWX+aO0bGOWWPkXGwGC3VWftdNm13Rqoa94o/EjkS+gp4BkobWW9HMJhYM/kaP6TBuLXRbSruH33xufiTVMQh0r0f6PtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496624; c=relaxed/simple;
	bh=RY4qsKV3fuNXv4OR6bOLPXKMlIL30mWAOpOH26zVmIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmTJSzvBKZIkRv5QJeRaM77QBarNp/cwFOPruk1oYOAXrh41h2AIsnmx5Q9pQ4SdObX9ll0ANf7TEuc2BvS4W0tVgVUSI7sFWG4U1FVUGE6siWz87n3zW/GQD5ntI1sCuj61S3VQigy2PboZ77vcErpq5wqIqjmqlmn5seMiSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XuXp60U3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289EEC4CED1;
	Fri,  6 Dec 2024 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496623;
	bh=RY4qsKV3fuNXv4OR6bOLPXKMlIL30mWAOpOH26zVmIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuXp60U3UzYPkmrGfFDgOZnwHyO+zuV/SGcOZDXeUUaKBPSY8kjUNoT1noCb1Ergr
	 +NyvS8csAvt9akaP/0jigKfDNL7Exqa3qTT0ji7r8jN7cSZGc12MAy0A4qSdYalXvh
	 1EGGTBuv0t8pKCk7QSJSGetyH8IXwvINb7WRAJY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Xiangyu Chen <xiangyu.chen@windriver.com>
Subject: [PATCH 6.6 040/676] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
Date: Fri,  6 Dec 2024 15:27:39 +0100
Message-ID: <20241206143654.919914395@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 7f7b850689ac06a62befe26e1fd1806799e7f152 ]

It's observed that a crash occurs during hot-remove a memory device,
in which user is accessing the hugetlb. See calltrace as following:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14045 at arch/x86/mm/fault.c:1278 do_user_addr_fault+0x2a0/0x790
Modules linked in: kmem device_dax cxl_mem cxl_pmem cxl_port cxl_pci dax_hmem dax_pmem nd_pmem cxl_acpi nd_btt cxl_core crc32c_intel nvme virtiofs fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc s
mirror dm_region_hash dm_log dm_mod
CPU: 1 PID: 14045 Comm: daxctl Not tainted 6.10.0-rc2-lizhijian+ #492
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:do_user_addr_fault+0x2a0/0x790
Code: 48 8b 00 a8 04 0f 84 b5 fe ff ff e9 1c ff ff ff 4c 89 e9 4c 89 e2 be 01 00 00 00 bf 02 00 00 00 e8 b5 ef 24 00 e9 42 fe ff ff <0f> 0b 48 83 c4 08 4c 89 ea 48 89 ee 4c 89 e7 5b 5d 41 5c 41 5d 41
RSP: 0000:ffffc90000a575f0 EFLAGS: 00010046
RAX: ffff88800c303600 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000001000 RSI: ffffffff82504162 RDI: ffffffff824b2c36
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000a57658
R13: 0000000000001000 R14: ffff88800bc2e040 R15: 0000000000000000
FS:  00007f51cb57d880(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001000 CR3: 00000000072e2004 CR4: 00000000001706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn+0x8d/0x190
 ? do_user_addr_fault+0x2a0/0x790
 ? report_bug+0x1c3/0x1d0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 ? do_user_addr_fault+0x2a0/0x790
 ? exc_page_fault+0x31/0x200
 exc_page_fault+0x68/0x200
<...snip...>
BUG: unable to handle page fault for address: 0000000000001000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 ---[ end trace 0000000000000000 ]---
 BUG: unable to handle page fault for address: 0000000000001000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 14045 Comm: daxctl Kdump: loaded Tainted: G        W          6.10.0-rc2-lizhijian+ #492
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 RIP: 0010:dentry_name+0x1f4/0x440
<...snip...>
? dentry_name+0x2fa/0x440
vsnprintf+0x1f3/0x4f0
vprintk_store+0x23a/0x540
vprintk_emit+0x6d/0x330
_printk+0x58/0x80
dump_mapping+0x10b/0x1a0
? __pfx_free_object_rcu+0x10/0x10
__dump_page+0x26b/0x3e0
? vprintk_emit+0xe0/0x330
? _printk+0x58/0x80
? dump_page+0x17/0x50
dump_page+0x17/0x50
do_migrate_range+0x2f7/0x7f0
? do_migrate_range+0x42/0x7f0
? offline_pages+0x2f4/0x8c0
offline_pages+0x60a/0x8c0
memory_subsys_offline+0x9f/0x1c0
? lockdep_hardirqs_on+0x77/0x100
? _raw_spin_unlock_irqrestore+0x38/0x60
device_offline+0xe3/0x110
state_store+0x6e/0xc0
kernfs_fop_write_iter+0x143/0x200
vfs_write+0x39f/0x560
ksys_write+0x65/0xf0
do_syscall_64+0x62/0x130

Previously, some sanity check have been done in dump_mapping() before
the print facility parsing '%pd' though, it's still possible to run into
an invalid dentry.d_name.name.

Since dump_mapping() only needs to dump the filename only, retrieve it
by itself in a safer way to prevent an unnecessary crash.

Note that either retrieving the filename with '%pd' or
strncpy_from_kernel_nofault(), the filename could be unreliable.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/20240826055503.1522320-1-lizhijian@fujitsu.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: Bp to fix CVE: CVE-2024-49934, modified strscpy step due to 6.1/6.6 need pass
the max len to strscpy]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9cafde77e2b03..030e07b169c27 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -593,6 +593,7 @@ void dump_mapping(const struct address_space *mapping)
 	struct hlist_node *dentry_first;
 	struct dentry *dentry_ptr;
 	struct dentry dentry;
+	char fname[64] = {};
 	unsigned long ino;
 
 	/*
@@ -628,11 +629,14 @@ void dump_mapping(const struct address_space *mapping)
 		return;
 	}
 
+	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
+		strscpy(fname, "<invalid>", 63);
 	/*
-	 * if dentry is corrupted, the %pd handler may still crash,
-	 * but it's unlikely that we reach here with a corrupt mapping
+	 * Even if strncpy_from_kernel_nofault() succeeded,
+	 * the fname could be unreliable
 	 */
-	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
+	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
+		a_ops, ino, fname);
 }
 
 void clear_inode(struct inode *inode)
-- 
2.43.0




