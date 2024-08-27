Return-Path: <stable+bounces-70343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA4960AB7
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985BB1F2391B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA061A01C4;
	Tue, 27 Aug 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EoL0H5Gq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6B1448C7
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762587; cv=none; b=HjWY4Bz8ePJtGnn49o8N06vxNQTMqckk7c/sOA1UWUnGsiSXcfLMqmMwaCjDOJB46ZFfN+g7623bMsx+YXkyOdhGDMR8XxuYt/EBSb8iIVsRA5rWnBg9e+DeL6MG09n8A9RURSE7U36oaCNltnlY6jqu5KuiRNaqweCX6XIgi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762587; c=relaxed/simple;
	bh=3Tlx4UW44mUjn7mJws5LT4HTEyMiMy1rKeauMqAK8Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcZBy2dcjhj/6E+hb72hJpppMtD7vpNT1P2Il/nOBAKduKcJdtFSRpV8q6Z29EmicH0sxb4nCLHFrYk7Rt+p947W3bUwBRBdGO4PSbUm5GbO4MBFIr4LKbaS9N5I7Bq3W18bCEjFeh3brf0vMf0TnYQ7jxoNIA4vqqJpwSAGKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EoL0H5Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDBC4FF5B;
	Tue, 27 Aug 2024 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762586;
	bh=3Tlx4UW44mUjn7mJws5LT4HTEyMiMy1rKeauMqAK8Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoL0H5GqM2qXGSrYS4UzQGrWCnCvXOGcZgthqVBq6Ylsa3u00rBm5o2nvon3IxU+v
	 XXQh2l8ZtzBJLO7wATmXNDO8PPg87ruQ+1tdjGNXlmOMaLv7FcliQkeEmP7zzXekJr
	 OfqJ/g3N4qGN7QJRc1Uv50krVDvselH76+aeU1L8=
Date: Tue, 27 Aug 2024 14:43:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mel Gorman <mgorman@suse.de>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/numa: no task_numa_fault() call if PTE is
 changed
Message-ID: <2024082752-prototype-turkey-0001@gregkh>
References: <2024081934-embargo-primer-a23e@gregkh>
 <20240821161017.2399833-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821161017.2399833-1-ziy@nvidia.com>

On Wed, Aug 21, 2024 at 12:10:17PM -0400, Zi Yan wrote:
> When handling a numa page fault, task_numa_fault() should be called by a
> process that restores the page table of the faulted folio to avoid
> duplicated stats counting.  Commit b99a342d4f11 ("NUMA balancing: reduce
> TLB flush via delaying mapping on hint page fault") restructured
> do_numa_page() and did not avoid task_numa_fault() call in the second page
> table check after a numa migration failure.  Fix it by making all
> !pte_same() return immediately.
> 
> This issue can cause task_numa_fault() being called more than necessary
> and lead to unexpected numa balancing results (It is hard to tell whether
> the issue will cause positive or negative performance impact due to
> duplicated numa fault counting).
> 
> Link: https://lkml.kernel.org/r/20240809145906.1513458-2-ziy@nvidia.com
> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 40b760cfd44566bca791c80e0720d70d75382b84)
> ---
>  mm/memory.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

All now queued up, thanks.

greg k-h

