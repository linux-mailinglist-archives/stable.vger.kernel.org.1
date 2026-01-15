Return-Path: <stable+bounces-208422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC4D22E16
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A78A30AEE2F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFED32B9BB;
	Thu, 15 Jan 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JaKHEL8Y"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0732B9AC;
	Thu, 15 Jan 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462315; cv=none; b=M4bmUJpnof3pPQfPvxjZTU+BLicIfvEP0eM+48oNwfKvdhbZ2o8adrok0gVTrEfxdMxztfew0YtxYmff7pSrW+CalHWs2ERUdM0e7kRQ+lXf4l77sA8amE5turBWn5WSmP0kpnCQZXutpwuL0ySEq/oaUAIaaz8KUNraeFZwQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462315; c=relaxed/simple;
	bh=gCFxi3rBkIO5d81796YNR0A+M2D1y9GX8Cd3rDJphhg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=epOzyErs+KSC8X0BLQdGezyF3mcrhGsGj9BG4wom90JGVDGem8TVgT4pxSk9V30ts96X2FQI7z3Lx5JQGq7XMwo9wucyzP4CtFO3uJ1KdDOM3/EynmmGDc6qoUFnKi9Zft136zzQeeisniK8yx4XPy/6NsoKKu1k7q3FiPeURSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JaKHEL8Y; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5dFnQyFRzBn2t4MUukpNZzTFF4PhWnExbW+AKUMLisU=;
	b=JaKHEL8Y/IPR1Cf5YY2IVD9M9zftKBScCC05h3tzuh3MwGU6pGQLT28Amtx5GcpkE3HCmUohI
	RbGAufGmnt94cmn62OUN3X7f70Lu/qkjC8ikMAXdmkpI6JOvgCLT6zZ/SGdVW3zSZpkHKSF78ns
	cbD/k58AX5v+7HaQIl1Q65w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dsF2h1VLlzRhR3;
	Thu, 15 Jan 2026 15:28:28 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 998A740539;
	Thu, 15 Jan 2026 15:31:48 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 15:31:48 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 15:31:47 +0800
Subject: Re: [PATCH v5 1/2] mm/memory-failure: fix missing ->mf_stats count in
 hugetlb poison
To: Jane Chu <jane.chu@oracle.com>
CC: <linux-mm@kvack.org>, <stable@vger.kernel.org>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@kernel.org>, <jiaqiyan@google.com>,
	<william.roche@oracle.com>, <rientjes@google.com>,
	<akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@Oracle.com>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <willy@infradead.org>, <clm@meta.com>, linux-kernel
	<linux-kernel@vger.kernel.org>
References: <20260114213721.2295844-1-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e3b0033b-0506-2ec2-239c-93a7ac7b0c2e@huawei.com>
Date: Thu, 15 Jan 2026 15:31:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260114213721.2295844-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/1/15 5:37, Jane Chu wrote:
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
> v5 -> v4:
>   fix a bug pointed out by William and Chris, add comment.
> v3 -> v4:
>   incorporate/adapt David's suggestions.
> v2 -> v3:
>   No change.
> v1 -> v2:
>   adapted David and Liam's comment, define __get_huge_page_for_hwpoison()
> return values in terms of symbol names instead of naked integers for better
> readibility.  #define instead of enum is used since the function has footprint
> outside MF, just try to limit the MF specifics local.
>   also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
> since the function does more than the conventional bit setting and the
> fact three possible return values are expected.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

This patch looks good to me. A few nits below.

