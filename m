Return-Path: <stable+bounces-196807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E79C828B8
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DFBD343837
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F22F363E;
	Mon, 24 Nov 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY2BYiG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB75269AEE
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020013; cv=none; b=fij1/fFPPJQG0Q1HOgQPU6xttO6U5JiHXOKBiBn46PinxdZtC9iyGewfOtRENUCofix3PEitnaK0uWdvqvnaZ0NM7ZxNKsRZhUPXXTax/Id2rLFhpqjDwpyq3Y/5WdFX2iJpm6IqOTdxf4BniRdqmPKqYxsGCqpZKA9MrKnV+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020013; c=relaxed/simple;
	bh=HSGXj2K2EfLSSYf1CsYQSH8CdtpzAwNZmkXNH2/C5bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaaRBGqXsYyNko75Qm5wp/mLmXYNtuT+vKofeMGrK1wRPQj+w+vv8CAqOe6vz01vLm+Jk3aIoDnF52ITbmyS8iJvpZIEu/Q5UqsYKrmSAwJJYGI3bzrClWoXnF9dA5zC9Xb/uGQL3tkj3aa3vTNhl9pBeoWdZaHImJqXXf7BuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY2BYiG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFA0C4CEF1;
	Mon, 24 Nov 2025 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020012;
	bh=HSGXj2K2EfLSSYf1CsYQSH8CdtpzAwNZmkXNH2/C5bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rY2BYiG7Pf8geFEsn+0wKWtrmeW+jwxwTiRJxAH7ylCkRUlq2H6/ZYc83JZRpEmad
	 +dhv3EwOpyRsxc0GgplN09nFQv4aa03vOCY5bJniYzWiaDbLuYzbpfe3shC6cK3DWx
	 WMMZKsJD678VVIphINmvqUQrwJ0FE2ftuduiJSAvL/PpBC+0OIZ4Qw5OyyHqtddd5n
	 CC+UtpmnqwSZsmZUbpSLmr3uCvaEFGE9QxzzqHqqWlUjZmU9mpv/LQZTf8APsK8Ia8
	 yHAis1BkNYa6JGrxQzC9Xs+yhYeNgD+qlbc0A6LL1yA5aqySn5pmQ1Akslx96OD3yr
	 xENxyc67iLd4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mm/mempool: replace kmap_atomic() with kmap_local_page()
Date: Mon, 24 Nov 2025 16:33:29 -0500
Message-ID: <20251124213330.39729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112436-unabashed-tacky-b8b3@gregkh>
References: <2025112436-unabashed-tacky-b8b3@gregkh>
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
index 0b8afbec3e358..802ca5db52696 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -63,10 +63,10 @@ static void check_element(mempool_t *pool, void *element)
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
 
@@ -86,10 +86,10 @@ static void poison_element(mempool_t *pool, void *element)
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


