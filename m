Return-Path: <stable+bounces-15332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589F8384CF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E6328ED1B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1A768FC;
	Tue, 23 Jan 2024 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycubfe2t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F376908;
	Tue, 23 Jan 2024 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975496; cv=none; b=Yk4CiEZRpOfQB315Wv1JyxmCM7iFY6ATrymjyRPMIPQEVbeWmRC0F9jKTLE0wlN894uVQdvOtQhfA6ujnyG3x/e5tRjNk/FNNVBDYdAyQU3aE0NNAXkMpA4yJDtJaT++lIfUTgGXSRvJeN+MxyFBDeFza7s1375Sxg+O/RCUoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975496; c=relaxed/simple;
	bh=BC9duqeS4flUaDoiUmEpQWB8FVQw89p2y34sHGfcD9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiyhW9VcgCH86CTsK1kze6jmofxj45VeMW0ISecm0PA4OujpCQ2OKn58t1ywqUVuSA/ekpDKxcLSuQIJZtGTJPayQLbUfj4+aW/xdUlfdSmLRAO6DnbMvBga5xqXZUXpek2llBWOmD3d5/UmbO4z9RoaUMmgAMXJJ2a5XYZ7OZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycubfe2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5C2C43390;
	Tue, 23 Jan 2024 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975496;
	bh=BC9duqeS4flUaDoiUmEpQWB8FVQw89p2y34sHGfcD9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ycubfe2t9nnwyet2MURKkagPO0NN7uvMrDYnc0sKXrDOqO0jWowU5uNm5ND6irXSf
	 /SvQKdCIHwnQBfjDIHTN7RknLNFPVAk7Hje1yajL5rBDywOOEiJ4fAWiKNthx5SE3B
	 0Vl7wTKeVtUK5o6vjL7ormephUVILIMLL8JGJwdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 451/583] riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
Date: Mon, 22 Jan 2024 15:58:22 -0800
Message-ID: <20240122235825.772992112@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 311cd2f6e25380cff0abc2884dc6a3d33bc9b5c3 ]

When STRICT_KERNEL_RWX is set, any change of permissions on any kernel
mapping (vmalloc/modules/kernel text...etc) should be applied on its
linear mapping alias. The problem is that the riscv kernel uses huge
mappings for the linear mapping and walk_page_range_novma() does not
split those huge mappings.

So this patchset implements such split in order to apply fine-grained
permissions on the linear mapping.

Below is the difference before and after (the first PUD mapping is split
into PTE/PMD mappings):

Before:

---[ Linear mapping ]---
0xffffaf8000080000-0xffffaf8000200000    0x0000000080080000      1536K PTE     D A G . . W R V
0xffffaf8000200000-0xffffaf8077c00000    0x0000000080200000      1914M PMD     D A G . . W R V
0xffffaf8077c00000-0xffffaf8078800000    0x00000000f7c00000        12M PMD     D A G . . . R V
0xffffaf8078800000-0xffffaf8078c00000    0x00000000f8800000         4M PMD     D A G . . W R V
0xffffaf8078c00000-0xffffaf8079200000    0x00000000f8c00000         6M PMD     D A G . . . R V
0xffffaf8079200000-0xffffaf807e600000    0x00000000f9200000        84M PMD     D A G . . W R V
0xffffaf807e600000-0xffffaf807e716000    0x00000000fe600000      1112K PTE     D A G . . W R V
0xffffaf807e717000-0xffffaf807e71a000    0x00000000fe717000        12K PTE     D A G . . W R V
0xffffaf807e71d000-0xffffaf807e71e000    0x00000000fe71d000         4K PTE     D A G . . W R V
0xffffaf807e722000-0xffffaf807e800000    0x00000000fe722000       888K PTE     D A G . . W R V
0xffffaf807e800000-0xffffaf807fe00000    0x00000000fe800000        22M PMD     D A G . . W R V
0xffffaf807fe00000-0xffffaf807ff54000    0x00000000ffe00000      1360K PTE     D A G . . W R V
0xffffaf807ff55000-0xffffaf8080000000    0x00000000fff55000       684K PTE     D A G . . W R V
0xffffaf8080000000-0xffffaf8400000000    0x0000000100000000        14G PUD     D A G . . W R V

