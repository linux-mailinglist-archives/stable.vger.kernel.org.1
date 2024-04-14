Return-Path: <stable+bounces-36762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA389C18E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F37A1C21D11
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E47EF06;
	Mon,  8 Apr 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZhZO8u+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816E7EEE1;
	Mon,  8 Apr 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582270; cv=none; b=lP5WNq5dquvMq0bK00ScDjbO5KhLCXWnvN1+VVY+f18jwdQncDUQ3WWi+Ka6Ym4SHxgcrK1pHY436IoU5lN9dkCbs7EUSvU28RBoR+sAWV9Pxi51JOmwXySb50i2j0Vwqw0EmvsNtGadKp0U0DlPbMwLo+OEWXNnnK9VzIruXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582270; c=relaxed/simple;
	bh=EDESPvVzWbQCKxbb0sI+gOGj/Ko6EPiJ0RmtmhaSrfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRgw8pt271Z5SaGB+d15cvZNyT5zztHtZKuqR647qFq3WwdG8ofV8ev6BhJ3lh0BHhL1cwMRslMn9PPmCCZhqllO2qrMece0ZH9i+5DJ2Xkn6ZWqnYQSFCFdgFXQ3Fn1D25EMJJx6hVy4QxRHQfLOebw4Vi8Ze9UDHRYpD2ZNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZhZO8u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9437AC43390;
	Mon,  8 Apr 2024 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582270;
	bh=EDESPvVzWbQCKxbb0sI+gOGj/Ko6EPiJ0RmtmhaSrfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZhZO8u+GGp9UWEj1zw2el26x5fbANyM6nFCcjaMbTnlddGckPY6AiAcMIX8+McMM
	 /AxEI2Bj3b2Ian12Bw1Cu9thuCtoIvNWIjfKLc4zCt3BEqxQ1OO+ueRBRrUA50qA6Y
	 3xDkK2FcqO5kw957MZyBRc9K7HB4/9G+tkdVxJX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Xu <peterx@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 061/273] mm/treewide: replace pud_large() with pud_leaf()
Date: Mon,  8 Apr 2024 14:55:36 +0200
Message-ID: <20240408125311.193630178@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Xu <peterx@redhat.com>

[ Upstream commit 0a845e0f6348ccfa2dcc8c450ffd1c9ffe8c4add ]

pud_large() is always defined as pud_leaf().  Merge their usages.  Chose
pud_leaf() because pud_leaf() is a global API, while pud_large() is not.

Link: https://lkml.kernel.org/r/20240305043750.93762-9-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c567f2948f57 ("Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/pgtable.c | 2 +-
 arch/s390/boot/vmem.c              | 2 +-
 arch/s390/include/asm/pgtable.h    | 4 ++--
 arch/s390/mm/gmap.c                | 2 +-
 arch/s390/mm/hugetlbpage.c         | 4 ++--
 arch/s390/mm/pageattr.c            | 2 +-
 arch/s390/mm/pgtable.c             | 2 +-
 arch/s390/mm/vmem.c                | 6 +++---
 arch/sparc/mm/init_64.c            | 2 +-
 arch/x86/kvm/mmu/mmu.c             | 2 +-
 arch/x86/mm/fault.c                | 4 ++--
 arch/x86/mm/ident_map.c            | 2 +-
 arch/x86/mm/init_64.c              | 4 ++--
 arch/x86/mm/kasan_init_64.c        | 2 +-
 arch/x86/mm/mem_encrypt_identity.c | 2 +-
 arch/x86/mm/pat/set_memory.c       | 6 +++---
 arch/x86/mm/pgtable.c              | 2 +-
 arch/x86/mm/pti.c                  | 2 +-
 arch/x86/power/hibernate.c         | 2 +-
 arch/x86/xen/mmu_pv.c              | 4 ++--
 20 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 3438ab72c346b..d975fb5d7cbe4 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -130,7 +130,7 @@ void set_pud_at(struct mm_struct *mm, unsigned long addr,
 
 	WARN_ON(pte_hw_valid(pud_pte(*pudp)));
 	assert_spin_locked(pud_lockptr(mm, pudp));
-	WARN_ON(!(pud_large(pud)));
+	WARN_ON(!(pud_leaf(pud)));
 #endif
 	trace_hugepage_set_pud(addr, pud_val(pud));
 	return set_pte_at(mm, addr, pudp_ptep(pudp), pud_pte(pud));
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index e3a4500a5a757..47e1f54c587ae 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -366,7 +366,7 @@ static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long e
 			}
 			pmd = boot_crst_alloc(_SEGMENT_ENTRY_EMPTY);
 			pud_populate(&init_mm, pud, pmd);
