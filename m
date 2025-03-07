Return-Path: <stable+bounces-121376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22614A567CF
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14FE175408
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C8219309;
	Fri,  7 Mar 2025 12:28:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF63218EBD;
	Fri,  7 Mar 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350519; cv=none; b=cMuRBG1x7gMHQa7XWqEDeXHYnvbBKx3AxhkFmcA9/Kl+1iVZ9IhlfhLqzLFnkVNyWfUwkP4Hjq0M+X9M88BULkHjZSBxTng6YvUUlTDoFQ1koIcL90SsDSACXs5hHgYhIttnHAIiv+AfLjCjZf7mCE1Wf0VJDFh4DMvFEvidtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350519; c=relaxed/simple;
	bh=CSdZa/BGFCkVFPBirpA0O/BUijBpHtYF7yEbbo391pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCwGUM5D61/KF81Zkqzy86Wol06Xhmkpm1bwka3hqacTO05iFM/x29W36uzUM7g5cQxovZXfMgmUto7CGpi2v4/P0PM/2V6Qaeq+tYtksDkmhltcTquERJjPs7dWSoNILfQAHhua8K9w9yxMwPkLkgOD9AvpvsZn9mcu6M8LAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 1EDDD24CC8;
	Fri,  7 Mar 2025 15:28:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru [10.177.185.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 15:28:33 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z8QYs2NtXz1c0sm;
	Fri,  7 Mar 2025 15:28:33 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	David Hildenbrand <david@redhat.com>,
	syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 5.10/5.15] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Fri,  7 Mar 2025 15:28:30 +0300
Message-Id: <20250307122830.10655-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/07 11:11:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;lkml.kernel.org:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191572 [Mar 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/07 09:54:00 #27658601
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/07 11:11:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: David Hildenbrand <david@redhat.com>

commit 091c1dd2d4df6edd1beebe0e5863d4034ade9572 upstream.

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
[ Alexey: mmap_read_lock is not used in this context, so mmap_read_unlock
  is removed. Synchronization is provided by an external context in
  do_migrate_pages(). find_vma(mm, 0) is the same as mm->mmap. ]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
v2: Clarify mmap_lock context in changes summary. Fix braces for a single
statement block. Rearrange the changes with a comment and VM_BUG_ON to
look more consistent with upstream.

 mm/mempolicy.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6c98585f20df..db94aec0ea17 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1067,6 +1067,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err = 0;
 	struct migration_target_control mtc = {
@@ -1077,13 +1078,18 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodes_clear(nmask);
 	node_set(source, nmask);
 
+	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
+
+	vma = find_vma(mm, 0);
+	if (unlikely(!vma))
+		return 0;
+
 	/*
 	 * This does not "check" the range but isolates all pages that
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
-	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-- 
2.30.2


