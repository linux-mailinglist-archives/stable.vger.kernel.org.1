Return-Path: <stable+bounces-121250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C2A54E1B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7854188ECE7
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E131422D4;
	Thu,  6 Mar 2025 14:47:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4962038DE0
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272449; cv=none; b=Lab2yCo6nS9FU+qQZPjAXXWtix0WA7yPDjdTJkbCeVsjlUff8ILg6A8ws8BCVuWkjaREb++VV3qTP0ZJ310FpHXVid6SlaY2YiB5Am/GmygUxcKJeaLCbcgyRflIxq7BFpeS2Tf//QchZnSWbenZgIHLQLKlcVMh0pEjEwG9+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272449; c=relaxed/simple;
	bh=i9berVgAvY0SClYWhSnTJCQDxTDuxEXKrcmNNuV1yYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCkyXFkE3QGkJYV3Ozpb5UespTdw7YwlPA0VzOmFSC5RHWl4DvxQhLq6EJAFgsLaG4zJolGupxxVTRPqBOvvIiuoMPqcyqVHzwvBmieX5O/rqph6rHDVBR37k/O6dVvbyiTyVgui4751HVUTcv/fg6f4N31bu7xNLZTSEsspF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C971007;
	Thu,  6 Mar 2025 06:47:39 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62A4A3F66E;
	Thu,  6 Mar 2025 06:47:25 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6.y] mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
Date: Thu,  6 Mar 2025 14:47:16 +0000
Message-ID: <20250306144716.71199-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025030436-idealize-unsaddle-3c68@gregkh>
References: <2025030436-idealize-unsaddle-3c68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 02410ac72ac3707936c07ede66e94360d0d65319)
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/hugetlb.h     |  4 ++--
 arch/arm64/mm/hugetlbpage.c          |  8 +++++---
 arch/loongarch/include/asm/hugetlb.h |  6 ++++--
 arch/mips/include/asm/hugetlb.h      |  6 ++++--
 arch/parisc/include/asm/hugetlb.h    |  2 +-
 arch/parisc/mm/hugetlbpage.c         |  2 +-
 arch/powerpc/include/asm/hugetlb.h   |  6 ++++--
 arch/riscv/include/asm/hugetlb.h     |  3 ++-
 arch/riscv/mm/hugetlbpage.c          |  2 +-
 arch/s390/include/asm/hugetlb.h      | 17 ++++++++++++-----
 arch/s390/mm/hugetlbpage.c           |  4 ++--
 arch/sparc/include/asm/hugetlb.h     |  2 +-
 arch/sparc/mm/hugetlbpage.c          |  2 +-
 include/asm-generic/hugetlb.h        |  2 +-
 include/linux/hugetlb.h              |  4 +++-
 mm/hugetlb.c                         |  4 ++--
 16 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 2ddc33d93b13..92a5e0879b11 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -34,8 +34,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
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
index a5e1588780b2..f86a09309807 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -403,8 +403,8 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		pte_clear(mm, addr, ptep);
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz)
 {
 	int ncontig;
 	size_t pgsize;
@@ -556,6 +556,8 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 
 pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
 	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
 	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
 		/*
@@ -566,7 +568,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 		if (pte_user_exec(READ_ONCE(*ptep)))
 			return huge_ptep_clear_flush(vma, addr, ptep);
 	}
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 
 void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index 427b487fbfd6..7b88eda0ac7e 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -41,7 +41,8 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -56,8 +57,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
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
index fd69c8808554..00ee3c036630 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -32,7 +32,8 @@ static inline int prepare_hugepage_range(struct file *file,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -47,13 +48,14 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
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
index 72daacc472a0..f7a91411dcc9 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -10,7 +10,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index a9f7e21f6656..9e8da00e55f6 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -147,7 +147,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t entry;
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 8d8f4909ae1a..167c66c4e9ea 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -46,7 +46,8 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
 }
@@ -56,8 +57,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
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
index 22deb7a2a6ec..0e809026b6e3 100644
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
index 5ef2a6891158..c9d70dc310d5 100644
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
index deb198a61039..097b388d4e69 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -20,8 +20,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
 pte_t huge_ptep_get(pte_t *ptep);
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep);
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
+{
+	return __huge_ptep_get_and_clear(mm, addr, ptep);
+}
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
@@ -57,7 +64,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long address, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
+	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
 
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
@@ -66,7 +73,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	int changed = !pte_same(huge_ptep_get(ptep), pte);
 	if (changed) {
-		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
 	}
 	return changed;
@@ -75,7 +82,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
+	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
 	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 763469e518ee..5ebd730f1ffb 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -174,8 +174,8 @@ pte_t huge_ptep_get(pte_t *ptep)
 	return __rste_to_pte(pte_val(*ptep));
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = huge_ptep_get(ptep);
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
index b432500c13a5..8dad5d0995dc 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -371,7 +371,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 6dcf4d576970..2d7ae9b51d1e 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -84,7 +84,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, pte_t *ptep, unsigned long sz)
 {
 	return ptep_get_and_clear(mm, addr, ptep);
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0ca93c7574ad..fc2023d07f69 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1007,7 +1007,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
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
index 21c12519a7ef..faded25b19be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5236,7 +5236,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
 
 	if (src_ptl != dst_ptl)
@@ -5399,7 +5399,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
+		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
-- 
2.43.0


