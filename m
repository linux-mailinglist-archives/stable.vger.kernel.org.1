Return-Path: <stable+bounces-120287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2944A4E722
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C32A7A53F3
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905BE28FFC3;
	Tue,  4 Mar 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XKH90KxP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AD27FE89
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105974; cv=none; b=TzaLba5StLF9j3ddwwgie/vAiCTUzZ+V/S1OAjTGXKSY0N6TTgr2zI4BWnKjiciGsRh0CDFDIKExRBGFnGW5YW+tYDrvYyocWvlVUA4+frnBoYkdu/wUkSnGmZxGSOWT6Yp/RKGXqqmGhjgE5+yp6iWt3uyhF6NdMWhpbAHJN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105974; c=relaxed/simple;
	bh=ynWJss7wKOIhiKQAmrydxUgilVFaAkEtgB/CbUEUZzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=djhTKH3ded7TUOyT0Cx7BAPzqVtakCGLyuBViBwKYszmU9gPJK+AgYx3HfRx4YGIPQ+fowyWTwHfvOvO9g3kt4ymUp+iOHFoDvLOZXQ6AhXH/mjaWzQkr6qG+n5fWq586wTv+jc3falwb9FG7iHOwe19GyoTIhvbsA4zJVGJ3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XKH90KxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369C2C4CEE5;
	Tue,  4 Mar 2025 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105973;
	bh=ynWJss7wKOIhiKQAmrydxUgilVFaAkEtgB/CbUEUZzU=;
	h=Subject:To:Cc:From:Date:From;
	b=XKH90KxP6xop/5oZ6AFTzXlQMCMlwhbDJUYymZ4skYXfREFhd3bf5Bo/khLuetxkM
	 Plsz04KVqP2R65gQmvbeN9zq1BJ5mnAoUbZoNr4BQ5qRUNkxXqulkvnUuCeQjgwxxa
	 Uhw6qAS7WYo2CPrfxiYsEQYSNVhhVTT70B/VPffA=
Subject: FAILED: patch "[PATCH] arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present" failed to apply to 6.6-stable tree
To: ryan.roberts@arm.com,catalin.marinas@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:32:50 +0100
Message-ID: <2025030450-spotlight-popsicle-bbba@gregkh>
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
git cherry-pick -x 49c87f7677746f3c5bd16c81b23700bb6b88bfd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030450-spotlight-popsicle-bbba@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49c87f7677746f3c5bd16c81b23700bb6b88bfd4 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Wed, 26 Feb 2025 12:06:52 +0000
Subject: [PATCH] arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present
 ptes

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
+	pte_t pte, tmp_pte;
+	bool present;
 
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
 


