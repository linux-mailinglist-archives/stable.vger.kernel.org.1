Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6447ED82D
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 00:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjKOX2E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 18:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKOX2D (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 18:28:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D6BE6;
        Wed, 15 Nov 2023 15:28:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D7C433C9;
        Wed, 15 Nov 2023 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700090880;
        bh=/3hbHk/NkTbi9ojdITtKamabzwOY0LFXBaucoOGBzCI=;
        h=Date:To:From:Subject:From;
        b=OHt+STav6SiXot0RFXx0d5VhMbgfjNA+B7Z5IuWPO60cI3tQgKpEQRyHLp2w3axvp
         +M62t/cbQcU4TjKl7/s2SFG+MZ+lcvyXbH6HfIYk4aINeMYNi2Opy4zQt+5JP9Uiup
         qbw3imulmHbX6GXJPp0FhuV6A5P9Ai9ykhtXJxlw=
Date:   Wed, 15 Nov 2023 15:27:59 -0800
To:     mm-commits@vger.kernel.org, willy@infradead.org,
        stable@vger.kernel.org, riel@surriel.com, hannes@cmpxchg.org,
        david@redhat.com, shr@devkernel.io, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [folded-merged] mm-fix-for-negative-counter-nr_file_hugepages-v3.patch removed from -mm tree
Message-Id: <20231115232800.721D7C433C9@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm-fix-for-negative-counter-nr_file_hugepages-v3
has been removed from the -mm tree.  Its filename was
     mm-fix-for-negative-counter-nr_file_hugepages-v3.patch

This patch was dropped because it was folded into mm-fix-for-negative-counter-nr_file_hugepages.patch

------------------------------------------------------
From: Stefan Roesch <shr@devkernel.io>
Subject: mm-fix-for-negative-counter-nr_file_hugepages-v3
Date: Wed, 8 Nov 2023 09:15:17 -0800

test for folio_test_pmd_mappable()

Link: https://lkml.kernel.org/r/20231108171517.2436103-1-shr@devkernel.io
Signed-off-by: Stefan Roesch <shr@devkernel.io>
Co-debugged-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: <stable@vger.kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/mm/huge_memory.c~mm-fix-for-negative-counter-nr_file_hugepages-v3
+++ a/mm/huge_memory.c
@@ -2769,13 +2769,15 @@ int split_huge_page_to_list(struct page
 			int nr = folio_nr_pages(folio);
 
 			xas_split(&xas, folio, folio_order(folio));
-			if (folio_test_swapbacked(folio)) {
-				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
-							-nr);
-			} else if (folio_test_pmd_mappable(folio)) {
-				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
-							-nr);
-				filemap_nr_thps_dec(mapping);
+			if (folio_test_pmd_mappable(folio)) {
+				if (folio_test_swapbacked(folio)) {
+					__lruvec_stat_mod_folio(folio,
+							NR_SHMEM_THPS, -nr);
+				} else {
+					__lruvec_stat_mod_folio(folio,
+							NR_FILE_THPS, -nr);
+					filemap_nr_thps_dec(mapping);
+				}
 			}
 		}
 
_

Patches currently in -mm which might be from shr@devkernel.io are

mm-fix-for-negative-counter-nr_file_hugepages.patch

