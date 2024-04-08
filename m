Return-Path: <stable+bounces-36405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD1189BF7C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26E91F22804
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12F6F065;
	Mon,  8 Apr 2024 12:52:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438664CF2
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580762; cv=none; b=ac1JqFLGVeg7fdHgqDwVdK1FNrx8dZ/lK4YXWILPM5ecdFT+hjrzqCdDNvG/YglBK36NrtABT6PKLFaFoGD1E4U4J7D81hsRoekMg3P+B1dlFlzyT8ZoKCzhgOikLi6/e9DUQGmYH9iTXJFi1W+iJe9AvTahPUiIuIGC8DTj0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580762; c=relaxed/simple;
	bh=ifaxlRYgBds8zwS4KgTva2occA8f2QrxdNr6ELiIu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/uQjJFV4QmhPxRdmSojnLh2D/lzHAolTA7PK771ibaBlXUbopInfu/Y9PTQpFW3V2jLq1u4ZNSYT7xiucG97WYW80EWcPwbnrCw1PZoRiBZT+MBk0ZZwTSh1PB8IVXenJciUinSdx+FAFb9GdpkhLhwLP2F/9HnQRhfzgtcMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 32C1D2F20247; Mon,  8 Apr 2024 12:52:37 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 17C3A2F20247;
	Mon,  8 Apr 2024 12:52:28 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Toshi Kani <toshi.kani@hp.com>,
	lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	Ma Wupeng <mawupeng1@huawei.com>,
	syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 6.1] x86/mm/pat: clear VM_PAT if copy_p4d_range failed
Date: Mon,  8 Apr 2024 15:52:01 +0300
Message-ID: <20240408125201.1844843-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ma Wupeng <mawupeng1@huawei.com>

[ Upstream commit d155df53f31068c3340733d586eb9b3ddfd70fc5 ]

Syzbot reports a warning in untrack_pfn().  Digging into the root we found
that this is due to memory allocation failure in pmd_alloc_one.  And this
failure is produced due to failslab.

In copy_page_range(), memory alloaction for pmd failed.  During the error
handling process in copy_page_range(), mmput() is called to remove all
vmas.  While untrack_pfn this empty pfn, warning happens.

Here's a simplified flow:

dup_mm
  dup_mmap
    copy_page_range
      copy_p4d_range
        copy_pud_range
          copy_pmd_range
            pmd_alloc
              __pmd_alloc
                pmd_alloc_one
                  page = alloc_pages(gfp, 0);
                    if (!page)
                      return NULL;
    mmput
        exit_mmap
          unmap_vmas
            unmap_single_vma
              untrack_pfn
                follow_phys
                  WARN_ON_ONCE(1);

Since this vma is not generate successfully, we can clear flag VM_PAT.  In
this case, untrack_pfn() will not be called while cleaning this vma.

Function untrack_pfn_moved() has also been renamed to fit the new logic.

Link: https://lkml.kernel.org/r/20230217025615.1595558-1-mawupeng1@huawei.com
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Reported-by: <syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 arch/x86/mm/pat/memtype.c | 12 ++++++++----
 include/linux/pgtable.h   |  7 ++++---
 mm/memory.c               |  1 +
 mm/mremap.c               |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 66a209f7eb86d..ed07807845ab0 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1116,11 +1116,15 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 }
 
 /*
- * untrack_pfn_moved is called, while mremapping a pfnmap for a new region,
- * with the old vma after its pfnmap page table has been removed.  The new
- * vma has a new pfnmap to the same pfn & cache type with VM_PAT set.
+ * untrack_pfn_clear is called if the following situation fits:
+ *
+ * 1) while mremapping a pfnmap for a new region,  with the old vma after
+ * its pfnmap page table has been removed.  The new vma has a new pfnmap
+ * to the same pfn & cache type with VM_PAT set.
+ * 2) while duplicating vm area, the new vma fails to copy the pgtable from
+ * old vma.
  */
-void untrack_pfn_moved(struct vm_area_struct *vma)
+void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vma->vm_flags &= ~VM_PAT;
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5f0d7d0b9471b..cce5f8ab461c6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1214,9 +1214,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_moved is called while mremapping a pfnmap for a new region.
+ * untrack_pfn_clear is called while mremapping a pfnmap for a new region
+ * or fails to copy pgtable during duplicate vm area.
  */
-static inline void untrack_pfn_moved(struct vm_area_struct *vma)
+static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 }
 #else
@@ -1228,7 +1229,7 @@ extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 extern int track_pfn_copy(struct vm_area_struct *vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size);
-extern void untrack_pfn_moved(struct vm_area_struct *vma);
+extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/mm/memory.c b/mm/memory.c
index fb83cf56377ab..91e2d4520e4d4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1335,6 +1335,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
+			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
diff --git a/mm/mremap.c b/mm/mremap.c
index 930f65c315c02..6ed28eeae5a84 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -682,7 +682,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_moved(vma);
+		untrack_pfn_clear(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-- 
2.42.1


