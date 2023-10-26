Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1125B7D78EF
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjJYXvD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 19:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJYXtd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 19:49:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F01BC;
        Wed, 25 Oct 2023 16:49:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A16C433CC;
        Wed, 25 Oct 2023 23:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698277757;
        bh=OOdxqSua3xS12DlIUuGNmoIU4HDw2ogvlyqEhFFzaKc=;
        h=Date:To:From:Subject:From;
        b=UHqq8ANrzYLw88Sv/Kw7oSGXn99Zx2Q9wGD415wezSRl8WH/Dr/O00nM23YUFVaxK
         wmy+CRvi6FRyO1LwWm3QL4D2sGkxifDK0uZDd2K3qR6TbIgziJkBZpsPCQ7h4pig8x
         3BHjRt1AY+fKS7r6K25O2uWPJr3xfYhBeapblE5w=
Date:   Wed, 25 Oct 2023 16:49:16 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        acsjakub@amazon.de, sj@kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-damon-lru_sort-avoid-divide-by-zero-in-hot-threshold-calculation.patch removed from -mm tree
Message-Id: <20231025234916.E5A16C433CC@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
has been removed from the -mm tree.  Its filename was
     mm-damon-lru_sort-avoid-divide-by-zero-in-hot-threshold-calculation.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
Date: Thu, 19 Oct 2023 19:49:23 +0000

When calculating the hotness threshold for lru_prio scheme of
DAMON_LRU_SORT, the module divides some values by the maximum nr_accesses.
However, due to the type of the related variables, simple division-based
calculation of the divisor can return zero.  As a result, divide-by-zero
is possible.  Fix it by using damon_max_nr_accesses(), which handles the
case.

Link: https://lkml.kernel.org/r/20231019194924.100347-5-sj@kernel.org
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: Jakub Acs <acsjakub@amazon.de>
Cc: <stable@vger.kernel.org>	[6.0+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/lru_sort.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/mm/damon/lru_sort.c~mm-damon-lru_sort-avoid-divide-by-zero-in-hot-threshold-calculation
+++ a/mm/damon/lru_sort.c
@@ -195,9 +195,7 @@ static int damon_lru_sort_apply_paramete
 	if (err)
 		return err;
 
-	/* aggr_interval / sample_interval is the maximum nr_accesses */
-	hot_thres = damon_lru_sort_mon_attrs.aggr_interval /
-		damon_lru_sort_mon_attrs.sample_interval *
+	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
 		hot_thres_access_freq / 1000;
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-remove-requested-targets-when-online-commit-inputs.patch

