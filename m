Return-Path: <stable+bounces-216831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCquIANvlGk0DwIAu9opvQ
	(envelope-from <stable+bounces-216831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:37:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BE14CAA6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F6A3053ABF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6915361DD4;
	Tue, 17 Feb 2026 13:35:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC236B066;
	Tue, 17 Feb 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335344; cv=none; b=gBANE8pHOoVm/a27t0iqAgn4kLDmpTxiIdsWRQsDN2mOfJKMN64IQ8R35c6+y/W0cTDukVmDU/gvg/buVJ6Tr0niDhkgkEpDj4JkWU5EZYsoRSBa1W3X8btacgwB2TANIw0fBBYTm7cJZ6Ro9fGNZfI7hK1WQQ7AjSFCb6buq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335344; c=relaxed/simple;
	bh=1YIhWqZuX/5+uFQxGW6DplC0TV4TWqwnIxIJFKZGVRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icvdeXgJDWkhbQytX+rQSstCae7GlPF/DL2XgSFVQGjYEuogaSDsi3DlpOp9Em7OCRgGfLQfxjZKUfT1QFWzezIMa7Jmg1fmPi764vyZ8qgPBpatuTuL+yVMinTOE7gRQQoKZt9JQqFxSpzFi8Wly8VFgbJYJseaFA34kTvwUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCCB1477;
	Tue, 17 Feb 2026 05:35:36 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 087B73FD09;
	Tue, 17 Feb 2026 05:35:40 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.1 3/3] arm64: mm: Don't remap pgtables for allocate vs populate
Date: Tue, 17 Feb 2026 13:35:24 +0000
Message-ID: <20260217133527.2881603-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217133527.2881603-1-ryan.roberts@arm.com>
References: <20260217133527.2881603-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-216831-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,arm.com:mid,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD2BE14CAA6
X-Rspamd-Action: no action

[ Upstream commit 0e9df1c905d8293d333ace86c13d147382f5caf9 ]

During linear map pgtable creation, each pgtable is fixmapped /
fixunmapped twice; once during allocation to zero the memory, and a
again during population to write the entries. This means each table has
2 TLB invalidations issued against it. Let's fix this so that each table
is only fixmapped/fixunmapped once, halving the number of TLBIs, and
improving performance.

Achieve this by separating allocation and initialization (zeroing) of
the page. The allocated page is now fixmapped directly by the walker and
initialized, before being populated and finally fixunmapped.

This approach keeps the change small, but has the side effect that late
allocations (using __get_free_page()) must also go through the generic
memory clearing routine. So let's tell __get_free_page() not to zero the
memory to avoid duplication.

Additionally this approach means that fixmap/fixunmap is still used for
late pgtable modifications. That's not technically needed since the
memory is all mapped in the linear map by that point. That's left as a
possible future optimization if found to be needed.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |   11   (0%) |  161   (0%) |  656   (0%) |  1654   (0%)
after          |   10 (-11%) |  104 (-35%) |  438 (-33%) |  1223 (-26%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240412131908.433043-4-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[ Ryan: Trivial backport ]
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ca06b5e131e0f..ca0bf180082d3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -110,28 +110,12 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 static phys_addr_t __init early_pgtable_alloc(int shift)
 {
 	phys_addr_t phys;
-	void *ptr;

 	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
 					 MEMBLOCK_ALLOC_NOLEAKTRACE);
 	if (!phys)
 		panic("Failed to allocate page table page\n");

-	/*
-	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
-	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
-	 * any level of table.
-	 */
-	ptr = pte_set_fixmap(phys);
-
-	memset(ptr, 0, PAGE_SIZE);
-
-	/*
-	 * Implicit barriers also ensure the zeroed page is visible to the page
-	 * table walker
-	 */
-	pte_clear_fixmap();
-
 	return phys;
 }

@@ -169,6 +153,14 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	return ((old ^ new) & ~mask) == 0;
 }

+static void init_clear_pgtable(void *table)
+{
+	clear_page(table);
+
+	/* Ensure the zeroing is observed by page table walks. */
+	dsb(ishst);
+}
+
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
@@ -211,12 +203,15 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			pmdval |= PMD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc(PAGE_SHIFT);
+		ptep = pte_set_fixmap(pte_phys);
+		init_clear_pgtable(ptep);
+		ptep += pte_index(addr);
 		__pmd_populate(pmdp, pte_phys, pmdval);
-		pmd = READ_ONCE(*pmdp);
+	} else {
+		BUG_ON(pmd_bad(pmd));
+		ptep = pte_set_fixmap_offset(pmdp, addr);
 	}
-	BUG_ON(pmd_bad(pmd));

-	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pgprot_t __prot = prot;

@@ -295,12 +290,15 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			pudval |= PUD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc(PMD_SHIFT);
+		pmdp = pmd_set_fixmap(pmd_phys);
+		init_clear_pgtable(pmdp);
+		pmdp += pmd_index(addr);
 		__pud_populate(pudp, pmd_phys, pudval);
-		pud = READ_ONCE(*pudp);
+	} else {
+		BUG_ON(pud_bad(pud));
+		pmdp = pmd_set_fixmap_offset(pudp, addr);
 	}
-	BUG_ON(pud_bad(pud));

-	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pgprot_t __prot = prot;

@@ -338,12 +336,15 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			p4dval |= P4D_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc(PUD_SHIFT);
+		pudp = pud_set_fixmap(pud_phys);
+		init_clear_pgtable(pudp);
+		pudp += pud_index(addr);
 		__p4d_populate(p4dp, pud_phys, p4dval);
-		p4d = READ_ONCE(*p4dp);
+	} else {
+		BUG_ON(p4d_bad(p4d));
+		pudp = pud_set_fixmap_offset(p4dp, addr);
 	}
-	BUG_ON(p4d_bad(p4d));

-	pudp = pud_set_fixmap_offset(p4dp, addr);
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);

@@ -425,11 +426,10 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,

 static phys_addr_t __pgd_pgtable_alloc(int shift)
 {
-	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
-	BUG_ON(!ptr);
+	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
+	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);

-	/* Ensure the zeroed page is visible to the page table walker */
-	dsb(ishst);
+	BUG_ON(!ptr);
 	return __pa(ptr);
 }

--
2.43.0


