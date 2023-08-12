Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7106F779D81
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHLGKI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLGKH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7052D7
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5921264505
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5FEC433C7;
        Sat, 12 Aug 2023 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820605;
        bh=wgkhfMM3XoTSk0En3pqt+hwNd6+GkjiHE0GNGtg54aE=;
        h=Subject:To:Cc:From:Date:From;
        b=HEqngW6jYz9IcBQEqP/qwCMwITevLzTGVEPWg5H+nxE1umMeUaDm0WbyfP6YIeZrX
         JFZu0+tABpDqW+d9hA3sV1Z1+gl46dY4ADndIYCkwZvEKWbD3vwWBPUStGaPJbKn2K
         yj9KhM4Kn4UDmL1L4eqhgL8alRzba8n5OvxMk83s=
Subject: FAILED: patch "[PATCH] hugetlb: do not clear hugetlb dtor until allocating vmemmap" failed to apply to 6.1-stable tree
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        axelrasmussen@google.com, jiaqiyan@google.com,
        jthoughton@google.com, linmiaohe@huawei.com, mhocko@suse.com,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:10:03 +0200
Message-ID: <2023081202-unloader-t-shirt-eb23@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 32c877191e022b55fe3a374f3d7e9fb5741c514d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081202-unloader-t-shirt-eb23@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
d6ef19e25df2 ("mm/hugetlb: convert update_and_free_page() to folios")
cfd5082b5147 ("mm/hugetlb: convert remove_hugetlb_page() to folios")
1a7cdab59b22 ("mm/hugetlb: convert dissolve_free_huge_page() to folios")
911565b82853 ("mm/hugetlb: convert destroy_compound_gigantic_page() to folios")
cb67f4282bf9 ("mm,thp,rmap: simplify compound page mapcount handling")
dad6a5eb5556 ("mm,hugetlb: use folio fields in second tail page")
0356c4b96f68 ("mm/hugetlb: convert free_huge_page to folios")
de656ed376c4 ("mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios")
f074732d599e ("mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios")
a098c977722c ("mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios")
4781593d5dba ("mm/hugetlb: unify clearing of RestoreReserve for private pages")
149562f75094 ("mm/hugetlb: add hugetlb_folio_subpool() helpers")
d340625f4849 ("mm: add private field of first tail to struct page and struct folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32c877191e022b55fe3a374f3d7e9fb5741c514d Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 11 Jul 2023 15:09:41 -0700
Subject: [PATCH] hugetlb: do not clear hugetlb dtor until allocating vmemmap

Patch series "Fix hugetlb free path race with memory errors".

In the discussion of Jiaqi Yan's series "Improve hugetlbfs read on
HWPOISON hugepages" the race window was discovered.
https://lore.kernel.org/linux-mm/20230616233447.GB7371@monkey/

Freeing a hugetlb page back to low level memory allocators is performed
in two steps.
1) Under hugetlb lock, remove page from hugetlb lists and clear destructor
2) Outside lock, allocate vmemmap if necessary and call low level free
Between these two steps, the hugetlb page will appear as a normal
compound page.  However, vmemmap for tail pages could be missing.
If a memory error occurs at this time, we could try to update page
flags non-existant page structs.

A much more detailed description is in the first patch.

The first patch addresses the race window.  However, it adds a
hugetlb_lock lock/unlock cycle to every vmemmap optimized hugetlb page
free operation.  This could lead to slowdowns if one is freeing a large
number of hugetlb pages.

The second path optimizes the update_and_free_pages_bulk routine to only
take the lock once in bulk operations.

The second patch is technically not a bug fix, but includes a Fixes tag
and Cc stable to avoid a performance regression.  It can be combined with
the first, but was done separately make reviewing easier.


This patch (of 2):

Freeing a hugetlb page and releasing base pages back to the underlying
allocator such as buddy or cma is performed in two steps:
- remove_hugetlb_folio() is called to remove the folio from hugetlb
  lists, get a ref on the page and remove hugetlb destructor.  This
  all must be done under the hugetlb lock.  After this call, the page
  can be treated as a normal compound page or a collection of base
  size pages.
