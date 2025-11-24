Return-Path: <stable+bounces-196800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C105C82762
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95314E1054
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851C2E613A;
	Mon, 24 Nov 2025 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwgSPxhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563932BDC28
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017984; cv=none; b=U+/+gWqfGeEYcwqtBOB0Jt/wKDMMFwA9wdysvZ3aSNMYYcLgVhMUAWZ9nWw0TPuY8YnJ8uN+XjnDemda/wXg44tvHJaiKRqsC8nU8XSDMG3JesnCwpPkLOOZWxhfpdowB6dI8M1un6P5ynYzcCmICHHyv5eXCP9Gb15ZORrQjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017984; c=relaxed/simple;
	bh=aMkmmsnTbKVjxcnfJ0hIngjjLdZniN3qocy3kGiCQ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O20pm3V2zFEZicyASHZYIbS9buDARJKitNchRe6hHs4FYdPbW355VMadAnlgm8I2/WBDEI8E6DJis05n+fc6flrrWYjnZiP7pCMJnP1m+cbuPF6qh1CK8MaTc4d6lj8A5CPY7f8cfyJ7L7IjXgiEnTlykCEZ2nbVA4cQ6T5YrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwgSPxhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24222C4CEF1;
	Mon, 24 Nov 2025 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764017983;
	bh=aMkmmsnTbKVjxcnfJ0hIngjjLdZniN3qocy3kGiCQ2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwgSPxhGPmoAt6zvI2fS8gPvKcY8bFsvptkkq4fFeeLUpTQpATKAugwM6Xrr27isf
	 8hhKySxb8bCY9vp4eu8DMEpG3Zi/NVO9sEWysRzp4fshf9UHA0GN05/wMqnnXkfOJL
	 reix40dFSY89Ir0vwJcaCznd8nZ5MhbprqHYIyadkdGdYo71svoBGUUmC/VIDPtI1D
	 NaM4QBxgtERIGPlTbb/qcDQtFPKL4N7rDys4uYdVE4hGi2rBba+2ocRdQ+V3GNu7XY
	 FoSoyELCHA9H82tPQ9f55bIMWzGSvoYtksIAJAuCZGAdEZOpv4TeDDHilA289DkX60
	 hrkdqwkOKud+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm/mempool: replace kmap_atomic() with kmap_local_page()
Date: Mon, 24 Nov 2025 15:59:40 -0500
Message-ID: <20251124205941.27830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112434-uncle-ethics-cb16@gregkh>
References: <2025112434-uncle-ethics-cb16@gregkh>
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
index 734bcf5afbb78..b3d2084fd989c 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -64,10 +64,10 @@ static void check_element(mempool_t *pool, void *element)
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
 
@@ -89,10 +89,10 @@ static void poison_element(mempool_t *pool, void *element)
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


