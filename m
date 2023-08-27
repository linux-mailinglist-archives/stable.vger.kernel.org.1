Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8E789FC2
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjH0OfD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjH0Oet (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 10:34:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D16911C
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693146887; x=1724682887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFCNgKLif0LJIT8CcrRHVpjecz3E00CPio84hNZ/G6Q=;
  b=R5yN5T8h+Ay9IHMgLuM9r6DynZ9N1K6Yh58XA6hXLFdzSTXFSdrb7J/d
   nkcYqLxkC7DCJZdcb04O4jyv7ioNeIYuCZe0KiAYDZOkhRMM20+WhqN/1
   58yZCxLSjQ5i3MwiYTtMk8kOlyi/xEafyeBIP3n3CyZWW7FwQXPuDVoT3
   faa2stN0NUeb7HaiFBxV6JAkeQ7ho4i2psbjCqsAvEOEIVmVzy/zFueIH
   aL4V+G0M2ta9Lu1SQPJjrLVEX+tlh3F8RdiOCoNcnavxZuw/uN5ZT/0re
   umtvROTLd7860JmoI8NFxQ8BBekqXOnxI7sfXBAJdKsd+q0sAnyphXV8r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="359940843"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="359940843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 07:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="714856936"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="714856936"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2023 07:34:44 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     stable@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Vishal Moola <vishal.moola@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check
Date:   Sun, 27 Aug 2023 22:32:30 +0800
Message-Id: <20230827143230.2325435-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023082616-velocity-mocha-97c0@gregkh>
References: <2023082616-velocity-mocha-97c0@gregkh>
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

Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a
folio") replaced the page_mapcount() with folio_mapcount() to check
whether the folio is shared by other mapping.

It's not correct for large folios. folio_mapcount() returns the total
mapcount of large folio which is not suitable to detect whether the folio
is shared.

Use folio_estimated_sharers() which returns a estimated number of shares.
That means it's not 100% correct. It should be OK for madvise case here.

User-visible effects is that the THP is skipped when user call madvise.
But the correct behavior is THP should be split and processed then.

NOTE: this change is a temporary fix to reduce the user-visible effects
before the long term fix from David is ready.

Link: https://lkml.kernel.org/r/20230808020917.2230692-4-fengwei.yin@intel.com
Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a folio")
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
(cherry picked from commit 0e0e9bd5f7b9d40fd03b70092367247d52da1db0)
---
 include/linux/mm.h | 19 +++++++++++++++++++
 mm/madvise.c       |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b8ed44f401b5..983ae8b31e31 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1727,6 +1727,25 @@ static inline size_t folio_size(struct folio *folio)
 	return PAGE_SIZE << folio_order(folio);
 }
 
+/**
+ * folio_estimated_sharers - Estimate the number of sharers of a folio.
+ * @folio: The folio.
+ *
+ * folio_estimated_sharers() aims to serve as a function to efficiently
+ * estimate the number of processes sharing a folio. This is done by
+ * looking at the precise mapcount of the first subpage in the folio, and
+ * assuming the other subpages are the same. This may not be true for large
+ * folios. If you want exact mapcounts for exact calculations, look at
+ * page_mapcount() or folio_total_mapcount().
+ *
+ * Return: The estimated number of processes sharing a folio.
+ */
+static inline int folio_estimated_sharers(struct folio *folio)
+{
+	return page_mapcount(folio_page(folio, 0));
+}
+
+
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 static inline int arch_make_page_accessible(struct page *page)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index d03e149ffe6e..5973399b2f9b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -654,8 +654,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 * deactivate all pages.
 		 */
 		if (folio_test_large(folio)) {
-			if (folio_mapcount(folio) != 1)
-				goto out;
+			if (folio_estimated_sharers(folio) != 1)
+				break;
 			folio_get(folio);
 			if (!folio_trylock(folio)) {
 				folio_put(folio);
-- 
2.39.2

