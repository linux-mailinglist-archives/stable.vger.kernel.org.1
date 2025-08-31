Return-Path: <stable+bounces-176755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE8B3D2AB
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 14:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AA4188C909
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEA20D4E9;
	Sun, 31 Aug 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MStGD96M"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA341E47A5;
	Sun, 31 Aug 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756642265; cv=none; b=QmpDkjx4OGLWZebgWyrsGRY4M3YQqC2mEYWu+P6fh8AXeyM+UIPXBZvpYTf0QohVsSB9ibbt7op8gxW8aDu2LdAqry/Hro4FTmnrHhFFr5TXpnFUO5/NU6CoUYGMMN6UDNni0jcOLMap1Z3OoOgkjfgbhqR6cgtsJNeGUf08FbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756642265; c=relaxed/simple;
	bh=jICduQK12QHrbBJp8MUu9GI3F6Ji/6j0lTVwrNM4gcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4CeIrdYJdcrpiB63OsVK9DGibIpFhywWjBKYdCJ7qsZVPeeQmfcwfDR7qPYGKn/7tibAGgzn39VYn9H5uEMoCU0s8Cogo4UWmrE6c7rb9vDyLhkaTYqC1HcEBguQ3NACNGmDzDPvgsfRKShgDhd4vq5nHlWPLvZRvDZa1ht9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MStGD96M; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f98e7782bso3381e87.0;
        Sun, 31 Aug 2025 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756642262; x=1757247062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JG9B+llAHV7LYg7nSulca8AjjzTpBy37d7vM3/vyiO0=;
        b=MStGD96MzGclUFwGwNC4Se+nVsduW7AQ/6LaovEIh9fg1GCGR7AFAwEs5IYkt+uXzT
         7EGkS49/eouiD7cDQ39kaDXnyR0LSEilFxNdqDabOuRpQORY+rkWBtQhareD/YO3GYoz
         557wz1SXzEl6vinM4dRo89tPvcM30JtsiefVHGBpvjSBfzmygQacRZqJesyZdGp8xrWW
         4kMsR7gqNN32OlVr9MOQ2AJs7urnqYg/yONztSfTnTw0tbcNohTNziY3Ifv0Cd7sQMfB
         HTiSHJpba7uOwmlhOgac3Trt4SMWqmppzjAXjpdns4DAcR/gvJsz1x4V852eDonB9m7K
         zXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756642262; x=1757247062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG9B+llAHV7LYg7nSulca8AjjzTpBy37d7vM3/vyiO0=;
        b=G88H4iqPBT/2XgxK/E/M0TPJERHQ/s7PEO0iczQcdvCYUY3yxQ0L7nnSH1oGMH9o3B
         BghWG+82Yr19i9fSU/m7Yi8CdrJk58sYMwUeCrtHGjumxnw9xPnKibmGvxoZAKngft1l
         0l+psRI0uK4gPWNLTrEfGs14CPcJLsqF067Px1NteYuit4p5lsm3aDfc3Po5E8mD1m3C
         eL5+Jc3BMMmOPgytmjFn+jgnuQQONz1sbcTTZmM1om+lgeOqBo8XyfZoMsPDf5w3qUin
         gkJ3ivImIbGW2Z1x90VCAOZHyVzBJmBqBMvQmh8Rw1WNFt/hxRpQgFxqqsnw59jS7C4+
         c0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUFNsm4fQfQeZk5USIB9TzTCalrZwmrK9YIjNX2HDh7C8v/TPi1R7ag9Fu2l+VOpTeeKdkdTjQQ@vger.kernel.org, AJvYcCXxOxnP9YFEkdn6Zg8AkgibRwGVm14fE+dQR3vWnlWtEkAtOC8jYap+nwgCLkpLG17VEmjlK6gebw9c+Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXiOBbMCof19hE+qWPoPsycOCQXr3qk8VItMXq/EbINkYsxXY
	N8CVWcEFjFehRf4ojmcqRs0+PsOoVdtpIqr5zr68c7y8LOvwcxOd1uB62sRAtu+Q
