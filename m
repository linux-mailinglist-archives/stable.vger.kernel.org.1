Return-Path: <stable+bounces-35560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2B894CFF
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 09:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C08B21FCF
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073AA3D0A9;
	Tue,  2 Apr 2024 07:55:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352E3D0D9
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044527; cv=none; b=XM4kgqKvliAQSEB9jCUP/HNRIupZxpbi5Cja7+dfqguJ/cwlnASqHPUMPOoGoG8Nk1NQJE9Xk/QGTkqQ80C71cYEJibnHPOqHHEvC4b38RnHou/0caL2WufVSyx9PdH2tqun2kqKkuvS9DntcIhlqzjpAX9hbPeznbdSdzXhmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044527; c=relaxed/simple;
	bh=vrjkzzyRlmXPlrs/YQ3qsMgAm5d/QF+iFNqts+rjI5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXsmm33zL5d2l6AerHCrtw8Gpb5ZJBgssmvYmhtzwxVdy09fOu+bg2WCPNzENgpvenAe9exMiQzke7yEhXygDIl1gVdTXiW4qryQielneiKWF7D3nYYdzUZS95RRXB6xI3nkLruWB5wz1y5H3F4FSyLPNrBCs+Ur9570eksd1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C160F1042;
	Tue,  2 Apr 2024 00:55:57 -0700 (PDT)
Received: from [10.57.73.65] (unknown [10.57.73.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 246C93F64C;
	Tue,  2 Apr 2024 00:55:24 -0700 (PDT)
Message-ID: <6009297b-bb22-41a9-b337-a597fcec54d7@arm.com>
Date: Tue, 2 Apr 2024 08:55:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 116/399] mm: swap: fix race between
 free_swap_and_cache() and swapoff()
Content-Language: en-GB
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, David Hildenbrand <david@redhat.com>,
 "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
References: <20240401152549.131030308@linuxfoundation.org>
 <20240401152552.653009386@linuxfoundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240401152552.653009386@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 16:41, Greg Kroah-Hartman wrote:
> 6.8-stable review patch.  If anyone has any objections, please let me know.

LGTM!

> 
> ------------------
> 
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> [ Upstream commit 82b1c07a0af603e3c47b906c8e991dc96f01688e ]
> 
> There was previously a theoretical window where swapoff() could run and
> teardown a swap_info_struct while a call to free_swap_and_cache() was
> running in another thread.  This could cause, amongst other bad
> possibilities, swap_page_trans_huge_swapped() (called by
> free_swap_and_cache()) to access the freed memory for swap_map.
> 
> This is a theoretical problem and I haven't been able to provoke it from a
> test case.  But there has been agreement based on code review that this is
> possible (see link below).
> 
> Fix it by using get_swap_device()/put_swap_device(), which will stall
> swapoff().  There was an extra check in _swap_info_get() to confirm that
> the swap entry was not free.  This isn't present in get_swap_device()
> because it doesn't make sense in general due to the race between getting
> the reference and swapoff.  So I've added an equivalent check directly in
> free_swap_and_cache().
> 
> Details of how to provoke one possible issue (thanks to David Hildenbrand
> for deriving this):
> 
> --8<-----
> 
> __swap_entry_free() might be the last user and result in
> "count == SWAP_HAS_CACHE".
> 
> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
> 
> So the question is: could someone reclaim the folio and turn
> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
> 
> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
> still references by swap entries.
> 
> Process 1 still references subpage 0 via swap entry.
> Process 2 still references subpage 1 via swap entry.
> 
> Process 1 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> [then, preempted in the hypervisor etc.]
> 
> Process 2 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> 
> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
> __try_to_reclaim_swap().
> 
> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
> swap_entry_free()->swap_range_free()->
> ...
> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
> 
> What stops swapoff to succeed after process 2 reclaimed the swap cache
> but before process1 finished its call to swap_page_trans_huge_swapped()?
> 
> --8<-----
> 
> Link: https://lkml.kernel.org/r/20240306140356.3974886-1-ryan.roberts@arm.com
> Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
> Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/swapfile.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 746aa9da53025..6fe0cc25535f5 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1227,6 +1227,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>   * with get_swap_device() and put_swap_device(), unless the swap
>   * functions call get/put_swap_device() by themselves.
>   *
> + * Note that when only holding the PTL, swapoff might succeed immediately
> + * after freeing a swap entry. Therefore, immediately after
> + * __swap_entry_free(), the swap info might become stale and should not
> + * be touched without a prior get_swap_device().
> + *
>   * Check whether swap entry is valid in the swap device.  If so,
>   * return pointer to swap_info_struct, and keep the swap entry valid
>   * via preventing the swap device from being swapoff, until
> @@ -1604,13 +1609,19 @@ int free_swap_and_cache(swp_entry_t entry)
>  	if (non_swap_entry(entry))
>  		return 1;
>  
> -	p = _swap_info_get(entry);
> +	p = get_swap_device(entry);
>  	if (p) {
> +		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
> +			put_swap_device(p);
> +			return 0;
> +		}
> +
>  		count = __swap_entry_free(p, entry);
>  		if (count == SWAP_HAS_CACHE &&
>  		    !swap_page_trans_huge_swapped(p, entry))
>  			__try_to_reclaim_swap(p, swp_offset(entry),
>  					      TTRS_UNMAPPED | TTRS_FULL);
> +		put_swap_device(p);
>  	}
>  	return p != NULL;
>  }


