Return-Path: <stable+bounces-130741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69590A8063C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295234C042A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612926A095;
	Tue,  8 Apr 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjJMb7b9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAB26A08B;
	Tue,  8 Apr 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114525; cv=none; b=R8n4JyW4pa/PrRoLRzEUb14l+T0vdZiFZeUKj50wDhoHjNIPhVm9iv+zGERYhp1OtbeiAr8FUYNAKdufrqch4Lrg9qgMvLMWMDJ11fTP+xlQs4Hp34K4JwgwWwUAenu8k1DqBlkjU5Cp79tGQOcVysFJW3aSouvtQoQw1zch5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114525; c=relaxed/simple;
	bh=vHjtYTbN3Z/5z+wltAQfQeD/vLv0YGiq7sRasg2gPqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZNw77egPp+Q9q+koG2bba+zsia6NT81UpqtFJ7YW5bCmNXHY07vPSINV5pwUkeZ0YB/RICw+HFhNDn4NFL4YaS2MQVVZT/m+n8xXsDm/dvgJK2c4G51FVWYpIe6PsyY1zc3lqGtLKwBYlFDy2vcF+/Z/6bh583kWA4X7ADMOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjJMb7b9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5897C4CEE5;
	Tue,  8 Apr 2025 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114525;
	bh=vHjtYTbN3Z/5z+wltAQfQeD/vLv0YGiq7sRasg2gPqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjJMb7b9eu2EZ48+5wuCCOwl/IE2Yi7i/6JRkhyPzb0t8BErtu7Mj6+BwFtmti4kI
	 GyzN+jqFYd/WhiE0SU4FkINv9yr3ZfTLci8EOmEvwAt98MK6/r8CqoFqoe08Dbxwr6
	 mMYyJ/wdSw8Bc/Y1yALR6yH4Zy3KrvDwni22O6KA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 140/499] x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()
Date: Tue,  8 Apr 2025 12:45:52 +0200
Message-ID: <20250408104854.682016603@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

[ Upstream commit dc84bc2aba85a1508f04a936f9f9a15f64ebfb31 ]

If track_pfn_copy() fails, we already added the dst VMA to the maple
tree. As fork() fails, we'll cleanup the maple tree, and stumble over
the dst VMA for which we neither performed any reservation nor copied
any page tables.

Consequently untrack_pfn() will see VM_PAT and try obtaining the
PAT information from the page table -- which fails because the page
table was not copied.

The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
if track_pfn_copy() fails. However, the whole thing is about "simply"
clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
and performed a reservation, but copying the page tables fails, we'll
simply clear the VM_PAT flag, not properly undoing the reservation ...
which is also wrong.

So let's fix it properly: set the VM_PAT flag only if the reservation
succeeded (leaving it clear initially), and undo the reservation if
anything goes wrong while copying the page tables: clearing the VM_PAT
flag after undoing the reservation.

Note that any copied page table entries will get zapped when the VMA will
get removed later, after copy_page_range() succeeded; as VM_PAT is not set
then, we won't try cleaning VM_PAT up once more and untrack_pfn() will be
happy. Note that leaving these page tables in place without a reservation
is not a problem, as we are aborting fork(); this process will never run.

A reproducer can trigger this usually at the first try:

  https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/pat_fork.c

  WARNING: CPU: 26 PID: 11650 at arch/x86/mm/pat/memtype.c:983 get_pat_info+0xf6/0x110
  Modules linked in: ...
  CPU: 26 UID: 0 PID: 11650 Comm: repro3 Not tainted 6.12.0-rc5+ #92
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:get_pat_info+0xf6/0x110
  ...
  Call Trace:
   <TASK>
   ...
   untrack_pfn+0x52/0x110
   unmap_single_vma+0xa6/0xe0
   unmap_vmas+0x105/0x1f0
   exit_mmap+0xf6/0x460
   __mmput+0x4b/0x120
   copy_process+0x1bf6/0x2aa0
   kernel_clone+0xab/0x440
   __do_sys_clone+0x66/0x90
   do_syscall_64+0x95/0x180

Likely this case was missed in:

  d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")

... and instead of undoing the reservation we simply cleared the VM_PAT flag.

Keep the documentation of these functions in include/linux/pgtable.h,
one place is more than sufficient -- we should clean that up for the other
functions like track_pfn_remap/untrack_pfn separately.

Fixes: d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")
Fixes: 2ab640379a0a ("x86: PAT: hooks in generic vm code to help archs to track pfnmap regions - v3")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yuxin wang <wang1315768607@163.com>
Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20250321112323.153741-1-david@redhat.com
Closes: https://lore.kernel.org/lkml/CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com/
Closes: https://lore.kernel.org/lkml/CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/memtype.c | 52 +++++++++++++++++++++------------------
 include/linux/pgtable.h   | 28 ++++++++++++++++-----
 kernel/fork.c             |  4 +++
 mm/memory.c               | 11 +++------
 4 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf2..d721cc19addbd 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,29 +984,42 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 	return -EINVAL;
 }
 
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
+int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
+	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
 	resource_size_t paddr;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
+	int rc;
 
-	if (vma->vm_flags & VM_PAT) {
-		if (get_pat_info(vma, &paddr, &pgprot))
-			return -EINVAL;
-		/* reserve the whole chunk covered by vma. */
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
-	}
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
+
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (rc)
+		return rc;
 
+	/* Reservation for the destination VMA succeeded. */
+	vm_flags_set(dst_vma, VM_PAT);
+	*pfn = PHYS_PFN(paddr);
 	return 0;
 }
 
+void untrack_pfn_copy(struct vm_area_struct *dst_vma, unsigned long pfn)
+{
+	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start, true);
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+}
+
 /*
  * prot is passed in as a parameter for the new mapping. If the vma has
  * a linear pfn mapping for the entire range, or no vma is provided,
@@ -1095,15 +1108,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	}
 }
 
-/*
- * untrack_pfn_clear is called if the following situation fits:
- *
- * 1) while mremapping a pfnmap for a new region,  with the old vma after
- * its pfnmap page table has been removed.  The new vma has a new pfnmap
- * to the same pfn & cache type with VM_PAT set.
- * 2) while duplicating vm area, the new vma fails to copy the pgtable from
- * old vma.
- */
 void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vm_flags_clear(vma, VM_PAT);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index adef9d6e9b1ba..468ddc7e7aea4 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1501,14 +1501,25 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range(). On success, stores the pfn to be
+ * passed to untrack_pfn_copy().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
 	return 0;
 }
 
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn)
+{
+}
+
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
@@ -1521,8 +1532,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_clear is called while mremapping a pfnmap for a new region
- * or fails to copy pgtable during duplicate vm area.
+ * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
+ *
+ * 1) During mremap() on the src VMA after the page tables were moved.
+ * 2) During fork() on the dst VMA, immediately after duplicating the src VMA.
  */
 static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
@@ -1533,7 +1546,10 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn);
+extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9da032802e347..4fc3611435501 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -504,6 +504,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
+	/* track_pfn_copy() will later take care of copying internal state. */
+	if (unlikely(new->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(new);
+
 	return new;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 5fdfdbc65e58d..058234fbd0308 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1362,12 +1362,12 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
 	unsigned long addr = src_vma->vm_start;
 	unsigned long end = src_vma->vm_end;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct mmu_notifier_range range;
+	unsigned long next, pfn;
 	bool is_cow;
 	int ret;
 
@@ -1378,11 +1378,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
 		if (ret)
 			return ret;
 	}
@@ -1419,7 +1415,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1429,6 +1424,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, pfn);
 	return ret;
 }
 
-- 
2.39.5




