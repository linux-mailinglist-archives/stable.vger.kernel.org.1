Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD17B8DFA
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjJDUXC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbjJDUWa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 16:22:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ED31981;
        Wed,  4 Oct 2023 13:21:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD76C433C8;
        Wed,  4 Oct 2023 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696450912;
        bh=GNS6BSFj6u2Xy5tBd1EB4TiDf/VVcuu/3YFfEVqIK80=;
        h=Date:To:From:Subject:From;
        b=pMdCFiDp4M5KLV2aVBVraXpOdlDlWRcmOchxXxcxnshY2CQZHzRsQbF8GrRf+1BoB
         JvunuOGnbv6J7Hoc/+BGBzD9ZHTL5k6Sr+UPJ4enyTfAlEQjra2M1WUWebX7jb6v5A
         PDaIgX5NpiqLNFZGIkwJSaDddWgivm6ynfU/liiI=
Date:   Wed, 04 Oct 2023 13:21:50 -0700
To:     mm-commits@vger.kernel.org, willy@infradead.org,
        tsbogend@alpha.franken.de, stable@vger.kernel.org,
        songmuchun@bytedance.com, rppt@kernel.org, mike.kravetz@oracle.com,
        david@redhat.com, ziy@nvidia.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] fs-use-nth_page-in-place-of-direct-struct-page-manipulation.patch removed from -mm tree
Message-Id: <20231004202152.2CD76C433C8@smtp.kernel.org>
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
     Subject: fs: use nth_page() in place of direct struct page manipulation
has been removed from the -mm tree.  Its filename was
     fs-use-nth_page-in-place-of-direct-struct-page-manipulation.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Zi Yan <ziy@nvidia.com>
Subject: fs: use nth_page() in place of direct struct page manipulation
Date: Wed, 13 Sep 2023 16:12:47 -0400

When dealing with hugetlb pages, struct page is not guaranteed to be
contiguous on SPARSEMEM without VMEMMAP.  Use nth_page() to handle it
properly.

Without the fix, a wrong subpage might be checked for HWPoison, causing wrong
number of bytes of a page copied to user space. No bug is reported. The fix
comes from code inspection.

Link: https://lkml.kernel.org/r/20230913201248.452081-5-zi.yan@sent.com
Fixes: 38c1ddbde6c6 ("hugetlbfs: improve read HWPOISON hugepage")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/hugetlbfs/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/hugetlbfs/inode.c~fs-use-nth_page-in-place-of-direct-struct-page-manipulation
+++ a/fs/hugetlbfs/inode.c
@@ -295,7 +295,7 @@ static size_t adjust_range_hwpoison(stru
 	size_t res = 0;
 
 	/* First subpage to start the loop. */
-	page += offset / PAGE_SIZE;
+	page = nth_page(page, offset / PAGE_SIZE);
 	offset %= PAGE_SIZE;
 	while (1) {
 		if (is_raw_hwpoison_page_in_hugepage(page))
@@ -309,7 +309,7 @@ static size_t adjust_range_hwpoison(stru
 			break;
 		offset += n;
 		if (offset == PAGE_SIZE) {
-			page++;
+			page = nth_page(page, 1);
 			offset = 0;
 		}
 	}
_

Patches currently in -mm which might be from ziy@nvidia.com are


