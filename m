Return-Path: <stable+bounces-86718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556FD9A3031
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 23:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152AA2829EA
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A021D63C2;
	Thu, 17 Oct 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI4cVylg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE61D6DA3
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202302; cv=none; b=ArZ/DD6m8yslA55r0XWI2ABiPmDqujawag+l4WD9+KyxMT3bj4WojxyGdJtZzB8QyHxa/UDS0AQb6XHZcWyL/fHf6vxGbiLZL74crkgxigCq3P5rBubNG9sU6mN7Oo+8G67MD/AJhZz+vi/adt3/xQuAZNUgbLcbmMcSzH8iyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202302; c=relaxed/simple;
	bh=RUxXZJYvPeb2Ga6fXDj0iK9zbK0BMwyzEioc1oJLD6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E12vzB8HkjyPwocDwlAPSdizptcOKxCPEmSZylv2axY9uKSJMb/RmPWu9BTx0ljy0TX10dvKY8x2tqv5MrSuA89O5Qyrqyab+dbJzQbssMcx7WMq4IEgXFfs8HA2wHaS+ztgH4+oL+4l/CvD0HS3KZRhCY1NMjAhp+uYbGg0pKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI4cVylg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE0C4CED0;
	Thu, 17 Oct 2024 21:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202301;
	bh=RUxXZJYvPeb2Ga6fXDj0iK9zbK0BMwyzEioc1oJLD6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jI4cVylgoMuQpU1A3Wz4P0cB/ymfTHyJoqhsJ2mddHJZkQ3fdmP2Z/7teBLVTAlr3
	 GDyETfcZsfjYirJ5vdQGkXKf+ti7Ud38tH3IIxjWi51jvgGspI/1iZqdPqi0pK2aWY
	 gPWo4vpdDF+nGdRx4TkeVgvpfnLqLXo8/LdKzjvaTjYa6jH8kNwhZBcVk14UwnLapc
	 BHqzoJS74/9+NmvxLxPKstPkad2tMOOom//Wqnq0bmCv88B5i1vvKKkpjL/ZI1bXmE
	 oWngLGrbimdpgIkOvayInf86BxHBAsdzkVYP/mYO1/3EmzHpnWLM5Svk5l9anu1tvI
	 daRmtbxfGLwyA==
From: chrisl@kernel.org
Date: Thu, 17 Oct 2024 14:58:03 -0700
Subject: [PATCH 6.11.y 2/3] mm/codetag: fix pgalloc_tag_split()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-stable-yuzhao-v1-2-3a4566660d44@kernel.org>
References: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
In-Reply-To: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit 95599ef684d01136a8b77c16a7c853496786e173 ]

The current assumption is that a large folio can only be split into
order-0 folios.  That is not the case for hugeTLB demotion, nor for THP
split: see commit c010d47f107f ("mm: thp: split huge page to any lower
order pages").

When a large folio is split into ones of a lower non-zero order, only the
new head pages should be tagged.  Tagging tail pages can cause imbalanced
"calls" counters, since only head pages are untagged by pgalloc_tag_sub()
and the "calls" counts on tail pages are leaked, e.g.,

  # echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
  # echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
  # echo 0 >/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
  # grep alloc_gigantic_folio /proc/allocinfo

Before this patch:
  0  549427200  mm/hugetlb.c:1549 func:alloc_gigantic_folio

  real  0m2.057s
  user  0m0.000s
  sys   0m2.051s

After this patch:
  0          0  mm/hugetlb.c:1549 func:alloc_gigantic_folio

  real  0m1.711s
  user  0m0.000s
  sys   0m1.704s

Not tagging tail pages also improves the splitting time, e.g., by about
15% when demoting 1GB hugeTLB folios to 2MB ones, as shown above.

Link: https://lkml.kernel.org/r/20240906042108.1150526-2-yuzhao@google.com
Fixes: be25d1d4e822 ("mm: create new codetag references during page splitting")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h          | 30 ++++++++++++++++++++++++++++++
 include/linux/pgalloc_tag.h | 31 -------------------------------
 mm/huge_memory.c            |  2 +-
 mm/page_alloc.c             |  4 ++--
 4 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1470736017168..8330363126918 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4216,4 +4216,34 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+	int i;
+	struct alloc_tag *tag;
+	unsigned int nr_pages = 1 << new_order;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	tag = pgalloc_tag_get(&folio->page);
+	if (!tag)
+		return;
+
+	for (i = nr_pages; i < (1 << old_order); i += nr_pages) {
+		union codetag_ref *ref = get_page_tag_ref(folio_page(folio, i));
+
+		if (ref) {
+			/* Set new reference to point to the original tag */
+			alloc_tag_ref_set(ref, tag);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+#else /* !CONFIG_MEM_ALLOC_PROFILING */
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+}
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 207f0c83c8e97..59a3deb792a8d 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -80,36 +80,6 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
 	}
 }
 
-static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
-{
-	int i;
-	struct page_ext *first_page_ext;
-	struct page_ext *page_ext;
-	union codetag_ref *ref;
-	struct alloc_tag *tag;
-
-	if (!mem_alloc_profiling_enabled())
-		return;
-
-	first_page_ext = page_ext = page_ext_get(page);
-	if (unlikely(!page_ext))
-		return;
-
-	ref = codetag_ref_from_page_ext(page_ext);
-	if (!ref->ct)
-		goto out;
-
-	tag = ct_to_alloc_tag(ref->ct);
-	page_ext = page_ext_next(page_ext);
-	for (i = 1; i < nr; i++) {
-		/* Set new reference to point to the original tag */
-		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
-		page_ext = page_ext_next(page_ext);
-	}
-out:
-	page_ext_put(first_page_ext);
-}
-
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
 {
 	struct alloc_tag *tag = NULL;
@@ -142,7 +112,6 @@ static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
-static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 99b146d16a185..837d41906f2ac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2976,7 +2976,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(head, 1 << order);
+	pgalloc_tag_split(folio, order, new_order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (folio_test_anon(folio)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91ace8ca97e21..72b710566cdbc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2764,7 +2764,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
-	pgalloc_tag_split(page, 1 << order);
+	pgalloc_tag_split(page_folio(page), order, 0);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4950,7 +4950,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
-		pgalloc_tag_split(page, 1 << order);
+		pgalloc_tag_split(page_folio(page), order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);

-- 
2.47.0.rc1.288.g06298d1525-goog


