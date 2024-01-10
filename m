Return-Path: <stable+bounces-10293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C72782743D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255911C22B1F
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CF53E00;
	Mon,  8 Jan 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dpV2lHkP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C151C4E;
	Mon,  8 Jan 2024 15:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D073FC433C9;
	Mon,  8 Jan 2024 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728591;
	bh=z13SVoW36uz3ddVW1/95f5Clmi1GK/qr0T+c72vuPc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpV2lHkPfkDjb2pTYv4FKqOOAPLDXBIO9mDRXh9GIzubAoc+e04govZWQHpgjUxnz
	 Synv6nBiSWaLxLUOJdDqnEjN2jMUHOU5F61KLn2gaHfSgmE8xncmhh5GhmHlVNTHPn
	 fjh0pv6KERv99TUQeXMnwzVM4cOcLc7Y+M9MSfLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/150] mm/memory_hotplug: add missing mem_hotplug_lock
Date: Mon,  8 Jan 2024 16:36:09 +0100
Message-ID: <20240108153516.621951419@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Sumanth Korikkar <sumanthk@linux.ibm.com>

[ Upstream commit 001002e73712cdf6b8d9a103648cda3040ad7647 ]

>From Documentation/core-api/memory-hotplug.rst:
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/memory.c | 18 +++++++++++++++---
 mm/memory_hotplug.c   | 13 ++++++-------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 9aa0da991cfb9..5d39f3e374dae 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -175,6 +175,9 @@ int memory_notify(unsigned long val, void *v)
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
 
+/*
+ * Must acquire mem_hotplug_lock in write mode.
+ */
 static int memory_block_online(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
@@ -193,10 +196,11 @@ static int memory_block_online(struct memory_block *mem)
 	 * stage helps to keep accounting easier to follow - e.g vmemmaps
 	 * belong to the same zone as the memory they backed.
 	 */
+	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
 		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = online_pages(start_pfn + nr_vmemmap_pages,
@@ -204,7 +208,7 @@ static int memory_block_online(struct memory_block *mem)
 	if (ret) {
 		if (nr_vmemmap_pages)
 			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -216,9 +220,14 @@ static int memory_block_online(struct memory_block *mem)
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
@@ -233,6 +242,7 @@ static int memory_block_offline(struct memory_block *mem)
 	 * Unaccount before offlining, such that unpopulated zone and kthreads
 	 * can properly be torn down in offline_pages().
 	 */
+	mem_hotplug_begin();
 	if (nr_vmemmap_pages)
 		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  -nr_vmemmap_pages);
@@ -244,13 +254,15 @@ static int memory_block_offline(struct memory_block *mem)
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
index bd2570b4f9b7b..d02722bbfcf33 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1069,6 +1069,9 @@ void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
 	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 }
 
+/*
+ * Must be called with mem_hotplug_lock in write mode.
+ */
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       struct zone *zone, struct memory_group *group)
 {
@@ -1089,7 +1092,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
-	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
@@ -1148,7 +1150,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	writeback_set_ratelimit();
 
 	memory_notify(MEM_ONLINE, &arg);
-	mem_hotplug_done();
 	return 0;
 
 failed_addition:
@@ -1157,7 +1158,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
 	memory_notify(MEM_CANCEL_ONLINE, &arg);
 	remove_pfn_range_from_zone(zone, pfn, nr_pages);
-	mem_hotplug_done();
 	return ret;
 }
 
@@ -1787,6 +1787,9 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
+/*
+ * Must be called with mem_hotplug_lock in write mode.
+ */
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group)
 {
@@ -1809,8 +1812,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
-	mem_hotplug_begin();
-
 	/*
 	 * Don't allow to offline memory blocks that contain holes.
 	 * Consequently, memory blocks with holes can never get onlined
@@ -1946,7 +1947,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	memory_notify(MEM_OFFLINE, &arg);
 	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
-	mem_hotplug_done();
 	return 0;
 
 failed_removal_isolated:
@@ -1961,7 +1961,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
 		 reason);
-	mem_hotplug_done();
 	return ret;
 }
 
-- 
2.43.0




