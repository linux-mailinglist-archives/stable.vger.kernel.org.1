Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677776F9892
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEGNKq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEGNKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 09:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28627524D
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF41E619CC
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6CFC433D2;
        Sun,  7 May 2023 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683465037;
        bh=DRX9vZK/X2UJjhXom/Q9C++wdyo+FCK+wl8V/CfqJ78=;
        h=Subject:To:Cc:From:Date:From;
        b=qI+1nfGR397Z69bja87QdCUX8CZ6ksa/S6RBuSKLaRDulVbvoACm3/inCRmMe4mxH
         VcnLnOG8Tc1zlWA8hECcmL2s7r4zd0LVfomz5L9aoL2DTFo+KNPeQD1iUWH11QOKez
         wfdLbK8H95nG5GpduS/KUOAM8LoZodjSgnheBgKY=
Subject: FAILED: patch "[PATCH] mm/vmemmap/devdax: fix kernel crash when probing devdax" failed to apply to 6.3-stable tree
To:     aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, joao.m.martins@oracle.com,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        stable@vger.kernel.org, tsahu@linux.ibm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 15:10:34 +0200
Message-ID: <2023050734-mosaic-duplex-55e7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 87a7ae75d7383afa998f57656d1d14e2a730cc47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050734-mosaic-duplex-55e7@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

