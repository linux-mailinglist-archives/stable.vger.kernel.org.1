Return-Path: <stable+bounces-5137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B580B439
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04C12810D0
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA9CA76;
	Sat,  9 Dec 2023 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RM2kxOEr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60711184
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821FAC433C7;
	Sat,  9 Dec 2023 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702125329;
	bh=52dHSvX4wYfErirlFcdAhuBWIMgUhCR2g+S9vwu2AZo=;
	h=Subject:To:Cc:From:Date:From;
	b=RM2kxOErF7SlyjzuzEG4ACqY01jKnuILE3AVWtCrXUiRTVbCPkdKPaAsV+s8btRo6
	 /MdroTlSX4OKiOwPF0IxLsNTpMvXnO7gdRlXyF9ZWJ/wWMEFE2m1pDyL6Zn9Q3Xve2
	 F2CpmmZIm6d90HvWvq7tXyZx+LQ5/gTvixQptIaE=
Subject: FAILED: patch "[PATCH] mm/memory_hotplug: add missing mem_hotplug_lock" failed to apply to 6.1-stable tree
To: sumanthk@linux.ibm.com,agordeev@linux.ibm.com,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,anshuman.khandual@arm.com,david@redhat.com,gerald.schaefer@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com,lkp@intel.com,mhocko@suse.com,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:35:26 +0100
Message-ID: <2023120925-hazard-mustard-8df5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 001002e73712cdf6b8d9a103648cda3040ad7647
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120925-hazard-mustard-8df5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

001002e73712 ("mm/memory_hotplug: add missing mem_hotplug_lock")
1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
2d1f649c7c08 ("mm/memory_hotplug: support memmap_on_memory when memmap is not aligned to pageblocks")
85a2b4b08f20 ("mm/memory_hotplug: allow architecture to override memmap on memory support check")
e3c2bfdd33a3 ("mm/memory_hotplug: allow memmap on memory hotplug request to fallback")
5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
a46c9304b4bb ("mm/hwpoison: pass pfn to num_poisoned_pages_*()")
d027122d8363 ("mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c")
e591ef7d96d6 ("mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 001002e73712cdf6b8d9a103648cda3040ad7647 Mon Sep 17 00:00:00 2001
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Date: Mon, 20 Nov 2023 15:53:52 +0100
Subject: [PATCH] mm/memory_hotplug: add missing mem_hotplug_lock

From Documentation/core-api/memory-hotplug.rst:
When adding/removing/onlining/offlining memory or adding/removing
heterogeneous/device memory, we should always hold the mem_hotplug_lock
in write mode to serialise memory hotplug (e.g. access to global/zone
variables).

mhp_(de)init_memmap_on_memory() functions can change zone stats and
struct page content, but they are currently called w/o the
mem_hotplug_lock.

When memory block is being offlined and when kmemleak goes through each
populated zone, the following theoretical race conditions could occur:
CPU 0:					     | CPU 1:
memory_offline()			     |
-> offline_pages()			     |
	-> mem_hotplug_begin()		     |
	   ...				     |
	-> mem_hotplug_done()		     |
					     | kmemleak_scan()
					     | -> get_online_mems()
					     |    ...
-> mhp_deinit_memmap_on_memory()	     |
  [not protected by mem_hotplug_begin/done()]|
  Marks memory section as offline,	     |   Retrieves zone_start_pfn
  poisons vmemmap struct pages and updates   |   and struct page members.
  the zone related data			     |
   					     |    ...
   					     | -> put_online_mems()

Fix this by ensuring mem_hotplug_lock is taken before performing
mhp_init_memmap_on_memory().  Also ensure that
mhp_deinit_memmap_on_memory() holds the lock.

online/offline_pages() are currently only called from
memory_block_online/offline(), so it is safe to move the locking there.

Link: https://lkml.kernel.org/r/20231120145354.308999-2-sumanthk@linux.ibm.com
Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f3b9a4d0fa3b..8a13babd826c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -180,6 +180,9 @@ static inline unsigned long memblk_nr_poison(struct memory_block *mem)
 }
 #endif
 
+/*
+ * Must acquire mem_hotplug_lock in write mode.
+ */
 static int memory_block_online(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
@@ -204,10 +207,11 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
+	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
 		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = online_pages(start_pfn + nr_vmemmap_pages,
@@ -215,7 +219,7 @@ static int memory_block_online(struct memory_block *mem)
 	if (ret) {
 		if (nr_vmemmap_pages)
 			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -227,9 +231,14 @@ static int memory_block_online(struct memory_block *mem)
 					  nr_vmemmap_pages);
 
 	mem->zone = zone;
+out:
+	mem_hotplug_done();
 	return ret;
 }
 
+/*
+ * Must acquire mem_hotplug_lock in write mode.
+ */
 static int memory_block_offline(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
@@ -247,6 +256,7 @@ static int memory_block_offline(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
+	mem_hotplug_begin();
 	if (nr_vmemmap_pages)
 		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  -nr_vmemmap_pages);
@@ -258,13 +268,15 @@ static int memory_block_offline(struct memory_block *mem)
 		if (nr_vmemmap_pages)
 			adjust_present_page_count(pfn_to_page(start_pfn),
 						  mem->group, nr_vmemmap_pages);
-		return ret;
+		goto out;
 	}
 
 	if (nr_vmemmap_pages)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
+out:
+	mem_hotplug_done();
 	return ret;
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ab41a511e20a..bb908289679e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1129,6 +1129,9 @@ void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
 	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 }
 
+/*
+ * Must be called with mem_hotplug_lock in write mode.
+ */
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       struct zone *zone, struct memory_group *group)
 {
@@ -1149,7 +1152,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
-	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
@@ -1208,7 +1210,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	writeback_set_ratelimit();
 
 	memory_notify(MEM_ONLINE, &arg);
-	mem_hotplug_done();
 	return 0;
 
 failed_addition:
@@ -1217,7 +1218,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
 	memory_notify(MEM_CANCEL_ONLINE, &arg);
 	remove_pfn_range_from_zone(zone, pfn, nr_pages);
-	mem_hotplug_done();
 	return ret;
 }
 
@@ -1863,6 +1863,9 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
+/*
+ * Must be called with mem_hotplug_lock in write mode.
+ */
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group)
 {
@@ -1885,8 +1888,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
-	mem_hotplug_begin();
-
 	/*
 	 * Don't allow to offline memory blocks that contain holes.
 	 * Consequently, memory blocks with holes can never get onlined
@@ -2031,7 +2032,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	memory_notify(MEM_OFFLINE, &arg);
 	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
-	mem_hotplug_done();
 	return 0;
 
 failed_removal_isolated:
@@ -2046,7 +2046,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
 		 reason);
-	mem_hotplug_done();
 	return ret;
 }
 


