Return-Path: <stable+bounces-119346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D53A425AA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F547189550A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EA155308;
	Mon, 24 Feb 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLObIJtv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1214B080;
	Mon, 24 Feb 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409153; cv=none; b=bAUehZYzhlNy4Em9XVhhZk1gswMBKk09wCJzvcUOABt9aY3LOf/h4oPv/yhGVhM5dzwVMCN77z30JJdy4VgqO8IDqHmgpq1dnytw4FF0Jn0xN7YUJmevifbh4gWomPuswvJb1/8nN4ogc6CTUQPUoP7cRyi3MISJo4aFTk0LtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409153; c=relaxed/simple;
	bh=3T2JjnlYTyyTu4OBMUwW02klpsMVSnGIWrIiIQmJPCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1DLsJ0PVeiIYbOfF7aylnkMI39JS4F6Wn5xwlkXQuf/5i4DPWGyqU5SG47awTzSuwngafr9YOuIqLNJMAN8qdf06XHCRTSTEhvKAca7abVBaSg7npKRgxe3bieSsreT4YJ3oJNDqq8byJw53Aku+o+MzvoZGlkNviclm+7IUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLObIJtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C332C4CED6;
	Mon, 24 Feb 2025 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740409153;
	bh=3T2JjnlYTyyTu4OBMUwW02klpsMVSnGIWrIiIQmJPCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLObIJtvhiK8jRsefXPiBt5Tk77IZHh5ExU3zoa10fj3vN0QJLP6+t2lxHhvbVQcN
	 bX022rpXszMUdVtK9NZ7SHt6qQU5Bje+PAZR+0PouzLhx1gqNVWDvC3Ss1EjsdOKPV
	 7SaxSbIBmSNU503u2yEzru9DYsdkwDZIb+YZ3Epk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 112/138] mm/zswap: fix inconsistency when zswap_store_page() fails
Date: Mon, 24 Feb 2025 15:35:42 +0100
Message-ID: <20250224142608.881768571@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

commit 63895d20d63b446f5049a963983489319c2ea3e2 upstream.

Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
skips charging any zswap entries when it failed to zswap the entire folio.

However, when some base pages are zswapped but it failed to zswap the
entire folio, the zswap operation is rolled back.  When freeing zswap
entries for those pages, zswap_entry_free() uncharges the zswap entries
that were not previously charged, causing zswap charging to become
inconsistent.

This inconsistency triggers two warnings with following steps:
  # On a machine with 64GiB of RAM and 36GiB of zswap
  $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
  $ sudo reboot

  The two warnings are:
    in mm/memcontrol.c:163, function obj_cgroup_release():
      WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));

    in mm/page_counter.c:60, function page_counter_cancel():
      if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
	  new, nr_pages))

zswap_stored_pages also becomes inconsistent in the same way.

As suggested by Kanchana, increment zswap_stored_pages and charge zswap
entries within zswap_store_page() when it succeeds.  This way,
zswap_entry_free() will decrement the counter and uncharge the entries
when it failed to zswap the entire folio.

While this could potentially be optimized by batching objcg charging and
incrementing the counter, let's focus on fixing the bug this time and
leave the optimization for later after some evaluation.

After resolving the inconsistency, the warnings disappear.

[42.hyeyoo@gmail.com: refactor zswap_store_page()]
  Link: https://lkml.kernel.org/r/20250131082037.2426-1-42.hyeyoo@gmail.com
Link: https://lkml.kernel.org/r/20250129100844.2935-1-42.hyeyoo@gmail.com
Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
Co-developed-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zswap.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6504174fbc6a..ac9d299e7d0c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1445,9 +1445,9 @@ resched:
 * main API
 **********************************/
 
-static ssize_t zswap_store_page(struct page *page,
-				struct obj_cgroup *objcg,
-				struct zswap_pool *pool)
+static bool zswap_store_page(struct page *page,
+			     struct obj_cgroup *objcg,
+			     struct zswap_pool *pool)
 {
 	swp_entry_t page_swpentry = page_swap_entry(page);
 	struct zswap_entry *entry, *old;
@@ -1456,7 +1456,7 @@ static ssize_t zswap_store_page(struct page *page,
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
-		return -EINVAL;
+		return false;
 	}
 
 	if (!zswap_compress(page, entry, pool))
@@ -1483,13 +1483,17 @@ static ssize_t zswap_store_page(struct page *page,
 
 	/*
 	 * The entry is successfully compressed and stored in the tree, there is
-	 * no further possibility of failure. Grab refs to the pool and objcg.
-	 * These refs will be dropped by zswap_entry_free() when the entry is
-	 * removed from the tree.
+	 * no further possibility of failure. Grab refs to the pool and objcg,
+	 * charge zswap memory, and increment zswap_stored_pages.
+	 * The opposite actions will be performed by zswap_entry_free()
+	 * when the entry is removed from the tree.
 	 */
 	zswap_pool_get(pool);
-	if (objcg)
+	if (objcg) {
 		obj_cgroup_get(objcg);
+		obj_cgroup_charge_zswap(objcg, entry->length);
+	}
+	atomic_long_inc(&zswap_stored_pages);
 
 	/*
 	 * We finish initializing the entry while it's already in xarray.
@@ -1510,13 +1514,13 @@ static ssize_t zswap_store_page(struct page *page,
 		zswap_lru_add(&zswap_list_lru, entry);
 	}
 
-	return entry->length;
+	return true;
 
 store_failed:
 	zpool_free(pool->zpool, entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
-	return -EINVAL;
+	return false;
 }
 
 bool zswap_store(struct folio *folio)
@@ -1526,7 +1530,6 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
-	size_t compressed_bytes = 0;
 	bool ret = false;
 	long index;
 
@@ -1564,20 +1567,14 @@ bool zswap_store(struct folio *folio)
 
 	for (index = 0; index < nr_pages; ++index) {
 		struct page *page = folio_page(folio, index);
-		ssize_t bytes;
 
-		bytes = zswap_store_page(page, objcg, pool);
-		if (bytes < 0)
+		if (!zswap_store_page(page, objcg, pool))
 			goto put_pool;
-		compressed_bytes += bytes;
 	}
 
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+	if (objcg)
 		count_objcg_events(objcg, ZSWPOUT, nr_pages);
-	}
 
-	atomic_long_add(nr_pages, &zswap_stored_pages);
 	count_vm_events(ZSWPOUT, nr_pages);
 
 	ret = true;
-- 
2.48.1




