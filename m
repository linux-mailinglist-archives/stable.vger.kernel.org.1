Return-Path: <stable+bounces-147835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB14AC5964
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28B64C1719
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341227FD63;
	Tue, 27 May 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SN4CD8vI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48372566;
	Tue, 27 May 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368578; cv=none; b=hAA92onAO5gS2oVkL+F+KHmwSdNWSebEHX+Bg1zeJzN0rPiUm0tMFHW+Cp8cc90ttCL4ygHWGhIimaFCC/laIqr+miHdS8QmXeIOJtkRlnp6QLmdnkojGDz/E9IU239iJld7SWD5Fkf/fEtFEImV8IQm5ReHMD/IOEX2XfUfg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368578; c=relaxed/simple;
	bh=K//EjSXk2NlGfd1VMTb0uMOHIhldpydjM5A07Lafk+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocQ9ZlrK4F6UZAznO7e2rVgJPVLAMhz8WU2K20TP8+ITU/jKDWQ1GgiP/GL1mT/7V0yTnqkMnlf0lxtbynMuIv80Lfo2waPDkAL1nMtcr2BHpM8C/+q3mgtEbPPhpSCFe0Nzm9efTUL9yRaW00EiBtLBK4Ty21Qh9f0gp3f2h8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SN4CD8vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63858C4CEE9;
	Tue, 27 May 2025 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368578;
	bh=K//EjSXk2NlGfd1VMTb0uMOHIhldpydjM5A07Lafk+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SN4CD8vIieRkZYEbJKV3h6lOTtWIhaSu9BSDV1p7PUG42TFEch5aqH7n1cFDDRY0e
	 c8kwSszWftchVVHlCAe9cvUfra+cabBkp2GnlvHbDNB/OIQQ5Ed0auMpZin08JVUAy
	 4+/YsR6XNo6S3hhBCDnQxRtA0zHObvO1BXOgazNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Daniel Axtens <dja@axtens.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14 753/783] kasan: avoid sleepable page allocation from atomic context
Date: Tue, 27 May 2025 18:29:10 +0200
Message-ID: <20250527162543.792049478@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Gordeev <agordeev@linux.ibm.com>

commit b6ea95a34cbd014ab6ade4248107b86b0aaf2d6c upstream.

apply_to_pte_range() enters the lazy MMU mode and then invokes
kasan_populate_vmalloc_pte() callback on each page table walk iteration.
However, the callback can go into sleep when trying to allocate a single
page, e.g.  if an architecutre disables preemption on lazy MMU mode enter.

On s390 if make arch_enter_lazy_mmu_mode() -> preempt_enable() and
arch_leave_lazy_mmu_mode() -> preempt_disable(), such crash occurs:

[    0.663336] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
[    0.663348] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2, name: kthreadd
[    0.663358] preempt_count: 1, expected: 0
[    0.663366] RCU nest depth: 0, expected: 0
[    0.663375] no locks held by kthreadd/2.
[    0.663383] Preemption disabled at:
[    0.663386] [<0002f3284cbb4eda>] apply_to_pte_range+0xfa/0x4a0
[    0.663405] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.15.0-rc5-gcc-kasan-00043-gd76bb1ebb558-dirty #162 PREEMPT
[    0.663408] Hardware name: IBM 3931 A01 701 (KVM/Linux)
[    0.663409] Call Trace:
[    0.663410]  [<0002f3284c385f58>] dump_stack_lvl+0xe8/0x140
[    0.663413]  [<0002f3284c507b9e>] __might_resched+0x66e/0x700
[    0.663415]  [<0002f3284cc4f6c0>] __alloc_frozen_pages_noprof+0x370/0x4b0
[    0.663419]  [<0002f3284ccc73c0>] alloc_pages_mpol+0x1a0/0x4a0
[    0.663421]  [<0002f3284ccc8518>] alloc_frozen_pages_noprof+0x88/0xc0
[    0.663424]  [<0002f3284ccc8572>] alloc_pages_noprof+0x22/0x120
[    0.663427]  [<0002f3284cc341ac>] get_free_pages_noprof+0x2c/0xc0
[    0.663429]  [<0002f3284cceba70>] kasan_populate_vmalloc_pte+0x50/0x120
[    0.663433]  [<0002f3284cbb4ef8>] apply_to_pte_range+0x118/0x4a0
[    0.663435]  [<0002f3284cbc7c14>] apply_to_pmd_range+0x194/0x3e0
[    0.663437]  [<0002f3284cbc99be>] __apply_to_page_range+0x2fe/0x7a0
[    0.663440]  [<0002f3284cbc9e88>] apply_to_page_range+0x28/0x40
[    0.663442]  [<0002f3284ccebf12>] kasan_populate_vmalloc+0x82/0xa0
[    0.663445]  [<0002f3284cc1578c>] alloc_vmap_area+0x34c/0xc10
[    0.663448]  [<0002f3284cc1c2a6>] __get_vm_area_node+0x186/0x2a0
[    0.663451]  [<0002f3284cc1e696>] __vmalloc_node_range_noprof+0x116/0x310
[    0.663454]  [<0002f3284cc1d950>] __vmalloc_node_noprof+0xd0/0x110
[    0.663457]  [<0002f3284c454b88>] alloc_thread_stack_node+0xf8/0x330
[    0.663460]  [<0002f3284c458d56>] dup_task_struct+0x66/0x4d0
[    0.663463]  [<0002f3284c45be90>] copy_process+0x280/0x4b90
[    0.663465]  [<0002f3284c460940>] kernel_clone+0xd0/0x4b0
[    0.663467]  [<0002f3284c46115e>] kernel_thread+0xbe/0xe0
[    0.663469]  [<0002f3284c4e440e>] kthreadd+0x50e/0x7f0
[    0.663472]  [<0002f3284c38c04a>] __ret_from_fork+0x8a/0xf0
[    0.663475]  [<0002f3284ed57ff2>] ret_from_fork+0xa/0x38

