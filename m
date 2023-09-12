Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D279D2AB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjILNuh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILNuh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:50:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0C10D0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:50:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ef8b91a72so346754385a.0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694526632; x=1695131432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DG/S9kEpT/rLqv5tf8oU3tSCxop5cRy8sJkoaweQRbM=;
        b=BiXRHs2crIQO/7pMppDc7gjKOjmT5Bv0o0NisnRcvFrq9jZ09fHeiGco9ClJyFGqBG
         hMeTNNBaYI+GHJzcUj+fq806xnd7lCALKI4fV3ZnIaI/Mb5iDPWZJSggIJT+uZizf5iY
         eCMiMUJV5h9Jtp9Q//iym11SShB2BnNAmbxp+RTi1gnvQsc7nZc7QmMVY49b+xYFQLIZ
         DMfo0CjtGtciOfzjpdfULkFdk8wpf1n1Q1MV4V969RWZsiBoNJxzKIUIXrHoYnd0OlwK
         sL8rx9BY0//cu6kSQJJOm9ufwmUsUutYnTE0ChkKSZrLY2aGtEOSg5/zW4Z1RUaYaKVC
         WsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526632; x=1695131432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG/S9kEpT/rLqv5tf8oU3tSCxop5cRy8sJkoaweQRbM=;
        b=mmMJ4Gt6TqD1B8adyyB1yOvZmZk8buROWjAWOpWFu4oFLxZRDXaoMbwBRe5ongrwa3
         OIxeCJnU7EmF9e0S4CC+OMRFZ64+Ni2mqMo1pWQYAavcwZWmjFG8ZUCwExSpEv+kZNt5
         0DC9x5FVYdQ72pYaow/tmP1c6uwBGLM3lUtXEc/QQzWgdI/0CcJp/CeeJvc2x5v2EiS7
         SW4V1SIzkBPncv8sYg+pcrsjkabOlcuoYLLBrQ94S0CO5kWXyn4XeZ5CNyrJBs/OI8Lf
         SmeSSs500Rpn6eBBosLJhGysb7bsHmCGOsW7ikquU9KDUtFTs6+AKVoKonzFvEc/01ts
         xhRA==
X-Gm-Message-State: AOJu0Yy2G+xW4dGTveBYBbPaownrXLfrBT0GUeIl7HUwDpTL5tOsJrqV
        tjxuVT3qscl2VAMbQWL4Nb6+zQ==
X-Google-Smtp-Source: AGHT+IHl17Fh754j/sY1LMMjJ+dwmOkJ5oU0X+qqqtvKNtHGorsM7EEe2ygKmW1RZLvnRBMWm/Uy9g==
X-Received: by 2002:a05:620a:894:b0:76f:e2e:4d99 with SMTP id b20-20020a05620a089400b0076f0e2e4d99mr10826440qka.78.1694526631952;
        Tue, 12 Sep 2023 06:50:31 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a071400b00767d6ec578csm3203622qkc.20.2023.09.12.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:50:31 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:50:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, vbabka@suse.cz, stable@vger.kernel.org,
        joe.liu@mediatek.com, mgorman@techsingularity.net
Subject: Re: +
 mm-page_alloc-free-pages-to-correct-buddy-list-after-pcp-lock-contention.patch
 added to mm-hotfixes-unstable branch
Message-ID: <20230912135029.GA249952@cmpxchg.org>
References: <20230911210053.8B7B0C433CD@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911210053.8B7B0C433CD@smtp.kernel.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 02:00:52PM -0700, Andrew Morton wrote:
> 
> The patch titled
>      Subject: mm: page_alloc: free pages to correct buddy list after PCP lock contention
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      mm-page_alloc-free-pages-to-correct-buddy-list-after-pcp-lock-contention.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-page_alloc-free-pages-to-correct-buddy-list-after-pcp-lock-contention.patch
> 
> This patch will later appear in the mm-hotfixes-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
> 
> ------------------------------------------------------
> From: Mel Gorman <mgorman@techsingularity.net>
> Subject: mm: page_alloc: free pages to correct buddy list after PCP lock contention
> Date: Tue, 5 Sep 2023 10:09:22 +0100
> 
> Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> returns pages to the buddy list on PCP lock contention. However, for
> migratetypes that are not MIGRATE_PCPTYPES, the migratetype may have
> been clobbered already for pages that are not being isolated. In
> practice, this means that CMA pages may be returned to the wrong
> buddy list. While this might be harmless in some cases as it is
> MIGRATE_MOVABLE, the pageblock could be reassigned in rmqueue_fallback
> and prevent a future CMA allocation. Lookup the PCP migratetype
> against unconditionally if the PCP lock is contended.
> 
> [lecopzer.chen@mediatek.com: CMA-specific fix]
> Link: https://lkml.kernel.org/r/20230905090922.zy7srh33rg5c3zao@techsingularity.net
> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Reported-by: Joe Liu <joe.liu@mediatek.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This patch is superseded by the following patch you picked up:
mm-page_alloc-fix-cma-and-highatomic-landing-on-the-wrong-buddy-list.patch

If you drop this patch here, you can also drop the fixlet to
free_unref_page(). The branch in there should look like this:

	if (pcp)
		free_unref_page_commit(..., pcpmigratetype, ...);
	else
		free_one_page(..., migratetype, ...);
