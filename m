Return-Path: <stable+bounces-67369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7C94F5B8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DBD1C210C0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7F18784F;
	Mon, 12 Aug 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGZo123c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488816D4DF;
	Mon, 12 Aug 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482972; cv=none; b=OToWM8mFLJl+We/5fWKb5R9f2dFvciSPiadbM5m0RvA4WpDPPOigZKWhP1xcZ3tYSSgyIw+3npqvejAMG2tv7CHUNI9pNclXsGwc8XvURJwyxPv5lD5Y6LalRojdmHRj/wdU+YqidTQlb5vH/gop4fYCmWc1BChPVjcblRGHWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482972; c=relaxed/simple;
	bh=2Ciirbb9iWd+rYCPUCMqEQdLHIveLhDU9YkDnTq0r3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DOjlUCGg8gbGdKwuXWoAIoiL3fFIyNF/PMPxFt7zc4gfyr0YlSUoXdt3FA4NgnkxBgxmnurmsBzMw17pEmBAW6qLAv7oo7wFCmhHTNbLblM7dOSuKLk0IHfOlecYRBlK/6l1dg2t3XGFoce3P2aP4UdujmJ59SpNB1uRBKgsNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGZo123c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD3C32782;
	Mon, 12 Aug 2024 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723482972;
	bh=2Ciirbb9iWd+rYCPUCMqEQdLHIveLhDU9YkDnTq0r3o=;
	h=From:To:Cc:Subject:Date:From;
	b=fGZo123c+c3lvg/rJ/jyR+u9sLZ3CkM/reSd7HcG3mzUjuUu/PaYkUO8c6HiT6bSO
	 0jM0rM3NlTf9HgOddKPVh7PnAnZWZo0bnrJrm3T2Tt2bq1aIGz7QA5O6oZ5RzULJ7a
	 Il9nQDhti1Z7Rk+prE28LQe7/T8j0+8dPRNqPM1S/a6xVIl8uFCr7Rq6ZhIWEd4boV
	 8O1tuTHlMDKL++q1TVniYEzqiKNEpkp48E3C8nCIQ+MSXmBS8XsCNVXyksXVQ8JxR+
	 HzVeLXIIkfW64xuDP3CQ3KCNARxY61SGchn01yKB+490j9iGgdYWaMJVG6e75kjl9r
	 b6rMkcQjQm15w==
From: Will Deacon <will@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"Hailong . Liu" <hailong.liu@oppo.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH] mm: vmalloc: Ensure vmap_block is initialised before adding to queue
Date: Mon, 12 Aug 2024 18:16:06 +0100
Message-Id: <20240812171606.17486-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8c61291fd850 ("mm: fix incorrect vbq reference in
purge_fragmented_block") extended the 'vmap_block' structure to contain
a 'cpu' field which is set at allocation time to the id of the
initialising CPU.

When a new 'vmap_block' is being instantiated by new_vmap_block(), the
partially initialised structure is added to the local 'vmap_block_queue'
xarray before the 'cpu' field has been initialised. If another CPU is
concurrently walking the xarray (e.g. via vm_unmap_aliases()), then it
may perform an out-of-bounds access to the remote queue thanks to an
uninitialised index.

This has been observed as UBSAN errors in Android:

 | Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
 |
 | Call trace:
 |  purge_fragmented_block+0x204/0x21c
 |  _vm_unmap_aliases+0x170/0x378
 |  vm_unmap_aliases+0x1c/0x28
 |  change_memory_common+0x1dc/0x26c
 |  set_memory_ro+0x18/0x24
 |  module_enable_ro+0x98/0x238
 |  do_init_module+0x1b0/0x310

Move the initialisation of 'vb->cpu' in new_vmap_block() ahead of the
addition to the xarray.

Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Cc: Hailong.Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>
Fixes: 8c61291fd850 ("mm: fix incorrect vbq reference in purge_fragmented_block")
Signed-off-by: Will Deacon <will@kernel.org>
---

I _think_ the insertion into the free list is ok, as the vb shouldn't be
considered for purging if it's clean. It would be great if somebody more
familiar with this code could confirm either way, however.

 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..64c0a2c8a73c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2626,6 +2626,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	vb->dirty_max = 0;
 	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
+	vb->cpu = raw_smp_processor_id();
 
 	xa = addr_to_vb_xa(va->va_start);
 	vb_idx = addr_to_vb_idx(va->va_start);
@@ -2642,7 +2643,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	 * integrity together with list_for_each_rcu from read
 	 * side.
 	 */
-	vb->cpu = raw_smp_processor_id();
 	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
-- 
2.46.0.76.ge559c4bf1a-goog


