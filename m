Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30A789904
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHZU0s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHZU03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF2BE50
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 750BE60E55
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821F8C433C7;
        Sat, 26 Aug 2023 20:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693081585;
        bh=Ep4b5JoBWh/GK8UhDddj03iRb3cYirwirPTdskbEjZw=;
        h=Subject:To:Cc:From:Date:From;
        b=oJdIvisVSX7AVKU/W5BYJJtSRsGaLXFQykLDQ7iQIBrHSfsIT+AnNwzmC0D9NsRmd
         fwbVZeD6ri3cAkEsg1yoU9/QZyRk571+OVhKzVwvH63mPw1xLjrVIpI998rRndxZQb
         ywEvK2irn/RXi/cpHOg3Yeom+O3G29jgapimbNig=
Subject: FAILED: patch "[PATCH] madvise:madvise_cold_or_pageout_pte_range(): don't use" failed to apply to 6.4-stable tree
To:     fengwei.yin@intel.com, akpm@linux-foundation.org, david@redhat.com,
        minchan@kernel.org, ryan.roberts@arm.com, shy828301@gmail.com,
        stable@vger.kernel.org, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, yuzhao@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 22:26:20 +0200
Message-ID: <2023082620-overact-feisty-c309@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2f406263e3e954aa24c1248edcfa9be0c1bb30fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082620-overact-feisty-c309@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f406263e3e954aa24c1248edcfa9be0c1bb30fa Mon Sep 17 00:00:00 2001
From: Yin Fengwei <fengwei.yin@intel.com>
Date: Tue, 8 Aug 2023 10:09:15 +0800
Subject: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): don't use
 mapcount() against large folio for sharing check

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

diff --git a/mm/madvise.c b/mm/madvise.c
index bfe0e06427bd..46802b4cf65a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -384,7 +384,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapcount(folio) != 1)
+		if (folio_estimated_sharers(folio) != 1)
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -458,7 +458,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;

