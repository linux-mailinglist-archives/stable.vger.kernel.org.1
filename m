Return-Path: <stable+bounces-210497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBq5Ew5XcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:33:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C5510ED
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0654C6459D6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C913A7E03;
	Tue, 20 Jan 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iKsu+/mh"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1BF3A961D;
	Tue, 20 Jan 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910064; cv=none; b=WBM2g+mqE1QBJ7ZtChpNywKD9Z8oJhfyty0QKkcMYm4Uj5bcu+fOwoGc1thAgWM61jS96h66eUVhEMDDRfuSuQoAL1ocS5wqOjvgNj5mf7Y9EN4BFPjUA9UQMnj0gEKX2PkIPazCmAPH+LmxcVIHgPpVJBBQAxBaRW7f2vvrtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910064; c=relaxed/simple;
	bh=awXGqn/RSQpv18RBkOhsvzKRJfFKoO+HSKXADV8ok9g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K2Q5FDwznicRlFKjgJlnC5TfAswt4/Bu7O9Osz9nuodBijXZ5DKj6IoHtnOnIVFzPP+0pz9CaHsO0NLpdRnbh8PaUb+9dCWJ8diTEl2NWqWbg9q4Kd7VQJ8++Vl/itxQjKUr3nUnQIxa+cKr/c7+lt11dtqRNDbYFG6V19xq4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iKsu+/mh; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LD2S+Q4ihx8nd0KPbEgJkcPOIMRBud8mbNzwagk5rek=;
	b=iKsu+/mhPJ6YLmsegjpkHBAxm56LWV2D3sCl261iIHJ61pTh6rmqg7N9ydTLXo2iYaooxFr/1
	C5Qa6XrwAnfjxb1JPktZ6kYdLxfydQ2QpeVdJD/HtLwjxDOqYZMwMZFdEK2kx+1tdl8CIok0R9/
	yjzjyo553GGg5FeyNXPIwCA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwQcR47trznTys;
	Tue, 20 Jan 2026 19:50:15 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CAA640563;
	Tue, 20 Jan 2026 19:54:14 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:54:13 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:54:12 +0800
Subject: Re: [PATCH v6 1/2] mm/memory-failure: fix missing ->mf_stats count in
 hugetlb poison
To: Jane Chu <jane.chu@oracle.com>
CC: <linux-mm@kvack.org>, <stable@vger.kernel.org>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@kernel.org>, <jiaqiyan@google.com>,
	<william.roche@oracle.com>, <rientjes@google.com>,
	<akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@Oracle.com>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <willy@infradead.org>, <clm@meta.com>, linux-kernel
	<linux-kernel@vger.kernel.org>
References: <20260116203834.3179551-1-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <958f1e3a-3c40-51ae-8fac-a185e76aa940@huawei.com>
Date: Tue, 20 Jan 2026 19:54:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260116203834.3179551-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210497-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E24C5510ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/1/17 4:38, Jane Chu wrote:
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
> Fixes: 18f41fa616ee ("mm: memory-failure: bump memory failure stats to pglist_data")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

This patch looks good to me with some nits below.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
> v5 -> v6:
>   comments from Miaohe.
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
> ---
>  mm/memory-failure.c | 91 +++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c80c2907da33..49ced16e9c1a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1883,12 +1883,22 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  	return count;
>  }
>  
> -static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
> +#define	MF_HUGETLB_FREED		0	/* freed hugepage */
> +#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
> +#define	MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
> +#define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
> +#define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
> +#define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
> +/*
> + * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
> + * to keep track of the poisoned pages.
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
> @@ -1896,20 +1906,17 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
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
> @@ -1957,42 +1964,38 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>  
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
>  	bool count_increased = false;
> +	int ret, rc;
>  
> -	if (!folio_test_hugetlb(folio))
> +	if (!folio_test_hugetlb(folio)) {
> +		ret = MF_HUGETLB_NON_HUGEPAGE;
>  		goto out;
> -
> -	if (flags & MF_COUNT_INCREASED) {
> -		ret = 1;
> +	} else if (flags & MF_COUNT_INCREASED) {
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

IIRC, code style requires {} here. .i.e

if (folio_try_get(folio)) {
	ret = MF_HUGETLB_IN_USED;
	count_increased = true;
} else {
	ret = MF_HUGETLB_FREED;
}

>  	} else {
> -		ret = -EBUSY;
> +		ret = MF_HUGETLB_RETRY;
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
> @@ -2017,10 +2020,15 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   * with basic operations like hugepage allocation/free/demotion.
>   * So some of prechecks for hwpoison (pinning, and testing/setting
>   * PageHWPoison) should be done in single hugetlb_lock range.
> + * Returns:
> + *	0		- not hugetlb, or recovered
> + *	-EBUSY		- not recovered
> + *	-EOPNOTSUPP	- hwpoison_filter'ed
> + *	-EHWPOISON	- folio or exact page already poisoned

-EFAULT can be returned when kill_accessing_process finds p->mm is null. So it might be better
to comment EFAULT case too.

Thanks.
.

