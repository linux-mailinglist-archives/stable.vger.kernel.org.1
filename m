Return-Path: <stable+bounces-16014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F6B83E728
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03812863B9
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500F5C5E5;
	Fri, 26 Jan 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbwIQ0Wo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8455458218
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312409; cv=none; b=Es3NmJTYn3M/Ex1OxGj9rNNoogWl2Y4u2XSvlTaqI21uc8NDKiAkfrDExpVUyVHT7WcVi+qrPfdgizkIhdzOVAE0OgoWDZWgrci1Tw6v+IdWO51Fcq2/FweJVUyLPBAt4kKZUEjDzhcd5mTLYMFmOUUS24xoYcMs5A9N6gBHc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312409; c=relaxed/simple;
	bh=qKVU9Q4a38yEmM3ZhHq5MkZsjqu131PQF52Dw5hzWQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=peFgJJHSmy92G/6j/2jel5yrejns7c29ovV20HqMUa1fB8BUh5TE+s/ESXPiYqL6QNAhzSQGA+l1pGH3grMTQ4XjKRjuvay/21Sggk93wdCaELojoBNpS/7v2gJtupbj4g36C6nOJpJ1SB5J3MFAwz8vq/13kG4lAJliGzyy8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbwIQ0Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C679C433F1;
	Fri, 26 Jan 2024 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312409;
	bh=qKVU9Q4a38yEmM3ZhHq5MkZsjqu131PQF52Dw5hzWQQ=;
	h=Subject:To:Cc:From:Date:From;
	b=NbwIQ0Wocj/XqbkK9ciNpN1AqV1w8yWbJKEnUqM3Uvj6lRQj0/XSLK9yblQ+aQhsT
	 gPnWlvR28HFbT0Nq0gsi7hZjztMiN+VERwOxiT0TiG5i1XBu2rWgSGiKbFLu/XGeBU
	 pD3am/oCK1L0szGbWREGdU1sA72QKyk7ezCoFBnk=
Subject: FAILED: patch "[PATCH] mm/sparsemem: fix race in accessing memory_section->usage" failed to apply to 5.4-stable tree
To: quic_charante@quicinc.com,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,dan.j.williams@intel.com,david@redhat.com,mgorman@techsingularity.net,osalvador@suse.de,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:40:08 -0800
Message-ID: <2024012608-bonanza-edition-993c@gregkh>
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
git cherry-pick -x 5ec8e8ea8b7783fab150cf86404fc38cb4db8800
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012608-bonanza-edition-993c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")
f1dc0db296bd ("mm: use __pfn_to_section() instead of open coding it")
0a9f9f623166 ("mm/sparse.c: only use subsection map in VMEMMAP case")
37bc15020a96 ("mm/sparse.c: introduce a new function clear_subsection_map()")
5d87255cadde ("mm/sparse.c: introduce new function fill_subsection_map()")
b943f045a9af ("mm/sparse: fix kernel crash with pfn_section_valid check")
d41e2f3bd546 ("mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case")
1f503443e7df ("mm/sparse.c: reset section's mem_map when fully deactivated")
8068df3b6037 ("mm/memory_hotplug: don't free usage map when removing a re-added early section")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ec8e8ea8b7783fab150cf86404fc38cb4db8800 Mon Sep 17 00:00:00 2001
From: Charan Teja Kalla <quic_charante@quicinc.com>
Date: Fri, 13 Oct 2023 18:34:27 +0530
Subject: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage

The below race is observed on a PFN which falls into the device memory
region with the system memory configuration where PFN's are such that
[ZONE_NORMAL ZONE_DEVICE ZONE_NORMAL].  Since normal zone start and end
pfn contains the device memory PFN's as well, the compaction triggered
will try on the device memory PFN's too though they end up in NOP(because
pfn_to_online_page() returns NULL for ZONE_DEVICE memory sections).  When
from other core, the section mappings are being removed for the
ZONE_DEVICE region, that the PFN in question belongs to, on which
compaction is currently being operated is resulting into the kernel crash
with CONFIG_SPASEMEM_VMEMAP enabled.  The crash logs can be seen at [1].

compact_zone()			memunmap_pages
-------------			---------------
__pageblock_pfn_to_page
   ......
 (a)pfn_valid():
     valid_section()//return true
			      (b)__remove_pages()->
				  sparse_remove_section()->
				    section_deactivate():
				    [Free the array ms->usage and set
				     ms->usage = NULL]
     pfn_section_valid()
     [Access ms->usage which
     is NULL]

NOTE: From the above it can be said that the race is reduced to between
the pfn_valid()/pfn_section_valid() and the section deactivate with
SPASEMEM_VMEMAP enabled.

The commit b943f045a9af("mm/sparse: fix kernel crash with
pfn_section_valid check") tried to address the same problem by clearing
the SECTION_HAS_MEM_MAP with the expectation of valid_section() returns
false thus ms->usage is not accessed.

Fix this issue by the below steps:

a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.

b) RCU protected read side critical section will either return NULL
   when SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.

c) Free the ->usage with kfree_rcu() and set ms->usage = NULL.  No
   attempt will be made to access ->usage after this as the
   SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.