After:

---[ Linear mapping ]---
0xffffaf8000080000-0xffffaf8000200000    0x0000000080080000      1536K PTE     D A G . . W R V
0xffffaf8000200000-0xffffaf8077c00000    0x0000000080200000      1914M PMD     D A G . . W R V
0xffffaf8077c00000-0xffffaf8078800000    0x00000000f7c00000        12M PMD     D A G . . . R V
0xffffaf8078800000-0xffffaf8078a00000    0x00000000f8800000         2M PMD     D A G . . W R V
0xffffaf8078a00000-0xffffaf8078c00000    0x00000000f8a00000         2M PTE     D A G . . W R V
0xffffaf8078c00000-0xffffaf8079200000    0x00000000f8c00000         6M PMD     D A G . . . R V
0xffffaf8079200000-0xffffaf807e600000    0x00000000f9200000        84M PMD     D A G . . W R V
0xffffaf807e600000-0xffffaf807e716000    0x00000000fe600000      1112K PTE     D A G . . W R V
0xffffaf807e717000-0xffffaf807e71a000    0x00000000fe717000        12K PTE     D A G . . W R V
0xffffaf807e71d000-0xffffaf807e71e000    0x00000000fe71d000         4K PTE     D A G . . W R V
0xffffaf807e722000-0xffffaf807e800000    0x00000000fe722000       888K PTE     D A G . . W R V
0xffffaf807e800000-0xffffaf807fe00000    0x00000000fe800000        22M PMD     D A G . . W R V
0xffffaf807fe00000-0xffffaf807ff54000    0x00000000ffe00000      1360K PTE     D A G . . W R V
0xffffaf807ff55000-0xffffaf8080000000    0x00000000fff55000       684K PTE     D A G . . W R V
0xffffaf8080000000-0xffffaf8080800000    0x0000000100000000         8M PMD     D A G . . W R V
0xffffaf8080800000-0xffffaf8080af6000    0x0000000100800000      3032K PTE     D A G . . W R V
0xffffaf8080af6000-0xffffaf8080af8000    0x0000000100af6000         8K PTE     D A G . X . R V
0xffffaf8080af8000-0xffffaf8080c00000    0x0000000100af8000      1056K PTE     D A G . . W R V
0xffffaf8080c00000-0xffffaf8081a00000    0x0000000100c00000        14M PMD     D A G . . W R V
0xffffaf8081a00000-0xffffaf8081a40000    0x0000000101a00000       256K PTE     D A G . . W R V
0xffffaf8081a40000-0xffffaf8081a44000    0x0000000101a40000        16K PTE     D A G . X . R V
0xffffaf8081a44000-0xffffaf8081a52000    0x0000000101a44000        56K PTE     D A G . . W R V
0xffffaf8081a52000-0xffffaf8081a54000    0x0000000101a52000         8K PTE     D A G . X . R V
...
0xffffaf809e800000-0xffffaf80c0000000    0x000000011e800000       536M PMD     D A G . . W R V
0xffffaf80c0000000-0xffffaf8400000000    0x0000000140000000        13G PUD     D A G . . W R V

Note that this also fixes memfd_secret() syscall which uses
set_direct_map_invalid_noflush() and set_direct_map_default_noflush() to
remove the pages from the linear mapping. Below is the kernel page table
while a memfd_secret() syscall is running, you can see all the !valid
page table entries in the linear mapping:

