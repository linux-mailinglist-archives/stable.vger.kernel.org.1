Return-Path: <stable+bounces-179518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67392B562A1
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 20:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE09F7A7822
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C7238142;
	Sat, 13 Sep 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGBmW6RZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B10237707
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757789989; cv=none; b=EkqA0h+581A99Ha4Lq6jVIb2UXCd/nJJW8xjE1DxTTpLzFfEj2KiWeziwgcsAmpZOcnvGvvJnPVDpdL5JCY2Kxy8KbRU593nVZDscc4MkF8WA/YbGPO4QOhv8QE+7cNRizJPpgR7DYwTSSi7LXAuM/KMQSOk7ao648+RpoNRIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757789989; c=relaxed/simple;
	bh=rz4i2TiYDwK/+hL36Ql8VGyzT4rQGgV80p7+9ya1jck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFlEwxeXs24FIPVI4Acbp8wSycw4E9njevcmUb2xs60pbJtmt4hTYkUr09VYaKAmfUljhX+YDg2ALMzr68nt4jbqZozZytFQs0dicICj6wk0oF/LQg8lOybT4QcPeTnt8D7cZsRCxo29/42LFBm64GHMfJFqjJB5DEmpuGdHezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGBmW6RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55134C4CEF9;
	Sat, 13 Sep 2025 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757789989;
	bh=rz4i2TiYDwK/+hL36Ql8VGyzT4rQGgV80p7+9ya1jck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGBmW6RZKLWoNbR5057vHiI/6VDEikL2BtzAi5N7QZ2alQeyb2qtKjYTbWjl/LYDb
	 RHN0e3aKTX7D1nBnfoNI+f+sfyXxl+tsA64GQAoT3XKAoW6OMbhqYo45MI14mHQjUB
	 jzaY5rkEyKefgvn7eE5bsZlF0PmFrLroUhYd4wNv7UdmA95ck4dIgS70wUk7IZ/1/I
	 ARkM3yb0aC21JyeJk+a4OcehxxWBw+z679tttUAiAUj3+Tixi+prjsohtmnlvCvplr
	 ITDR8AUNkOzZw8I+dAWy89g+6p3G6C+/17pNZCM6gjfMkyrHk9+DPUx0W+gxoCwjbJ
	 18B++5QZd00gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	syzbot+3470c9ffee63e4abafeb@syzkaller.appspotmail.com,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/vmalloc, mm/kasan: respect gfp mask in kasan_populate_vmalloc()
Date: Sat, 13 Sep 2025 14:59:45 -0400
Message-ID: <20250913185945.1514830-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913185945.1514830-1-sashal@kernel.org>
References: <2025091303-hush-compactor-2f22@gregkh>
 <20250913185945.1514830-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

[ Upstream commit 79357cd06d41d0f5a11b17d7c86176e395d10ef2 ]

kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask and
always allocate memory using the hardcoded GFP_KERNEL flag.  This makes
them inconsistent with vmalloc(), which was recently extended to support
GFP_NOFS and GFP_NOIO allocations.

Page table allocations performed during shadow population also ignore the
external gfp_mask.  To preserve the intended semantics of GFP_NOFS and
GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
memalloc scope.

xfs calls vmalloc with GFP_NOFS, so this bug could lead to deadlock.

There was a report here
https://lkml.kernel.org/r/686ea951.050a0220.385921.0016.GAE@google.com

This patch:
 - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
 - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
 - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
   around apply_to_page_range();
 - Updates vmalloc.c and percpu allocator call sites accordingly.

Link: https://lkml.kernel.org/r/20250831121058.92971-1-urezki@gmail.com
Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reported-by: syzbot+3470c9ffee63e4abafeb@syzkaller.appspotmail.com
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kasan.h |  6 +++---
 mm/kasan/shadow.c     | 31 ++++++++++++++++++++++++-------
 mm/vmalloc.c          |  8 ++++----
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6bbfc8aa42e8f..ef81c543ea2a0 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -564,7 +564,7 @@ static inline void kasan_init_hw_tags(void) { }
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
@@ -576,7 +576,7 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
 						       unsigned long size)
 { }
 static inline int kasan_populate_vmalloc(unsigned long start,
-					unsigned long size)
+					unsigned long size, gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -612,7 +612,7 @@ static __always_inline void kasan_poison_vmalloc(const void *start,
 static inline void kasan_populate_early_vm_area_shadow(void *start,
 						       unsigned long size) { }
 static inline int kasan_populate_vmalloc(unsigned long start,
-					unsigned long size)
+					unsigned long size, gfp_t gfp_mask)
 {
 	return 0;
 }
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1d..c7c0be1191737 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
 	}
 }
 
-static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
+static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
 {
 	unsigned long nr_populated, nr_total = nr_pages;
 	struct page **page_array = pages;
 
 	while (nr_pages) {
-		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
 		if (!nr_populated) {
 			___free_pages_bulk(page_array, nr_total - nr_pages);
 			return -ENOMEM;
@@ -353,25 +353,42 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
 	return 0;
 }
 
-static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
+static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
 {
 	unsigned long nr_pages, nr_total = PFN_UP(end - start);
 	struct vmalloc_populate_data data;
+	unsigned int flags;
 	int ret = 0;
 
-	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
 	if (!data.pages)
 		return -ENOMEM;
 
 	while (nr_total) {
 		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
-		ret = ___alloc_pages_bulk(data.pages, nr_pages);
+		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
 		if (ret)
 			break;
 
 		data.start = start;
+
+		/*
+		 * page tables allocations ignore external gfp mask, enforce it
+		 * by the scope API
+		 */
+		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+			flags = memalloc_nofs_save();
+		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+			flags = memalloc_noio_save();
+
 		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
 					  kasan_populate_vmalloc_pte, &data);
+
+		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+			memalloc_nofs_restore(flags);
+		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+			memalloc_noio_restore(flags);
+
 		___free_pages_bulk(data.pages, nr_pages);
 		if (ret)
 			break;
@@ -385,7 +402,7 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
 	return ret;
 }
 
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask)
 {
 	unsigned long shadow_start, shadow_end;
 	int ret;
@@ -414,7 +431,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
 	shadow_end = PAGE_ALIGN(shadow_end);
 
-	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
+	ret = __kasan_populate_vmalloc(shadow_start, shadow_end, gfp_mask);
 	if (ret)
 		return ret;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3519c4e4f841d..79e6c0e599f5f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1977,6 +1977,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
 
+	/* Only reclaim behaviour flags are relevant. */
+	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
 	might_sleep();
 
 	/*
@@ -1989,8 +1991,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 */
 	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
 	if (!va) {
-		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
-
 		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 		if (unlikely(!va))
 			return ERR_PTR(-ENOMEM);
@@ -2040,7 +2040,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	ret = kasan_populate_vmalloc(addr, size);
+	ret = kasan_populate_vmalloc(addr, size, gfp_mask);
 	if (ret) {
 		free_vmap_area(va);
 		return ERR_PTR(ret);
@@ -4789,7 +4789,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 	/* populate the kasan shadow space */
 	for (area = 0; area < nr_vms; area++) {
-		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
+		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area], GFP_KERNEL))
 			goto err_free_shadow;
 	}
 
-- 
2.51.0