Thanks to David/Pavan for their inputs on this patch.

[1] https://lore.kernel.org/linux-mm/994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com/

On Snapdragon SoC, with the mentioned memory configuration of PFN's as
[ZONE_NORMAL ZONE_DEVICE ZONE_NORMAL], we are able to see bunch of
issues daily while testing on a device farm.

For this particular issue below is the log.  Though the below log is
not directly pointing to the pfn_section_valid(){ ms->usage;}, when we
loaded this dump on T32 lauterbach tool, it is pointing.

[  540.578056] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  540.578068] Mem abort info:
[  540.578070]   ESR = 0x0000000096000005
[  540.578073]   EC = 0x25: DABT (current EL), IL = 32 bits
[  540.578077]   SET = 0, FnV = 0
[  540.578080]   EA = 0, S1PTW = 0
[  540.578082]   FSC = 0x05: level 1 translation fault
[  540.578085] Data abort info:
[  540.578086]   ISV = 0, ISS = 0x00000005
[  540.578088]   CM = 0, WnR = 0
[  540.579431] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBSBTYPE=--)
[  540.579436] pc : __pageblock_pfn_to_page+0x6c/0x14c
[  540.579454] lr : compact_zone+0x994/0x1058
[  540.579460] sp : ffffffc03579b510
[  540.579463] x29: ffffffc03579b510 x28: 0000000000235800 x27:000000000000000c
[  540.579470] x26: 0000000000235c00 x25: 0000000000000068 x24:ffffffc03579b640
[  540.579477] x23: 0000000000000001 x22: ffffffc03579b660 x21:0000000000000000
[  540.579483] x20: 0000000000235bff x19: ffffffdebf7e3940 x18:ffffffdebf66d140
[  540.579489] x17: 00000000739ba063 x16: 00000000739ba063 x15:00000000009f4bff
[  540.579495] x14: 0000008000000000 x13: 0000000000000000 x12:0000000000000001
[  540.579501] x11: 0000000000000000 x10: 0000000000000000 x9 :ffffff897d2cd440
[  540.579507] x8 : 0000000000000000 x7 : 0000000000000000 x6 :ffffffc03579b5b4
[  540.579512] x5 : 0000000000027f25 x4 : ffffffc03579b5b8 x3 :0000000000000001
[  540.579518] x2 : ffffffdebf7e3940 x1 : 0000000000235c00 x0 :0000000000235800
[  540.579524] Call trace:
[  540.579527]  __pageblock_pfn_to_page+0x6c/0x14c
[  540.579533]  compact_zone+0x994/0x1058
[  540.579536]  try_to_compact_pages+0x128/0x378
[  540.579540]  __alloc_pages_direct_compact+0x80/0x2b0
[  540.579544]  __alloc_pages_slowpath+0x5c0/0xe10
[  540.579547]  __alloc_pages+0x250/0x2d0
[  540.579550]  __iommu_dma_alloc_noncontiguous+0x13c/0x3fc
[  540.579561]  iommu_dma_alloc+0xa0/0x320
[  540.579565]  dma_alloc_attrs+0xd4/0x108

[quic_charante@quicinc.com: use kfree_rcu() in place of synchronize_rcu(), per David]
  Link: https://lkml.kernel.org/r/1698403778-20938-1-git-send-email-quic_charante@quicinc.com
Link: https://lkml.kernel.org/r/1697202267-23600-1-git-send-email-quic_charante@quicinc.com
Fixes: f46edbd1b151 ("mm/sparsemem: add helpers track active portions of a section at boot")
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ec73582e7d27..2efd3be484fd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1799,6 +1799,7 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+	struct rcu_head rcu;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
@@ -1992,7 +1993,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
 
-	return test_bit(idx, ms->usage->subsection_map);
+	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
@@ -2016,6 +2017,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
+	int ret;
 
 	/*
 	 * Ensure the upper PAGE_SHIFT bits are clear in the
@@ -2029,13 +2031,19 @@ static inline int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-	if (!valid_section(ms))
+	rcu_read_lock();
+	if (!valid_section(ms)) {
+		rcu_read_unlock();
 		return 0;
+	}
 	/*
 	 * Traditionally early sections always returned pfn_valid() for
 	 * the entire section-sized span.
 	 */
-	return early_section(ms) || pfn_section_valid(ms, pfn);
+	ret = early_section(ms) || pfn_section_valid(ms, pfn);
+	rcu_read_unlock();
+
+	return ret;
 }
 #endif
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..338cf946dee8 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -791,6 +791,13 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
+		/*
+		 * Mark the section invalid so that valid_section()
+		 * return false. This prevents code from dereferencing
+		 * ms->usage array.
+		 */
+		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
+
 		/*
 		 * When removing an early section, the usage map is kept (as the
 		 * usage maps of other sections fall into the same page). It
@@ -799,16 +806,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
-			kfree(ms->usage);
-			ms->usage = NULL;
+			kfree_rcu(ms->usage, rcu);
+			WRITE_ONCE(ms->usage, NULL);
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-		/*
-		 * Mark the section invalid so that valid_section()
-		 * return false. This prevents code from dereferencing
-		 * ms->usage array.
-		 */
-		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
 	}
 
 	/*


