Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1118789FAE
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjH0Nyv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjH0Nyb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 09:54:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5312E
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693144468; x=1724680468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gOa2BNaEtR20yuUAbnvHtMItfKbUC364UnPJX+o2Q2M=;
  b=ImIqmraqDwfG1D2kTF39vLDRBcYNfa23VdvaG/qJk+5Hmk6rbwLi39IP
   k0k1n1i7nVOVK3AMvU7SqfyUE8MqUobyLgiy+6WJujwiv8T3gHasL9NEq
   BWAnJ60ZiyICBKFbcn0cCbdR4Yu81we9JN6AI9721bWKmeICvs3Y5K/WB
   Rd8FjvTOaUfXG0iMpidXOGhKo0G3jdomxVb53k3WLE+TNhLL/f5lu/MtB
   Ob+q2/WJd7v7J1SA5fFAHBMsm8Oax2VjgVE3OmhSG2Ibmy6/aEF5hqzj7
   2kNcnaPRdEqxX0zKC2LqFqM/w556z2/DjUQlScumeDxCLShlFs6mP4tW0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="441292025"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="441292025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:54:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="767401793"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="767401793"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2023 06:54:24 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     fengwei.yin@intel.com
Cc:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Vishal Moola <vishal.moola@gmail.com>,
        Yang Shi <shy828301@gmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4.12] madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
Date:   Sun, 27 Aug 2023 21:52:11 +0800
Message-Id: <20230827135211.2115099-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Patch series "don't use mapcount() to check large folio sharing", v2.

In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
folio_mapcount() is used to check whether the folio is shared.  But it's
not correct as folio_mapcount() returns total mapcount of large folio.

Use folio_estimated_sharers() here as the estimated number is enough.

This patchset will fix the cases:
User space application call madvise() with MADV_FREE, MADV_COLD and
MADV_PAGEOUT for specific address range. There are THP mapped to the
range. Without the patchset, the THP is skipped. With the patch, the
THP will be split and handled accordingly.

David reported the cow self test skip some cases because of MADV_PAGEOUT
skip THP:
https://lore.kernel.org/linux-mm/9e92e42d-488f-47db-ac9d-75b24cd0d037@intel.com/T/#mbf0f2ec7fbe45da47526de1d7036183981691e81
and I confirmed this patchset make it work again.

This patch (of 3):

Commit 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range()
to use folios") replaced the page_mapcount() with folio_mapcount() to
check whether the folio is shared by other mapping.

It's not correct for large folio.  folio_mapcount() returns the total
mapcount of large folio which is not suitable to detect whether the folio
is shared.

Use folio_estimated_sharers() which returns a estimated number of shares.
That means it's not 100% correct.  It should be OK for madvise case here.

User-visible effects is that the THP is skipped when user call madvise.
But the correct behavior is THP should be split and processed then.

NOTE: this change is a temporary fix to reduce the user-visible effects
before the long term fix from David is ready.

Link: https://lkml.kernel.org/r/20230808020917.2230692-1-fengwei.yin@intel.com
Link: https://lkml.kernel.org/r/20230808020917.2230692-2-fengwei.yin@intel.com
Fixes: 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 2f406263e3e954aa24c1248edcfa9be0c1bb30fa)
---
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..6adee363a9fa 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -375,7 +375,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapcount(folio) != 1)
+		if (folio_estimated_sharers(folio) != 1)
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -447,7 +447,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * are sure it's worth. Split it if we are only owner.
 		 */
 		if (folio_test_large(folio)) {
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
-- 
2.39.2

