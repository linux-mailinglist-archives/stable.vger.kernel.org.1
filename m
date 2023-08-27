Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23880789FD4
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjH0OzZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjH0OzW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 10:55:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE0B5
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693148119; x=1724684119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jeF58AELVOfc3hfokcBCXag6pG1i98ss9u7CduLLyno=;
  b=aPl3natekMUHnmjqLQSUNc+AwT3lgG0IVz+SJ1pRf/VHRiwmAFDlFfC4
   c8VooPZCljLwsw/6Qu0SD2kXIW7a/s3DvgxDenzIm1+XanCPp9CWbALyT
   LqXLkXzk+0EucnxkvEaS6I6/PkQqTyu7/exf4AhfIAgnScr0FwBJq5vzq
   PPEnEC2KaG0IGZnhogxcddB0bghtR2RxkntekiKntb+j9CSXylZakknCc
   7sPLggkU9g5GPx6r8dUAmGR7Y7GaLqxurnmTdFmwD67z4wwD2vanYJ6kS
   YBX43VBe5ozymh3L3dhhcXfrIQNV/pw4DyMiAgOBvnVv8+yJx+kB/3ZlF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="374923313"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="374923313"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 07:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="737987321"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="737987321"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by orsmga002.jf.intel.com with ESMTP; 27 Aug 2023 07:55:16 -0700
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
Subject: [PATCH 6.4.y] madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check
Date:   Sun, 27 Aug 2023 22:53:02 +0800
Message-Id: <20230827145302.2407183-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023082614-choice-mongoose-0731@gregkh>
References: <2023082614-choice-mongoose-0731@gregkh>
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
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..584ff190bf90 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -664,8 +664,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
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

