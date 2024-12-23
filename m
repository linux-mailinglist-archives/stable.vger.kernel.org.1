Return-Path: <stable+bounces-106013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3016D9FB519
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 21:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768FC166C7D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44B1ADFFB;
	Mon, 23 Dec 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PLdFivzN"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B531C07FB
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985086; cv=none; b=ZzQhgnCaoiF9Ey86HQ4awKPDyEJNSBwYCCm2XsMyKn+jBg5iUsrGFUt3/yQ/yn/LBEpACXFabRCaEHMrGD3VWGIuHLlb/XyLpSCAiGFqIa3+h+tXheBbLJyldkrnX61CxiGk/2+9iwl9ss6cZTzqI5kfI8gepflPhamhtuDoVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985086; c=relaxed/simple;
	bh=nl069XhX3jNmo/WDBP9hHf9D5Z6sLY2sGn/1nvZc6Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lh6bnhG+Kj6FkPTRbi6paPo1jxBmgmgdnaOEpscCS1CbuHdGwcbXXwpEJCgnM+gXVWr7leELkxScrBg15QS1ROD8QLjH1uRTBZub7LjBNR5MN3RCAcdqe2UOmx3KHoQDWdmoYIHMB1YGwmlnN17jEuBjpbnLuDAl2dakaTrSO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PLdFivzN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GsFQs/DVmKBhpNjHI7ul4i3bLyvNDcJ2fIXOo28hxhg=; b=PLdFivzNoSmm+v+h3u8pUsidgX
	KJnERtVDri3MhnfuIFMRyY7ifJLjWSIqXuGsBzqv5a1k1ZcJVFtGynxE6j8YQ1lMbIUzajeldZcns
	HvUm2gBI+mrcx0myVaI4ZMAzZz7BAjlLpQxRxyoDmJjELVvEF78k1+2ScwghBsqwTxEeh1piktHzZ
	oRj9BjpS2Eb5HmplwFNMsvvogKaTRkvP/oyZRQ58o6iqqazvvQVCnHZO6ae787QrZmED4iBNRnm+Z
	Ax4R/lKK9JR0y3gKZ3Z2YsjZ793EkvJ1rsKwG/gn1J1jOKt3TUlOEeQ543Sfa4mhdDqgcWO97vUTP
	5qm414nw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPosM-0000000Gp7m-112m;
	Mon, 23 Dec 2024 20:18:02 +0000
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
Subject: [PATCH 5.15.y] vmalloc: fix accounting with i915
Date: Mon, 23 Dec 2024 20:18:00 +0000
Message-ID: <20241223201800.4009725-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024122300-utensil-parsnip-aaf2@gregkh>
References: <2024122300-utensil-parsnip-aaf2@gregkh>
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
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cd434f0ec47f..3cb1f59d1b53 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2621,7 +2621,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			__free_pages(page, page_order);
 			cond_resched();
 		}
-		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
+		if (!(area->flags & VM_MAP_PUT_PAGES))
+			atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
 		kvfree(area->pages);
 	}
-- 
2.45.2


