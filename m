Return-Path: <stable+bounces-53689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0974F90E3D5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296D91C22728
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38C6F305;
	Wed, 19 Jun 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eG2f5Uje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F76F2EF
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780250; cv=none; b=stmLq9vMhHrLafAlVIVwMXasJjiHvfLKwxgJuFqNKjXni6dShEcIiNuE8SMP55nwojDrUylaHwymeJLqRpXraOv6h7Dk5opXGX0XiiClDDcuys6E09xIIOER01NtkwxDdCAv37V6ZRdIjg/nmoQ44YoK5tu6MkUBYhuQa3ZD3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780250; c=relaxed/simple;
	bh=OTuXUUaGEOTv2plc+vCozzA6LDduMgtE+OP0YtQxFeI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XT8G5taBgUonWV6ngsIc5CV0i3JrZu2MLSMRwHv0GVHWY+JmU5TtN/cBoC3QuV81IXoawhP1asJ3lKRW9+NTZ5lLMnTOAdcGtwx6C4Ix4gwF24gdXsQdVdnUVAe0pAp4qtEt3MyngvSjTEh4o2mYc7I3ORpr0/w+A2Z8+LjjAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eG2f5Uje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ECFC2BBFC;
	Wed, 19 Jun 2024 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780250;
	bh=OTuXUUaGEOTv2plc+vCozzA6LDduMgtE+OP0YtQxFeI=;
	h=Subject:To:Cc:From:Date:From;
	b=eG2f5Uje3vqJpwt1pftaYkQM4SN14jJ9in7edDUYbsHMETEW+WxEeuVUxekrex3En
	 cRv1ZuuJWSvvEujnYX1lLzOFwP9+4HcV6Ya1B8L9CfiAaCQOE5jYH1YJzN7rOtQmnT
	 7YGbQkCrGNkhQWKM9mGvcECigezJQ7Tr6SvkhPro=
Subject: FAILED: patch "[PATCH] riscv: rewrite __kernel_map_pages() to fix sleeping in" failed to apply to 5.10-stable tree
To: namcao@linutronix.de,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:57:27 +0200
Message-ID: <2024061927-remindful-dash-9f14@gregkh>
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
git cherry-pick -x fb1cf0878328fe75d47f0aed0a65b30126fcefc4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061927-remindful-dash-9f14@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

fb1cf0878328 ("riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context")
5d6ad668f316 ("arch, mm: restore dependency of __kernel_map_pages() on DEBUG_PAGEALLOC")
2abf962a8d42 ("PM: hibernate: make direct map manipulations more explicit")
77bc7fd607de ("mm: introduce debug_pagealloc_{map,unmap}_pages() helpers")
4f5b0c178996 ("arm, arm64: move free_unused_memmap() to generic mm")
5e545df3292f ("arm: remove CONFIG_ARCH_HAS_HOLES_MEMORYMODEL")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb1cf0878328fe75d47f0aed0a65b30126fcefc4 Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Wed, 15 May 2024 07:50:40 +0200
Subject: [PATCH] riscv: rewrite __kernel_map_pages() to fix sleeping in
 invalid context

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
 


