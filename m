Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EE7E8243
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjKJTJE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 10 Nov 2023 14:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjKJTIw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 10 Nov 2023 14:08:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2FE12C92A;
        Fri, 10 Nov 2023 10:31:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53724C433AD;
        Fri, 10 Nov 2023 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699641119;
        bh=MvmzewS5VJRc98gsbGkCIaIKE2HsqDNSyOsXEIVZFwA=;
        h=Date:To:From:Subject:From;
        b=zIS1+NWWfsjeeW4wJqDvIFizSMlHuB0JPnqrmqHsHh0oYX+//JCz06dvK4GRfvPKg
         v+aIUv+VXA45Vb4ZiXmVo3qOt8k7r+odUoloyaFT5EwbrVjr6oCVzkFmwY4YFeYBiV
         mn0MtlK3jY8umi0Dj6DPmwNCmDYVryOTXLSmjLWA=
Date:   Fri, 10 Nov 2023 10:31:58 -0800
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org, sj@kernel.org,
        hyeongtak.ji@sk.com, hyeongtak.ji@gmail.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-corec-avoid-unintentional-filtering-out-of-schemes.patch added to mm-hotfixes-unstable branch
Message-Id: <20231110183159.53724C433AD@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mm/damon/core.c: avoid unintentional filtering out of schemes
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-corec-avoid-unintentional-filtering-out-of-schemes.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-corec-avoid-unintentional-filtering-out-of-schemes.patch

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
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
Subject: mm/damon/core.c: avoid unintentional filtering out of schemes
Date: Fri, 10 Nov 2023 14:37:09 +0900

The function '__damos_filter_out()' causes DAMON to always filter out
schemes whose filter type is anon or memcg if its matching value is set
to false.

This commit addresses the issue by ensuring that '__damos_filter_out()'
no longer applies to filters whose type is 'anon' or 'memcg'.

Link: https://lkml.kernel.org/r/1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com
Fixes: ab9bda001b681 ("mm/damon/core: introduce address range type damos filter")
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/damon/core.c~mm-damon-corec-avoid-unintentional-filtering-out-of-schemes
+++ a/mm/damon/core.c
@@ -924,7 +924,7 @@ static bool __damos_filter_out(struct da
 		matched = true;
 		break;
 	default:
-		break;
+		return false;
 	}
 
 	return matched == filter->matching;
_

Patches currently in -mm which might be from hyeongtak.ji@gmail.com are

mm-damon-corec-avoid-unintentional-filtering-out-of-schemes.patch