Instead of allocating single pages per-PTE, bulk-allocate the shadow
memory prior to applying kasan_populate_vmalloc_pte() callback on a page
range.

Link: https://lkml.kernel.org/r/c61d3560297c93ed044f0b1af085610353a06a58.1747316918.git.agordeev@linux.ibm.com
Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kasan/shadow.c |   92 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 14 deletions(-)

--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -292,33 +292,99 @@ void __init __weak kasan_populate_early_
 {
 }
 
+struct vmalloc_populate_data {
+	unsigned long start;
+	struct page **pages;
+};
+
 static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
-				      void *unused)
+				      void *_data)
 {
-	unsigned long page;
+	struct vmalloc_populate_data *data = _data;
+	struct page *page;
 	pte_t pte;
+	int index;
 
 	if (likely(!pte_none(ptep_get(ptep))))
 		return 0;
 
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
-	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
+	index = PFN_DOWN(addr - data->start);
+	page = data->pages[index];
+	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
+	pte = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
 
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pte_none(ptep_get(ptep)))) {
 		set_pte_at(&init_mm, addr, ptep, pte);
-		page = 0;
+		data->pages[index] = NULL;
 	}
 	spin_unlock(&init_mm.page_table_lock);
-	if (page)
-		free_page(page);
+
+	return 0;
+}
+
+static void ___free_pages_bulk(struct page **pages, int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i]) {
+			__free_pages(pages[i], 0);
+			pages[i] = NULL;
+		}
+	}
+}
+
+static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
+{
+	unsigned long nr_populated, nr_total = nr_pages;
+	struct page **page_array = pages;
+
+	while (nr_pages) {
+		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+		if (!nr_populated) {
+			___free_pages_bulk(page_array, nr_total - nr_pages);
+			return -ENOMEM;
+		}
+		pages += nr_populated;
+		nr_pages -= nr_populated;
+	}
+
 	return 0;
 }
 
+static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
+{
+	unsigned long nr_pages, nr_total = PFN_UP(end - start);
+	struct vmalloc_populate_data data;
+	int ret = 0;
+
+	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!data.pages)
+		return -ENOMEM;
+
+	while (nr_total) {
+		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
+		ret = ___alloc_pages_bulk(data.pages, nr_pages);
+		if (ret)
+			break;
+
+		data.start = start;
+		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
+					  kasan_populate_vmalloc_pte, &data);
+		___free_pages_bulk(data.pages, nr_pages);
+		if (ret)
+			break;
+
+		start += nr_pages * PAGE_SIZE;
+		nr_total -= nr_pages;
+	}
+
+	free_page((unsigned long)data.pages);
+
+	return ret;
+}
+
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 {
 	unsigned long shadow_start, shadow_end;
@@ -348,9 +414,7 @@ int kasan_populate_vmalloc(unsigned long
 	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
 	shadow_end = PAGE_ALIGN(shadow_end);
 
-	ret = apply_to_page_range(&init_mm, shadow_start,
-				  shadow_end - shadow_start,
-				  kasan_populate_vmalloc_pte, NULL);
+	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
 	if (ret)
 		return ret;
 



