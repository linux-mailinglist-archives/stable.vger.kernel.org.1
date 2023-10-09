Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535227BDE28
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376998AbjJINQb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376987AbjJINQ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B7121
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD9AC433C7;
        Mon,  9 Oct 2023 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857384;
        bh=LJF3Y4AghiBf5DWwkFqTRFLKsbsdDCtNla/gbKXW8ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Me3Ub2Vwz9KBphE8XM05reox/pWS2ltGq5BZgVrKC1DgZuMFIgf6A0DTRGfGTTa27
         8sk7/NLlflp3yqgs2FBv7pYTw1rOXeE6quLvSdXwI6VCsffJ5FkP2SgZLA+jhwVUBZ
         /EIlzXuep/bccF9LAHIlkKD3vZOVdjJSJqGu3ijU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/162] mm/page_alloc: always remove pages from temporary list
Date:   Mon,  9 Oct 2023 15:00:10 +0200
Message-ID: <20231009130123.750266985@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@techsingularity.net>

[ Upstream commit c3e58a70425ac6ddaae1529c8146e88b4f7252bb ]

Patch series "Leave IRQs enabled for per-cpu page allocations", v3.

This patch (of 2):

free_unref_page_list() has neglected to remove pages properly from the
list of pages to free since forever.  It works by coincidence because
list_add happened to do the right thing adding the pages to just the PCP
lists.  However, a later patch added pages to either the PCP list or the
zone list but only properly deleted the page from the list in one path
leading to list corruption and a subsequent failure.  As a preparation
patch, always delete the pages from one list properly before adding to
another.  On its own, this fixes nothing although it adds a fractional
amount of overhead but is critical to the next patch.

Link: https://lkml.kernel.org/r/20221118101714.19590-1-mgorman@techsingularity.net
Link: https://lkml.kernel.org/r/20221118101714.19590-2-mgorman@techsingularity.net
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reported-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7b086755fb8c ("mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69668817fed37..d94ac6d87bc97 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3547,6 +3547,8 @@ void free_unref_page_list(struct list_head *list)
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
+		list_del(&page->lru);
+
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
 			if (pcp)
-- 
2.40.1



