Return-Path: <stable+bounces-187312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDBBEAB9B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BB0743CD5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183F3277A9;
	Fri, 17 Oct 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XzSqi+BC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D361330B2C;
	Fri, 17 Oct 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715721; cv=none; b=kYY3SznhegCheYWUFaMParo5kRjXQxrXMCBScI/e/MWAUFtr/gaQZ2vdEa2moUwV+eZqvpWdtCKJVL/UkHmzT67qN4A85YgNtDmzgpneaVia30yFx9sarOUlKlePZMZgxK0WBezyWVQU5jFztI5INXpIoRe4ujQZCKsY5x/610c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715721; c=relaxed/simple;
	bh=lBk1VOWo+Hupd/X0Slp9nNTi02Bv+1U7ZFY6EHaFU5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAoaDfHyTFi/ApJpG/Z0xY5dDJMsCnjwDy0Hu9h9sTDFccbJLeF2s7egvKllYFebDn+CO0p2w9v0uKbZbAVZYCD+2GRSUP0AkEpidcCOWSrnQyxo6VYhHBnCtcvIN+5Uyhhd7hPSOPfr4qVG7T/na4HA3YGD9uSBReUANIpUfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XzSqi+BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25CCC113D0;
	Fri, 17 Oct 2025 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715721;
	bh=lBk1VOWo+Hupd/X0Slp9nNTi02Bv+1U7ZFY6EHaFU5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzSqi+BCa4D++Bii8NQL13zLuagNcwlPgPh733qe8NNaEeFlOgLcKH3aJG1HhAYqI
	 T4Zhkk12dnu18H2Pp5s926Q1wLLaUXCbjSRz8aRqNL+I05Bbj2Yofac66GvXD10WYo
	 vo7SVYoVnE/lp45UCUgs+3bZRvhf3mEx8N+5WejA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lance Yang <lance.yang@linux.dev>,
	Qun-wei Lin <Qun-wei.Lin@mediatek.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	"andrew.yang" <andrew.yang@mediatek.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Byungchul Park <byungchul@sk.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chinwen Chang <chinwen.chang@mediatek.com>,
	Dev Jain <dev.jain@arm.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Kairui Song <ryncsn@gmail.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mariano Pache <npache@redhat.com>,
	Mathew Brost <matthew.brost@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.17 315/371] mm/thp: fix MTE tag mismatch when replacing zero-filled subpages
Date: Fri, 17 Oct 2025 16:54:50 +0200
Message-ID: <20251017145213.471668235@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lance Yang <lance.yang@linux.dev>

commit 1ce6473d17e78e3cb9a40147658231731a551828 upstream.

When both THP and MTE are enabled, splitting a THP and replacing its
zero-filled subpages with the shared zeropage can cause MTE tag mismatch
faults in userspace.

Remapping zero-filled subpages to the shared zeropage is unsafe, as the
zeropage has a fixed tag of zero, which may not match the tag expected by
the userspace pointer.

KSM already avoids this problem by using memcmp_pages(), which on arm64
intentionally reports MTE-tagged pages as non-identical to prevent unsafe
merging.

As suggested by David[1], this patch adopts the same pattern, replacing the
memchr_inv() byte-level check with a call to pages_identical(). This
leverages existing architecture-specific logic to determine if a page is
truly identical to the shared zeropage.

Having both the THP shrinker and KSM rely on pages_identical() makes the
design more future-proof, IMO. Instead of handling quirks in generic code,
we just let the architecture decide what makes two pages identical.

[1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com

Link: https://lkml.kernel.org/r/20250922021458.68123-1-lance.yang@linux.dev
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: andrew.yang <andrew.yang@mediatek.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Mathew Brost <matthew.brost@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Samuel Holland <samuel.holland@sifive.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/huge_memory.c |   15 +++------------
 mm/migrate.c     |    8 +-------
 2 files changed, 4 insertions(+), 19 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4115,32 +4115,23 @@ static unsigned long deferred_split_coun
 static bool thp_underused(struct folio *folio)
 {
 	int num_zero_pages = 0, num_filled_pages = 0;
-	void *kaddr;
 	int i;
 
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
-		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
-		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
-			num_zero_pages++;
-			if (num_zero_pages > khugepaged_max_ptes_none) {
-				kunmap_local(kaddr);
+		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
+			if (++num_zero_pages > khugepaged_max_ptes_none)
 				return true;
-			}
 		} else {
 			/*
 			 * Another path for early exit once the number
 			 * of non-zero filled pages exceeds threshold.
 			 */
-			num_filled_pages++;
-			if (num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none) {
-				kunmap_local(kaddr);
+			if (++num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none)
 				return false;
-			}
 		}
-		kunmap_local(kaddr);
 	}
 	return false;
 }
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -301,9 +301,7 @@ static bool try_to_map_unused_to_zeropag
 					  unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
-	bool contains_data;
 	pte_t newpte;
-	void *addr;
 
 	if (PageCompound(page))
 		return false;
@@ -320,11 +318,7 @@ static bool try_to_map_unused_to_zeropag
 	 * this subpage has been non present. If the subpage is only zero-filled
 	 * then map it to the shared zeropage.
 	 */
-	addr = kmap_local_page(page);
-	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
-	kunmap_local(addr);
-
-	if (contains_data)
+	if (!pages_identical(page, ZERO_PAGE(0)))
 		return false;
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),



