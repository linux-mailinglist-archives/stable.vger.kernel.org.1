Return-Path: <stable+bounces-105580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38A9FAD12
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EA5164EE8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B675191F69;
	Mon, 23 Dec 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYv27WyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955017BB35
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734949095; cv=none; b=isg7WetAlvTGc1nDk7Ra2Jzk0yFL+5LDs3Wx6poTBALdDWbzugFQ047+w3+xmbVLou+qCtz87CQ/15KaUWWt/IWhrYN40OQBAXmbyz6kxR1gm6lCvFHNqifZpeDvE1JfJEQ2yr2tzHyP9ByFQZ2C65v7x1mU7+WnPwzbnKWV35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734949095; c=relaxed/simple;
	bh=w3+CtPrz/bzvGP/mWGaxFwmJUwLEJxSlnNFuGWO3Bh8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hFStIj0r6dUPpI9vuySJRuuhDkOOMFyOddwEsHxfmcy2+s6af6U8JuKb0RjHnBZYwGBfNYvFz7GGLcwDznm3AODd6NCIXr3YAvT4jpGYygq8N7rj5+iSo7e/mC8i1hGfWjUfK5WxzwfcFVnjEnTmGnQwnUpxv9DuDJbq7hc8SXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYv27WyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C6DC4CED3;
	Mon, 23 Dec 2024 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734949094;
	bh=w3+CtPrz/bzvGP/mWGaxFwmJUwLEJxSlnNFuGWO3Bh8=;
	h=Subject:To:Cc:From:Date:From;
	b=IYv27WyTEoc0aJOndjy/6wI0XEa33E/+UEINgrA1swj4Ndj5EfteF3wTF8LeQVuMx
	 WVXDwOCnK2gBYc9pqTBv+hhUVHmjGfUKJDg2E0fmWR9ByCB7lyR0MOvw1/KrR4zH8y
	 rM4TEVrP025NhtKHfry+u+YgoRefG5L6JLzYoMs8=
Subject: FAILED: patch "[PATCH] vmalloc: fix accounting with i915" failed to apply to 5.10-stable tree
To: willy@infradead.org,akpm@linux-foundation.org,balbirs@nvidia.com,hannes@cmpxchg.org,hch@lst.de,mhocko@suse.com,muchun.song@linux.dev,roman.gushchin@linux.dev,shakeel.butt@linux.dev,stable@vger.kernel.org,urezki@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:18:01 +0100
Message-ID: <2024122301-uncommon-enquirer-5f71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a2e740e216f5bf49ccb83b6d490c72a340558a43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122301-uncommon-enquirer-5f71@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2e740e216f5bf49ccb83b6d490c72a340558a43 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 11 Dec 2024 20:25:37 +0000
Subject: [PATCH] vmalloc: fix accounting with i915

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

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f009b21705c1..5c88d0e90c20 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3374,7 +3374,8 @@ void vfree(const void *addr)
 		struct page *page = vm->pages[i];
 
 		BUG_ON(!page);
-		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+		if (!(vm->flags & VM_MAP_PUT_PAGES))
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 		/*
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
@@ -3382,7 +3383,8 @@ void vfree(const void *addr)
 		__free_page(page);
 		cond_resched();
 	}
-	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
+	if (!(vm->flags & VM_MAP_PUT_PAGES))
+		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
 	kvfree(vm->pages);
 	kfree(vm);
 }