X-Gm-Gg: ASbGncuhH6JVGUINTsIt2utCHyeZ90tn87ti9/UjLrl/CEDODxxQTCiHddeBzepMIsX
	mKazJWDT62/j+PHit7rYUJ5GLsPwhMH1/3YaBrjSiAEdt5z+hbP3+mJ3f5chdM2LyyTRuikep+P
	lYfx3So9VrqhYqfGvrSbPNoCwEmqxEB418YOHhZp2bgXkJlzEeXgyI6iTMBfepy5G57TqqYP+Dz
	2o24eV79Mq6R8wQR7P8mr/aaSzIIySvfIMyuXFQIU/Odndv1NcyU2D/K2bCMULOU4VYWKvl2bxT
	mjp0gI2TX7WuxwNYej29vPrhpdkUEvknE4+YX5WIzJpCCkwQ02LeWhPZegwWhi1qp0KDARj6qCG
	bViZ/2numSsJWbYnjZhbzyq1pHBzo
X-Google-Smtp-Source: AGHT+IFueuf2oZt8S2Uk0qkd9+oS33qtaqyqR6ss70d2dMC/0TmF2R5rYRs5z4E0tLgmfioWY9AQ/A==
X-Received: by 2002:a05:6512:3491:b0:55b:83cf:b260 with SMTP id 2adb3069b0e04-55f6f6c39b1mr927648e87.11.1756642261264;
        Sun, 31 Aug 2025 05:11:01 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7a3bf9b4sm279519e87.78.2025.08.31.05.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 05:11:00 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in kasan_populate_vmalloc()
Date: Sun, 31 Aug 2025 14:10:58 +0200
Message-ID: <20250831121058.92971-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
and always allocate memory using the hardcoded GFP_KERNEL flag. This
makes them inconsistent with vmalloc(), which was recently extended to
support GFP_NOFS and GFP_NOIO allocations.

Page table allocations performed during shadow population also ignore
the external gfp_mask. To preserve the intended semantics of GFP_NOFS
and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
memalloc scope.

This patch:
 - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
 - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
 - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
   around apply_to_page_range();
 - Updates vmalloc.c and percpu allocator call sites accordingly.

To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: <stable@vger.kernel.org>
Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/kasan.h |  6 +++---
 mm/kasan/shadow.c     | 31 ++++++++++++++++++++++++-------
 mm/vmalloc.c          |  8 ++++----
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..fe5ce9215821 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -562,7 +562,7 @@ static inline void kasan_init_hw_tags(void) { }
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
@@ -574,7 +574,7 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
 						       unsigned long size)
 { }
 static inline int kasan_populate_vmalloc(unsigned long start,
-					unsigned long size)
+					unsigned long size, gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -610,7 +610,7 @@ static __always_inline void kasan_poison_vmalloc(const void *start,
 static inline void kasan_populate_early_vm_area_shadow(void *start,
 						       unsigned long size) { }
 static inline int kasan_populate_vmalloc(unsigned long start,
-					unsigned long size)
+					unsigned long size, gfp_t gfp_mask)
 {
 	return 0;
 }
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1..c7c0be119173 100644
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
index 6dbcdceecae1..5edd536ba9d2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2026,6 +2026,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
 
+	/* Only reclaim behaviour flags are relevant. */
+	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
 	might_sleep();
 
 	/*
@@ -2038,8 +2040,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 */
 	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
 	if (!va) {
-		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
-
 		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 		if (unlikely(!va))
 			return ERR_PTR(-ENOMEM);
@@ -2089,7 +2089,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	ret = kasan_populate_vmalloc(addr, size);
+	ret = kasan_populate_vmalloc(addr, size, gfp_mask);
 	if (ret) {
 		free_vmap_area(va);
 		return ERR_PTR(ret);
@@ -4826,7 +4826,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 	/* populate the kasan shadow space */
 	for (area = 0; area < nr_vms; area++) {
-		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
+		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area], GFP_KERNEL))
 			goto err_free_shadow;
 	}
 
-- 
2.47.2


