Return-Path: <stable+bounces-158859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64916AED227
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 03:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8F53B49F5
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 01:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F674059;
	Mon, 30 Jun 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdNtSdiX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E078F24;
	Mon, 30 Jun 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751246002; cv=none; b=AK/zjcvRgUvKpyW5llqUhW+3aIF1FzMrNnlcp6gggA5Zg56NOprjnLYguKSIH633RSlwzXIqI/wIpK838sdoVOKERjKxyQljI6Xs3E/afAuXKmvC5TJA9cLjIx2rz8mB00CxJbPvcNGGYiEUDxhO2T76s4wQz9RqZmDXSIBdR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751246002; c=relaxed/simple;
	bh=vNHSQQAYVcc4uD1KveBlGS066NoRCj08nymU/rir7Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drg3IidrcSv26FQWWz4YCywgvmhfagjMuV+jzcjx6VnUghl/X0X46GPFyjFfBT/i9OaJJ8HhQzVboS67LVWE6+TnmzqLoke6UBsrRhoJzdDMl54bW4MSsOn1bQYcOIWI6Mn7dl6rdEuZDR+39nfVWjcQbUbgocfah50jnnFcJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdNtSdiX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5123c1533so802544f8f.2;
        Sun, 29 Jun 2025 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751245998; x=1751850798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvYmFatUul6C95sdqfwhbwawXh1OZ/t57imv68gIbAs=;
        b=EdNtSdiXfZQ8GEAbEJIEJeG4abRRPqQojjVb2KABySzYBQqsmKrrRf/lET+7HSykKg
         miIHsPbvYZ+yzfRb5iBBxwkqghQwu3K85G50Uw9Hc5h9HbUeAnNq3Y1SGmU/uFCl6VSK
         ZNPOLBkTepk2GtmZ+bYCVJnI67mkBsR0KcXAxeUpNIk8KX5jXnJC0OZNr/N1LfTom+tr
         6GLp/0k9PWCPtSxAlJxsdNW0glWkgrFqI3vJ4MO3WgCbZhb3kueWAymVDTV2ZolZOyQ3
         Z7e0a3FQ0mkwj1WmbSwVXBx7rrO3OkP0lP4C63tdt0owO9AVfUQeV1MojTC5agz0LuPb
         P/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751245998; x=1751850798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvYmFatUul6C95sdqfwhbwawXh1OZ/t57imv68gIbAs=;
        b=pDw/bliTjnOUNBCoe8lM0GnqnS33DLwn07kpZ5QNR1GwAIj/YY87XF3Gq8KNeV67kw
         gZ0zVtZNfNfC1HhuEXMy1oYNce6K3h3SzLczfQSLfbpetYTEwXx7XJ05HL/HvoZYiHe+
         90YUiLLD7rdxI2Jxhub1o4LLAwPcduB2NCckgSnyxy7Ow4AADlyvvPvfyYLCgQXgTiqk
         0NIZevg9nwCiNQfaaTVnXmXKnLMXUz87cd6S1Ey+CusVbqELtwsCDLHfs9iYXIo9jw13
         F0QToeLZGfVkCz/my5st8Snv0PtYDSMlLCfp9h4CXTeFlcWxsurh5kY3P9Iq4ZYLAMLp
         JR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhdnwsGnoIcwAdqQErClG97hYtpVQZk5GORRboJJgHzE7SDSdcOD3MHGA6/V2Jcb+M+CTuoKc8@vger.kernel.org, AJvYcCX40xQ5MrTWTIPCzj+p7FfzRc0KT3N1ZVMsmv0zCRZlvjHI3WneHcvik3wKBPnGlLkKkrZ4jGOVnFvhIoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjH6uF50obSjmQ9nMILanAnVSSj2JtZ1pj5qVT5SLEAni3f/mS
	5NtgL0wOkDV/zXVCpEt2SFSVACpIWhGlIq0F5ZRws0ICJwUxsmE+mZV0
X-Gm-Gg: ASbGncu7lncZAfc9bsWCi9Y61CG4QdKOW8qRtHIzKmcMLmyHBsdyG6YD04nNOvuYkV/
	8H/kuyrpvljZLwpxaGGdee/CCD6+YksLcPGBdwXMV14ZIsq9aIHsTcEjftHvftvxHGPOlkGQwfS
	LAF7P25BG+A7s9BlvSJKtiNtFxTH0BMggD0f7OxZ2jgnmR0yyv8EDGZCIt0iCFp0OY0QZIsfKD8
	avEZI2cbIOYoQ7XqlawhuaARFL6oF8bO/7n3bY+5p9XUvh710Ohiv6B/5RkaGnGtxYxFbUwuH/n
	mavkM1GlDGnCcs+kaV+UQMGCPyhXNYtXJWps60GQe/gT8ZVb
