Return-Path: <stable+bounces-69308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B293B9545FC
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 11:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A9284BD3
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7015B132;
	Fri, 16 Aug 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ofSa5QKx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8F4RbK3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B715B10F;
	Fri, 16 Aug 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801433; cv=none; b=Ed876i5CA0tOXZD5DWPB6wJmddnxqUMSSXP512GK1vZatXOvTaAdwarYjnbPBbev0TogCxAanc8BJBInl7t2+DPLgLwqPcy9B+GzROOC3E1j++BExfna75dmZAxQ4Jb2/BO1uKLUwTU+ZtUxPSK6c6TMNU0i0Ln47509pQ6uMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801433; c=relaxed/simple;
	bh=8v+vudh8G0FULKhRV2KPrVNh0DmyX03e1TqFnRrcarY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cfbJif2DNBF+I2wQQJmBBLZIx17CDlFRFdLNstHYgdl5rEYipL6mabuWN+egLl+VY5KZlkR5/itPBittcHnwit9wfNgYX73+zkkVqA0GIe792kOL+XzU8zXbLsS1mVv7xiqGy8dnwiTLT5J37KuX5lxLythhx21rIiHHWBqsPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ofSa5QKx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8F4RbK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Aug 2024 09:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723801429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDeFDV1UGN5ys8G/ZTdhRYc7K5xIx+15xIld86nv5lM=;
	b=ofSa5QKxJMEwAL7subtb08LFsQsy3BooUUgEzfbyMiLmdes8HHXKw7J0fvhnfdGviagBF1
	EkIn3Qqhk+jmkhqYc1EitG8a6F4GSPyEDLI/KFlL8rYgYoblyOrID2kj7+isQ0MG9rPW/7
	dbN47tcWdA64I26I01IWXCrtL4ljhELjoFOvWIwDEzgY5VCitoy12cIN4FiLYGLA9Tpj+P
	NOibx9potZ9tSsZwo5ESVS/fb5SnNDmsO5L1kTLIG+WYeTVhyb7vg7RvvPlGJwrdidhyOR
	sf05ru0UJmr1/kDChuB35UBvxj2jEMvWg97lbgDFvYmouogRKL9LhgljD894uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723801429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDeFDV1UGN5ys8G/ZTdhRYc7K5xIx+15xIld86nv5lM=;
	b=E8F4RbK3Q1pIQa7d7QDEhx2mvQaLKcIR9udRLO6lC1sg/+1v0f2EPoG68GDn+ZH2l4mNeM
	UgY3ffgzX+uXHeDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kaslr: Expose and use the end of the physical
 memory address space
Cc: Max Ramanouski <max8rr8@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>,
 Kees Cook <kees@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ed6soy3z.ffs@tglx>
References: <87ed6soy3z.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172380142936.2215.14207416159198118829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dfb3911c3692e45b027f13c7dca3230921533953
Gitweb:        https://git.kernel.org/tip/dfb3911c3692e45b027f13c7dca3230921533953
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Aug 2024 00:29:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Aug 2024 11:33:33 +02:00

x86/kaslr: Expose and use the end of the physical memory address space

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
---
 arch/x86/include/asm/page_64.h          |  1 +-
 arch/x86/include/asm/pgtable_64_types.h |  4 ++++-
 arch/x86/mm/init_64.c                   |  4 ++++-
 arch/x86/mm/kaslr.c                     | 26 +++++++++++++++++++++---
 include/linux/mm.h                      |  4 ++++-
 kernel/resource.c                       |  6 ++----
 mm/memory_hotplug.c                     |  2 +-
 mm/sparse.c                             |  2 +-
 8 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index af4302d..f3d257c 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -17,6 +17,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+extern unsigned long physmem_end;
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 9053dfe..a98e534 100644
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
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d8dbeac..ff25364 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -958,8 +958,12 @@ static void update_end_of_memory_vars(u64 start, u64 size)
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
 
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 37db264..0f2a3a4 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -47,13 +47,24 @@ static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
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
@@ -82,6 +93,8 @@ void __init kernel_randomize_memory(void)
 	BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
+	/* Preset the end of the possible address space for physical memory */
+	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
 	if (!kaslr_memory_enabled())
 		return;
 
@@ -134,6 +147,13 @@ void __init kernel_randomize_memory(void)
 		 */
 		vaddr += get_padding(&kaslr_regions[i]);
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
+
+		/*
+		 * KASLR trims the maximum possible size of the
+		 * direct-map. Update the physmem_end boundary.
+		 */
+		if (kaslr_regions[i].end)
+			*kaslr_regions[i].end = __pa(vaddr) - 1;
 		remain_entropy -= entropy;
 	}
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a..b386415 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_max;
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
+#ifndef PHYSMEM_END
+# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+#endif
+
 #include <asm/page.h>
 #include <asm/processor.h>
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 14777af..a83040f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1826,8 +1826,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end,
-			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		end = min_t(resource_size_t, base->end, PHYSMEM_END);
 		return end - size + 1;
 	}
 
@@ -1844,8 +1843,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 66267c2..951878a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_range(void)
 
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
+	const u64 max_phys = PHYSMEM_END;
 	struct range mhp_range;
 
 	if (need_mapping) {
diff --git a/mm/sparse.c b/mm/sparse.c
index e4b8300..0c3bff8 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struct mem_section *section)
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
 
 	/*
 	 * Sanity checks - do not allow an architecture to pass