...
0xffffaf8082240000-0xffffaf8082241000    0x0000000102240000         4K PTE     D A G . . W R .
0xffffaf8082241000-0xffffaf8082250000    0x0000000102241000        60K PTE     D A G . . W R V
0xffffaf8082250000-0xffffaf8082252000    0x0000000102250000         8K PTE     D A G . . W R .
0xffffaf8082252000-0xffffaf8082256000    0x0000000102252000        16K PTE     D A G . . W R V
0xffffaf8082256000-0xffffaf8082257000    0x0000000102256000         4K PTE     D A G . . W R .
0xffffaf8082257000-0xffffaf8082258000    0x0000000102257000         4K PTE     D A G . . W R V
0xffffaf8082258000-0xffffaf8082259000    0x0000000102258000         4K PTE     D A G . . W R .
0xffffaf8082259000-0xffffaf808225a000    0x0000000102259000         4K PTE     D A G . . W R V
0xffffaf808225a000-0xffffaf808225c000    0x000000010225a000         8K PTE     D A G . . W R .
0xffffaf808225c000-0xffffaf8082266000    0x000000010225c000        40K PTE     D A G . . W R V
0xffffaf8082266000-0xffffaf8082268000    0x0000000102266000         8K PTE     D A G . . W R .
0xffffaf8082268000-0xffffaf8082284000    0x0000000102268000       112K PTE     D A G . . W R V
0xffffaf8082284000-0xffffaf8082288000    0x0000000102284000        16K PTE     D A G . . W R .
0xffffaf8082288000-0xffffaf808229c000    0x0000000102288000        80K PTE     D A G . . W R V
0xffffaf808229c000-0xffffaf80822a0000    0x000000010229c000        16K PTE     D A G . . W R .
0xffffaf80822a0000-0xffffaf80822a5000    0x00000001022a0000        20K PTE     D A G . . W R V
0xffffaf80822a5000-0xffffaf80822a6000    0x00000001022a5000         4K PTE     D A G . . . R V
0xffffaf80822a6000-0xffffaf80822ab000    0x00000001022a6000        20K PTE     D A G . . W R V
...

And when the memfd_secret() fd is released, the linear mapping is
correctly reset:

...
0xffffaf8082240000-0xffffaf80822a5000    0x0000000102240000       404K PTE     D A G . . W R V
0xffffaf80822a5000-0xffffaf80822a6000    0x00000001022a5000         4K PTE     D A G . . . R V
0xffffaf80822a6000-0xffffaf80822af000    0x00000001022a6000        36K PTE     D A G . . W R V
...

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20231108075930.7157-3-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Stable-dep-of: b8b2711336f0 ("riscv: Fix set_direct_map_default_noflush() to reset _PAGE_EXEC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/pageattr.c | 270 +++++++++++++++++++++++++++++++++------
 1 file changed, 230 insertions(+), 40 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 161d0b34c2cb..fc5fc4f785c4 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -5,6 +5,7 @@
 
 #include <linux/pagewalk.h>
 #include <linux/pgtable.h>
+#include <linux/vmalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
 #include <asm/set_memory.h>
@@ -25,19 +26,6 @@ static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
 	return new_val;
 }
 
-static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	pgd_t val = READ_ONCE(*pgd);
-
-	if (pgd_leaf(val)) {
-		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
-		set_pgd(pgd, val);
-	}
-
-	return 0;
-}
-
 static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
