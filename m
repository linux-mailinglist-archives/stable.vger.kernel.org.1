Return-Path: <stable+bounces-5140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD89580B43C
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F110C1C20A72
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA911184;
	Sat,  9 Dec 2023 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wheLNHsk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9D187C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57F1C433C9;
	Sat,  9 Dec 2023 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702125367;
	bh=Ntttwa8XdS+qPPpn9rAZybHAiloO3AMhG7Z5opPJIP4=;
	h=Subject:To:Cc:From:Date:From;
	b=wheLNHsk17a+jaKBLPECyYf3lk2gcCxrA7xScYHoNhoGCQQavkDKsu75obYRqRbgg
	 fFF9p//0zakZD/TygRTD2uoCRUmblF5Yypgk8/hipAye4gqBJk2tX29WVmrXV5/rnX
	 fPQ6d67yldL/j8lVQkwEhF12BSdIlC5ONvHmRnZI=
Subject: FAILED: patch "[PATCH] mm/memory_hotplug: fix error handling in" failed to apply to 5.15-stable tree
To: sumanthk@linux.ibm.com,agordeev@linux.ibm.com,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,anshuman.khandual@arm.com,david@redhat.com,gerald.schaefer@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com,lkp@intel.com,mhocko@suse.com,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:36:04 +0100
Message-ID: <2023120904-duffel-joining-636f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f42ce5f087eb69e47294ababd2e7e6f88a82d308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120904-duffel-joining-636f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f42ce5f087eb ("mm/memory_hotplug: fix error handling in add_memory_resource()")
1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
2d1f649c7c08 ("mm/memory_hotplug: support memmap_on_memory when memmap is not aligned to pageblocks")
85a2b4b08f20 ("mm/memory_hotplug: allow architecture to override memmap on memory support check")
e3c2bfdd33a3 ("mm/memory_hotplug: allow memmap on memory hotplug request to fallback")
66361095129b ("mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory")
78f39084b41d ("mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl")
9c54c522bb76 ("mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing")
6e02c46b4d97 ("mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on")
0effdf461c57 ("mm: hugetlb_vmemmap: disable hugetlb_optimize_vmemmap when struct page crosses page boundaries")
47010c040dec ("mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*")
f10f1442c309 ("mm: hugetlb_vmemmap: cleanup hugetlb_free_vmemmap_enabled*")
5981611d0a00 ("mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related functions")
1e63ac088f20 ("arm64: mm: hugetlb: enable HUGETLB_PAGE_FREE_VMEMMAP for arm64")
2e4ec02bbcc0 ("mm: hugetlb_vmemmap: introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP")
2aa065f7afb2 ("drivers/base/memory: clarify adding and removing of memory blocks")
395f6081bad4 ("drivers/base/memory: determine and store zone for single-zone memory blocks")
7ea0d2d79da0 ("drivers/base/memory: add memory block to memory group after registration succeeded")
e54084173487 ("mm: sparsemem: move vmemmap related to HugeTLB to CONFIG_HUGETLB_PAGE_FREE_VMEMMAP")
a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f42ce5f087eb69e47294ababd2e7e6f88a82d308 Mon Sep 17 00:00:00 2001
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Date: Mon, 20 Nov 2023 15:53:53 +0100
Subject: [PATCH] mm/memory_hotplug: fix error handling in
 add_memory_resource()

In add_memory_resource(), creation of memory block devices occurs after
successful call to arch_add_memory().  However, creation of memory block
devices could fail.  In that case, arch_remove_memory() is called to
perform necessary cleanup.

Currently with or without altmap support, arch_remove_memory() is always
passed with altmap set to NULL during error handling.  This leads to
freeing of struct pages using free_pages(), eventhough the allocation
might have been performed with altmap support via
altmap_alloc_block_buf().

Fix the error handling by passing altmap in arch_remove_memory(). This
ensures the following:
* When altmap is disabled, deallocation of the struct pages array occurs
  via free_pages().
* When altmap is enabled, deallocation occurs via vmem_altmap_free().

Link: https://lkml.kernel.org/r/20231120145354.308999-3-sumanthk@linux.ibm.com
Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bb908289679e..7a5fc89a8652 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1458,7 +1458,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/* create memory block devices after memory was added */
 	ret = create_memory_block_devices(start, size, params.altmap, group);
 	if (ret) {
-		arch_remove_memory(start, size, NULL);
+		arch_remove_memory(start, size, params.altmap);
 		goto error_free;
 	}
 


