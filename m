Return-Path: <stable+bounces-208379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADBD20F78
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C3C302D939
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BFA33986C;
	Wed, 14 Jan 2026 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CuH1fcnd"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC026F2B0;
	Wed, 14 Jan 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417475; cv=none; b=E2Wi0Ckaf+dbnm1QZitvzP8rfoLuKrKO3DlE+NGpg8TVqKyDZ+u7FP0csW7SBQCEaBxqX56qKl6aPxhVaycOd9Q+3fEgf15ToMYr2X/z5hWX38jHYTYn4IKQT86WQneGwZsOroOZHyCSiQxE2BAhDgVUT7/ql7tVQzhyYi96Ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417475; c=relaxed/simple;
	bh=BffaKBhvmP1p+q6rNAGaC3tWhZ78LI5cT8HM1RnweYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LA52CrctLDYjNe7CzUPFOhjonfiKGoQSiPGjd3olrJboxwtG1Y/dxDd9ackK2yys8BBuHGuetqyho70Du0Uiq05hZSC/wbEP1m3CLMXXn9Yr775UsLLD9kh0NmgyzD/QdR2oMJI9iceKFHOX71SXacEGDwSs88A3vCIbwVTbp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CuH1fcnd; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id C4BB7407795F;
	Wed, 14 Jan 2026 18:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C4BB7407795F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1768417082;
	bh=07dpiY8kEY0GFcUy8qFirliZcsifX5zb7aQFpXv8mdk=;
	h=From:To:Cc:Subject:Date:From;
	b=CuH1fcndh0lXvPTo0rn/Y+U9pKgds0YKQya6T2gKdmRU504AtbeSOI+LLGyuzkvxE
	 +Te0rfQCvkIdEaanOsp/J3qcq+k70Wk/CeJK1rC88V041b+zzksrd+zYI5rtf2taGP
	 KSa2aQt+LJXlrca5a/OwnZ1LE8O4GB9CkBHlyMXo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] mm/mprotect: restore pmd stability check in change_pte_range()
Date: Wed, 14 Jan 2026 21:57:45 +0300
Message-ID: <20260114185746.816527-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

There is a crash which started to be observed on 6.1.y kernel after
backporting a modified version of commit 670ddd8cdcbd ("mm/mprotect:
delete pmd_none_or_clear_bad_unless_trans_huge()").

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 23316 Comm: syz-executor.6 Not tainted 6.1.160-syzkaller-00409-g94ae58088937 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__lock_acquire+0xdc2/0x5320 kernel/locking/lockdep.c:4919
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5662 [inline]
 lock_acquire+0x194/0x4b0 kernel/locking/lockdep.c:5627
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x27/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 change_pte_range mm/mprotect.c:91 [inline]
 change_pmd_range mm/mprotect.c:401 [inline]
 change_pud_range mm/mprotect.c:432 [inline]
 change_p4d_range mm/mprotect.c:453 [inline]
 change_protection_range mm/mprotect.c:477 [inline]
 change_protection+0xa1f/0x35e0 mm/mprotect.c:499
 uffd_wp_range+0xf8/0x190 mm/userfaultfd.c:748
 userfaultfd_unregister fs/userfaultfd.c:1646 [inline]
 userfaultfd_ioctl+0x38a7/0x46d0 fs/userfaultfd.c:2037
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:46 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:76

The reason is that a pmd_none entry made its way into
pte_offset_map_lock().  It crashes when USE_SPLIT_PTE_PTLOCKS is set.

It seems that pmd_trans_unstable() check shouldn't have been removed from
the 6.1.y version of the patch, restore it.  Upstream code, starting with
commit 0d940a9b270b ("mm/pgtable: allow pte_offset_map[_lock]() to fail"),
has internal checks for that inside pte_offset_map_lock() itself.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 670ddd8cdcbd ("mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

I've tried to follow the original discussion [1] regarding the problem
this backport is supposed to solve and how it was tweaked for stable
inclusion but failed to find whether the pmd_trans_unstable() check was
dropped accidentaly (because upstream commit does remove it as well) or
there was some reasoning behind it.

The backport patch is already in 6.1.160 release so I guess the fix should
be added to 6.1.y branch directly.  Looking forward for your review and
comments on the problem, thanks!  I can provide .config and reproducer if
needed.

The backport patches are currently in queue for 5.10 and 5.15 kernels
inclusion so they still may be dropped from there and reworked accordingly.

[1]: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/

 mm/mprotect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f09229fbcf6c..ef6a360ec088 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -88,6 +88,15 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
+	/*
+	 * Can be called with only the mmap_lock for reading by
+	 * prot_numa so we must check the pmd isn't constantly
+	 * changing from under us from pmd_none to pmd_trans_huge
+	 * and/or the other way around.
+	 */
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	/* Make sure pmd didn't change after acquiring ptl */
 	_pmd = pmd_read_atomic(pmd);
-- 
2.51.0


