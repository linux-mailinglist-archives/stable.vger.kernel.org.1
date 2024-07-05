Return-Path: <stable+bounces-58129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B55928568
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 11:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357401C20643
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35DA143C55;
	Fri,  5 Jul 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="C8PQzFbr"
X-Original-To: stable@vger.kernel.org
Received: from mail16.out.titan.email (mail16.out.titan.email [3.64.226.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74686F09C
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172805; cv=none; b=F0IL8OM2cYB+kCcBbTLIatgR3vV9bOgazt7qd5v3o/sShZepZiqHF4B4EsHBUFHrRzQ3y+1bgDlwaNpeX+JidR+81nwK9kJSjrb3H/5u0uRUOTO0ObObQMkqwomIQRIxj6QVXqVprEQbBL35lOhWEx3f+/8dPDmNtl2c5vlwgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172805; c=relaxed/simple;
	bh=9QgdMSzfWP+N7iU2g8EaYZcU8FuPRoYvmLkd0hjni9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfNOTNpMHIb3cn/o7oIOiWCf9qQ1q4azPZdty99tRhJUxXA0NlQaLNIUgSbHFJOY9OwOwGMD5FFzCGyi30y3ZHfDkrwsbUd2lTgXgQ5/7GpzH2rsxcPrTYbQxiwtzUrQVVLj0jb40WIYSMSJpliAKr/qKWGc6UzuIh3pWsk09Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=C8PQzFbr; arc=none smtp.client-ip=3.64.226.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 9E13FA0031;
	Fri,  5 Jul 2024 09:27:57 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=gfDNsbbr44wtsa/28j7FedUDrpzQMLgTmEhYi5JNIWE=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=date:cc:references:message-id:from:to:mime-version:in-reply-to:subject:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1720171677; v=1;
	b=C8PQzFbr5RtS+PXu5Q3771cr6OtzTM4mxoAhv7jnP0TiSiuM1MlxAjp+TENn2TJhuxcuCfGW
	oiCdF8HE40AYFXd8gvjG5yjd07H4zgNkMqbP927fxvyp0cJU6cedxRoMzBLwOdyGFeV+3pkREhb
	GPljQmvIMUWTsvPgZY/yiXus=
Received: from mail.blacknight.com (ip-84-203-196-95.broadband.digiweb.ie [84.203.196.95])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id D649CA0051;
	Fri,  5 Jul 2024 09:27:56 +0000 (UTC)
Date: Fri, 5 Jul 2024 10:27:54 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
Message-ID: <20240705092754.cv4dowdunoxfn6l5@techsingularity.net>
References: <1718801672-30152-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1718801672-30152-1-git-send-email-yangge1116@126.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1720171677523044635.8944.4972576934373349811@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=beRtUvPB c=1 sm=1 tr=0 ts=6687bc9d
	a=yLX2s/SMutoCvBNwHxSr4A==:117 a=yLX2s/SMutoCvBNwHxSr4A==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=gnbuhwpKAAAA:8 a=R_Myd5XaAAAA:8
	a=rSyjtz3AbgEkiwi8wb8A:9 a=PUjeQqilurYA:10 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Jun 19, 2024 at 08:54:32PM +0800, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations") no longer differentiates the migration type
> of pages in THP-sized PCP list, it's possible that non-movable
> allocation requests may get a CMA page from the list, in some cases,
> it's not acceptable.
> 
> If a large number of CMA memory are configured in system (for
> example, the CMA memory accounts for 50% of the system memory),
> starting a virtual machine with device passthrough will get stuck.
> During starting the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
> if a page is present and in CMA area, pin_user_pages_remote() will
> migrate the page from CMA area to non-CMA area because of
> FOLL_LONGTERM flag. But if non-movable allocation requests return
> CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
> page to another CMA page, which will fail to pass the check in
> check_and_migrate_movable_pages() and cause migration endless.
> Call trace:
> pin_user_pages_remote
> --__gup_longterm_locked // endless loops in this function
> ----_get_user_pages_locked
> ----check_and_migrate_movable_pages
> ------migrate_longterm_unpinnable_pages
> --------alloc_migration_target
> 
> This problem will also have a negative impact on CMA itself. For
> example, when CMA is borrowed by THP, and we need to reclaim it
> through cma_alloc() or dma_alloc_coherent(), we must move those
> pages out to ensure CMA's users can retrieve that contigous memory.
> Currently, CMA's memory is occupied by non-movable pages, meaning
> we can't relocate them. As a result, cma_alloc() is more likely to
> fail.
> 
> To fix the problem above, we add one PCP list for THP, which will
> not introduce a new cacheline for struct per_cpu_pages. THP will
> have 2 PCP lists, one PCP list is used by MOVABLE allocation, and
> the other PCP list is used by UNMOVABLE allocation. MOVABLE
> allocation contains GPF_MOVABLE, and UNMOVABLE allocation contains
> GFP_UNMOVABLE and GFP_RECLAIMABLE.
> 
> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
> Signed-off-by: yangge <yangge1116@126.com>

Too late to be relevant but

Acked-by: Mel Gorman <mgorman@techsingularity.net>

It would have been preferred if the comment stated why GFP_UNMOVABLE is
needed because the original assumption that THP would mostly be MOVABLE
allocations did not age well but git blame is enough. Maybe one day
GFP_RECLAIMABLE will also be added to the list. However, I suspect the
bigger problem later will be multiple THP sizes becoming more common that
are not necessarily fitting within PAGE_ALLOC_COSTLY_ORDER and per-cpu
not being enough to mitigate zone->lock contention in general. That's
beyond the scope of this patch.

Thanks.

-- 
Mel Gorman
SUSE Labs

