Return-Path: <stable+bounces-158734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34537AEAEFC
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 08:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E492A562306
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 06:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3995475E;
	Fri, 27 Jun 2025 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxxHP/+B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F582866;
	Fri, 27 Jun 2025 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005428; cv=none; b=kx/kh/ep1lSCEweoMH7A0XGXSgYpnPtpLBVYdvEYq4pK7igzRhwM7fCzYpTMN6+6ILPWWDj4iaHTLT5H90Mn/IaU46f7s+IqKYvCBCTrw8LcwPfHQ4L0+J1KJoxGzpfXdMkrd9m8LEvIpNriFWsxLT2bjE1EqqsrZsHNrjnERX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005428; c=relaxed/simple;
	bh=sxKU4vp0w5gNhXkyFUOM3H3iHQyXxFxKA4+jwYiBH5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APaQBxUVrzWuD3vtDfzPSrDR6OxHsKMwFAvwfS7F8brV15Uhle7CtFB31Iz8gaq4SYV08FV+Y6evoSbl221GPFtxJb74+bC12UhyQ5N/CeXZQPFI0qu9/ebUP1vBSStceDVncK/3HQHCn3ppKN9qCZR3AxOj7cwdoKQ3/7Rle4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxxHP/+B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so11725765e9.1;
        Thu, 26 Jun 2025 23:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751005425; x=1751610225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtGJ3hLLX6kLkhpS+Roj43p3ubAD6EYXh2l2qlYKI+A=;
        b=YxxHP/+BnUN7zKxwp9oofA4SO8TIRyOBSQhYUCabqF5BZkDXNQL1rcbSM6Tb6AFxO8
         BEoElSpaM6+PADHcxjeZKjVM040G1AKvPuhcDs098zd/0fa9rraZTh4v3evC8qTsPzjN
         G5uHdjPnzWB4cSnJXg/8pCmZ2KEy+PArFAF/HaRvvJ2bqJixmwkqu5tKf57kUjYmeOR6
         UAnf+muT+OVhJ9cQNVt07Nv0j3vb8qSbcb1T0K/3n7G++nqZ//j3BTQHcZhSRpHw34xp
         5DCSiaXFVwwRKGp+ldHB147cetZMnPqfxxsTWacuQa0115GUUzbNGvkGDBxYZoSMLd6a
         jh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005425; x=1751610225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtGJ3hLLX6kLkhpS+Roj43p3ubAD6EYXh2l2qlYKI+A=;
        b=IXQSq9g6LLkjiMrxnOF8+EzVzA3yzMK5H+R73mrh14icZJE666AyRAAjHT7wiwND8U
         f5RPH4EGZSHr6pno2rDBndzDGCs8H27IDETW1m9M0K96GXi8Z8aOmIQlZQwbIVpXyPmk
         GONorJuLlL08GE+AIlY4/XuTMf2S+LiW48looP3l5N2JWyqp5VEjOpH6qzd1qEua88Cl
         iU5ZMZYpImu3WpAfWe152t2GvBjEjjLX/a+Y6Y7+NQVwIH2WH31eLzgUKYQVB58VwQ7v
         KExuK8QyfFRrm0q+M50QCdzoQIsM2UAIuQQ9QPvRKhOzHBY6eFn8AuEzyMraotlXbnI0
         K7sw==
X-Forwarded-Encrypted: i=1; AJvYcCVG+rj6uPNNUqCSrge/4GE0KWo1uAIij5aP5WRorLOzU6aR7hg07isPy8R+QQ3x5eD3dGrM7RkSv2bbwts=@vger.kernel.org, AJvYcCWRXzZTuge59wEcUxWHaQ2NuO90L3gr51TV5hdAX3R/hvot9q9hw1mBUKYe+0/+DNHUp9FKEwc+@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0syFx/oZnL+mWIF3N8ShIIxEjSUOdD0pCYqV4GwdcgbG1DiB
	2/8bFENNZJYaybVXVqd2yULe/VMAVE348z6a8qZKIOGHMJXIUIPR/NXT
X-Gm-Gg: ASbGncsDOasi//16cihKfwIe6cWVghH9BrdZ1sa4R8pcGh0rP/x3uMZZP+UDUf7m67/
	enLAZT1HTCqz8TpXDkNQZL+lBCTVUUUysEEfi7jMSfP2ydQT1Uoj3LoaqbijH45CX5NkshKWwFE
	arg6fjlRls364vc3wrAsv9izSd4ji6HS6hYCFNTIHbGlb/OInsJkyBZuszBbPxtASlDHO9B9KAT
	pfSCzIU+1T/ZkFEvlScG2V094WKcsAa+jJVVv1FvvCb9//A0ECP4Vg2ToDtap4eyPcEku5f5UoM
	w6neyRmRREg2gskmtLDs/lihfCeQAwB95MkAoeJ/WviplEAG
X-Google-Smtp-Source: AGHT+IEoFmH9LFHUYF3P7bOEbto60ZCDPCXGpSefiJHXbVDjvZl7uEcOX8LVwFH/mVmusY3MGMlK3g==
X-Received: by 2002:a05:600c:c4ac:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-4538ee85615mr17039465e9.22.1751005424277;
        Thu, 26 Jun 2025 23:23:44 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::302c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8b6sm1792296f8f.91.2025.06.26.23.23.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Jun 2025 23:23:43 -0700 (PDT)
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
Subject: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table access during batched unmap
Date: Fri, 27 Jun 2025 14:23:19 +0800
Message-ID: <20250627062319.84936-1-lance.yang@linux.dev>
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
can read past the end of a PTE table if a large folio is mapped starting at
the last entry of that table. It would be quite rare in practice, as
MADV_FREE typically splits the large folio ;)

So let's fix the potential out-of-bounds read by refactoring the logic into
a new helper, folio_unmap_pte_batch().

The new helper now correctly calculates the safe number of pages to scan by
limiting the operation to the boundaries of the current VMA and the PTE
table.

In addition, the "all-or-nothing" batching restriction is removed to
support partial batches. The reference counting is also cleaned up to use
folio_put_refs().

[1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com

Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
Cc: <stable@vger.kernel.org>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Barry Song <baohua@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
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


