Return-Path: <stable+bounces-121255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0300FA54E7E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10584160DCF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660E18BC26;
	Thu,  6 Mar 2025 15:03:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BBEEA9
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273384; cv=none; b=joXC1QWL8fGaG2oXiEUDezv9oGi98zVcf9XkP+7zRzcI/XjpSOmz6JjVYpWEKDBTJk0qk+x6A5DG5dAQaS+HhbaBEtrCSbk24Gmu1XIY6N7vtW/vbO5AlDdJzEOafPw+12+taf+f5UTH+SzmDR81h6B1nTnSWHUYE1TRcIZUqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273384; c=relaxed/simple;
	bh=W3Fma+JgOinWC+o5oypabKoEbXPlBiKweOxJahh9Dv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv1nWshmD3ehUE4RIZri/54/ekto7Np4iq16cEUK1hFupIx8vPmN3urxjvXUuZIST46kHKysHwL7HC7H/5LUSxdmxXeI30LsaA4foH9gUTV1s8ZZwx5tgk0pr0JVvT0xVJU/zUHtmFj26qh56sSyQohqRw9sR0nnQbTaT5bCHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A09501007;
	Thu,  6 Mar 2025 07:03:14 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198013F66E;
	Thu,  6 Mar 2025 07:03:00 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6.y] arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
Date: Thu,  6 Mar 2025 15:02:50 +0000
Message-ID: <20250306150250.154641-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306144716.71199-1-ryan.roberts@arm.com>
References: <20250306144716.71199-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
CONT_PMD_SIZE). So the function has to figure out the size from the
huge_pte pointer. This was previously done by walking the pgtable to
determine the level and by using the PTE_CONT bit to determine the
number of ptes at the level.

But the PTE_CONT bit is only valid when the pte is present. For
non-present pte values (e.g. markers, migration entries), the previous
implementation was therefore erroneously determining the size. There is
at least one known caller in core-mm, move_huge_pte(), which may call
huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
this case. Additionally the "regular" ptep_get_and_clear() is robust to
being called for non-present ptes so it makes sense to follow the
behavior.

Fix this by using the new sz parameter which is now provided to the
function. Additionally when clearing each pte in a contig range, don't
gather the access and dirty bits if the pte is not present.

An alternative approach that would not require API changes would be to
store the PTE_CONT bit in a spare bit in the swap entry pte for the
non-present case. But it felt cleaner to follow other APIs' lead and
just pass in the size.

As an aside, PTE_CONT is bit 52, which corresponds to bit 40 in the swap
entry offset field (layout of non-present pte). Since hugetlb is never
swapped to disk, this field will only be populated for markers, which
always set this bit to 0 and hwpoison swap entries, which set the offset
field to a PFN; So it would only ever be 1 for a 52-bit PVA system where
memory in that high half was poisoned (I think!). So in practice, this
bit would almost always be zero for non-present ptes and we would only
clear the first entry if it was actually a contiguous block. That's
probably a less severe symptom than if it was always interpreted as 1
and cleared out potentially-present neighboring PTEs.

Cc: stable@vger.kernel.org
Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/r/20250226120656.2400136-3-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
(cherry picked from commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4)
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 53 ++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f86a09309807..06efc3a1652e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -121,20 +121,11 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 
 static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 {
-	int contig_ptes = 0;
+	int contig_ptes = 1;
 
 	*pgsize = size;
 
 	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		if (pud_sect_supported())
-			contig_ptes = 1;
-		break;
-#endif
-	case PMD_SIZE:
-		contig_ptes = 1;
-		break;
 	case CONT_PMD_SIZE:
 		*pgsize = PMD_SIZE;
 		contig_ptes = CONT_PMDS;
@@ -143,6 +134,8 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 		*pgsize = PAGE_SIZE;
 		contig_ptes = CONT_PTES;
 		break;
+	default:
+		WARN_ON(!__hugetlb_valid_size(size));
 	}
 
 	return contig_ptes;
@@ -184,24 +177,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
-
-		/*
-		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty or accessed bit for any page in the set,
-		 * so check them all.
-		 */
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
+	pte_t pte, tmp_pte;
+	bool present;
+
+	pte = ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += pgsize;
+		tmp_pte = ptep_get_and_clear(mm, addr, ptep);
+		if (present) {
+			if (pte_dirty(tmp_pte))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tmp_pte))
+				pte = pte_mkyoung(pte);
+		}
 	}
-	return orig_pte;
+	return pte;
 }
 
 static pte_t get_clear_contig_flush(struct mm_struct *mm,
@@ -408,13 +400,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = ptep_get(ptep);
-
-	if (!pte_cont(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
+	ncontig = num_contig_ptes(sz, &pgsize);
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
 
-- 
2.43.0


