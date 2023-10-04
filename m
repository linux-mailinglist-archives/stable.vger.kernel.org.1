Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8F7B8DF9
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbjJDUXC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244951AbjJDUW3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 16:22:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7B1980;
        Wed,  4 Oct 2023 13:21:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DFCC433C8;
        Wed,  4 Oct 2023 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696450910;
        bh=P1T3tX3cWJfWmmcvFahcE/Wp2JopScpt3rU1DWxwsAo=;
        h=Date:To:From:Subject:From;
        b=gWUhPZNaoau+8j8LyMf0bfIlFIYHKT8GkRLOUOGIWgZ/Cc1GkdlBPFcflphM8PZX5
         5kwpwVLvLNCHGr4T3qA6/dWyxEiQ1PV3azJ+zzXz9YAhDSwMUDnRgOrbZ5eTscQ3mD
         sHdlZZ7OiI/42VFEdMDvzYCVVGNfKOaBMecMMTXE=
Date:   Wed, 04 Oct 2023 13:21:48 -0700
To:     mm-commits@vger.kernel.org, willy@infradead.org,
        tsbogend@alpha.franken.de, stable@vger.kernel.org,
        songmuchun@bytedance.com, rppt@kernel.org, mike.kravetz@oracle.com,
        david@redhat.com, ziy@nvidia.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-memory_hotplug-use-pfn-math-in-place-of-direct-struct-page-manipulation.patch removed from -mm tree
Message-Id: <20231004202149.E1DFCC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm/memory_hotplug: use pfn math in place of direct struct page manipulation
has been removed from the -mm tree.  Its filename was
     mm-memory_hotplug-use-pfn-math-in-place-of-direct-struct-page-manipulation.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Zi Yan <ziy@nvidia.com>
Subject: mm/memory_hotplug: use pfn math in place of direct struct page manipulation
Date: Wed, 13 Sep 2023 16:12:46 -0400

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
---

 mm/memory_hotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory_hotplug.c~mm-memory_hotplug-use-pfn-math-in-place-of-direct-struct-page-manipulation
+++ a/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned l
 		 */
 		if (HPageMigratable(head))
 			goto found;
-		skip = compound_nr(head) - (page - head);
+		skip = compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn += skip - 1;
 	}
 	return -ENOENT;
_

Patches currently in -mm which might be from ziy@nvidia.com are


