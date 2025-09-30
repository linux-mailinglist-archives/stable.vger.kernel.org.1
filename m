Return-Path: <stable+bounces-182070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB0BACF55
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0BE4E268C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87E25393C;
	Tue, 30 Sep 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="KRIweQCD"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311B3FB1B;
	Tue, 30 Sep 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237237; cv=none; b=vBPhQfpT0qgXrk4TNgggK72pkdPHHjz5JDcR21g0Se5IouYfhmLYdk+LVre0bcD/7CCgVXNNSm7OQyQxFCDkIuJwTVSFtShyouBE1iTLriBjeUV4GMEsEWkzBuiYjpsgAuol7HEB8+vMBOH5LAUQRKSY58dIfKI8ZtbF/9cP4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237237; c=relaxed/simple;
	bh=UJsfwDqFx/fhlLVWTizVS7mTfIl3qNGXsfhOUznPVeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L4R2hkTK4hpRaPlwPOZSkvPqZqKiZwjAGu9YmNUYyxqVJCdCgGmQm97/nXY1SgH9Wo3IzL2KKs1seXxptjG+llS0ZLCO/zR7qDiZj8TgAtWqwYer6PS7HWHSMYKlmJXICb4fPgPmvTUgB9YigzcQyqSpXJbFjztkgOx0h6LTABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=KRIweQCD; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759237235; x=1790773235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4y9rVmjkhatWvM5IQXAd0quXaLLwCNEnONzYm/0o4vg=;
  b=KRIweQCD/Hz0TSpyoFjP8q/xMzBKzxxdNt8RxManMAU5gyCWSrbu2l/t
   Nh2mcWNt4hLoajYpEVNS/81gtsUq+6Q3xKmBJSzrCIBFWkwLXB8fTH0KC
   gRsehyK3Q72lKbB4Od8YlVhaQzVPVDlk3EpjmyPvCo7US37QcDKtiNR8n
   fXa7uisjoXMsl9Pho32Qa7a+1TYhFSZB0f0qaX8AsWH7XVHVtu9yvPIFK
   iVnmR0SFKd8FqiIrjvAE4BKUDYzFA9FIb8IgEmHeeW+TukBsn6WHz4def
   16ev/246Zar4THwTNd6y7v8LyKjq5e+1NxluB/lcRG+TijbJxpubN9R6h
   g==;
X-CSE-ConnectionGUID: U2bmbB3zQ6esQ+cFN2bi4Q==
X-CSE-MsgGUID: T2b8wKMdQxSUE3HXqyo/mQ==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4002597"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 13:00:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:22805]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.86:2525] with esmtp (Farcaster)
 id 143b7053-1d57-488d-839b-227c6cd39263; Tue, 30 Sep 2025 13:00:32 +0000 (UTC)
X-Farcaster-Flow-ID: 143b7053-1d57-488d-839b-227c6cd39263
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 30 Sep 2025 13:00:32 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 30 Sep 2025
 13:00:30 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <linux-mm@kvack.org>
CC: <acsjakub@amazon.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
	<chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>, Axel Rasmussen
	<axelrasmussen@google.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Tue, 30 Sep 2025 13:00:23 +0000
Message-ID: <20250930130023.60106-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

syzkaller discovered the following crash: (kernel BUG)