- update_and_free_hugetlb_folio() is called to allocate vmemmap if
  needed and the free routine of the underlying allocator is called
  on the resulting page.  We can not hold the hugetlb lock here.

One issue with this scheme is that a memory error could occur between
these two steps.  In this case, the memory error handling code treats
the old hugetlb page as a normal compound page or collection of base
pages.  It will then try to SetPageHWPoison(page) on the page with an
error.  If the page with error is a tail page without vmemmap, a write
error will occur when trying to set the flag.

Address this issue by modifying remove_hugetlb_folio() and
update_and_free_hugetlb_folio() such that the hugetlb destructor is not
cleared until after allocating vmemmap.  Since clearing the destructor
requires holding the hugetlb lock, the clearing is done in
remove_hugetlb_folio() if the vmemmap is present.  This saves a
lock/unlock cycle.  Otherwise, destructor is cleared in
update_and_free_hugetlb_folio() after allocating vmemmap.

Note that this will leave hugetlb pages in a state where they are marked
free (by hugetlb specific page flag) and have a ref count.  This is not
a normal state.  The only code that would notice is the memory error
code, and it is set up to retry in such a case.

A subsequent patch will create a routine to do bulk processing of
vmemmap allocation.  This will eliminate a lock/unlock cycle for each
hugetlb page in the case where we are freeing a large number of pages.

Link: https://lkml.kernel.org/r/20230711220942.43706-1-mike.kravetz@oracle.com
Link: https://lkml.kernel.org/r/20230711220942.43706-2-mike.kravetz@oracle.com
Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..6da626bfb52e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
+static inline void __clear_hugetlb_destructor(struct hstate *h,
+						struct folio *folio)
+{
+	lockdep_assert_held(&hugetlb_lock);
+
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 */
+	if (hstate_is_gigantic(h))
+		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
+	else
+		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
+}
+
 /*
- * Remove hugetlb folio from lists, and update dtor so that the folio appears
- * as just a compound page.
+ * Remove hugetlb folio from lists.
+ * If vmemmap exists for the folio, update dtor so that the folio appears
+ * as just a compound page.  Otherwise, wait until after allocating vmemmap
+ * to update dtor.
  *
  * A reference is held on the folio, except in the case of demote.
  *
@@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	}
 
 	/*
-	 * Very subtle
-	 *
-	 * For non-gigantic pages set the destructor to the normal compound
-	 * page dtor.  This is needed in case someone takes an additional
-	 * temporary ref to the page, and freeing is delayed until they drop
-	 * their reference.
-	 *
-	 * For gigantic pages set the destructor to the null dtor.  This
-	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_folio will turn the folio into a
-	 * simple group of pages.  After this the destructor does not
-	 * apply.
-	 *
-	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_hugetlb_folio is called.
-	 *
-	 * In the case of demote we do not ref count the page as it will soon
-	 * be turned into a page of smaller size.
+	 * We can only clear the hugetlb destructor after allocating vmemmap
+	 * pages.  Otherwise, someone (memory error handling) may try to write
+	 * to tail struct pages.
+	 */
+	if (!folio_test_hugetlb_vmemmap_optimized(folio))
+		__clear_hugetlb_destructor(h, folio);
+
+	 /*
+	  * In the case of demote we do not ref count the page as it will soon
+	  * be turned into a page of smaller size.
 	 */
 	if (!demote)
 		folio_ref_unfreeze(folio, 1);
-	if (hstate_is_gigantic(h))
-		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
-	else
-		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1705,6 +1721,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	int i;
 	struct page *subpage;
+	bool clear_dtor = folio_test_hugetlb_vmemmap_optimized(folio);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1735,6 +1752,16 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	if (unlikely(folio_test_hwpoison(folio)))
 		folio_clear_hugetlb_hwpoison(folio);
 
+	/*
+	 * If vmemmap pages were allocated above, then we need to clear the
+	 * hugetlb destructor under the hugetlb lock.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = folio_page(folio, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |

