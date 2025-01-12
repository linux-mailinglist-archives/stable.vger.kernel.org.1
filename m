Return-Path: <stable+bounces-108333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4B8A0AA1A
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 15:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2243A7632
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F01B81B8;
	Sun, 12 Jan 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JAun+o4f"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9D1E4B2
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736692588; cv=none; b=PyeyJ0Hr9JVN6eBikVvd+GJgoXF7CDmaMEtSKEKRC9fQOAqZAbrwmYQMHGhFrB/EVifFM5F41KyI8PznHKf7p99wtV9N90I8cJtdwX6WmSvC/mdIRfxseWX8bgxwJnUhWiWI2RJlhlcT9OHNrswdLEaLT7/9Nj9BlVwNeIxqqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736692588; c=relaxed/simple;
	bh=ZKBSTRyc24WpADSa4Ae+YdUi8fOkKx7r/eEx/WXoiFM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tOTjN+dpuk56qDxWf9QGsqJ2ELrsmMevqendlZUDpLrhFFgyWelxhQjIOxwQO294Ouov05imLRCGJJLD7aLdX2mwfE5zL6+S4fAo3IjI9zh0tjWi+3Th4nVqT08dFHkJEkrjZdAQqWL/oPL/A6hjqrG7Q+6nE7QKpgrxja1L/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JAun+o4f; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736692572;
	bh=Zyk1GHe/S4BKYCbBNlstb5I8/N7VcveCDWKdLmy+XNQ=;
	h=From:To:Cc:Subject:Date;
	b=JAun+o4fLO2KNUnN6CpXEuFuT+envEXL0GJMvAA0iW9hpq9f8syw4xy/bSmz5Ax3a
	 TGnRDTbaY+oJUoeIMnAkA0gMiPbOe6So6v+3QMtbQBLflvPp+bY0R6Vuw/Kv/Ou7Ql
	 benxUq9Ts+cZ7A7u4pR6NONpDVzSw3DsFJ0KaQvA=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 8F72C824; Sun, 12 Jan 2025 22:35:55 +0800
X-QQ-mid: xmsmtpt1736692555tym2kfgf5
Message-ID: <tencent_CD1AB68F5D4976EB329C2698E60661DA8D07@qq.com>
X-QQ-XMAILINFO: Nxcyh1H/ItmfTfSiZFJyDSMZf7l52xT/2PGH3NkWMTX3oysx+BJHLT4UsmXEdL
	 onRJX/k7cZ0oy/4ZRqAeJ2uB7y+kIqa0YfFzQVNOu9IW/1IudRPQJ6odW0G7XJcPvwvwsAYRGAj+
	 VVfFy+c2UDhd4DtfXlSmJZyAcoelMB3lgoQYxtxnQ9AJu/Imx1jf7gr7Tv7FbDJnRibb8HNo7l/k
	 aCWx1kBbdbKBuGDAaqFVtXU5WZI+dmbE69SK3mzQmPlHSMhpC+mozdH3wXJ1W250yfefklcnH/vJ
	 lfkVDnIYc0DbHZPt771q30IonVWAF+rDyl7ja+qtOmx5iy996qCl+vBbPL8e4AECASilTCfGeGwK
	 L+PlBlP/Wstl1GsvLY0ZUFgprve0+bYipmHJny1PWLVGTIHYnkUgBewVxB4vkfz2U5XZLgTt53DU
	 FDNnkNqr6WW8EUqNd4D9swwbMday8W3vMo9asU2JQofizfo0pJ9Y8X9Ot396d7BqsxXiKJe0s5Qm
	 UBtFZ/O9xHrjwsjMqVdImPohOa9nhH55nuteYtsBN+oU8kvaPykh6KM5PbAWiZsH36dFedvO+BiH
	 NyQ2S6/GXiCordz9RWHKktq8gGBUB9TOsOiZSA7WwEnfoLykvdggoqxzI7JckdZnAEXf5qDr9gjC
	 jlQEWy5LlgFYLituIzQuM/IqVQvRpdwQfzYRknsT6KEinIAoXGfFhBXzirYPfaTJvhDxTmWpwOjk
	 lBG4eCYXOxzBCPDQViIH3yziaBWqA9awt36QNDbdhKJEAekiJybiFHuf+ZoDkhorECXVroAnC+uG
	 Nnoy4ZZ7nqRpbRrwuEnD7G0JgWEpV1LWrojOfyIblQLMWiH1pPkdVaLket2tx6H0iI4TtmBegPT+
	 TKZac3KcWIuuYhb3q9iWuIENJSOE0V41XPkxiRVWvFyfuuWBNm3yGv+2nNu6LZUaeGnelifClLT0
	 PvWsdIxfU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org,
	david@redhat.com
Cc: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
	Liam.Howlett@Oracle.com,
	cl@linux.com,
	akpm@linux-foundation.org
Subject: [PATCH 6.1.y v2] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Sun, 12 Jan 2025 22:35:55 +0800
X-OQ-MSGID: <20250112143555.1769-1-alvalan9@foxmail.com>
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
[ Remove mmap_read_unlock() because mmap_read_lock() is not called before find_vma() in the function migrate_to_node() ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
v1->v2: remove {} which is not needed.
---
 mm/mempolicy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 399d8cb48813..13b04fd04306 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1068,6 +1068,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
 	vma = find_vma(mm, 0);
+	if (unlikely(!vma))
+		return 0;
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
-- 
2.43.0


