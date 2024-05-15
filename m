Return-Path: <stable+bounces-45123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6B8C604B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2421F21BA2
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9345F3B290;
	Wed, 15 May 2024 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBp/I4aA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xw64g/ie"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589F39ADD;
	Wed, 15 May 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752252; cv=none; b=GQgcUW9RqeYJ6UCOIa8cZS0Z2reoqqAyJ1H/GKZhRE+KV1oh/67/+uVpB3X0kUdhrRYKm0WB7do8uL4t5FhUGQqkp9UfL/WtqWWcKIW0iX+ULFKC3boUhYdoPK13XJQNbknb3H6IwyivnO6eT2ldsluO5jKusaM76m2hL/AgQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752252; c=relaxed/simple;
	bh=HF5toEqhQfrhLTSEZCj88KO6yHunqQvh6aTZ1D1a8+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSyn/qz4MDaoIH4tf7nwySVNf5HlrRRcSW9WUDpgGGX6e1vBuFgN0fSt+trFvzLCVS5w1dqtF87dB9Ux+JLK+pxmemvhvitzcdkwmBqzAwmwA+H47VkKHZkL7+wCGTypViI8K+I/ErB9/7jKCfgrpCpRmDfPRP+8wPuvcIwFA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBp/I4aA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xw64g/ie; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715752248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcCWvr4SYjjrlRwhgChA7o17sApj+WC9QqfSYFJ7iw8=;
	b=BBp/I4aAMOJZAn0wYG2Ov3GZZFd3p39GWccszwcrm6q7whrnMNp+LT633bIzm7vK7JPRza
	UIFJALiiqKN+Lc2IlqzVYYNB8yP1J5c2wgXfvy8w2rUhEcYXS/776ppePa3vyo4v+96rhX
	zKMB47qE07KbmgDAm/bJxjdTdpNt5M4vpN8xHxOq1UHmwO4CMYg0kqZfZrGXmH/hZwp6hU
	X4hiMiChusRVwIrS6TTt3MVJkUQ+rKmctwIv4J2igd2hE3f6f8XmIGOtVKOEKw6ATNjCYj
	twvrbySbUFgkAzoBSRwXR+wsmeAu218sF1lMxiKzc5ybIBkuVdUIJcFl0WXdtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715752248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcCWvr4SYjjrlRwhgChA7o17sApj+WC9QqfSYFJ7iw8=;
	b=xw64g/ieiCfH+JsJAphRQgD5n4QcjPNhfUwFJaLtQ81Kzet3RCCy3Z8NJgbJMfQ13Kg7ai
	56K9Ek3XHbUwS6Dw==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context
Date: Wed, 15 May 2024 07:50:40 +0200
Message-Id: <1289ecba9606a19917bc12b6c27da8aa23e1e5ae.1715750938.git.namcao@linutronix.de>
In-Reply-To: <cover.1715750938.git.namcao@linutronix.de>
References: <cover.1715750938.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__kernel_map_pages() is a debug function which clears the valid bit in page
table entry for deallocated pages to detect illegal memory accesses to
freed pages.

This function set/clear the valid bit using __set_memory(). __set_memory()
acquires init_mm's semaphore, and this operation may sleep. This is
problematic, because  __kernel_map_pages() can be called in atomic context,
and thus is illegal to sleep. An example warning that this causes:

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1578
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2, name: kthreadd
preempt_count: 2, expected: 0
CPU: 0 PID: 2 Comm: kthreadd Not tainted 6.9.0-g1d4c6d784ef6 #37
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff800060dc>] dump_backtrace+0x1c/0x24
[<ffffffff8091ef6e>] show_stack+0x2c/0x38
[<ffffffff8092baf8>] dump_stack_lvl+0x5a/0x72
[<ffffffff8092bb24>] dump_stack+0x14/0x1c
[<ffffffff8003b7ac>] __might_resched+0x104/0x10e
[<ffffffff8003b7f4>] __might_sleep+0x3e/0x62
[<ffffffff8093276a>] down_write+0x20/0x72
[<ffffffff8000cf00>] __set_memory+0x82/0x2fa
[<ffffffff8000d324>] __kernel_map_pages+0x5a/0xd4
[<ffffffff80196cca>] __alloc_pages_bulk+0x3b2/0x43a
[<ffffffff8018ee82>] __vmalloc_node_range+0x196/0x6ba
[<ffffffff80011904>] copy_process+0x72c/0x17ec
[<ffffffff80012ab4>] kernel_clone+0x60/0x2fe
[<ffffffff80012f62>] kernel_thread+0x82/0xa0
[<ffffffff8003552c>] kthreadd+0x14a/0x1be
[<ffffffff809357de>] ret_from_fork+0xe/0x1c

Rewrite this function with apply_to_existing_page_range(). It is fine to
not have any locking, because __kernel_map_pages() works with pages being
allocated/deallocated and those pages are not changed by anyone else in the
meantime.

Fixes: 5fde3db5eb02 ("riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/riscv/mm/pageattr.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 410056a50aa9..271d01a5ba4d 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -387,17 +387,33 @@ int set_direct_map_default_noflush(struct page *page)
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
+static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
+{
+	int enable = *(int *)data;
+
+	unsigned long val = pte_val(ptep_get(pte));
+
+	if (enable)
+		val |= _PAGE_PRESENT;
+	else
+		val &= ~_PAGE_PRESENT;
+
+	set_pte(pte, __pte(val));
+
+	return 0;
+}
+
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	if (!debug_pagealloc_enabled())
 		return;
 
-	if (enable)
-		__set_memory((unsigned long)page_address(page), numpages,
-			     __pgprot(_PAGE_PRESENT), __pgprot(0));
-	else
-		__set_memory((unsigned long)page_address(page), numpages,
-			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long size = PAGE_SIZE * numpages;
+
+	apply_to_existing_page_range(&init_mm, start, size, debug_pagealloc_set_page, &enable);
+
+	flush_tlb_kernel_range(start, start + size);
 }
 #endif
 
-- 
2.39.2


