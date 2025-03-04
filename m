Return-Path: <stable+bounces-120315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A2FA4E7EC
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD87B4226D7
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372027C15B;
	Tue,  4 Mar 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJa5SHuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF628FFD9
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106501; cv=none; b=nN9qqlhQDXzIVF7Q3Mvc43DqaRgH+15tBUxJtM/KCJn2JW9JnAN2WBVD6Ghfi0yonoQZ2SHsrni77RcLb3gHdZdNRIRJFEZYiHc9b4t22rWSFT6i+U29zNOI0z6Zy+k0HyXL9A0KS70OlrDupYBVY3MRT8aj9cWMJlXXB3w+o2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106501; c=relaxed/simple;
	bh=aQpS4CxptC484zEsOK8+dFZungJZCiw8eJngOXELvUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=THrstoQC3c7jKXBCqUsnsmJKBwcmcNNqyDwb0KxKFY1OlxKuMh9XrBkjM2EI6e1do3v4xr4xNYk/yEADd3ZphjV3HFZSrIxAkqDMI1G3zzC4E3wnmK42xfCe7rmnFl7id5sukBQV+iG6i+dhKJ0x+PYMEb0ZfK74yoJuzXmfM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJa5SHuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33935C4CEE5;
	Tue,  4 Mar 2025 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106501;
	bh=aQpS4CxptC484zEsOK8+dFZungJZCiw8eJngOXELvUQ=;
	h=Subject:To:Cc:From:Date:From;
	b=pJa5SHuX/T5yibjFG9Hak/+eYhIlI4s+NWDyunCUMzeB22UoHmLwgfpi3gt1BcVK0
	 OxLikTx3paDVBx+BebduAlcieSQHSeR8rzBRlBUitETxSK+h+LWbFxYO2PMhiS/2zo
	 w/+REok9XFIcvAvC//kt7Bwe3zS898IRbsytuwJ8=
Subject: FAILED: patch "[PATCH] mm: hugetlb: Add huge page size param to" failed to apply to 6.6-stable tree
To: ryan.roberts@arm.com,agordeev@linux.ibm.com,alexghiti@rivosinc.com,anshuman.khandual@arm.com,catalin.marinas@arm.com,christophe.leroy@csgroup.eu,david@redhat.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:41:36 +0100
Message-ID: <2025030436-idealize-unsaddle-3c68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 02410ac72ac3707936c07ede66e94360d0d65319
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030436-idealize-unsaddle-3c68@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02410ac72ac3707936c07ede66e94360d0d65319 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Wed, 26 Feb 2025 12:06:51 +0000
Subject: [PATCH] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()

In order to fix a bug, arm64 needs to be told the size of the huge page
for which the huge_pte is being cleared in huge_ptep_get_and_clear().
Provide for this by adding an `unsigned long sz` parameter to the
function. This follows the same pattern as huge_pte_clear() and
set_huge_pte_at().

This commit makes the required interface modifications to the core mm as
well as all arches that implement this function (arm64, loongarch, mips,
parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
in a separate commit.

Cc: stable@vger.kernel.org
Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
Link: https://lore.kernel.org/r/20250226120656.2400136-2-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index c6dff3e69539..03db9cb21ace 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -42,8 +42,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-				     unsigned long addr, pte_t *ptep);
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 98a2a0e64e25..06db4649af91 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -396,8 +396,8 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		__pte_clear(mm, addr, ptep);
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz)
 {
 	int ncontig;
 	size_t pgsize;
@@ -549,6 +549,8 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 
 pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
 		/*
 		 * Break-before-make (BBM) is required for all user space mappings
@@ -558,7 +560,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 		if (pte_user_exec(__ptep_get(ptep)))
 			return huge_ptep_clear_flush(vma, addr, ptep);
 	}
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 
 void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index c8e4057734d0..4dc4b3e04225 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -36,7 +36,8 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = ptep_get(ptep);
@@ -51,8 +52,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index d0a86ce83de9..fbc71ddcf0f6 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -27,7 +27,8 @@ static inline int prepare_hugepage_range(struct file *file,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -42,13 +43,14 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
 	/*
 	 * clear the huge pte entry firstly, so that the other smp threads will
 	 * not get old pte entry after finishing flush_tlb_page and before
 	 * setting new huge pte entry
 	 */
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 5b3a5429f71b..21e9ace17739 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -10,7 +10,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index e9d18cf25b79..a94fe546d434 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -126,7 +126,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t entry;
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index dad2e7980f24..86326587e58d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -45,7 +45,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
 }
@@ -55,8 +56,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_hugetlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index faf3624d8057..446126497768 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -28,7 +28,8 @@ void set_huge_pte_at(struct mm_struct *mm,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+			      unsigned long addr, pte_t *ptep,
+			      unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 42314f093922..b4a78a4b35cf 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -293,7 +293,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t orig_pte = ptep_get(ptep);
 	int pte_num;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 7c52acaf9f82..663e87220e89 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -25,8 +25,16 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 #define __HAVE_ARCH_HUGE_PTEP_GET
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep);
+
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
+{
+	return __huge_ptep_get_and_clear(mm, addr, ptep);
+}
 
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
@@ -48,7 +56,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long address, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
+	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
 
 #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
@@ -59,7 +67,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 
 	if (changed) {
-		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
 	}
 	return changed;
@@ -69,7 +77,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
+	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
 
 	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index d9ce199953de..2e568f175cd4 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -188,8 +188,8 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	return __rste_to_pte(pte_val(*ptep));
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index c714ca6a05aa..e7a9cdd498dc 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -20,7 +20,7 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index eee601a0d2cf..80504148d8a5 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -260,7 +260,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index f42133dae68e..2afc95bf1655 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -90,7 +90,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, pte_t *ptep, unsigned long sz)
 {
 	return ptep_get_and_clear(mm, addr, ptep);
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ec8c0ccc8f95..bf5f7256bd28 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1004,7 +1004,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
 						unsigned long addr, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 #endif
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 65068671e460..de9d49e521c1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5447,7 +5447,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
 	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
@@ -5622,7 +5622,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
+		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);


