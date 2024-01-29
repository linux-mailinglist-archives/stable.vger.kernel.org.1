Return-Path: <stable+bounces-16552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60130840D70
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67441F2C941
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22315704E;
	Mon, 29 Jan 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EnZByGRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DEE1586DB;
	Mon, 29 Jan 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548104; cv=none; b=YnVpVUnDOY7nZ+v7KvlmXgyEB2zN3tvSSpOC+xCugFAXYjReoWvJsuj1drh7y1ZNQl7rfF+6tPcsQ9NWLbpb3oqHHJeKkMEmfp7kdqz3D3DJ3kYFRdJXxnUEWRWEG/bNsz+eX7/TSbQPH5nmMxAc78bBLVhcbcN8ERatoktLrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548104; c=relaxed/simple;
	bh=+3R91bTp2qyNo1gNHFxu9UfFbBGEV+Hy4dhe2PhYsr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6pENY53sU783DCkVkD3zp1fQP17B3tNU4Jxbta2Da/3HLbhRUElUQ0S+QZBKCxvAq2X7K97OFXIkgqSmi0Uo0w6wsyk3t21VjsEBBvhnTlTEJB0vGhrWNAJhxmVDf/uSU6blToTOQW5Pm2ezeQAvgG1UcG5Ww1UMhkFFAvvfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EnZByGRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B51C433C7;
	Mon, 29 Jan 2024 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548104;
	bh=+3R91bTp2qyNo1gNHFxu9UfFbBGEV+Hy4dhe2PhYsr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnZByGRJOy+qLyP53vorPCAwAmmEw+KwYX2LgZliD0eqgFQxCxdgNidIMK0mZRdQt
	 QjoJe3mnt9QYh0N0AcMouCE1UW4PaobkQYKKnGUAOQTufuOgwcSPlJkf8JRrO63zaw
	 tpvlz3nqkE4x/kd97VKqmsZzn0tvfiXgAExU1gjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.7 125/346] mm/sparsemem: fix race in accessing memory_section->usage
Date: Mon, 29 Jan 2024 09:02:36 -0800
Message-ID: <20240129170020.057681007@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charan Teja Kalla <quic_charante@quicinc.com>

commit 5ec8e8ea8b7783fab150cf86404fc38cb4db8800 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mmzone.h |   14 +++++++++++---
 mm/sparse.c            |   17 +++++++++--------
 2 files changed, 20 insertions(+), 11 deletions(-)

--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1793,6 +1793,7 @@ static inline unsigned long section_nr_t
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+	struct rcu_head rcu;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
@@ -1986,7 +1987,7 @@ static inline int pfn_section_valid(stru
 {
 	int idx = subsection_map_index(pfn);
 
-	return test_bit(idx, ms->usage->subsection_map);
+	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
@@ -2010,6 +2011,7 @@ static inline int pfn_section_valid(stru
 static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
+	int ret;
 
 	/*
 	 * Ensure the upper PAGE_SHIFT bits are clear in the
@@ -2023,13 +2025,19 @@ static inline int pfn_valid(unsigned lon
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
 
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -792,6 +792,13 @@ static void section_deactivate(unsigned
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
 		/*
+		 * Mark the section invalid so that valid_section()
+		 * return false. This prevents code from dereferencing
+		 * ms->usage array.
+		 */
+		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
+
+		/*
 		 * When removing an early section, the usage map is kept (as the
 		 * usage maps of other sections fall into the same page). It
 		 * will be re-used when re-adding the section - which is then no
@@ -799,16 +806,10 @@ static void section_deactivate(unsigned
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