[   44.607039] ------------[ cut here ]------------
[   44.607422] kernel BUG at mm/userfaultfd.c:2067!
[   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
[   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460

<snip other registers, drop unreliable trace>

[   44.617726] Call Trace:
[   44.617926]  <TASK>
[   44.619284]  userfaultfd_release+0xef/0x1b0
[   44.620976]  __fput+0x3f9/0xb60
[   44.621240]  fput_close_sync+0x110/0x210
[   44.622222]  __x64_sys_close+0x8f/0x120
[   44.622530]  do_syscall_64+0x5b/0x2f0
[   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   44.623244] RIP: 0033:0x7f365bb3f227

Kernel panics because it detects UFFD inconsistency during
userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.

The inconsistency is caused in ksm_madvise(): when user calls madvise()
with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
mode, it accidentally clears all flags stored in the upper 32 bits of
vma->vm_flags.

Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
and int are 32-bit wide. This setup causes the following mishap during
the &= ~VM_MERGEABLE assignment.

VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
promoted to unsigned long before the & operation. This promotion fills
upper 32 bits with leading 0s, as we're doing unsigned conversion (and
even for a signed conversion, this wouldn't help as the leading bit is
0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
the upper 32-bits of its value.

Fix it by changing `VM_MERGEABLE` constant to unsigned long. Modify all
other VM_* flags constants for consistency.

Note: other VM_* flags are not affected:
This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
all constants of type int and after ~ operation, they end up with
leading 1 and are thus converted to unsigned long with leading 1s.

Note 2:
After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
no longer a kernel BUG, but a WARNING at the same place:

[   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067

but the root-cause (flag-drop) remains the same.

Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
v1 -> v2: 
- fix by adding ul to flag constants instead of explicit cast.
- drop Mike Kravetz <mike.kravetz@oracle.com> from cc, as the mail
  returned

v1:
https://lore.kernel.org/all/20250930063921.62354-1-acsjakub@amazon.de/

 include/linux/mm.h | 72 +++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..26a5c0f78b36 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -246,57 +246,57 @@ extern unsigned int kobjsize(const void *objp);
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
-#define VM_NONE		0x00000000
+#define VM_NONE		0x00000000ul
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+#define VM_READ		0x00000001ul	/* currently active flags */
+#define VM_WRITE	0x00000002ul
+#define VM_EXEC		0x00000004ul
+#define VM_SHARED	0x00000008ul
 
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
+#define VM_MAYREAD	0x00000010ul	/* limits for mprotect() etc */
+#define VM_MAYWRITE	0x00000020ul
+#define VM_MAYEXEC	0x00000040ul
+#define VM_MAYSHARE	0x00000080ul
 
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
+#define VM_GROWSDOWN	0x00000100ul	/* general info on the segment */
 #ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
+#define VM_UFFD_MISSING	0x00000200ul	/* missing pages tracking */
 #else /* CONFIG_MMU */
-#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
-#define VM_UFFD_MISSING	0
+#define VM_MAYOVERLAY	0x00000200ul	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+#define VM_UFFD_MISSING	0ul
 #endif /* CONFIG_MMU */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
+#define VM_PFNMAP	0x00000400ul	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_UFFD_WP	0x00001000ul	/* wrprotect pages tracking */
 
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
+#define VM_LOCKED	0x00002000ul
+#define VM_IO           0x00004000ul	/* Memory mapped I/O or similar */
 
 					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_SYNC		0x00800000	/* Synchronous page faults */
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+#define VM_SEQ_READ	0x00008000ul	/* App will access data sequentially */
+#define VM_RAND_READ	0x00010000ul	/* App will not benefit from clustered reads */
+
+#define VM_DONTCOPY	0x00020000ul    /* Do not copy this vma on fork */
+#define VM_DONTEXPAND	0x00040000ul	/* Cannot expand with mremap() */
+#define VM_LOCKONFAULT	0x00080000ul	/* Lock the pages covered when they are faulted in */
+#define VM_ACCOUNT	0x00100000ul	/* Is a VM accounted object */
+#define VM_NORESERVE	0x00200000ul	/* should the VM suppress accounting */
+#define VM_HUGETLB	0x00400000ul	/* Huge TLB Page VM */
+#define VM_SYNC		0x00800000ul	/* Synchronous page faults */
+#define VM_ARCH_1	0x01000000ul	/* Architecture-specific flag */
+#define VM_WIPEONFORK	0x02000000ul	/* Wipe VMA contents in child. */
+#define VM_DONTDUMP	0x04000000ul	/* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+# define VM_SOFTDIRTY	0x08000000ul	/* Not soft dirty clean area */
 #else
-# define VM_SOFTDIRTY	0
+# define VM_SOFTDIRTY	0ul
 #endif
 
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+#define VM_MIXEDMAP	0x10000000ul	/* Can contain "struct page" and pure PFN pages */
+#define VM_HUGEPAGE	0x20000000ul	/* MADV_HUGEPAGE marked this vma */
+#define VM_NOHUGEPAGE	0x40000000ul	/* MADV_NOHUGEPAGE marked this vma */
+#define VM_MERGEABLE	0x80000000ul	/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


