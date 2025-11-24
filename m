Return-Path: <stable+bounces-196804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A806C82804
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2BB3AD35C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6CB32E736;
	Mon, 24 Nov 2025 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3AKKhjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980E32E722
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019087; cv=none; b=jdETtzItw8iMvSLz6zTjhJOpyLRBroeIb+KqrMO7bngj6jHCgCGbPOMHbcFBdUjECb3WSgeqS40+Ma9Gd0ZXvAAJUcBnLrdAfzsd/V9iUbYIEXBMgq8EBk08NpPw0tp9AS384hvYhPwVmGgNQ2QRTR6GEQdfQ0VP1czOARqyyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019087; c=relaxed/simple;
	bh=F3qWh8Zw1liB2/TeEmTmKFCZDs6dZJCNSAqzyC1hJWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbKPWHuuFFOBhpFfa4aX+q+fNlQ1m+6VBYvE78Bmq4ArEz37Yg6HMtkjL7sFIikS6btzP468PZ4RIWzGAsx9E5cLA2PDg5nJDTvEYyD66NiBd1s4kqXqiivYX6asEDT0nOiDgmQi/rupAyqGGpeU6vbfZ6bm2gHY+ku2gNgyt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3AKKhjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E88BC4CEF1;
	Mon, 24 Nov 2025 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019085;
	bh=F3qWh8Zw1liB2/TeEmTmKFCZDs6dZJCNSAqzyC1hJWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3AKKhjKZTKRVhO977/typv3rgmobgCWHTyLznnr5SJyWehjjtLYxVXIunB4Uj4O+
	 c+gTrmwDbitBQqaJ5B4R0uNmuYlV8XQM+VAzdpnWK3yrIJDWR+Ab3HF/7aKjsn245g
	 1yrgWMIBh794dRv2rfjJ8yWWgFjrw7nPpFJzarOngceCGKcrenR/7x6oHgU0cit8zP
	 yGB7+BDkSNCswRw66/ARpQw/gaaIeZRCyZBKTwvASOqXtK96GrxE2i+d2/p5z3iG2b
	 sKsKBYnhBz35OS7LioMYgxKI1u1OjvP21xo91+qDSfpYCe58RBbaGPfHjgz4P0nGO/
	 cO3fTSHe/PZJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm/mempool: replace kmap_atomic() with kmap_local_page()
Date: Mon, 24 Nov 2025 16:18:02 -0500
Message-ID: <20251124211803.34596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112435-agile-sprawl-f420@gregkh>
References: <2025112435-agile-sprawl-f420@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>

[ Upstream commit f2bcc99a5e901a13b754648d1dbab60f4adf9375 ]

kmap_atomic() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap_atomic() with kmap_local_page().

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only in !PREEMPT_RT kernels).  The
kernel virtual addresses returned by these two API are only valid in the
context of the callers (i.e., they cannot be handed to other threads).

With kmap_local_page() the mappings are per thread and CPU local like in
kmap_atomic(); however, they can handle page-faults and can be called from
any context (including interrupts).  The tasks that call kmap_local_page()
can be preempted and, when they are scheduled to run again, the kernel
virtual addresses are restored and are still valid.

The code blocks between the mappings and un-mappings don't rely on the
above-mentioned side effects of kmap_atomic(), so that mere replacements
of the old API with the new one is all that they require (i.e., there is
no need to explicitly call pagefault_disable() and/or preempt_disable()).

Link: https://lkml.kernel.org/r/20231120142640.7077-1-fabio.maria.de.francesco@linux.intel.com
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ec33b59542d9 ("mm/mempool: fix poisoning order>0 pages with HIGHMEM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 96488b13a1ef1..81f38f8c2cbbe 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -62,10 +62,10 @@ static void check_element(mempool_t *pool, void *element)
 	} else if (pool->free == mempool_free_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
-		void *addr = kmap_atomic((struct page *)element);
+		void *addr = kmap_local_page((struct page *)element);
 
 		__check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
-		kunmap_atomic(addr);
+		kunmap_local(addr);
 	}
 }
 
@@ -85,10 +85,10 @@ static void poison_element(mempool_t *pool, void *element)
 	} else if (pool->alloc == mempool_alloc_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
-		void *addr = kmap_atomic((struct page *)element);
+		void *addr = kmap_local_page((struct page *)element);
 
 		__poison_element(addr, 1UL << (PAGE_SHIFT + order));
-		kunmap_atomic(addr);
+		kunmap_local(addr);
 	}
 }
 #else /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
-- 
2.51.0


