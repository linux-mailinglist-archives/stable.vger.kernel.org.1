Return-Path: <stable+bounces-73697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2D96E899
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 06:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679A51F24C0F
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8885464A;
	Fri,  6 Sep 2024 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9i9MwPg"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E614962B
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596478; cv=none; b=S8/yiNacoPjk43/xqRg4QH9+KtViqGf6lk6XEmxysDsmgE0dWvGCkQL2VvJGIefY603pr8rPYM6G+cBLWA9aczace7pwl8dYgtXwwhA89o9RuYgnZV6hxMqYwfxhugy7bqDx+fFdjnVSpAXaOBCgeICLoBabFyxs58WCZIBvbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596478; c=relaxed/simple;
	bh=L7oJlciADER/2IlwaPplzhgmjGrNEnuC9lRkpAH3ysk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CnOi/U7fsaF278bNfQaxMZ5UN8pzq56E6p7wboXb9HlrSf3GNTa9+t9nFmsf+tx/vIQ8+niavRHwKag5f80KVOmHlhGlIu2nCWi57FmMreH+LvLsKCNJShjhWP8Dy9qfLpHj8+J93DwyfDhjj+8+7EWQHLPll9ZONZFtdftGwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9i9MwPg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d351c9fb5so809106276.1
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 21:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725596475; x=1726201275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8z7JhTPd5a0ay4gHmViQDV8ynpAlUlJ3UT1hxWkVyQ=;
        b=q9i9MwPgtil2qBgcsarf8SIChduqmAI+AeNJEOrSJvCkg5vPShjKlheBbp4bNny9Vm
         sYZilf/+VEyTdt/LpdjViWcVLWQEIuIjIUik8x0e7QoCZR8z2w+SAmrM6LA7tEMKj4Na
         cNRXDExXJtGoyI7ek/8pFI2G6XDvxuYeUdceCcWh7YS35z69EaKJluwPyk3C/2UADjxn
         NTiFRE3mAtSauk2RkOwcIK6kxi4yGi6ABk5KBOpQQjxvYd5VF4P6NZxKMHvtSRi6vMmx
         hZD08bkQVDujn8V0zOCsnJF2w3mLE4ZuaP/7DyhReAElQBnRN/sDvLCTbGxPZxtG/uJw
         kydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725596475; x=1726201275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8z7JhTPd5a0ay4gHmViQDV8ynpAlUlJ3UT1hxWkVyQ=;
        b=RPcu/fS6m3Sj+OkB3/sx4QFcT5/qnHgGe4QHYFcsyhFxt4KyiZ54J2z5/V3/ZDPT24
         Bn4M9gmg4KIPkjDVDZpVsrifFzemm1eOwF8kSZx8GvE1eUMfF6885tj4wwt2ctJ4hi1Y
         iLRJ4FyqUM+hQv5K5aLvqjTtcq4NK6CZ6edxoA04dt3Bi0YFaK76FgDRXtJTuwmxrYpU
         mVlJaSYGUNrTvg2sZErLq+1Sngobb4F+wQn5TbDUwTwOJHPDtvVx04znvidO/+ZHUr7A
         BzaXuiydKjwmKP+1w3DwuZI536f2SArKHGSgPcSHvmzYpyN5lvOWfMmQJd3aSlEwuX98
         357g==
X-Forwarded-Encrypted: i=1; AJvYcCXlOmaQTRkSTNp7gmE8d0BsCPNl6VEBuASkZVP4VY/+D1R6GAc8opGtO5JbjIL/CB+VV6dlC7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggSADZPYmGlHDPpjvbVU+xrvgj+R/6//75AteS9IVzhCDdNra
	dbOC2UBPpYNhLNSW68a41f/CRYasBPh36aeFOr/44Bg9057O1/ly0AWcMea/J2BzqsF6wI3xdsC
	5DA==
X-Google-Smtp-Source: AGHT+IHnLZW3xX/3Rs6MjEAzTLo2oLLdlVk4kTRKTlbd52QR9KUnODr0nzvAIBIuE8r0TUpZnBgXzd5k3bg=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:5b7a:cdaf:9b3d:354a])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2d43:b0:e16:4e62:8a17 with SMTP id
 3f1490d57ef6-e1d3485d5cemr5514276.2.1725596475174; Thu, 05 Sep 2024 21:21:15
 -0700 (PDT)
Date: Thu,  5 Sep 2024 22:21:07 -0600
In-Reply-To: <20240906042108.1150526-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906042108.1150526-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906042108.1150526-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 2/3] mm/codetag: fix pgalloc_tag_split()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The current assumption is that a large folio can only be split into
order-0 folios. That is not the case for hugeTLB demotion, nor for
THP split: see commit c010d47f107f ("mm: thp: split huge page to any
lower order pages").

When a large folio is split into ones of a lower non-zero order, only
the new head pages should be tagged. Tagging tail pages can cause
imbalanced "calls" counters, since only head pages are untagged by
pgalloc_tag_sub() and the "calls" counts on tail pages are leaked,
e.g.,

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

Not tagging tail pages also improves the splitting time, e.g., by
about 15% when demoting 1GB hugeTLB folios to 2MB ones, as shown
above.

Fixes: be25d1d4e822 ("mm: create new codetag references during page splitting")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/mm.h          | 30 ++++++++++++++++++++++++++++++
 include/linux/pgalloc_tag.h | 31 -------------------------------
 mm/huge_memory.c            |  2 +-
 mm/hugetlb.c                |  2 +-
 mm/page_alloc.c             |  4 ++--
 5 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b31d4bdd65ad..a07e93adb8ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4137,4 +4137,34 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
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
index 207f0c83c8e9..59a3deb792a8 100644
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
index fdc83b0c9e71..2a73efea02d7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3242,7 +3242,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(head, 1 << order);
+	pgalloc_tag_split(folio, order, new_order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (folio_test_anon(folio)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2a73753ecf9e..5c77defad295 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3795,7 +3795,7 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
 		list_del(&folio->lru);
 
 		split_page_owner(&folio->page, huge_page_order(src), huge_page_order(dst));
-		pgalloc_tag_split(&folio->page, 1 <<  huge_page_order(src));
+		pgalloc_tag_split(folio, huge_page_order(src), huge_page_order(dst));
 
 		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
 			struct page *page = folio_page(folio, i);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6b003f57965d..88113fdba956 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2783,7 +2783,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
-	pgalloc_tag_split(page, 1 << order);
+	pgalloc_tag_split(page_folio(page), order, 0);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4981,7 +4981,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
-		pgalloc_tag_split(page, 1 << order);
+		pgalloc_tag_split(page_folio(page), order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.46.0.469.g59c65b2a67-goog


