Return-Path: <stable+bounces-203283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DCFCD87D5
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF2230204B9
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAEA3195F0;
	Tue, 23 Dec 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPEr2aSL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90421D58B;
	Tue, 23 Dec 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479831; cv=none; b=p6z+dVcg31rGv0BSRtKGh/wgvP/5ihLvgrjOByNeP9o16SVCa1rjmE/whWTDN1OpQZYXyGhKDQDlDSG7LVMujj0bolGZvC5FcvvRWB8s4/AIUGj8ETxTX1qvsfI7KbvYLCiGeCUMyIUK6EOSP+xTGuD0MH4hY0oT+X8ZYfFYMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479831; c=relaxed/simple;
	bh=D9p4aDnkMp3xBLSj20cZVuhUlzR174rG+fno549cX1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1JlT4Tdpo/F4UIQr0bn8RkbnWgwkzuxk+L3eyi4hIVxPa1vhBDPj1RpgRd2n4wZIm2gVWQ4fVa8faF4X8oAXKLmBQmxup1QXg6SJ1Tni6u7XS3+k7xpp9LezWLIRLHszAqTSGYerznsyMyLxiXvfO9CEENOmI9Cf34oqB3kuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPEr2aSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4FDC113D0;
	Tue, 23 Dec 2025 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766479831;
	bh=D9p4aDnkMp3xBLSj20cZVuhUlzR174rG+fno549cX1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VPEr2aSLQ0B5IvUkEwGnIN50DkddlnZkOls9Lg8LAdeR5yqixmwJjyZR3nVT8kSHZ
	 yccXBUwblTQpBXAqCsrn5N/VsNmomFTVWL4SyoqDmn+bgCnNuwvwPZjScnCf2+RNXi
	 BuPWAbDvHJPHG7PiNW0jgcDiGH3cra3+cdb3WjPChCx0sGS+7+7vmDsot5sgAKGZnd
	 zD8fLoReZj0cY1JzIll8pj9mtYSBC8bF84i/Mb7rENIKIDtw9j4pYjM0bCJOJIUPl0
	 tEw248ret7R96jK/PXGgkV6UxtNWzpze9V5cSWZboHYJalhEEEQHBKxZe2q7hkR8VO
	 pJKzn6O60YQ6A==
Message-ID: <d9e09523-2b61-4280-876e-95be787258f5@kernel.org>
Date: Tue, 23 Dec 2025 09:50:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/memory-failure: fix missing ->mf_stats count in
 hugetlb poison
To: Jane Chu <jane.chu@oracle.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
 osalvador@suse.de, linmiaohe@huawei.com, jiaqiyan@google.com,
 william.roche@oracle.com, rientjes@google.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, willy@infradead.org
References: <20251223012113.370674-1-jane.chu@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251223012113.370674-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 02:21, Jane Chu wrote:
> When a newly poisoned subpage ends up in an already poisoned hugetlb
> folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
> is not. Fix the inconsistency by designating action_result() to update
> them both.
> 
> While at it, define __get_huge_page_for_hwpoison() return values in terms
> of symbol names for better readibility. Also rename
> folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
> function does more than the conventional bit setting and the fact
> three possible return values are expected.
> 
> Fixes: 18f41fa616ee4 ("mm: memory-failure: bump memory failure stats to pglist_data")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
> v2 -> v3:
>    No change.
> v1 -> v2:
>    adapted David and Liam's comment, define __get_huge_page_for_hwpoison()
> return values in terms of symbol names instead of naked integers for better
> readibility.  #define instead of enum is used since the function has footprint
> outside MF, just try to limit the MF specifics local.
>    also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
> since the function does more than the conventional bit setting and the
> fact three possible return values are expected.
> 
> ---
>   mm/memory-failure.c | 56 ++++++++++++++++++++++++++-------------------
>   1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fbc5a01260c8..8b47e8a1b12d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1883,12 +1883,18 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>   	return count;
>   }
>   
> -static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
> +#define	MF_HUGETLB_ALREADY_POISONED	3  /* already poisoned */
> +#define	MF_HUGETLB_ACC_EXISTING_POISON	4  /* accessed existing poisoned page */

What happened to the idea of using an enum?


> +/*
> + * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
> + * to keep track of the poisoned pages.
> + */
> +static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>   {
>   	struct llist_head *head;
>   	struct raw_hwp_page *raw_hwp;
>   	struct raw_hwp_page *p;
> -	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> +	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_ALREADY_POISONED : 0;
>   
>   	/*
>   	 * Once the hwpoison hugepage has lost reliable raw error info,
> @@ -1896,20 +1902,18 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	 * so skip to add additional raw error info.
>   	 */
>   	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> -		return -EHWPOISON;
> +		return MF_HUGETLB_ALREADY_POISONED;
> +
>   	head = raw_hwp_list_head(folio);
>   	llist_for_each_entry(p, head->first, node) {
>   		if (p->page == page)
> -			return -EHWPOISON;
> +			return MF_HUGETLB_ACC_EXISTING_POISON;
>   	}
>   
>   	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>   	if (raw_hwp) {
>   		raw_hwp->page = page;
>   		llist_add(&raw_hwp->node, head);
> -		/* the first error event will be counted in action_result(). */
> -		if (ret)
> -			num_poisoned_pages_inc(page_to_pfn(page));
>   	} else {
>   		/*
>   		 * Failed to save raw error info.  We no longer trace all
> @@ -1955,32 +1959,30 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>   	folio_free_raw_hwp(folio, true);
>   }
>   
> +#define	MF_HUGETLB_FREED			0	/* freed hugepage */
> +#define	MF_HUGETLB_IN_USED			1	/* in-use hugepage */
> +#define	MF_NOT_HUGETLB				2	/* not a hugepage */

If you're already dealing with negative error codes, "MF_NOT_HUGETLB" nicely
translated to -EINVAL.

But I wonder if it would be cleaner to just define all values in an enum and return
that enum instead of an int from the functions.

enum md_hugetlb_status {
	MF_HUGETLB_INVALID,		/* not a hugetlb folio */
	MF_HUGETLB_BUSY,		/* busy, retry later */
	MF_HUGETLB_FREED,		/* hugetlb folio was freed */
	MF_HUGETLB_IN_USED,		/* ??? no idea what that really means */
	MF_HUGETLB_FOLIO_PRE_POISONED,	/* folio already poisoned, per-page information unclear */
	MF_HUGETLB_PAGE_PRE_POISONED,	/* exact page already poisoned */
}

-- 
Cheers

David

