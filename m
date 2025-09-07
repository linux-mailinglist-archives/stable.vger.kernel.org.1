Return-Path: <stable+bounces-178014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C4B4789A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C4B3C5A55
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A8194A73;
	Sun,  7 Sep 2025 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8AQjb1g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506B1078F
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209480; cv=none; b=OmuPN5EaEoo8vxILV/1czxwT0kRx4e7gTed6tRauS2jPVhTm9EvhQSvnHa48wzePoE+Qrmcw1Rg23Oa6Us7E6KJ2xdpo8YUI/cljH2Bh65JBZN9U2q82tksUHZT3HcJQe1zjar43e+U0mj6IGHNgFbcPe2zZ4oxQKudmmwDZgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209480; c=relaxed/simple;
	bh=vrdmjDeQ5CEvN3cUcBCMQFmJeAM00TJg+ET4gguiqKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmzlAbi90sVijV0ZEIP94lx2XWjW5vlKFE7I1n79xtp0sIRRLn90DB+WPfRdTph802eUQJf9WDrJJ13dGbyB1CBnrlkgxfQNZffVu5sdhXmXc3Dl/O9845SYneg2Qj8WSaoOQeis2k57Jw68oiSOK3TlptmHjruzV9rBNoczUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8AQjb1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61A0C4CEFB;
	Sun,  7 Sep 2025 01:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757209478;
	bh=vrdmjDeQ5CEvN3cUcBCMQFmJeAM00TJg+ET4gguiqKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8AQjb1gye80sKCf15WbE3uz3rvEY0e5tk/hTM6HZoO3fNbrNvfL9cKJgF2E7z9Qp
	 TS+nM8uL9a+KfQFDN5KFvD234FNkFwxXE90VMOHpTovoGfuqDOS15zyNgscI5LHLXn
	 sOD9Q0zwvDblyaJFuBm/Cr3FaCiAnZQ95fNs9+iidEYeUEMXdzJohgPHIRVx4aueQB
	 AJhH1bD4g3G2/SK9i6wpRvree7Odf/S0hXcj/ZqTzuz5EAadcrWoR/wkomfoTMLvns
	 07GOuCntvEpqUleqp9kbt9U7NPj9ySR2IKJ4SxyOx+agOepFT8J5ZXsiYC/pER9RkS
	 ajACo+y2TNGGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm: fix accounting of memmap pages
Date: Sat,  6 Sep 2025 21:44:36 -0400
Message-ID: <20250907014436.393471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090629-cargo-udder-f24a@gregkh>
References: <2025090629-cargo-udder-f24a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumanth Korikkar <sumanthk@linux.ibm.com>

[ Upstream commit c3576889d87b603cb66b417e08844a53c1077a37 ]

For !CONFIG_SPARSEMEM_VMEMMAP, memmap page accounting is currently done
upfront in sparse_buffer_init().  However, sparse_buffer_alloc() may
return NULL in failure scenario.

Also, memmap pages may be allocated either from the memblock allocator
during early boot or from the buddy allocator.  When removed via
arch_remove_memory(), accounting of memmap pages must reflect the original
allocation source.

To ensure correctness:
* Account memmap pages after successful allocation in sparse_init_nid()
  and section_activate().
* Account memmap pages in section_deactivate() based on allocation
  source.

Link: https://lkml.kernel.org/r/20250807183545.1424509-1-sumanthk@linux.ibm.com
Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/sparse-vmemmap.c |  5 -----
 mm/sparse.c         | 15 +++++++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c0388b2e959da..2628fc02be08b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -474,10 +474,5 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
-	if (system_state == SYSTEM_BOOTING)
-		memmap_boot_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
-	else
-		memmap_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
-
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index dc38539f85603..eb6c5cb27ed1e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -462,9 +462,6 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
-	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
-#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -532,6 +529,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			sparse_buffer_fini();
 			goto failed;
 		}
+		memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						   PAGE_SIZE));
 		check_usemap_section_nr(nid, usage);
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 				SECTION_IS_EARLY);
@@ -643,7 +642,6 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
@@ -819,10 +817,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early)
+	if (!section_is_early) {
+		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	else if (memmap)
+	} else if (memmap) {
+		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
+							  PAGE_SIZE)));
 		free_map_bootmem(memmap);
+	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -867,6 +869,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.51.0


