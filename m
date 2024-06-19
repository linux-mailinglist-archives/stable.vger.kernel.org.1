Return-Path: <stable+bounces-54590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA5090EEF3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771E2282F92
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44F14387E;
	Wed, 19 Jun 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wlMyCJZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C613DDC0;
	Wed, 19 Jun 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804030; cv=none; b=lbEOnJ/CnM3sKqLOHomPJ3UvYxIKHOxFC/LFYXSmzc770GYy8FZCG8bLvGn2EAuoqmyijw9/TAEE0lMvPsoU8GdtaJKa/+dmfBYYTejwioAqA6lomisNDU5u6YFtWUGDXI8Uy3FNNLsC7DaehMGWVira6VITK0l0lfSipOS0sD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804030; c=relaxed/simple;
	bh=pQHi8p+UBQ8bTEvZPKLtqvdYLQzV3L8hhKgZEDOe2oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxzz09q4wjWf69pBQS+q4OgX1hxyCRO/MGeVqBes2lZs3iucO6RW9N04ASSo5kbH65pNI9Th9Rs5Q7PmmtbHrstFzOJFjX/wOBDjL8liGSVpsNE9w44vdEWOYJf2zjKQb6J24n63NXJAe/jWmxr3lCmRTlCHupnKAilGEmHavHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wlMyCJZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADBCC2BBFC;
	Wed, 19 Jun 2024 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718804030;
	bh=pQHi8p+UBQ8bTEvZPKLtqvdYLQzV3L8hhKgZEDOe2oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wlMyCJZRgL+R75xl44U2jOere4T/agXh6EH0Axtefaw7gD62SFhVZcxgzCxT82iMr
	 TP52+Jv5U3PxxP/TNmzAiS9Tya+W4Xwf2VxbRhMOdT6/13l5/oWEU1AOX/Fr/a8HAx
	 Ve7gdbpph/bCNhFiZTE4RsgD3+cnNX3zNxJOtFoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 186/217] riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context
Date: Wed, 19 Jun 2024 14:57:09 +0200
Message-ID: <20240619125603.862327669@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcao@linutronix.de>

commit fb1cf0878328fe75d47f0aed0a65b30126fcefc4 upstream.

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
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/1289ecba9606a19917bc12b6c27da8aa23e1e5ae.1715750938.git.namcao@linutronix.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/mm/pageattr.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -386,17 +386,33 @@ int set_direct_map_default_noflush(struc
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
 



