Return-Path: <stable+bounces-213022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OIMLH8ngGnv3QIAu9opvQ
	(envelope-from <stable+bounces-213022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 05:26:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD5C826E
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3174E300C835
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EE28CF52;
	Mon,  2 Feb 2026 04:26:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A228EA72;
	Mon,  2 Feb 2026 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770006389; cv=none; b=Ka2iaKXaHjYE6tU95Kpe7v0rIE7MxrrxUs6mvXj9eUDgadjq+Kxm4+5DTpXwUmESChANstHgvtkaoRZ8IcjlV0ANh43sIHJRfCNz+PXmT8vfAh9Rr3DK9gN4I6aCaN/EjE37wuOWGfxbfvptjMiPJJDJGF8jV67kZM7SoA3gYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770006389; c=relaxed/simple;
	bh=LOSCuA7MZGwrIIsEWNN8iCtblTwVXafkk+0MvfypKTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6znUY1If8OAceyn92QUL0mbRvLkQRcHAKs0PkcOMGkJnDTJXh6fwxh5hrFhYrHFTmWOd0pubhYiQX3E5e2mnErAAE1zgx/Wv6/Hxa5Q8KUHhP7WxsPBMSqN+HADbTfu+ygazoHxNDaUoziqCj6NfI6s870WjpQIeSlwcXmwJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C100D1042;
	Sun,  1 Feb 2026 20:26:20 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2D5E3F740;
	Sun,  1 Feb 2026 20:26:25 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Christoph Lameter <cl@gentwo.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] arm64/mm: Reject memory removal that splits a kernel leaf mapping
Date: Mon,  2 Feb 2026 04:26:17 +0000
Message-Id: <20260202042617.504183-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260202042617.504183-1-anshuman.khandual@arm.com>
References: <20260202042617.504183-1-anshuman.khandual@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213022-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[anshuman.khandual@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email]
X-Rspamd-Queue-Id: 41CD5C826E
X-Rspamd-Action: no action

Linear and vmemmap mapings that get teared down during a memory hot remove
operation might contain leaf level entries on any page table level. If the
requested memory range's linear or vmemmap mappings falls within such leaf
entries, new mappings need to be created for the remaning memory mapped on
the leaf entry earlier, following standard break before make aka BBM rules.

Currently memory hot remove operation does not perform such restructuring,
and so removing memory ranges that could split a kernel leaf level mapping
need to be rejected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Closes: https://lore.kernel.org/all/aWZYXhrT6D2M-7-N@willie-the-truck/
Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
Cc: stable@vger.kernel.org
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 126 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8ec8a287aaa1..9d59e10fb3de 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2063,6 +2063,129 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 }
 
+
+static bool split_kernel_leaf_boundary(unsigned long addr)
+{
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	/*
+	 * PGD: If addr is PGD aligned then addr already
+	 * describes a leaf boundary.
+	 */
+	if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
+		return false;
+
+	pgdp = pgd_offset_k(addr);
+	pgd = pgdp_get(pgdp);
+	if (!pgd_present(pgd))
+		return false;
+
+	/*
+	 * P4D: If addr is P4D aligned then addr already
+	 * describes a leaf boundary.
+	 */
+	if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
+		return false;
+
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = p4dp_get(p4dp);
+	if (!p4d_present(p4d))
+		return false;
+
+	/*
+	 * PUD: If addr is PUD aligned then addr already
+	 * describes a leaf boundary.
+	 */
+	if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
+		return false;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = pudp_get(pudp);
+	if (!pud_present(pud))
+		return false;
+
+	if (pud_leaf(pud))
+		return true;
+
+	/*
+	 * CONT_PMD: If addr is CONT_PMD aligned then
+	 * addr already describes a leaf boundary.
+	 */
+	if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
+		return false;
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = pmdp_get(pmdp);
+	if (!pmd_present(pmd))
+		return false;
+
+	if (pmd_leaf(pmd) && pmd_cont(pmd))
+		return true;
+
+	/*
+	 * PMD: If addr is PMD aligned then addr already
+	 * describes a leaf boundary.
+	 */
+	if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
+		return false;
+
+	if (pmd_leaf(pmd))
+		return true;
+
+	/*
+	 * CONT_PTE: If addr is CONT_PTE aligned then addr
+	 * already describes a leaf boundary.
+	 */
+	if (ALIGN_DOWN(addr, CONT_PTE_SIZE) == addr)
+		return false;
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = __ptep_get(ptep);
+	if (!pte_present(pte))
+		return false;
+
+	if (pte_valid(pte) && pte_cont(pte))
+		return true;
+
+	if (ALIGN_DOWN(addr, PAGE_SIZE) == addr)
+		return false;
+	return true;
+}
+
+static bool can_unmap_without_split(unsigned long pfn, unsigned long nr_pages)
+{
+	unsigned long linear_start, linear_end, phys_start, phys_end;
+	unsigned long vmemmap_size, vmemmap_start, vmemmap_end;
+
+	/* Assert linear map edges do not split a leaf entry */
+	phys_start = PFN_PHYS(pfn);
+	phys_end = phys_start + nr_pages * PAGE_SIZE;
+	linear_start = __phys_to_virt(phys_start);
+	linear_end =  __phys_to_virt(phys_end);
+	if (split_kernel_leaf_boundary(linear_start) ||
+	    split_kernel_leaf_boundary(linear_end)) {
+		pr_warn("[%lx %lx] splits a leaf entry in linear map\n",
+			phys_start, phys_end);
+		return false;
+	}
+
+	/* Assert vmemmap edges do not split a leaf entry */
+	vmemmap_size = nr_pages * sizeof(struct page);
+	vmemmap_start = (unsigned long) pfn_to_page(pfn);
+	vmemmap_end = vmemmap_start + vmemmap_size;
+	if (split_kernel_leaf_boundary(vmemmap_start) ||
+	    split_kernel_leaf_boundary(vmemmap_end)) {
+		pr_warn("[%lx %lx] splits a leaf entry in vmemmap\n",
+			phys_start, phys_end);
+		return false;
+	}
+	return true;
+}
+
 /*
  * This memory hotplug notifier helps prevent boot memory from being
  * inadvertently removed as it blocks pfn range offlining process in
@@ -2083,6 +2206,9 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
 	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
 		return NOTIFY_OK;
 
+	if (!can_unmap_without_split(pfn, arg->nr_pages))
+		return NOTIFY_BAD;
+
 	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long start = PFN_PHYS(pfn);
 		unsigned long end = start + (1UL << PA_SECTION_SHIFT);
-- 
2.30.2