X-Google-Smtp-Source: AGHT+IG9vFE1ILgi8HDEneBoTPP9xiU1dYIZXp7wDUVsQw07A+lHFULl/cv0/NgbZly8KJ0xCHEmug==
X-Received: by 2002:a05:6000:42c7:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a8f50cc97cmr7907228f8f.21.1751245997833;
        Sun, 29 Jun 2025 18:13:17 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::302c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e74fbsm9123735f8f.10.2025.06.29.18.13.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Jun 2025 18:13:17 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
X-Google-Original-From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	21cnbao@gmail.com
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	ioworker0@gmail.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	x86@kernel.org,
	huang.ying.caritas@gmail.com,
	zhengtangquan@oppo.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	mingzhe.yang@ly.com,
	stable@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 1/1] mm/rmap: fix potential out-of-bounds page table access during batched unmap
Date: Mon, 30 Jun 2025 09:13:05 +0800
Message-ID: <20250630011305.23754-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
may read past the end of a PTE table when a large folio's PTE mappings
are not fully contained within a single page table.

While this scenario might be rare, an issue triggerable from userspace must
be fixed regardless of its likelihood. This patch fixes the out-of-bounds
access by refactoring the logic into a new helper, folio_unmap_pte_batch().

The new helper correctly calculates the safe batch size by capping the scan
at both the VMA and PMD boundaries. To simplify the code, it also supports
partial batching (i.e., any number of pages from 1 up to the calculated
safe maximum), as there is no strong reason to special-case for fully
mapped folios.

[1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com

Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
Cc: <stable@vger.kernel.org>
Acked-by: Barry Song <baohua@kernel.org>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Barry Song <baohua@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
 - Tweak changelog (per Barry and David)
 - Pick AB from Barry - thanks!
 - https://lore.kernel.org/linux-mm/20250627062319.84936-1-lance.yang@linux.dev

v1 -> v2:
 - Update subject and changelog (per Barry)
 - https://lore.kernel.org/linux-mm/20250627025214.30887-1-lance.yang@linux.dev

 mm/rmap.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index fb63d9256f09..1320b88fab74 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1845,23 +1845,32 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
 #endif
 }
 
-/* We support batch unmapping of PTEs for lazyfree large folios */
-static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
-			struct folio *folio, pte_t *ptep)
+static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
+			struct page_vma_mapped_walk *pvmw,
+			enum ttu_flags flags, pte_t pte)
 {
 	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
-	int max_nr = folio_nr_pages(folio);
-	pte_t pte = ptep_get(ptep);
+	unsigned long end_addr, addr = pvmw->address;
+	struct vm_area_struct *vma = pvmw->vma;
+	unsigned int max_nr;
+
+	if (flags & TTU_HWPOISON)
+		return 1;
+	if (!folio_test_large(folio))
+		return 1;
 
+	/* We may only batch within a single VMA and a single page table. */
+	end_addr = pmd_addr_end(addr, vma->vm_end);
+	max_nr = (end_addr - addr) >> PAGE_SHIFT;
+
+	/* We only support lazyfree batching for now ... */
 	if (!folio_test_anon(folio) || folio_test_swapbacked(folio))
-		return false;
+		return 1;
 	if (pte_unused(pte))
-		return false;
-	if (pte_pfn(pte) != folio_pfn(folio))
-		return false;
+		return 1;
 
-	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
-			       NULL, NULL) == max_nr;
+	return folio_pte_batch(folio, addr, pvmw->pte, pte, max_nr, fpb_flags,
+			       NULL, NULL, NULL);
 }
 
 /*
@@ -2024,9 +2033,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (pte_dirty(pteval))
 				folio_mark_dirty(folio);
 		} else if (likely(pte_present(pteval))) {
-			if (folio_test_large(folio) && !(flags & TTU_HWPOISON) &&
-			    can_batch_unmap_folio_ptes(address, folio, pvmw.pte))
-				nr_pages = folio_nr_pages(folio);
+			nr_pages = folio_unmap_pte_batch(folio, &pvmw, flags, pteval);
 			end_addr = address + nr_pages * PAGE_SIZE;
 			flush_cache_range(vma, address, end_addr);
 
@@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		} else {
 			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
-			folio_ref_sub(folio, nr_pages - 1);
 		}
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
-		folio_put(folio);
-		/* We have already batched the entire folio */
-		if (nr_pages > 1)
+		folio_put_refs(folio, nr_pages);
+
+		/*
+		 * If we are sure that we batched the entire folio and cleared
+		 * all PTEs, we can just optimize and stop right here.
+		 */
+		if (nr_pages == folio_nr_pages(folio))
 			goto walk_done;
 		continue;
 walk_abort:
-- 
2.49.0


