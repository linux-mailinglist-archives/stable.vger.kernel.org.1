Return-Path: <stable+bounces-119665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E9A45E6E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC611898F1A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E121D3E7;
	Wed, 26 Feb 2025 12:07:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEEF21D3D9;
	Wed, 26 Feb 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571644; cv=none; b=XiVUFGkdXOCGW8UR/nL378KDkvcdpXlrf7PKkvrnrxtCdd8Irzh1bjK6vBWlJpibDniTGVjuU+FOI68ROfrUHo2leptGlDh5DNI5CYNseZoIm9uuxUYKU6Ly6cVvZ+ZxPO43Z5xE1d08wtaglTDaM2V/JRDWhGsVo13qYmqxvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571644; c=relaxed/simple;
	bh=huAdMaRI7bolyqp5pV6KPirH0iauvy2dHwy1iIWoRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxjkfCizcyJneMkG7BYIf5wokVDSC9UAHYDD8YF5uCfTySXyrj/DtGRI3QEu81myevUVBJtBtK7B4wc/gCfRQ1/AbTI8CZO5e+dSOrsuUfJnyBRiUggy4zc5N7Ip27PO9Mx7kjjgfIc9PDV2MGZoLsUK8sJl40z96q8qw4sd1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453CF13D5;
	Wed, 26 Feb 2025 04:07:38 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 082C03F5A1;
	Wed, 26 Feb 2025 04:07:16 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
Date: Wed, 26 Feb 2025 12:06:52 +0000
Message-ID: <20250226120656.2400136-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226120656.2400136-1-ryan.roberts@arm.com>
References: <20250226120656.2400136-1-ryan.roberts@arm.com>
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

tmp
---
 arch/arm64/mm/hugetlbpage.c | 53 ++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 06db4649af91..b3a7fafe8892 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -100,20 +100,11 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 
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
@@ -122,6 +113,8 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 		*pgsize = PAGE_SIZE;
 		contig_ptes = CONT_PTES;
 		break;
+	default:
+		WARN_ON(!__hugetlb_valid_size(size));
 	}
 
 	return contig_ptes;
@@ -163,24 +156,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = __ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
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
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += pgsize;
+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
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
@@ -401,13 +393,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = __ptep_get(ptep);
-
-	if (!pte_cont(orig_pte))
-		return __ptep_get_and_clear(mm, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
+	ncontig = num_contig_ptes(sz, &pgsize);
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
 
-- 
2.43.0


