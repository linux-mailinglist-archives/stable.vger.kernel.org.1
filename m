Return-Path: <stable+bounces-108271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBFA0A41D
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EF23A9E73
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68B2770C;
	Sat, 11 Jan 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="APl2Wgqb"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569B1F5FD
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736605254; cv=none; b=cg0OxGRQQF0HdDYlnyld5dpS5uT928yVgEtwbMp71TMmZzKu4jOcCeoU9kaIJ+t2LERRyd4SrAPdu6dwnkHDiO8bBXGeWuYrECIG062TTPsul/TLMbKZ2EWCIpd7Tdet3+VUwW5qwg1eqB22hAxCa/7tjj15iY0169c3ZaouFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736605254; c=relaxed/simple;
	bh=xg4yiPWbPUpprgYgqbQALLPCNWTdiRWi8wgvEYlG3n8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qxk51lYYYuLt2/4VXAWsahFLNGm+ZATNvbfbmfRa+wm/bRUl2J51wxRNGaerlt5tGnPo55GdMyNuHT1iRnZ2YHAI46vkPDOdrWlITZ+L6/To1PJTC5JRZ0VRXKRWkGTjCA3TAdr+2DHQKM5Cx1BcLh2vvqrBYK4hafZDXWzwaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=APl2Wgqb; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736604938;
	bh=jXqyKbbd8qtbRc9GoA210k57Vn5B9St2nlVFUwlwYcg=;
	h=From:To:Cc:Subject:Date;
	b=APl2WgqbtteGL1ZK+Khsbw5MO88h5fqmi1P8PgCoqFs21mkSTdu23HNH/Rg++h/n6
	 WCH0afIV6CzmR+/2VMM4UMJA8HrHQJOyY782sFPNpTFXQnlBxzk+1pgRW5gPy2GZBO
	 jlU4nF3M52VqvVb2uDCb3L+vadLpPAME//X+CoM0=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.133])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 3D4154AF; Sat, 11 Jan 2025 22:15:20 +0800
X-QQ-mid: xmsmtpt1736604920tmp9aexwf
Message-ID: <tencent_A6390C6B4311AD460DE2C7BDE489B515CE06@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlQp0YmrcXtH9QPZ+CVcg9eHMzIrW7TKz6kbiPxLCzz7/nkoZ2cU
	 JsCJNLtFazM7q8gxM6BF4s0KvwEiYqXbe595Inw0uIW+z/fY5a8CkIgu1oGIiZwA1GYNiu2V2Y9P
	 9MRVVDoEPweD+nNughlZBV9OFlu96+wRBNLf65SjdXf7/TV7zm+xxZX7q9VQ17a6d0SIc327cIYU
	 WWVE+DPfEqX7FTxK1uawrX4aBMDhPAzQ29X3yg/Vki7LenhX8CHCV+RSGv0yMni4/UeBG9UFWE/4
	 RUFZWrJQy5a0bsQADT5KNgIR75uxmOpfYkPofsrjHXLj7Vekf+rEuvvSs3N9c6uIPg7DyJNuadOi
	 q8mrpFzVDXsQ0ZWsEQ6vdyeRGQ0+xHUHTHN4JPdJP40T5e6w5w07YWZEUIkgF3l25Yw5FaxhtmBI
	 WevQMi9dp9JpP2jP2EELeBEDyeFO6ctJloFnxmieG7TDno/xrV7LiBZkJCA3zi6+4jWgmLE1Yamc
	 tDw7LFTDqwlo5Q/ZlYavlg3sB3B0129q8zYdqwGabQmJGy2GZcamcuMvvL5kAoSjc6jPkzuaNKT6
	 aG+KUgr5g3PHUN8ohXNNqUmOjKOtmt7KiJkh8tSK9rG9+yFjrbHaJ6/zwQE9I4UHvCCYifAmr3zU
	 LUCUGh4BIchnPXmPyqaX7afEfcGhDSj9W1IHaoWCbbvOVVahIQG/6k+65vcxzbrVaDpTRGD61vMj
	 vaaM++qTzXZesEO0tqOwj7TPFrKzS4+L5GO5Iqpv/aaJmbMRKJ6gEKz/TKHyURx3CtCANChKZcmp
	 Z/apywKcWu2MimDSUZiz96mwGEmVCeCUqwS+Z1tGDzAmrTnyElh7Occz5kPZjoRskxMWRSK0c5g7
	 qq7InFWhROWPxxOfS9Hi9Ed9ymVhmSJbW44WhDYIVzJdQHO7IdCtVjfdto6Ob63jXU6hxjP8PzMh
	 Uhwz+CKCI1Y/u5+lR85eCie4rG3ZqB0WX41zut4CU/5aimKnlvA4ymvhw2eALT61hH8aiF11CnXI
	 5KNQWehN1NfaRiAlQT3kYmGNiUrA476SaWt/hjqwGpTyLD/+9C
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org,
	david@redhat.com
Cc: alvalan9@foxmail.com,
	Liam.Howlett@Oracle.com,
	cl@linux.com,
	akpm@linux-foundation.org
Subject: [PATCH 6.1.y] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Sat, 11 Jan 2025 22:15:20 +0800
X-OQ-MSGID: <20250111141520.8660-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 091c1dd2d4df6edd1beebe0e5863d4034ade9572 ]

We currently assume that there is at least one VMA in a MM, which isn't
true.

So we might end up having find_vma() return NULL, to then de-reference
NULL.  So properly handle find_vma() returning NULL.

This fixes the report:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
Code: ...
RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
 __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[akpm@linux-foundation.org: add unlikely()]
Link: https://lkml.kernel.org/r/20241120201151.9518-1-david@redhat.com
Fixes: 39743889aaf7 ("[PATCH] Swap Migration V5: sys_migrate_pages interface")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/673d2696.050a0220.3c9d61.012f.GAE@google.com/T/
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Remove mmap_read_unlock() because mmap_read_lock() is not called before find_vma() ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 mm/mempolicy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 399d8cb48813..d67dd0f503fa 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1068,6 +1068,9 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
 	vma = find_vma(mm, 0);
+	if (unlikely(!vma)) {
+		return 0;
+	}	
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
-- 
2.43.0


