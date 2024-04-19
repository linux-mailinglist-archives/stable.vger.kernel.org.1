Return-Path: <stable+bounces-40254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027558AA9DC
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C871F214A7
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AF4D59F;
	Fri, 19 Apr 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7UUQVNm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58D3E485
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514329; cv=none; b=fse5ahJ/lvqTmofE1XTk8gKR5stAXmv2hggZg9I+yYA5jCeJ00ZCsgk0KLri9ra5kAfp0HeFQLdDuhh1SJJlCPY62HtS6NR3QJmLgeBdfqm+f0CvXOVXc51+ft0Q0on40kTt38AyLtjkpS5yXsVnOd0F1UqlDG6Rf1Vo3Q12LwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514329; c=relaxed/simple;
	bh=tDzLVsILiXcFOnE8Fzga/mI8jKgRVoIVNFwS8TO+M/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HY0hTzxhVF0cZNqfqMSPBcr9P+FEnpfRDPOpem4NHmK5cZfxc238whRk038QKHhEnYRTGTLsPt1QoyUFlUvtpOEKysgnJiB0t4AjySbWSxg49rqmzYnRxcs4wvjlVt6Ac4x+hYwFFNk4XN+y1TeSMsXhJUVl4cBZuuJkHLSjxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7UUQVNm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4167351545cso14605745e9.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514326; x=1714119126; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWRh5ObV3F8mmCXzsfRsD1oUVeAlVk6GBhHa6QZ5oT8=;
        b=q7UUQVNmZwLdI1HKyjgoVgjPJ3GOJUm+enNMWXZN9wtDiDdgvlavVcDunOe2vjy2O2
         cQW8tI3FcemWQh6q0I4PqzV7nvrWO0wJgt11kHG2dl5SkTlS3QXlw3/UUSfwQuYfHysz
         ctJS3f+rHIRn8r4gWMcExQFpcKO9Ru8yOcP8ZF1HD+G5ejJMIpKnxiX1AE2jTGYQgpEW
         +T1k9mGuHwiKhM3LlN02T1Byona7HYhSaAv5jDgSaJY7Jdq1FtOhn2HG7cLW2YYhA858
         6g0EIcudvK3IV59IOf53FvoIubehYDrGRV1Inqeps7qjMPlv91YgsNmkAXu2VlYjwZin
         cT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514326; x=1714119126;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWRh5ObV3F8mmCXzsfRsD1oUVeAlVk6GBhHa6QZ5oT8=;
        b=TYhHPb9j1o7bIxCyI+p725Vu3xMqe5GC72hgHED/ILa59tFj0ZWBcvWvseJesqjTV+
         9oCCadBNWTGTypRyGnb8Mp4fgJVa8M6nOVki2gdIJRDhPFPoA438wx41OpzKQh0io0HA
         oKFZK9jPigmcHyplNcvc0+91xfX6aJS9f87IrUetp4gMdPJoiA4SZEyCufCM+spZ5dgK
         LMWPtUlbP8B0Gi4SJ/D1NMuIIZ2T4PFLgzG0MksazBf1PIyBLqUmfmHZA16saHdy7DRb
         eH6NsjfaJlgtwegllJa5vxZ6AfqZDWuqpVtSkBRtYKma4Roc0dWimJLeWwyGadOYPASY
         bP2A==
X-Gm-Message-State: AOJu0YyyDpEjY0KrUGhwiSa7ih3lpAY4rEImR1hI620aLk+HGNEhW7MN
	ChGx/B3DblWY5JZEXPrYFxh3JK7HiOYNTDxZjuhBYXHYTCTvblOd45mNHWTonY/+pBMhrC2hmAz
	KomPUlrquDyZn31Rls2w5UeUzCQ281YCR+xZ18YYMGMGwYcMnEwMCGNbbIuRm4iWo8TDUDF+TGp
	wR52uAAGO/fwi/hFgoBZav2A==
X-Google-Smtp-Source: AGHT+IHZmeNHXE/eN5MPUHeGF75CA3e211cGXJUiEC9S1zZRpSUH2rQ6EHZ6Er2zZS30zt216nFJKDsp
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5102:b0:418:739e:d48 with SMTP id
 o2-20020a05600c510200b00418739e0d48mr9111wms.5.1713514326743; Fri, 19 Apr
 2024 01:12:06 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:24 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8502; i=ardb@kernel.org;
 h=from:subject; bh=T/1GQgsG7ni0wEObjh8OhfQSBZFpE67ob0tzcHOD+sY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXX2a4PrCw8wTvqzrfnnTYD2fn/1TvnP+i05fZHbKu
 Lju6SS7jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAnCTpRn+14jqld9r3bxEsUba
 93b+mWwVrweRHfY8n6r4tvbNUn4VyvBX7FXqD8b7fdpLGzfEByxvCfmXYb7qtbPMhe3T1wie2Wf EDQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-43-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 18/23] x86/mm: Remove P*D_PAGE_MASK and
 P*D_PAGE_SIZE macros
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Pasha Tatashin <pasha.tatashin@soleen.com>

[ Commit 82328227db8f0b9b5f77bb5afcd47e59d0e4d08f upstream ]

