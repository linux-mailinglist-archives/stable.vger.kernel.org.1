Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8976BD52
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHATHj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHATHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 15:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E4115;
        Tue,  1 Aug 2023 12:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15EAC6169A;
        Tue,  1 Aug 2023 19:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EB0C433C8;
        Tue,  1 Aug 2023 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690916856;
        bh=57zf9Om8vODBq+bZ9BTVlxd4r7eOmAAn53S8KsVVpcg=;
        h=Date:To:From:Subject:From;
        b=0IlcmEZXf7YG7pePXraHjg3zwpuKeNsPvwWtmu/Nbdj3fw4TW0qgeJ2W8WD1XoBKO
         wguBYNffBmMaRv6wQEvty/UWo6eBJtbNoSgwlfi8a5tXjmnRtK358rgkk9yuRDRHzy
         FUQs2X7ZHx30HHA8jVhuPrEIbpQht4KZ5U1KxPKk=
Date:   Tue, 01 Aug 2023 12:07:35 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org, sj@kernel.org,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-core-initialize-damo_filter-list-from-damos_new_filter.patch added to mm-hotfixes-unstable branch
Message-Id: <20230801190736.65EB0C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mm/damon/core: initialize damo_filter->list from damos_new_filter()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-core-initialize-damo_filter-list-from-damos_new_filter.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-core-initialize-damo_filter-list-from-damos_new_filter.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: initialize damo_filter->list from damos_new_filter()
Date: Sat, 29 Jul 2023 20:37:32 +0000

damos_new_filter() is not initializing the list field of newly allocated
filter object.  However, DAMON sysfs interface and DAMON_RECLAIM are not
initializing it after calling damos_new_filter().  As a result, accessing
uninitialized memory is possible.  Actually, adding multiple DAMOS filters
via DAMON sysfs interface caused NULL pointer dereferencing.  Initialize
the field just after the allocation from damos_new_filter().

Link: https://lkml.kernel.org/r/20230729203733.38949-2-sj@kernel.org
Fixes: 98def236f63c ("mm/damon/core: implement damos filter")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/damon/core.c~mm-damon-core-initialize-damo_filter-list-from-damos_new_filter
+++ a/mm/damon/core.c
@@ -273,6 +273,7 @@ struct damos_filter *damos_new_filter(en
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-core-initialize-damo_filter-list-from-damos_new_filter.patch
mm-damon-core-test-add-a-test-for-damos_new_filter.patch