87a7ae75d738 ("mm/vmemmap/devdax: fix kernel crash when probing devdax devices")
9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
23baf831a32c ("mm, treewide: redefine MAX_ORDER sanely")
61883d3c3241 ("iommu: fix MAX_ORDER usage in __iommu_dma_alloc_pages()")
7a16d7c7619b ("mm/slub: fix MAX_ORDER usage in calculate_order()")
75558ad31548 ("sparc/mm: fix MAX_ORDER usage in tsb_grow()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87a7ae75d7383afa998f57656d1d14e2a730cc47 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 11 Apr 2023 19:52:13 +0530
Subject: [PATCH] mm/vmemmap/devdax: fix kernel crash when probing devdax
 devices

commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for
compound devmaps") added support for using optimized vmmemap for devdax
devices.  But how vmemmap mappings are created are architecture specific.
For example, powerpc with hash translation doesn't have vmemmap mappings
in init_mm page table instead they are bolted table entries in the
hardware page table

vmemmap_populate_compound_pages() used by vmemmap optimization code is not
aware of these architecture-specific mapping.  Hence allow architecture to
opt for this feature.  I selected architectures supporting
HUGETLB_PAGE_OPTIMIZE_VMEMMAP option as also supporting this feature.

This patch fixes the below crash on ppc64.

BUG: Unable to handle kernel data access on write at 0xc00c000100400038
Faulting instruction address: 0xc000000001269d90
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-150500.34-default+ #2 5c90a668b6bbd142599890245c2fb5de19d7d28a
Hardware name: IBM,9009-42G POWER9 (raw) 0x4e0202 0xf000005 of:IBM,FW950.40 (VL950_099) hv:phyp pSeries
NIP:  c000000001269d90 LR: c0000000004c57d4 CTR: 0000000000000000
REGS: c000000003632c30 TRAP: 0300   Not tainted  (6.3.0-rc5-150500.34-default+)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24842228  XER: 00000000
CFAR: c0000000004c57d0 DAR: c00c000100400038 DSISR: 42000000 IRQMASK: 0
....
NIP [c000000001269d90] __init_single_page.isra.74+0x14/0x4c
LR [c0000000004c57d4] __init_zone_device_page+0x44/0xd0
Call Trace:
[c000000003632ed0] [c000000003632f60] 0xc000000003632f60 (unreliable)
[c000000003632f10] [c0000000004c5ca0] memmap_init_zone_device+0x170/0x250
[c000000003632fe0] [c0000000005575f8] memremap_pages+0x2c8/0x7f0
[c0000000036330c0] [c000000000557b5c] devm_memremap_pages+0x3c/0xa0
[c000000003633100] [c000000000d458a8] dev_dax_probe+0x108/0x3e0
[c0000000036331a0] [c000000000d41430] dax_bus_probe+0xb0/0x140
[c0000000036331d0] [c000000000cef27c] really_probe+0x19c/0x520
[c000000003633260] [c000000000cef6b4] __driver_probe_device+0xb4/0x230
[c0000000036332e0] [c000000000cef888] driver_probe_device+0x58/0x120
[c000000003633320] [c000000000cefa6c] __device_attach_driver+0x11c/0x1e0
[c0000000036333a0] [c000000000cebc58] bus_for_each_drv+0xa8/0x130
[c000000003633400] [c000000000ceefcc] __device_attach+0x15c/0x250
[c0000000036334a0] [c000000000ced458] bus_probe_device+0x108/0x110
[c0000000036334f0] [c000000000ce92dc] device_add+0x7fc/0xa10
[c0000000036335b0] [c000000000d447c8] devm_create_dev_dax+0x1d8/0x530
[c000000003633640] [c000000000d46b60] __dax_pmem_probe+0x200/0x270
[c0000000036337b0] [c000000000d46bf0] dax_pmem_probe+0x20/0x70
[c0000000036337d0] [c000000000d2279c] nvdimm_bus_probe+0xac/0x2b0
[c000000003633860] [c000000000cef27c] really_probe+0x19c/0x520
[c0000000036338f0] [c000000000cef6b4] __driver_probe_device+0xb4/0x230
[c000000003633970] [c000000000cef888] driver_probe_device+0x58/0x120
[c0000000036339b0] [c000000000cefd08] __driver_attach+0x1d8/0x240
[c000000003633a30] [c000000000cebb04] bus_for_each_dev+0xb4/0x130
[c000000003633a90] [c000000000cee564] driver_attach+0x34/0x50
[c000000003633ab0] [c000000000ced878] bus_add_driver+0x218/0x300
[c000000003633b40] [c000000000cf1144] driver_register+0xa4/0x1b0
[c000000003633bb0] [c000000000d21a0c] __nd_driver_register+0x5c/0x100
[c000000003633c10] [c00000000206a2e8] dax_pmem_init+0x34/0x48
[c000000003633c30] [c0000000000132d0] do_one_initcall+0x60/0x320
[c000000003633d00] [c0000000020051b0] kernel_init_freeable+0x360/0x400
[c000000003633de0] [c000000000013764] kernel_init+0x34/0x1d0
[c000000003633e50] [c00000000000de14] ret_from_kernel_thread+0x5c/0x64

Link: https://lkml.kernel.org/r/20230411142214.64464-1-aneesh.kumar@linux.ibm.com
Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a3eaa9a1f8c..21a7e2460084 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3560,6 +3560,22 @@ void vmemmap_populate_print_last(void);
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
 #endif
+
+#ifdef CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
+					   struct dev_pagemap *pgmap)
+{
+	return is_power_of_2(sizeof(struct page)) &&
+		pgmap && (pgmap_vmemmap_nr(pgmap) > 1) && !altmap;
+}
+#else
+static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
+					   struct dev_pagemap *pgmap)
+{
+	return false;
+}
+#endif
+
 void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
 				  unsigned long nr_pages);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a0ec3b3acb5e..7f7f9c677854 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1015,10 +1015,12 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of an altmap. See vmemmap_populate_compound_pages().
  */
 static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
-					      unsigned long nr_pages)
+					      struct dev_pagemap *pgmap)
 {
-	return is_power_of_2(sizeof(struct page)) &&
-		!altmap ? 2 * (PAGE_SIZE / sizeof(struct page)) : nr_pages;
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return pgmap_vmemmap_nr(pgmap);
+
+	return 2 * (PAGE_SIZE / sizeof(struct page));
 }
 
 static void __ref memmap_init_compound(struct page *head,
@@ -1083,7 +1085,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pfns_per_compound));
+				     compound_nr_pages(altmap, pgmap));
 	}
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c5398a5960d0..10d73a0dfcec 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -458,8 +458,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (is_power_of_2(sizeof(struct page)) &&
-	    pgmap && pgmap_vmemmap_nr(pgmap) > 1 && !altmap)
+	if (vmemmap_can_optimize(altmap, pgmap))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);