Other architectures and the common mm/ use P*D_MASK, and P*D_SIZE.
Remove the duplicated P*D_PAGE_MASK and P*D_PAGE_SIZE which are only
used in x86/*.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lore.kernel.org/r/20220516185202.604654-1-tatashin@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/page_types.h  | 12 +++---------
 arch/x86/kernel/amd_gart_64.c      |  2 +-
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/mm/mem_encrypt_boot.S     |  4 ++--
 arch/x86/mm/mem_encrypt_identity.c | 18 +++++++++---------
 arch/x86/mm/pat/set_memory.c       |  6 +++---
 arch/x86/mm/pti.c                  |  2 +-
 7 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index a506a411474d..86bd4311daf8 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -11,20 +11,14 @@
 #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-#define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
-#define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
-
-#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
-#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
-
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
-/* Cast *PAGE_MASK to a signed type so that it is sign-extended if
+/* Cast P*D_MASK to a signed type so that it is sign-extended if
    virtual addresses are 32-bits but physical addresses are larger
    (ie, 32-bit PAE). */
 #define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
-#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_PAGE_MASK) & __PHYSICAL_MASK)
-#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_PAGE_MASK) & __PHYSICAL_MASK)
+#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_MASK) & __PHYSICAL_MASK)
+#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_MASK) & __PHYSICAL_MASK)
 
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 19a0207e529f..56a917df410d 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -504,7 +504,7 @@ static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 	}
 
 	a = aper + iommu_size;
-	iommu_size -= round_up(a, PMD_PAGE_SIZE) - a;
+	iommu_size -= round_up(a, PMD_SIZE) - a;
 
 	if (iommu_size < 64*1024*1024) {
 		pr_warn("PCI-DMA: Warning: Small IOMMU %luMB."
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 84adf12a76d3..34580e1a4cdb 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -203,7 +203,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_PAGE_MASK)
+	if (load_delta & ~PMD_MASK)
 		for (;;);
 
 	/* Include the SME encryption mask in the fixup value */
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 9de3d900bc92..e25288ee33c2 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -26,7 +26,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 	 *   RCX - virtual address of the encryption workarea, including:
 	 *     - stack page (PAGE_SIZE)
 	 *     - encryption routine page (PAGE_SIZE)
-	 *     - intermediate copy buffer (PMD_PAGE_SIZE)
+	 *     - intermediate copy buffer (PMD_SIZE)
 	 *    R8 - physical address of the pagetables to use for encryption
 	 */
 
@@ -123,7 +123,7 @@ SYM_FUNC_START(__enc_copy)
 	wbinvd				/* Invalidate any cache entries */
 
 	/* Copy/encrypt up to 2MB at a time */
-	movq	$PMD_PAGE_SIZE, %r12
+	movq	$PMD_SIZE, %r12
 1:
 	cmpq	%r12, %r9
 	jnb	2f
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 06ccbd36e8dc..f7dfc3f89921 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -93,7 +93,7 @@ struct sme_populate_pgd_data {
  * section is 2MB aligned to allow for simple pagetable setup using only
  * PMD entries (see vmlinux.lds.S).
  */
-static char sme_workarea[2 * PMD_PAGE_SIZE] __section(".init.scratch");
+static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
@@ -197,8 +197,8 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
 
-		ppd->vaddr += PMD_PAGE_SIZE;
-		ppd->paddr += PMD_PAGE_SIZE;
+		ppd->vaddr += PMD_SIZE;
+		ppd->paddr += PMD_SIZE;
 	}
 }
 
@@ -224,11 +224,11 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	vaddr_end = ppd->vaddr_end;
 
 	/* If start is not 2MB aligned, create PTE entries */
-	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_PAGE_SIZE);
+	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_SIZE);
 	__sme_map_range_pte(ppd);
 
 	/* Create PMD entries */
-	ppd->vaddr_end = vaddr_end & PMD_PAGE_MASK;
+	ppd->vaddr_end = vaddr_end & PMD_MASK;
 	__sme_map_range_pmd(ppd);
 
 	/* If end is not 2MB aligned, create PTE entries */
@@ -325,7 +325,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 	/* Physical addresses gives us the identity mapped virtual addresses */
 	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_PAGE_SIZE);
+	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -355,12 +355,12 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *   executable encryption area size:
 	 *     stack page (PAGE_SIZE)
 	 *     encryption routine page (PAGE_SIZE)
-	 *     intermediate copy buffer (PMD_PAGE_SIZE)
+	 *     intermediate copy buffer (PMD_SIZE)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
 	execute_start = workarea_start;
-	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_PAGE_SIZE;
+	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
 	/*
@@ -383,7 +383,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * before it is mapped.
 	 */
 	workarea_len = execute_len + pgtable_area_len;
-	workarea_end = ALIGN(workarea_start + workarea_len, PMD_PAGE_SIZE);
+	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
 
 	/*
 	 * Set the address to the start of where newly created pagetable
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 5f0ce77a259d..68d4f328f169 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -747,11 +747,11 @@ phys_addr_t slow_virt_to_phys(void *__virt_addr)
 	switch (level) {
 	case PG_LEVEL_1G:
 		phys_addr = (phys_addr_t)pud_pfn(*(pud_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PUD_PAGE_MASK;
+		offset = virt_addr & ~PUD_MASK;
 		break;
 	case PG_LEVEL_2M:
 		phys_addr = (phys_addr_t)pmd_pfn(*(pmd_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PMD_PAGE_MASK;
+		offset = virt_addr & ~PMD_MASK;
 		break;
 	default:
 		phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
@@ -1041,7 +1041,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	case PG_LEVEL_1G:
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
-		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
+		pfninc = PMD_SIZE >> PAGE_SHIFT;
 		lpaddr = address & PUD_MASK;
 		lpinc = PMD_SIZE;
 		/*
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ffe3b3a087fe..78414c6d1b5e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -592,7 +592,7 @@ static void pti_set_kernel_image_nonglobal(void)
 	 * of the image.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_SIZE);
 
 	/*
 	 * This clears _PAGE_GLOBAL from the entire kernel image.
-- 
2.44.0.769.g3c40516874-goog


