Return-Path: <stable+bounces-121374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C42A567CA
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19A7174545
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14F218EA1;
	Fri,  7 Mar 2025 12:28:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0F21767D;
	Fri,  7 Mar 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350498; cv=none; b=qFOBmQisKH2VrSxsto6tBoKF87fqhhhBaTFKn85nYaXnmuOf7NrvBKjICroAjcbU93VpMvk2HvXYKb76aekFnWACbwioheTrurexasNUxypiB2kfDNenPrzUeBSM4OkgEDiNiLMmjvyoNSiz+BHpuEEp16das6BfqXE9xJ/Ysi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350498; c=relaxed/simple;
	bh=PLQGB3UirQe2knkq4IFIwqzOOTb1XEGyQFJ2J5v5fZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qDSi31fMd0ReQgG22CwZNDEFTLXcIEPHaUKym0Ekgwjf2l8izVuSDdylRNei6g79j07RbH3uUugznKfHoC64pLpQ69SgEh0lwW8LZREFXFuGwUSmoxWDUloc+p/OlajDasAnwOq/wfFd7QIj97eSkehqxgXHxogtXS4CSEyrAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 3533924CBE;
	Fri,  7 Mar 2025 15:28:03 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 15:27:58 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z8QY70nWqz1gywd;
	Fri,  7 Mar 2025 15:27:54 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Christoph Lameter <cl@linux.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 6.6] mm/mempolicy: fix unbalanced unlock in backported VMA check
Date: Fri,  7 Mar 2025 15:27:37 +0300
Message-Id: <20250307122737.10400-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191572 [Mar 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/07 09:54:00 #27658601
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

No upstream commit exists for this commit.

The issue was introduced with backporting upstream commit 091c1dd2d4df
("mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA
in a MM").

The backport incorrectly added unlock logic to a path where
mmap_lock was provided by external context in do_migrate_pages(),
creating lock imbalance when no VMAs are found.

This fixes the report:

WARNING: bad unlock balance detected!
6.6.79 #1 Not tainted
-------------------------------------
repro/9655 is trying to release lock (&mm->mmap_lock) at:
[<ffffffff81daa36f>] mmap_read_unlock include/linux/mmap_lock.h:173 [inline]
[<ffffffff81daa36f>] do_migrate_pages+0x59f/0x700 mm/mempolicy.c:1196
but there are no more locks to release!

other info that might help us debug this:
no locks held by repro/9655.

stack backtrace:
CPU: 1 PID: 9655 Comm: a Not tainted 6.6.79 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x1b0 lib/dump_stack.c:106
 __lock_release kernel/locking/lockdep.c:5431 [inline]
 lock_release+0x4b1/0x680 kernel/locking/lockdep.c:5774
 up_read+0x12/0x20 kernel/locking/rwsem.c:1615
 mmap_read_unlock include/linux/mmap_lock.h:173 [inline]
 do_migrate_pages+0x59f/0x700 mm/mempolicy.c:1196
 kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1665
 __do_sys_migrate_pages mm/mempolicy.c:1684 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1680 [inline]
 __x64_sys_migrate_pages+0x92/0xf0 mm/mempolicy.c:1680
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x68/0xd2

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: a13b2b9b0b0b ("mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM")
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
v2: Clarify mmap_lock context in commit description. Fix braces for a
single statement block. Add empty line after VM_BUG_ON to look more
consistent with upstream.

 mm/mempolicy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 94c74c594d10..d2855507d2e9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1070,11 +1070,10 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	node_set(source, nmask);
 
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
+
 	vma = find_vma(mm, 0);
-	if (unlikely(!vma)) {
-		mmap_read_unlock(mm);
+	if (unlikely(!vma))
 		return 0;
-	}
 
 	/*
 	 * This does not migrate the range, but isolates all pages that
-- 
2.30.2

