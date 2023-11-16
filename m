Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F97ED835
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 00:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjKOXa5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 18:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjKOXay (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 18:30:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7319E;
        Wed, 15 Nov 2023 15:30:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BABC433C9;
        Wed, 15 Nov 2023 23:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700091050;
        bh=6rn5cWJ7ClZ8Tq2sJ7TmyO0KeOdWzgpCmkjzWxIlbxg=;
        h=Date:To:From:Subject:From;
        b=GFA0nYsJQIIHvHgAO611CI2+7n3ySEcXJ2Zaf8MCAmI6rmG5B765B3AML90GhsLOL
         GMNqJ504tPqJJpMUbnCjhzj2KUQ3Q2mzlbx1yVSDrR/uHwrQ3kjiJoaTw6XhOlvv+q
         2Cm+XSOkgp/LrlPY1FiXkXl1i1CFJYduGGgNGlSI=
Date:   Wed, 15 Nov 2023 15:30:50 -0800
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org, sj@kernel.org,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-sysfs-schemes-handle-tried-region-directory-allocation-failure.patch removed from -mm tree
Message-Id: <20231115233050.98BABC433C9@smtp.kernel.org>
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
     Subject: mm/damon/sysfs-schemes: handle tried region directory allocation failure
has been removed from the -mm tree.  Its filename was
     mm-damon-sysfs-schemes-handle-tried-region-directory-allocation-failure.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: handle tried region directory allocation failure
Date: Mon, 6 Nov 2023 23:34:08 +0000

DAMON sysfs interface's before_damos_apply callback
(damon_sysfs_before_damos_apply()), which creates the DAMOS tried regions
for each DAMOS action applied region, is not handling the allocation
failure for the sysfs directory data.  As a result, NULL pointer
derefeence is possible.  Fix it by handling the case.

Link: https://lkml.kernel.org/r/20231106233408.51159-4-sj@kernel.org
Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.2+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs-schemes.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/damon/sysfs-schemes.c~mm-damon-sysfs-schemes-handle-tried-region-directory-allocation-failure
+++ a/mm/damon/sysfs-schemes.c
@@ -1826,6 +1826,8 @@ static int damon_sysfs_before_damos_appl
 		return 0;
 
 	region = damon_sysfs_scheme_region_alloc(r);
+	if (!region)
+		return 0;
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
_

Patches currently in -mm which might be from sj@kernel.org are