> ---
>  mm/memory-failure.c | 87 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fbc5a01260c8..2563718c34c6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1883,12 +1883,24 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  	return count;
>  }
>  
> -static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
> +#define	MF_HUGETLB_FOLIO_PRE_POISONED	3  /* folio already poisoned */
> +#define	MF_HUGETLB_PAGE_PRE_POISONED	4  /* exact page already poisoned */
> +/*
> + * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
> + * to keep track of the poisoned pages.
> + * Return:
> + *	0: folio was not already poisoned;
> + *	MF_HUGETLB_FOLIO_PRE_POISONED: folio was already poisoned: either
> + *		multiple pages being poisoned, or per page information unclear,
> + *	MF_HUGETLB_PAGE_PRE_POISONED: folio was already poisoned, an exact
> + *		poisoned page is being consumed again.
> + */
> +static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>  {
>  	struct llist_head *head;
>  	struct raw_hwp_page *raw_hwp;
>  	struct raw_hwp_page *p;
> -	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> +	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
>  
>  	/*
>  	 * Once the hwpoison hugepage has lost reliable raw error info,
> @@ -1896,20 +1908,17 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>  	 * so skip to add additional raw error info.
>  	 */
>  	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> -		return -EHWPOISON;
> +		return MF_HUGETLB_FOLIO_PRE_POISONED;
>  	head = raw_hwp_list_head(folio);
>  	llist_for_each_entry(p, head->first, node) {
>  		if (p->page == page)
> -			return -EHWPOISON;
> +			return MF_HUGETLB_PAGE_PRE_POISONED;
>  	}
>  
>  	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>  	if (raw_hwp) {
>  		raw_hwp->page = page;
>  		llist_add(&raw_hwp->node, head);
> -		/* the first error event will be counted in action_result(). */
> -		if (ret)
> -			num_poisoned_pages_inc(page_to_pfn(page));
>  	} else {
>  		/*
>  		 * Failed to save raw error info.  We no longer trace all
> @@ -1955,44 +1964,43 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>  	folio_free_raw_hwp(folio, true);
>  }
>  
> +#define	MF_HUGETLB_FREED		0	/* freed hugepage */
> +#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */

It might be better to define all of them together. e.g.

#define MF_HUGETLB_FREED		0 	/* freed hugepage */
#define MF_HUGETLB_IN_USED		1	/* in-use hugepage */
#define MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
#define MF_HUGETLB_FOLIO_PRE_POISONED	3  	/* folio already poisoned */
#define MF_HUGETLB_PAGE_PRE_POISONED	4  	/* exact page already poisoned */
#define MF_HUGETLB_RETRY		5	/* the hugepage is busy (try to retry) */

>  /*
>   * Called from hugetlb code with hugetlb_lock held.
> - *
> - * Return values:
> - *   0             - free hugepage
> - *   1             - in-use hugepage
> - *   2             - not a hugepage
> - *   -EBUSY        - the hugepage is busy (try to retry)
> - *   -EHWPOISON    - the hugepage is already hwpoisoned
>   */
>  int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  				 bool *migratable_cleared)
>  {
>  	struct page *page = pfn_to_page(pfn);
>  	struct folio *folio = page_folio(page);
> -	int ret = 2;	/* fallback to normal page handling */
> +	int ret = -EINVAL;
>  	bool count_increased = false;
> +	int rc;
>  
>  	if (!folio_test_hugetlb(folio))
>  		goto out;
>  
>  	if (flags & MF_COUNT_INCREASED) {
> -		ret = 1;
> +		ret = MF_HUGETLB_IN_USED;
>  		count_increased = true;
>  	} else if (folio_test_hugetlb_freed(folio)) {
> -		ret = 0;
> +		ret = MF_HUGETLB_FREED;
>  	} else if (folio_test_hugetlb_migratable(folio)) {
> -		ret = folio_try_get(folio);
> -		if (ret)
> +		if (folio_try_get(folio)) {
> +			ret = MF_HUGETLB_IN_USED;
>  			count_increased = true;
> +		} else
> +			ret = MF_HUGETLB_FREED;
>  	} else {
>  		ret = -EBUSY;
>  		if (!(flags & MF_NO_RETRY))
>  			goto out;
>  	}
>  
> -	if (folio_set_hugetlb_hwpoison(folio, page)) {
> -		ret = -EHWPOISON;
> +	rc = hugetlb_update_hwpoison(folio, page);
> +	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
> +		ret = rc;
>  		goto out;
>  	}
>  
> @@ -2017,10 +2025,15 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   * with basic operations like hugepage allocation/free/demotion.
>   * So some of prechecks for hwpoison (pinning, and testing/setting
>   * PageHWPoison) should be done in single hugetlb_lock range.
> + * Returns:
> + *	0		- not hugetlb, or recovered
> + *	-EBUSY		- not recovered
> + *	-EOPNOTSUPP	- hwpoison_filter'ed
> + *	-EHWPOISON	- folio or exact page already poisoned
>   */
>  static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
>  {
> -	int res;
> +	int res, rv;
>  	struct page *p = pfn_to_page(pfn);
>  	struct folio *folio;
>  	unsigned long page_flags;
> @@ -2029,22 +2042,30 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	*hugetlb = 1;
>  retry:
>  	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
> -	if (res == 2) { /* fallback to normal page handling */
> +	switch (res) {
> +	case -EINVAL:	/* fallback to normal page handling */
>  		*hugetlb = 0;
>  		return 0;
> -	} else if (res == -EHWPOISON) {
> -		if (flags & MF_ACTION_REQUIRED) {
> -			folio = page_folio(p);
> -			res = kill_accessing_process(current, folio_pfn(folio), flags);
> -		}
> -		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> -		return res;
> -	} else if (res == -EBUSY) {
> +	case -EBUSY:
>  		if (!(flags & MF_NO_RETRY)) {
>  			flags |= MF_NO_RETRY;
>  			goto retry;
>  		}
>  		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
> +	case MF_HUGETLB_FOLIO_PRE_POISONED:
> +	case MF_HUGETLB_PAGE_PRE_POISONED:
> +		rv = -EHWPOISON;
> +		if (flags & MF_ACTION_REQUIRED) {
> +			folio = page_folio(p);
> +			rv = kill_accessing_process(current, folio_pfn(folio), flags);
> +		}
> +		if (res == MF_HUGETLB_PAGE_PRE_POISONED)
> +			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> +		else
> +			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
> +		return rv;
> +	default:

Should we add a warn here?

Thanks.
.