-		} else if (pud_large(*pud)) {
+		} else if (pud_leaf(*pud)) {
 			continue;
 		}
 		pgtable_pmd_populate(pud, addr, next, mode);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1299b56e43f6f..12a7b86789259 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -730,7 +730,7 @@ static inline int pud_bad(pud_t pud)
 {
 	unsigned long type = pud_val(pud) & _REGION_ENTRY_TYPE_MASK;
 
-	if (type > _REGION_ENTRY_TYPE_R3 || pud_large(pud))
+	if (type > _REGION_ENTRY_TYPE_R3 || pud_leaf(pud))
 		return 1;
 	if (type < _REGION_ENTRY_TYPE_R3)
 		return 0;
@@ -1398,7 +1398,7 @@ static inline unsigned long pud_deref(pud_t pud)
 	unsigned long origin_mask;
 
 	origin_mask = _REGION_ENTRY_ORIGIN;
-	if (pud_large(pud))
+	if (pud_leaf(pud))
 		origin_mask = _REGION3_ENTRY_ORIGIN_LARGE;
 	return (unsigned long)__va(pud_val(pud) & origin_mask);
 }
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 8da39deb56ca4..08a7eca03daf7 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -596,7 +596,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	pud = pud_offset(p4d, vmaddr);
 	VM_BUG_ON(pud_none(*pud));
 	/* large puds cannot yet be handled */
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return -EFAULT;
 	pmd = pmd_offset(pud, vmaddr);
 	VM_BUG_ON(pmd_none(*pmd));
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 297a6d897d5a0..5f64f3d0fafbb 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		if (p4d_present(*p4dp)) {
 			pudp = pud_offset(p4dp, addr);
 			if (pud_present(*pudp)) {
-				if (pud_large(*pudp))
+				if (pud_leaf(*pudp))
 					return (pte_t *) pudp;
 				pmdp = pmd_offset(pudp, addr);
 			}
@@ -240,7 +240,7 @@ int pmd_huge(pmd_t pmd)
 
 int pud_huge(pud_t pud)
 {
-	return pud_large(pud);
+	return pud_leaf(pud);
 }
 
 bool __init arch_hugetlb_valid_size(unsigned long size)
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 631e3a4ee2de8..739185fc39ead 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -274,7 +274,7 @@ static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (pud_none(*pudp))
 			return -EINVAL;
 		next = pud_addr_end(addr, end);
-		if (pud_large(*pudp)) {
+		if (pud_leaf(*pudp)) {
 			need_split  = !!(flags & SET_MEMORY_4K);
 			need_split |= !!(addr & ~PUD_MASK);
 			need_split |= !!(addr + PUD_SIZE > next);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 99422926efe1b..3ff07b6bcd65a 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -470,7 +470,7 @@ static int pmd_lookup(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 		return -ENOENT;
 
 	/* Large PUDs are not supported yet. */
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return -EFAULT;
 
 	*pmdp = pmd_offset(pud, addr);
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 186a020857cf6..84e173c02ab91 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -323,7 +323,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (!add) {
 			if (pud_none(*pud))
 				continue;
-			if (pud_large(*pud)) {
+			if (pud_leaf(*pud)) {
 				if (IS_ALIGNED(addr, PUD_SIZE) &&
 				    IS_ALIGNED(next, PUD_SIZE)) {
 					pud_clear(pud);
@@ -344,7 +344,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 			if (!pmd)
 				goto out;
 			pud_populate(&init_mm, pud, pmd);
-		} else if (pud_large(*pud)) {
+		} else if (pud_leaf(*pud)) {
 			continue;
 		}
 		ret = modify_pmd_table(pud, addr, next, add, direct);
@@ -591,7 +591,7 @@ pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc)
 		if (!pmd)
 			goto out;
 		pud_populate(&init_mm, pud, pmd);
-	} else if (WARN_ON_ONCE(pud_large(*pud))) {
+	} else if (WARN_ON_ONCE(pud_leaf(*pud))) {
 		goto out;
 	}
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f83017992eaae..d7db4e737218c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1665,7 +1665,7 @@ bool kern_addr_valid(unsigned long addr)
 	if (pud_none(*pud))
 		return false;
 
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return pfn_valid(pud_pfn(*pud));
 
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0544700ca50b8..e2c3573f53e43 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3126,7 +3126,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	if (pud_none(pud) || !pud_present(pud))
 		goto out;
 
-	if (pud_large(pud)) {
+	if (pud_leaf(pud)) {
 		level = PG_LEVEL_1G;
 		goto out;
 	}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d6375b3c633bc..b01df023de04c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -376,7 +376,7 @@ static void dump_pagetable(unsigned long address)
 		goto bad;
 
 	pr_cont("PUD %lx ", pud_val(*pud));
-	if (!pud_present(*pud) || pud_large(*pud))
+	if (!pud_present(*pud) || pud_leaf(*pud))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
@@ -1037,7 +1037,7 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 	if (!pud_present(*pud))
 		return 0;
 
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return spurious_kernel_fault_check(error_code, (pte_t *) pud);
 
 	pmd = pmd_offset(pud, address);
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index f50cc210a9818..a204a332c71fc 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -33,7 +33,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 			next = end;
 
 		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_large(*pud))
+		if (pud_leaf(*pud))
 			continue;
 
 		/* Is using a gbpage allowed? */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a0dffaca6d2bf..534436c9d3997 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -617,7 +617,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		}
 
 		if (!pud_none(*pud)) {
-			if (!pud_large(*pud)) {
+			if (!pud_leaf(*pud)) {
 				pmd = pmd_offset(pud, 0);
 				paddr_last = phys_pmd_init(pmd, paddr,
 							   paddr_end,
@@ -1163,7 +1163,7 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 		if (!pud_present(*pud))
 			continue;
 
-		if (pud_large(*pud) &&
+		if (pud_leaf(*pud) &&
 		    IS_ALIGNED(addr, PUD_SIZE) &&
 		    IS_ALIGNED(next, PUD_SIZE)) {
 			spin_lock(&init_mm.page_table_lock);
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0302491d799d1..fcf508c52bdc5 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -115,7 +115,7 @@ static void __init kasan_populate_p4d(p4d_t *p4d, unsigned long addr,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (!pud_large(*pud))
+		if (!pud_leaf(*pud))
 			kasan_populate_pud(pud, addr, next, nid);
 	} while (pud++, addr = next, addr != end);
 }
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1780ccb..ead3561359242 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -144,7 +144,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 		set_pud(pud, __pud(PUD_FLAGS | __pa(pmd)));
 	}
 
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return NULL;
 
 	return pud;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1028804040463..135bb594df8b7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -684,7 +684,7 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 		return NULL;
 
 	*level = PG_LEVEL_1G;
-	if (pud_large(*pud) || !pud_present(*pud))
+	if (pud_leaf(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
 	pmd = pmd_offset(pud, address);
@@ -743,7 +743,7 @@ pmd_t *lookup_pmd_address(unsigned long address)
 		return NULL;
 
 	pud = pud_offset(p4d, address);
-	if (pud_none(*pud) || pud_large(*pud) || !pud_present(*pud))
+	if (pud_none(*pud) || pud_leaf(*pud) || !pud_present(*pud))
 		return NULL;
 
 	return pmd_offset(pud, address);
@@ -1278,7 +1278,7 @@ static void unmap_pud_range(p4d_t *p4d, unsigned long start, unsigned long end)
 	 */
 	while (end - start >= PUD_SIZE) {
 
-		if (pud_large(*pud))
+		if (pud_leaf(*pud))
 			pud_clear(pud);
 		else
 			unmap_pmd_range(pud, start, start + PUD_SIZE);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0cbc1b8e8e3d1..a67bb8f982bd5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -777,7 +777,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
  */
 int pud_clear_huge(pud_t *pud)
 {
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		pud_clear(pud);
 		return 1;
 	}
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 669ba1c345b38..912b1da7ed80c 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -217,7 +217,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 
 	pud = pud_offset(p4d, address);
 	/* The user page tables do not use large mappings: */
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		WARN_ON(1);
 		return NULL;
 	}
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 6f955eb1e1631..d8af46e677503 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -170,7 +170,7 @@ int relocate_restore_code(void)
 		goto out;
 	}
 	pud = pud_offset(p4d, relocated_restore_code);
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
 		goto out;
 	}
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 72af496a160c8..994aef4473a65 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1082,7 +1082,7 @@ static void __init xen_cleanmfnmap_pud(pud_t *pud, bool unpin)
 	pmd_t *pmd_tbl;
 	int i;
 
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		pa = pud_val(*pud) & PHYSICAL_PAGE_MASK;
 		xen_free_ro_pages(pa, PUD_SIZE);
 		return;
@@ -1863,7 +1863,7 @@ static phys_addr_t __init xen_early_virt_to_phys(unsigned long vaddr)
 	if (!pud_present(pud))
 		return 0;
 	pa = pud_val(pud) & PTE_PFN_MASK;
-	if (pud_large(pud))
+	if (pud_leaf(pud))
 		return pa + (vaddr & ~PUD_MASK);
 
 	pmd = native_make_pmd(xen_read_phys_ulong(pa + pmd_index(vaddr) *
-- 
2.43.0




