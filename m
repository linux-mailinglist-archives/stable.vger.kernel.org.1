Return-Path: <stable+bounces-75170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F815973333
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269291F22EAF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74D198E69;
	Tue, 10 Sep 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2EMouFbK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F2188A28;
	Tue, 10 Sep 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963952; cv=none; b=aTKDu53XN7+paEaKjQhVVXxYgkcgIZXEDqCZP0cOj7/n15jNIbDzb8PINaB6myO3Gtj3RIp0XsYNemas5lJ9p5ZV3PmJMm2i103Zw2OpDx0fLqTrH/PS/clgC7IM9eQbXivE3Rh/DR44kmo0MELKo7Vtdl/akxqOQc7cRaUyc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963952; c=relaxed/simple;
	bh=UQwWQ1JKuAZkTVIPQY6ShCh4xr5riSOAv7XL9t7O74o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Hw6KJsNmmJOlCI94VVNWSii3RjZL0xCj5i6Up439QibEZ0zMqzbtc30KLYbvjHJPK4bDyZmgQZ35olYvzXs8D4Lo4mWo9ddQgr91OekqaLDRE1XguJAYGxjHStVKFbMUrx6aUgfib0EXLzECk3Ih06BdzPsAhbfmhBgD9L5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2EMouFbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C3BC4CEC3;
	Tue, 10 Sep 2024 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963952;
	bh=UQwWQ1JKuAZkTVIPQY6ShCh4xr5riSOAv7XL9t7O74o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2EMouFbKxZMuBghW4CHms0RvPkR0++licG3yFpO8Y4CnCtZ3zVHW4BF6HMn8VAq6P
	 P+jF2l9aZThEl7JMis91cyoW/JKd1uDfnIX9RJOIjQ2HaczOJ2s0n3T93p6HLSb3hI
	 fifyUAYFgxAYXVgZy5N+LMPptTWNUVsjwklje7a0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Ramanouski <max8rr8@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.6 018/269] x86/kaslr: Expose and use the end of the physical memory address space
Date: Tue, 10 Sep 2024 11:30:05 +0200
Message-ID: <20240910092608.908890009@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit ea72ce5da22806d5713f3ffb39a6d5ae73841f93 upstream.

iounmap() on x86 occasionally fails to unmap because the provided valid
ioremap address is not below high_memory. It turned out that this
happens due to KASLR.

KASLR uses the full address space between PAGE_OFFSET and vaddr_end to
randomize the starting points of the direct map, vmalloc and vmemmap
regions.  It thereby limits the size of the direct map by using the
installed memory size plus an extra configurable margin for hot-plug
memory.  This limitation is done to gain more randomization space
because otherwise only the holes between the direct map, vmalloc,
vmemmap and vaddr_end would be usable for randomizing.

The limited direct map size is not exposed to the rest of the kernel, so
the memory hot-plug and resource management related code paths still
operate under the assumption that the available address space can be
determined with MAX_PHYSMEM_BITS.

request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
downwards.  That means the first allocation happens past the end of the
direct map and if unlucky this address is in the vmalloc space, which
causes high_memory to become greater than VMALLOC_START and consequently
causes iounmap() to fail for valid ioremap addresses.

MAX_PHYSMEM_BITS cannot be changed for that because the randomization
does not align with address bit boundaries and there are other places
which actually require to know the maximum number of address bits.  All
remaining usage sites of MAX_PHYSMEM_BITS have been analyzed and found
to be correct.

Cure this by exposing the end of the direct map via PHYSMEM_END and use
that for the memory hot-plug and resource management related places
instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
maps to a variable which is initialized by the KASLR initialization and
otherwise it is based on MAX_PHYSMEM_BITS as before.

To prevent future hickups add a check into add_pages() to catch callers
trying to add memory above PHYSMEM_END.

Fixes: 0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
Reported-by: Max Ramanouski <max8rr8@gmail.com>
Reported-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-By: Max Ramanouski <max8rr8@gmail.com>
Tested-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/87ed6soy3z.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/page_64.h          |    1 +
 arch/x86/include/asm/pgtable_64_types.h |    4 ++++
 arch/x86/mm/init_64.c                   |    4 ++++
 arch/x86/mm/kaslr.c                     |   32 ++++++++++++++++++++++++++------
 include/linux/mm.h                      |    4 ++++
 kernel/resource.c                       |    6 ++----
 mm/memory_hotplug.c                     |    2 +-
 mm/sparse.c                             |    2 +-
 8 files changed, 43 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -17,6 +17,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+extern unsigned long physmem_end;
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -140,6 +140,10 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+#ifdef CONFIG_RANDOMIZE_MEMORY
+# define PHYSMEM_END		physmem_end
+#endif
+
 /*
  * End of the region for which vmalloc page tables are pre-allocated.
  * For non-KMSAN builds, this is the same as VMALLOC_END.
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -950,8 +950,12 @@ static void update_end_of_memory_vars(u6
 int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	      struct mhp_params *params)
 {
+	unsigned long end = ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
 	int ret;
 
+	if (WARN_ON_ONCE(end > PHYSMEM_END))
+		return -ERANGE;
+
 	ret = __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
 
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -47,13 +47,24 @@ static const unsigned long vaddr_end = C
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
+	unsigned long *end;
 	unsigned long size_tb;
 } kaslr_regions[] = {
-	{ &page_offset_base, 0 },
-	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 0 },
+	{
+		.base	= &page_offset_base,
+		.end	= &physmem_end,
+	},
+	{
+		.base	= &vmalloc_base,
+	},
+	{
+		.base	= &vmemmap_base,
+	},
 };
 
+/* The end of the possible address space for physical memory */
+unsigned long physmem_end __ro_after_init;
+
 /* Get size in bytes used by the memory region */
 static inline unsigned long get_padding(struct kaslr_memory_region *region)
 {
@@ -82,6 +93,8 @@ void __init kernel_randomize_memory(void
 	BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
+	/* Preset the end of the possible address space for physical memory */
+	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
 	if (!kaslr_memory_enabled())
 		return;
 
@@ -128,11 +141,18 @@ void __init kernel_randomize_memory(void
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
+		/* Calculate the end of the region */
+		vaddr += get_padding(&kaslr_regions[i]);
 		/*
-		 * Jump the region and add a minimum padding based on
-		 * randomization alignment.
+		 * KASLR trims the maximum possible size of the
+		 * direct-map. Update the physmem_end boundary.
+		 * No rounding required as the region starts
+		 * PUD aligned and size is in units of TB.
 		 */
-		vaddr += get_padding(&kaslr_regions[i]);
+		if (kaslr_regions[i].end)
+			*kaslr_regions[i].end = __pa_nodebug(vaddr - 1);
+
+		/* Add a minimum padding based on randomization alignment. */
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -95,6 +95,10 @@ extern const int mmap_rnd_compat_bits_ma
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
+#ifndef PHYSMEM_END
+# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+#endif
+
 #include <asm/page.h>
 #include <asm/processor.h>
 
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1778,8 +1778,7 @@ static resource_size_t gfr_start(struct
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end,
-			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		end = min_t(resource_size_t, base->end, PHYSMEM_END);
 		return end - size + 1;
 	}
 
@@ -1796,8 +1795,7 @@ static bool gfr_continue(struct resource
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1610,7 +1610,7 @@ struct range __weak arch_get_mappable_ra
 
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
+	const u64 max_phys = PHYSMEM_END;
 	struct range mhp_range;
 
 	if (need_mapping) {
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struc
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
 
 	/*
 	 * Sanity checks - do not allow an architecture to pass



