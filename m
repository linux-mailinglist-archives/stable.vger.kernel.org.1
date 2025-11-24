Return-Path: <stable+bounces-196811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D46C82906
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0BF3AEB07
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB1132ED41;
	Mon, 24 Nov 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQx2+Okg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9332E6BE
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020616; cv=none; b=uQseujcHZ5wdjvVzHMUAY2I2tF4f4gFFdLFe9fi/v8u+UvFHsUcGNZQFPUWbkfD2l304Yhj9HTC6pbRrIwq8sZPM8VMIPzc6FlKbXK61of5kpf4N9YtqAePZAAJUuLBY/6lkkDc8XBliIG+6Tpcdf1GSh79b6BGSnNnaPj2qS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020616; c=relaxed/simple;
	bh=TPMLa8SgG3qXNLOxSZG3E4o46uE532DZy+ftd6LFtQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClCx4J2v8zC4WnElnUatbzS8NewtFdN8r7GMsEII6wcpkkInfIdms3GO8xWtiL+n03yuk8z4rtqrB6Wprm72v1oPfGM3kqKJHezFSFc5udH+pSFIouBT6xtbVGzpBZmPzddf7xgzCdlvVavvw9hShcL6HDMtzkx9hj2khRmiuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQx2+Okg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6666C4CEF1;
	Mon, 24 Nov 2025 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020616;
	bh=TPMLa8SgG3qXNLOxSZG3E4o46uE532DZy+ftd6LFtQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQx2+OkgYOUFUXrZyVv3lZw+srrRZxl42kMGXAl9hUXyTKLIgAemxGfDyrTQ/fS70
	 vh+xry7fdsmEF4lfdLOyjkvuamuVjmoWc/JIsWprisqyGgKKZ1P6Qwl4+3px76+6x1
	 q/WUR4Biov3S1S/ueJu6vYLVAJUDgXLJRR1nlu7JyP6myWlF3lcgeRSTrwhZY+tfak
	 zs9sUfQYjvdXj8Ga7NMlk0WOseqwLHLYlOv06xBVCS+0PA8ZGnVNBUACYYZNQ3uxGG
	 iJYl1N/WgsrwNC6OhbrT+OOpz9mHP7RyAwrkf1FeDgwWwy4KhpIxIep0IxYZSpiXY9
	 8Jz6b9PQX01gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] mm/mempool: replace kmap_atomic() with kmap_local_page()
Date: Mon, 24 Nov 2025 16:43:33 -0500
Message-ID: <20251124214334.44494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112438-stoppable-bribe-71e6@gregkh>
References: <2025112438-stoppable-bribe-71e6@gregkh>
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
index 85efab3da7204..f9f2afe42b92a 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -64,10 +64,10 @@ static void check_element(mempool_t *pool, void *element)
 	/* Mempools backed by page allocator */
 	if (pool->free == mempool_free_pages) {
 		int order = (int)(long)pool->pool_data;
-		void *addr = kmap_atomic((struct page *)element);
+		void *addr = kmap_local_page((struct page *)element);
 
 		__check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
-		kunmap_atomic(addr);
+		kunmap_local(addr);
 	}
 }
 
@@ -88,10 +88,10 @@ static void poison_element(mempool_t *pool, void *element)
 	/* Mempools backed by page allocator */
 	if (pool->alloc == mempool_alloc_pages) {
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


