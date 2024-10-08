Return-Path: <stable+bounces-82185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B7E994B98
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F149AB2799D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A451DE8A0;
	Tue,  8 Oct 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWHz0M2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB51DE2CF;
	Tue,  8 Oct 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391428; cv=none; b=HFH2nO9L13O3w3y6HJJHSvIWRXildaYCnTG55BKDcJrGMdbuRvyd6R9ZkmdCP7TAzWjbPZJH4fRFB9eHWj7eMMJxzrfpKl+at11Ffw0b5TE+DrGYRELHMBttevbtocTglwNEnaa6uwT0j5NuOHnjy2Zb+Cx2qF4Fsy4ERc5N9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391428; c=relaxed/simple;
	bh=/tl25x99j27BrdoNbFNLUNPSRk1/Y0/whtOo41j77VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luc4CfbtijTk1/jQjh0d3ylVRpjHkzuYoECpLQTw2G4El3PvqfbPoKUus7c4+QUKUU0nV8UcEvaGk9gAmffTdBTjgZP2KlNgZrln1LI07/IsOk7u0Gj+0rOiWv7pMnXQfXSzaomDqKwuK4Envl6WeF+PvxSpBr41mDUr5Mcyrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWHz0M2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF0EC4CEC7;
	Tue,  8 Oct 2024 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391428;
	bh=/tl25x99j27BrdoNbFNLUNPSRk1/Y0/whtOo41j77VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWHz0M2Wx+d4IMxtbCkzLn/eul2SsRFrXDlMww4I6ySRMhqddQiSDMTZBn/o19zvd
	 kfgHvMq+zjb2l02nRIuvPKCWUG10cv4EdSI4XnJCg3iz9OeE7C0RcC2RsufFqvsXpA
	 CESzag5cO14jXlzGHCEyIsvIaVjmzXJPQWesNgt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 104/558] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
Date: Tue,  8 Oct 2024 14:02:14 +0200
Message-ID: <20241008115706.461322421@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
---
 fs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 7125b73b53675..551ba352072fa 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -595,6 +595,7 @@ void dump_mapping(const struct address_space *mapping)
 	struct hlist_node *dentry_first;
 	struct dentry *dentry_ptr;
 	struct dentry dentry;
+	char fname[64] = {};
 	unsigned long ino;
 
 	/*
@@ -631,11 +632,14 @@ void dump_mapping(const struct address_space *mapping)
 		return;
 	}
 
+	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
+		strscpy(fname, "<invalid>");
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




