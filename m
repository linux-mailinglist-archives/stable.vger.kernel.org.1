Return-Path: <stable+bounces-73853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCE97069A
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4949B214EB
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30620136342;
	Sun,  8 Sep 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWXmis3o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466E71742
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791436; cv=none; b=udQ2Vv4O1eczdAttGa2Szko/su3OesluhaCfVx4go3P/TwfLnYEIEDmiJRLpB7jv/0ilvHcHbARHdjb+ljyZ9Rxg0KWEhpDqRTYCOYWPWmAm7fnhXs05OlidEEOF+Btx7gXyjlzyD2GaGuS07eFq0Tr1/SLsPYAa2gZ8qu3AZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791436; c=relaxed/simple;
	bh=7QGOPMWSMKCCnCeWsQWvib7qZUf5qP+ahB5HmpuA3DE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P3rzOAxVMPjIIyDrrSNGvZ62vCgbC90WqZyUL3asWDU4fcYIXpoQgnzrFkTf6Q9C6d9kPgFi2mY6F7Znbqj4ihZ4QzrayqqWzMt5qDH2Iilfe4lCEVvvaUkiR5R3s/Crn50ul5+pjhORFAKYu3ARUB5hqF5TmzqTkRk1zfhZtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWXmis3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11647C4CEC3;
	Sun,  8 Sep 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791435;
	bh=7QGOPMWSMKCCnCeWsQWvib7qZUf5qP+ahB5HmpuA3DE=;
	h=Subject:To:Cc:From:Date:From;
	b=IWXmis3okIv11eCjqaJHzIzKLUAZVP1NWdWnPgm3M1RNVkE/JLpm04QVZcifLa83c
	 QDdrpH+sybQ9RgVcx0l3wT0G/IT+Oyhew35pksIujd3hwnsH+xrhztKr7C2Tzh2ESG
	 QjYFhzq8+1k5ex4CEeh4UpJ7d6zCU80bEe+Lw82k=
Subject: FAILED: patch "[PATCH] x86/kaslr: Expose and use the end of the physical memory" failed to apply to 5.4-stable tree
To: tglx@linutronix.de,apopple@nvidia.com,dan.j.williams@intel.com,kees@kernel.org,max8rr8@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:30:29 +0200
Message-ID: <2024090829-swizzle-angelfish-9047@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ea72ce5da22806d5713f3ffb39a6d5ae73841f93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090829-swizzle-angelfish-9047@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ea72ce5da228 ("x86/kaslr: Expose and use the end of the physical memory address space")
1a167ddd3c56 ("x86: kmsan: pgtable: reduce vmalloc space")
14b80582c43e ("resource: Introduce alloc_free_mem_region()")
27674ef6c73f ("mm: remove the extra ZONE_DEVICE struct page refcount")
dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
895749455f60 ("mm: simplify freeing of devmap managed pages")
75e55d8a107e ("mm: move free_devmap_managed_page to memremap.c")
730ff52194cd ("mm: remove pointless includes from <linux/hmm.h>")
f56caedaf94f ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea72ce5da22806d5713f3ffb39a6d5ae73841f93 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 14 Aug 2024 00:29:36 +0200
Subject: [PATCH] x86/kaslr: Expose and use the end of the physical memory
 address space

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

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index af4302d79b59..f3d257c45225 100644
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
index 9053dfe9fa03..a98e53491a4e 100644
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
index d8dbeac8b206..ff253648706f 100644
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
index 37db264866b6..230f1dee4f09 100644
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
 
@@ -128,11 +141,18 @@ void __init kernel_randomize_memory(void)
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
-		/*
-		 * Jump the region and add a minimum padding based on
-		 * randomization alignment.
-		 */
+		/* Calculate the end of the region */
 		vaddr += get_padding(&kaslr_regions[i]);
+		/*
+		 * KASLR trims the maximum possible size of the
+		 * direct-map. Update the physmem_end boundary.
+		 * No rounding required as the region starts
+		 * PUD aligned and size is in units of TB.
+		 */
+		if (kaslr_regions[i].end)
+			*kaslr_regions[i].end = __pa_nodebug(vaddr - 1);
+
+		/* Add a minimum padding based on randomization alignment. */
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..b3864156eaa4 100644
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
index 14777afb0a99..a83040fde236 100644
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
index 66267c26ca1b..951878ab627a 100644
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
index e4b830091d13..0c3bff882033 100644
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


