Return-Path: <stable+bounces-54-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206617F5EA9
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518631C20F90
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E84241FE;
	Thu, 23 Nov 2023 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OdfjyAyw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905E241ED
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2133DC433C8;
	Thu, 23 Nov 2023 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700741055;
	bh=uRQohVlCOR7FQL08JJGJ/I7p5Q4ud9yaML/GqMDcjUg=;
	h=Subject:To:Cc:From:Date:From;
	b=OdfjyAywz4euEs3sg7rdx1lzyJavS7xgQ8HfCIQGqTlEjSr1XwPutdkbfERI/pQO1
	 GpTUMcMX9m/bq7Noc8GXAyeGm9fTr3GxkdeueYcd//x+tmAIZoprWj1ReevaInF2lJ
	 M35LtDkUiPBQvfbBRPS3QXZOEC57cABSxRpOz89Q=
Subject: FAILED: patch "[PATCH] mm/memory_hotplug: use pfn math in place of direct struct" failed to apply to 4.19-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,david@redhat.com,mike.kravetz@oracle.com,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,tsbogend@alpha.franken.de,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:03:53 +0000
Message-ID: <2023112353-revival-badness-110c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1640a0ef80f6d572725f5b0330038c18e98ea168
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112353-revival-badness-110c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1640a0ef80f6 ("mm/memory_hotplug: use pfn math in place of direct struct page manipulation")
aa218795cb5f ("mm: Allow to offline unmovable PageOffline() pages via MEM_GOING_OFFLINE")
fe4c86c916d9 ("mm: remove "count" parameter from has_unmovable_pages()")
3f9903b9ca5e ("mm: remove the memory isolate notifier")
756d25be457f ("mm/page_isolation.c: convert SKIP_HWPOISON to MEMORY_OFFLINE")
d8c6546b1aea ("mm: introduce compound_nr()")
a50b854e073c ("mm: introduce page_size()")
dd625285910d ("drivers/base/memory.c: get rid of find_memory_block_hinted()")
ea8846411ad6 ("mm/memory_hotplug: move and simplify walk_memory_blocks()")
fbcf73ce6582 ("mm/memory_hotplug: rename walk_memory_range() and pass start+size instead of pfns")
90ec010fe0d6 ("drivers/base/memory: use "unsigned long" for block ids")
2491f0a2c0b1 ("mm: section numbers use the type "unsigned long"")
4c4b7f9ba948 ("mm/memory_hotplug: remove memory block devices before arch_remove_memory()")
db051a0dac13 ("mm/memory_hotplug: create memory block devices after arch_add_memory()")
80ec922dbd87 ("mm/memory_hotplug: allow arch_remove_memory() without CONFIG_MEMORY_HOTREMOVE")
1811582587c4 ("drivers/base/memory: pass a block_id to init_memory_block()")
22eb634632a2 ("arm64/mm: add temporary arch_remove_memory() implementation")
eca499ab3749 ("mm/hotplug: make remove_memory() interface usable")
98879b3b9edc ("mm: vmscan: correct some vmscan counters for THP swapout")
aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1640a0ef80f6d572725f5b0330038c18e98ea168 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Wed, 13 Sep 2023 16:12:46 -0400
Subject: [PATCH] mm/memory_hotplug: use pfn math in place of direct struct
 page manipulation

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guaranteed
to be contiguous on SPARSEMEM without VMEMMAP.  Use pfn calculation to
handle it properly.

Without the fix, a wrong number of page might be skipped. Since skip cannot be
negative, scan_movable_page() will end early and might miss a movable page with
-ENOENT. This might fail offline_pages(). No bug is reported. The fix comes
from code inspection.

Link: https://lkml.kernel.org/r/20230913201248.452081-4-zi.yan@sent.com
Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1b03f4ec6fd2..3b301c4023ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 */
 		if (HPageMigratable(head))
 			goto found;
-		skip = compound_nr(head) - (page - head);
+		skip = compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn += skip - 1;
 	}
 	return -ENOENT;