@@ -96,7 +84,6 @@ static int pageattr_pte_hole(unsigned long addr, unsigned long next,
 }
 
 static const struct mm_walk_ops pageattr_ops = {
-	.pgd_entry = pageattr_pgd_entry,
 	.p4d_entry = pageattr_p4d_entry,
 	.pud_entry = pageattr_pud_entry,
 	.pmd_entry = pageattr_pmd_entry,
@@ -105,12 +92,181 @@ static const struct mm_walk_ops pageattr_ops = {
 	.walk_lock = PGWALK_RDLOCK,
 };
 
+#ifdef CONFIG_64BIT
+static int __split_linear_mapping_pmd(pud_t *pudp,
+				      unsigned long vaddr, unsigned long end)
+{
+	pmd_t *pmdp;
+	unsigned long next;
+
+	pmdp = pmd_offset(pudp, vaddr);
+
+	do {
+		next = pmd_addr_end(vaddr, end);
+
+		if (next - vaddr >= PMD_SIZE &&
+		    vaddr <= (vaddr & PMD_MASK) && end >= next)
+			continue;
+
+		if (pmd_leaf(*pmdp)) {
+			struct page *pte_page;
+			unsigned long pfn = _pmd_pfn(*pmdp);
+			pgprot_t prot = __pgprot(pmd_val(*pmdp) & ~_PAGE_PFN_MASK);
+			pte_t *ptep_new;
+			int i;
+
+			pte_page = alloc_page(GFP_KERNEL);
+			if (!pte_page)
+				return -ENOMEM;
+
+			ptep_new = (pte_t *)page_address(pte_page);
+			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
+				set_pte(ptep_new, pfn_pte(pfn + i, prot));
+
+			smp_wmb();
+
+			set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page), PAGE_TABLE));
+		}
+	} while (pmdp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_pud(p4d_t *p4dp,
+				      unsigned long vaddr, unsigned long end)
+{
+	pud_t *pudp;
+	unsigned long next;
+	int ret;
+
+	pudp = pud_offset(p4dp, vaddr);
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (next - vaddr >= PUD_SIZE &&
+		    vaddr <= (vaddr & PUD_MASK) && end >= next)
+			continue;
+
+		if (pud_leaf(*pudp)) {
+			struct page *pmd_page;
+			unsigned long pfn = _pud_pfn(*pudp);
+			pgprot_t prot = __pgprot(pud_val(*pudp) & ~_PAGE_PFN_MASK);
+			pmd_t *pmdp_new;
+			int i;
+
+			pmd_page = alloc_page(GFP_KERNEL);
+			if (!pmd_page)
+				return -ENOMEM;
+
+			pmdp_new = (pmd_t *)page_address(pmd_page);
+			for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new)
+				set_pmd(pmdp_new,
+					pfn_pmd(pfn + ((i * PMD_SIZE) >> PAGE_SHIFT), prot));
+
+			smp_wmb();
+
+			set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
+		}
+
+		ret = __split_linear_mapping_pmd(pudp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (pudp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_p4d(pgd_t *pgdp,
+				      unsigned long vaddr, unsigned long end)
+{
+	p4d_t *p4dp;
+	unsigned long next;
+	int ret;
+
+	p4dp = p4d_offset(pgdp, vaddr);
+
+	do {
+		next = p4d_addr_end(vaddr, end);
+
+		/*
+		 * If [vaddr; end] contains [vaddr & P4D_MASK; next], we don't
+		 * need to split, we'll change the protections on the whole P4D.
+		 */
+		if (next - vaddr >= P4D_SIZE &&
+		    vaddr <= (vaddr & P4D_MASK) && end >= next)
+			continue;
+
+		if (p4d_leaf(*p4dp)) {
+			struct page *pud_page;
+			unsigned long pfn = _p4d_pfn(*p4dp);
+			pgprot_t prot = __pgprot(p4d_val(*p4dp) & ~_PAGE_PFN_MASK);
+			pud_t *pudp_new;
+			int i;
+
+			pud_page = alloc_page(GFP_KERNEL);
+			if (!pud_page)
+				return -ENOMEM;
+
+			/*
+			 * Fill the pud level with leaf puds that have the same
+			 * protections as the leaf p4d.
+			 */
+			pudp_new = (pud_t *)page_address(pud_page);
+			for (i = 0; i < PTRS_PER_PUD; ++i, ++pudp_new)
+				set_pud(pudp_new,
+					pfn_pud(pfn + ((i * PUD_SIZE) >> PAGE_SHIFT), prot));
+
+			/*
+			 * Make sure the pud filling is not reordered with the
+			 * p4d store which could result in seeing a partially
+			 * filled pud level.
+			 */
+			smp_wmb();
+
+			set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
+		}
+
+		ret = __split_linear_mapping_pud(p4dp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (p4dp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_pgd(pgd_t *pgdp,
+				      unsigned long vaddr,
+				      unsigned long end)
+{
+	unsigned long next;
+	int ret;
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+		/* We never use PGD mappings for the linear mapping */
+		ret = __split_linear_mapping_p4d(pgdp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (pgdp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int split_linear_mapping(unsigned long start, unsigned long end)
+{
+	return __split_linear_mapping_pgd(pgd_offset_k(start), start, end);
+}
+#endif	/* CONFIG_64BIT */
+
 static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			pgprot_t clear_mask)
 {
 	int ret;
 	unsigned long start = addr;
 	unsigned long end = start + PAGE_SIZE * numpages;
+	unsigned long __maybe_unused lm_start;
+	unsigned long __maybe_unused lm_end;
 	struct pageattr_masks masks = {
 		.set_mask = set_mask,
 		.clear_mask = clear_mask
@@ -120,11 +276,67 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 		return 0;
 
 	mmap_write_lock(&init_mm);
+
+#ifdef CONFIG_64BIT
+	/*
+	 * We are about to change the permissions of a kernel mapping, we must
+	 * apply the same changes to its linear mapping alias, which may imply
+	 * splitting a huge mapping.
+	 */
+
+	if (is_vmalloc_or_module_addr((void *)start)) {
+		struct vm_struct *area = NULL;
+		int i, page_start;
+
+		area = find_vm_area((void *)start);
+		page_start = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
+
+		for (i = page_start; i < page_start + numpages; ++i) {
+			lm_start = (unsigned long)page_address(area->pages[i]);
+			lm_end = lm_start + PAGE_SIZE;
+
+			ret = split_linear_mapping(lm_start, lm_end);
+			if (ret)
+				goto unlock;
+
+			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+						    &pageattr_ops, NULL, &masks);
+			if (ret)
+				goto unlock;
+		}
+	} else if (is_kernel_mapping(start) || is_linear_mapping(start)) {
+		lm_start = (unsigned long)lm_alias(start);
+		lm_end = (unsigned long)lm_alias(end);
+
+		ret = split_linear_mapping(lm_start, lm_end);
+		if (ret)
+			goto unlock;
+
+		ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+					    &pageattr_ops, NULL, &masks);
+		if (ret)
+			goto unlock;
+	}
+
 	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
 				     &masks);
+
+unlock:
+	mmap_write_unlock(&init_mm);
+
+	/*
+	 * We can't use flush_tlb_kernel_range() here as we may have split a
+	 * hugepage that is larger than that, so let's flush everything.
+	 */
+	flush_tlb_all();
+#else
+	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+				     &masks);
+
 	mmap_write_unlock(&init_mm);
 
 	flush_tlb_kernel_range(start, end);
+#endif
 
 	return ret;
 }
@@ -159,36 +371,14 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	int ret;
-	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
-	struct pageattr_masks masks = {
-		.set_mask = __pgprot(0),
-		.clear_mask = __pgprot(_PAGE_PRESENT)
-	};
-
-	mmap_read_lock(&init_mm);
-	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
-	mmap_read_unlock(&init_mm);
-
-	return ret;
+	return __set_memory((unsigned long)page_address(page), 1,
+			    __pgprot(0), __pgprot(_PAGE_PRESENT));
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	int ret;
-	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
-	struct pageattr_masks masks = {
-		.set_mask = PAGE_KERNEL,
-		.clear_mask = __pgprot(0)
-	};
-
-	mmap_read_lock(&init_mm);
-	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
-	mmap_read_unlock(&init_mm);
-
-	return ret;
+	return __set_memory((unsigned long)page_address(page), 1,
+			    PAGE_KERNEL, __pgprot(0));
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.43.0




