Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8659B7DD515
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376399AbjJaRrH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376382AbjJaRrH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:47:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07E92
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:47:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC61C433C7;
        Tue, 31 Oct 2023 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774424;
        bh=RBYOLeoDJv2LJUEaj1Ba0lo0i4WokhoF9+Xs3jYCEZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtMK1D9APMuMceYvIQLyOH1P51yWkbVLe5YbYnsSbAKJLh/6j4s6E/M31loX6NeGq
         vUo5BrdRLFkUeA9Rh5aWMffoLVeESlLBQQn1JaJEANp+MOZ5aVpbpSa6pL/G9eW2E4
         nS0Guk9fT61+DQS7rRVmCSFiIsWYQ5LZZi/Teji0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 024/112] hugetlbfs: clear resv_map pointer if mmap fails
Date:   Tue, 31 Oct 2023 18:00:25 +0100
Message-ID: <20231031165902.077889936@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rik van Riel <riel@surriel.com>

commit 92fe9dcbe4e109a7ce6bab3e452210a35b0ab493 upstream.

Patch series "hugetlbfs: close race between MADV_DONTNEED and page fault", v7.

Malloc libraries, like jemalloc and tcalloc, take decisions on when to
call madvise independently from the code in the main application.

This sometimes results in the application page faulting on an address,
right after the malloc library has shot down the backing memory with
MADV_DONTNEED.

Usually this is harmless, because we always have some 4kB pages sitting
around to satisfy a page fault.  However, with hugetlbfs systems often
allocate only the exact number of huge pages that the application wants.

Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
any lock taken on the page fault path, which can open up the following
race condition:

       CPU 1                            CPU 2

       MADV_DONTNEED
       unmap page
       shoot down TLB entry
                                       page fault
                                       fail to allocate a huge page
                                       killed with SIGBUS
       free page

Fix that race by extending the hugetlb_vma_lock locking scheme to also
cover private hugetlb mappings (with resv_map), and pulling the locking
from __unmap_hugepage_final_range into helper functions called from
zap_page_range_single.  This ensures page faults stay locked out of the
MADV_DONTNEED VMA until the huge pages have actually been freed.


This patch (of 3):

Hugetlbfs leaves a dangling pointer in the VMA if mmap fails.  This has
not been a problem so far, but other code in this patch series tries to
follow that pointer.

Link: https://lkml.kernel.org/r/20231006040020.3677377-1-riel@surriel.com
Link: https://lkml.kernel.org/r/20231006040020.3677377-2-riel@surriel.com
Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1132,8 +1132,7 @@ static void set_vma_resv_map(struct vm_a
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
 
-	set_vma_private_data(vma, (get_vma_private_data(vma) &
-				HPAGE_RESV_MASK) | (unsigned long)map);
+	set_vma_private_data(vma, (unsigned long)map);
 }
 
 static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
@@ -7015,8 +7014,10 @@ out_err:
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
+		set_vma_resv_map(vma, NULL);
+	}
 	return false;
 }
 


