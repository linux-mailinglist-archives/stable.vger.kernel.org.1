Return-Path: <stable+bounces-106012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB739FB4DC
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE24166557
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D11AF0B8;
	Mon, 23 Dec 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IAgqkv28"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645780038
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984460; cv=none; b=qDUt+shlUxXi7a+j7bvA3hOpwAb1e0gk7IRpx4OCpUbVbQgkeNBWHXA/BqPzlnRpxZ3GADzyKJREKuNnUepj9nhtvA13xjCjfDn3tbiVpgv2GhY3IbKcqaoG6WjtdC4Yo/sxS6mX4VOA+Ch1xkjd9dq0on884i+sbhcaQOtMnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984460; c=relaxed/simple;
	bh=E9R2AC8wBq9jR2TW4fhnl4TsGvaWM+D5vwiLVKgfxkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0RlmHDP8Zz+KC0916E20Up9srhQxS9u/ljWpSBBMYbQlxKoShhuofvPr6I1w8SOP0wabDI+VSLObh5QhjUOOjWkN8oIOGBhmIa1SSnoRPrUxgBb4R6OeIfrSnTgbAhjV8pLjN8jLekS+1SIDKnkLhd8scWF78xvxKxiB5Qw4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IAgqkv28; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=grlRaSzP7I79d5ooCkf/pFq31vGLKyfkVOYvq3avOuM=; b=IAgqkv28YoBdPeZireTTCL1MjJ
	zYunKc+pa6Tv6xFqLZFZfCsgj3lJfB6XhIU0f1qfLLe5ZDhvikBrbYHP1icAjRt0VL4ZgGZlpTy11
	L2/0H/+4I/GO8vR9NAFgJzA2prE7qn7CsXAcwl7WHBnuU6BBIm2bh3g5ZQOqA8DXerrZn3RqGOr4L
	KB0HAozHREXCcqyX+NcWbSb+VU9UqmJ1K//U4KKTLno5wnXmeUILEGXR1pXJIbG94BEGNNfeKp5Vd
	pmnEDR7MeuWHcp+FYmNvsJIi81vwG3yxUz0qkkyKBfl9H4vL5jW+czjxjRWY4qw0sP3EXA/t+nxRU
	/T7EOBFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPoiE-0000000Gmfs-1npC;
	Mon, 23 Dec 2024 20:07:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Balbir Singh <balbirs@nvidia.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] vmalloc: fix accounting with i915
Date: Mon, 23 Dec 2024 20:07:29 +0000
Message-ID: <20241223200729.4000320-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024122359-compactly-cranium-ec0b@gregkh>
References: <2024122359-compactly-cranium-ec0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
vfree().  These counters are incremented by vmalloc() but not by vmap() so
this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
decrementing either counter.

Link: https://lkml.kernel.org/r/20241211202538.168311-1-willy@infradead.org
Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit a2e740e216f5bf49ccb83b6d490c72a340558a43)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a0b650f50faa..7c6694514606 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2709,7 +2709,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+			if (!(area->flags & VM_MAP_PUT_PAGES))
+				mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 			/*
 			 * High-order allocs for huge vmallocs are split, so
 			 * can be freed as an array of order-0 allocations
@@ -2717,7 +2718,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			__free_pages(page, 0);
 			cond_resched();
 		}
-		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
+		if (!(area->flags & VM_MAP_PUT_PAGES))
+			atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
 		kvfree(area->pages);
 	}
-- 
2.45.2


