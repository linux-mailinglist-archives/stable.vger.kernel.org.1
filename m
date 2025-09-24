Return-Path: <stable+bounces-181659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CDBB9C506
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 23:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB6516519F
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B942727F2;
	Wed, 24 Sep 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SKit6eLk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE4285C91;
	Wed, 24 Sep 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751087; cv=none; b=Mk1MPFNU+HKQT0W6sPzRAD+WuHuazYf8kGsL3zg6zgHQD6EQMNexag1SAv5mNZiIahtqPvbt+GRa5ynMguhy7xw4f/HiTX22X47dfu/7KLc9FkOk9HASqcVVtoKHNv46A1mvnZgN0gCRodXMatsvdhZB9krOJZVBMqfwjwuDCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751087; c=relaxed/simple;
	bh=ZZcO+Mr7RggpYqbZ7zOwH2ILwZjTr0dGvYRYCDHDlSk=;
	h=Date:To:From:Subject:Message-Id; b=oVFVU8UcBxPjLZHKcmHj2zypjZhMX60wpmfmOwrqmuuiiRgVIWQp2Lu0LWDO+JMwf3EEPoAuMOI96c5ZKTz0+Bl3oQj4GbxukmW4ktN5K0p8DRDy33wY0Ylljp62WdsGxlCsvvD10tm6O49HiN5jVsqiMd9xkDVqyOjdx2wABjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SKit6eLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA9FC4CEE7;
	Wed, 24 Sep 2025 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758751086;
	bh=ZZcO+Mr7RggpYqbZ7zOwH2ILwZjTr0dGvYRYCDHDlSk=;
	h=Date:To:From:Subject:From;
	b=SKit6eLkZt52EaopruCqUMZyLaPhwhYoiEMZM8CJA8FP/74fCuPdhmdT3h0A/zsc/
	 bm3ANV80cm9DZBuhU38we585aPHsR42NQiRDXiZMrbVrVJeds4KILvUfG+cDUGqOTj
	 7Q9n20JFfimvN6pMPd/3uMNolXT8a3F90HpzJFbE=
Date: Wed, 24 Sep 2025 14:58:06 -0700
To: mm-commits@vger.kernel.org,vbabka@suse.cz,stable@vger.kernel.org,rppt@kernel.org,nogikh@google.com,Markus.Elfring@web.de,elver@google.com,dvyukov@google.com,david@redhat.com,glider@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-memblock-correct-totalram_pages-accounting-with-kmsan.patch added to mm-new branch
Message-Id: <20250924215806.DAA9FC4CEE7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/memblock: correct totalram_pages accounting with KMSAN
has been added to the -mm mm-new branch.  Its filename is
     mm-memblock-correct-totalram_pages-accounting-with-kmsan.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-memblock-correct-totalram_pages-accounting-with-kmsan.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Alexander Potapenko <glider@google.com>
Subject: mm/memblock: correct totalram_pages accounting with KMSAN
Date: Wed, 24 Sep 2025 12:03:01 +0200

When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
for metadata instead of returning them to the early allocator.  The
callers, however, would unconditionally increment `totalram_pages`,
assuming the pages were always freed.  This resulted in an incorrect
calculation of the total available RAM, causing the kernel to believe it
had more memory than it actually did.

This patch refactors `memblock_free_pages()` to return the number of pages
it successfully frees.  If KMSAN stashes the pages, the function now
returns 0; otherwise, it returns the number of pages in the block.

The callers in `memblock.c` have been updated to use this return value,
ensuring that `totalram_pages` is incremented only by the number of pages
actually returned to the allocator.  This corrects the total RAM
accounting when KMSAN is active.

Link: https://lkml.kernel.org/r/20250924100301.1558645-1-glider@google.com
Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Aleksandr Nogikh <nogikh@google.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/internal.h |    4 ++--
 mm/memblock.c |   21 +++++++++++----------
 mm/mm_init.c  |    9 +++++----
 3 files changed, 18 insertions(+), 16 deletions(-)

--- a/mm/internal.h~mm-memblock-correct-totalram_pages-accounting-with-kmsan
+++ a/mm/internal.h
@@ -742,8 +742,8 @@ static inline void clear_zone_contiguous
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
-extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
+unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
+				  unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order,
 		enum meminit_context context);
 
--- a/mm/memblock.c~mm-memblock-correct-totalram_pages-accounting-with-kmsan
+++ a/mm/memblock.c
@@ -1826,6 +1826,7 @@ void *__init __memblock_alloc_or_panic(p
 void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t cursor, end;
+	unsigned long freed_pages = 0;
 
 	end = base + size - 1;
 	memblock_dbg("%s: [%pa-%pa] %pS\n",
@@ -1834,10 +1835,9 @@ void __init memblock_free_late(phys_addr
 	cursor = PFN_UP(base);
 	end = PFN_DOWN(base + size);
 
-	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
-		totalram_pages_inc();
-	}
+	for (; cursor < end; cursor++)
+		freed_pages += memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+	totalram_pages_add(freed_pages);
 }
 
 /*
@@ -2259,9 +2259,11 @@ static void __init free_unused_memmap(vo
 #endif
 }
 
-static void __init __free_pages_memory(unsigned long start, unsigned long end)
+static unsigned long __init __free_pages_memory(unsigned long start,
+						unsigned long end)
 {
 	int order;
+	unsigned long freed = 0;
 
 	while (start < end) {
 		/*
@@ -2279,14 +2281,15 @@ static void __init __free_pages_memory(u
 		while (start + (1UL << order) > end)
 			order--;
 
-		memblock_free_pages(pfn_to_page(start), start, order);
+		freed += memblock_free_pages(pfn_to_page(start), start, order);
 
 		start += (1UL << order);
 	}
+	return freed;
 }
 
 static unsigned long __init __free_memory_core(phys_addr_t start,
-				 phys_addr_t end)
+					       phys_addr_t end)
 {
 	unsigned long start_pfn = PFN_UP(start);
 	unsigned long end_pfn = PFN_DOWN(end);
@@ -2297,9 +2300,7 @@ static unsigned long __init __free_memor
 	if (start_pfn >= end_pfn)
 		return 0;
 
-	__free_pages_memory(start_pfn, end_pfn);
-
-	return end_pfn - start_pfn;
+	return __free_pages_memory(start_pfn, end_pfn);
 }
 
 static void __init memmap_init_reserved_pages(void)
--- a/mm/mm_init.c~mm-memblock-correct-totalram_pages-accounting-with-kmsan
+++ a/mm/mm_init.c
@@ -2547,24 +2547,25 @@ void *__init alloc_large_system_hash(con
 	return table;
 }
 
-void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
+unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
+					 unsigned int order)
 {
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
 
 		if (!early_page_initialised(pfn, nid))
-			return;
+			return 0;
 	}
 
 	if (!kmsan_memblock_free_pages(page, order)) {
 		/* KMSAN will take care of these pages. */
-		return;
+		return 0;
 	}
 
 	/* pages were reserved and not allocated */
 	clear_page_tag_ref(page);
 	__free_pages_core(page, order, MEMINIT_EARLY);
+	return 1UL << order;
 }
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
_

Patches currently in -mm which might be from glider@google.com are

mm-memblock-correct-totalram_pages-accounting-with-kmsan.patch


