Return-Path: <stable+bounces-57981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F992694E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 22:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3494B25FD4
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA11186E32;
	Wed,  3 Jul 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UoW7V4S/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154613DBB1;
	Wed,  3 Jul 2024 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037325; cv=none; b=R5EISxwv9fTpUs77PhHeYPW8BZO50qHMp40h+EYvGTODFlQ8DJJCMd3+zmbK3uNkIyF9lWgt+2bCILHCzG7NXZeR8UMBnd/0W6rKFpI1PhyvmkwYcKBls+/SKG5LUKnwExJquQSnWWQ77xO1FuO3FNLKGDdb6Pse+HiHcUQPVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037325; c=relaxed/simple;
	bh=/nseoorglFV3LVGoTmjXsLh5khxwk400OmG3i+R4mhM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HKkG2KpWeWHwRCrteqig3Lpp9Yarh4wu/fgFlz3WrkJg/GYSvpoSgHIH5dj7LmQpf67X9F5ceUgZJmwfTK2Q+FOzSyqnSCsuj0j4O5Z4P42ssBzTcgL9zRfQXh2MQ+DmDxvQAFWDs/99l6XeuQdp62qnPVFxa2UYeAb3FMZY2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UoW7V4S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745B1C4AF0A;
	Wed,  3 Jul 2024 20:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720037324;
	bh=/nseoorglFV3LVGoTmjXsLh5khxwk400OmG3i+R4mhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UoW7V4S/nCaVBYgHOxvfMlrMwvWOGPfTLT+WOrNnDWySJZyr7vx3w5NV04RWylcMV
	 YuZFg17gdN6R3mN2irJOIoMeNNtPBPsKXAZKd7aM8GkhNr2hra/pYSaVGFjVG7jLKk
	 Mk9FTPNWl9BM0shtiiooAW0jUQfWePyQWKfjGgL4=
Date: Wed, 3 Jul 2024 13:08:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: yangge1116@126.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com,
 baolin.wang@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
 liuzixing@hygon.cn
Subject: Re: [PATCH V3] mm/gup: Clear the LRU flag of a page before adding
 to LRU batch
Message-Id: <20240703130843.ad421344a0f3f05564a7f706@linux-foundation.org>
In-Reply-To: <1720008153-16035-1-git-send-email-yangge1116@126.com>
References: <1720008153-16035-1-git-send-email-yangge1116@126.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 20:02:33 +0800 yangge1116@126.com wrote:

> From: yangge <yangge1116@126.com>
> 
> If a large number of CMA memory are configured in system (for example, the
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine with device passthrough, it will
> call pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory.
> Normally if a page is present and in CMA area, pin_user_pages_remote()
> will migrate the page from CMA area to non-CMA area because of
> FOLL_LONGTERM flag. But the current code will cause the migration failure
> due to unexpected page refcounts, and eventually cause the virtual machine
> fail to start.
> 
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is not
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail.
> 
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page).
> Seems making the LRU flag of the page invisible a long time is no problem,
> because a new page is allocated from buddy and added to the lru batch,
> its LRU flag is also not visible for a long time.
> 

Thanks.

I'll add this to the mm-hotfixes branch for additional testing.  Please
continue to work with David on the changelog enhancements.

In mm-hotfixes I'd expect to send it to Linus next week.  I could move
it into mm-unstable (then mm-stable) for merging into 6.11-rc1.  This
is for additional testing time - it will still be backported into
earlier kernels.  We can do this with any patch.

