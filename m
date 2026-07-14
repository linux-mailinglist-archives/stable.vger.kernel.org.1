Return-Path: <stable+bounces-274071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fJt/Gf+UVWq/qQAAu9opvQ
	(envelope-from <stable+bounces-274071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:46:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB47502B9
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:46:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=RRpYOdHo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274071-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274071-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93E8301ECCC
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFF37189C;
	Tue, 14 Jul 2026 01:45:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147936F8E9;
	Tue, 14 Jul 2026 01:45:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993519; cv=none; b=kb+8DrDxPoLrk8qy21Y0u+hETvOsqX2Z4PO6EhcHphfVHS6+0t8TLuRUA6oJpKjElEta1Nj8THy00lGcVoExsooYOtpM/iXmF0GeOAosBplaiUtUWJIB2ooRmP5AjcNF/kUFKgThClK3sE+BNAgWkbJsPWnUMF47fqfbW8ZIgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993519; c=relaxed/simple;
	bh=i4ZxDO/+ykOXbwAN08DoAk0+quv4IMY8M8ZcR6U7YrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BpCxI4JA7BuR10NOXVeByvC8WmKrqyD3+sytBA1BFHAmysE1vQSA/Z+08FWgnHVeDWEEh+ncvjCBKZJVJ4vvcV+C3UfKPJa3tgZy9XK7X5V6F4+GhLWag28CRQ0UsZPgKh8qjxKmvrKCHNZlYRX4PhjYMaMlcuwsLv0AwP5c4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RRpYOdHo; arc=none smtp.client-ip=113.46.200.220
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=++7rftVlakMrFKrEO4lbgQgtkLGmOkhVD/bI4OObalE=;
	b=RRpYOdHoz6aig9ixOWmUmHZ6DUP+FRy4yp9nJIvt1oWKQardHIM6lNOfdg4+SQio5nDymzU2T
	g0eQmUzNqJQaSauuPYuMvyl50Fv1V3ReK3mFS0Nw0UBIlRTFUGMMExz1RsZP01r1nA0i4Sf0Rre
	HGmNlL8ajvtOuwDwcP/YmUY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gzhhG52WKz12LCc;
	Tue, 14 Jul 2026 09:35:26 +0800 (CST)
Received: from kwepemo200010.china.huawei.com (unknown [7.202.195.178])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A8004057D;
	Tue, 14 Jul 2026 09:45:05 +0800 (CST)
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemo200010.china.huawei.com (7.202.195.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 09:45:04 +0800
Message-ID: <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>
Date: Tue, 14 Jul 2026 09:45:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable/linux-6.6.y] mm/memory-failure: fix missing
 ->mf_stats count when hugetlb folio already poisoned
To: Naoya Horiguchi <naoya.horiguchi@nec.com>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Miaohe Lin <linmiaohe@huawei.com>
CC: Jane Chu <jane.chu@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>,
	<wangkefeng.wang@huawei.com>, <stable@vger.kernel.org>, <xiqi2@huawei.com>
References: <20260706084118.1284271-1-xiqi2@huawei.com>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <20260706084118.1284271-1-xiqi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo200010.china.huawei.com (7.202.195.178)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274071-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:naoya.horiguchi@nec.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:linmiaohe@huawei.com,m:jane.chu@oracle.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:sunnanyong@huawei.com,m:wangkefeng.wang@huawei.com,m:stable@vger.kernel.org,m:xiqi2@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xiqi2@huawei.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiqi2@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:mid,huawei.com:email,huawei.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCAB47502B9

Add stable@ to Cc.

On 06/07/2026 16:41, Qi Xi wrote:
> When a new subpage is poisoned on a hugetlb folio that has already been
> marked hwpoison (MF_HUGETLB_FOLIO_PRE_POISONED), hugetlb_update_hwpoison()
> increments num_poisoned_pages directly, but the per-node ->mf_stats is
> not updated because this path bypasses action_result(). This leaves the
> two accounting counters inconsistent within the hardware memory-failure
> path: a new poison event is counted in num_poisoned_pages but not reflected
> in the per-node mf_stats.
>
> In mainline, commit a148a2040191 ("mm/memory-failure: fix missing
> ->mf_stats count in hugetlb poison") fixed this by removing the direct
> num_poisoned_pages_inc() from the helper and adding action_result() calls
> in try_memory_failure_hugetlb() for the already-poisoned cases. The
> backport to linux-6.6.y as commit 252bb328b36f ("mm/memory-failure: fix
> missing ->mf_stats count in hugetlb poison") applied the refactoring
> (naming, constants, switch-case) but omitted the core counting fix,
> leaving the inconsistency in place.
>
> Fix this by adding a matching update_per_node_mf_stats() call alongside
> the existing num_poisoned_pages_inc() in the same block, so both counters
> stay consistent without restructuring the error path.
>
> Fixes: 252bb328b36f ("mm/memory-failure: fix missing ->mf_stats count in hugetlb poison")
> Signed-off-by: Qi Xi <xiqi2@huawei.com>
> ---
>   mm/memory-failure.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 86cdf36ee3bb..5f9203bf8ec1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1947,8 +1947,10 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>   		raw_hwp->page = page;
>   		llist_add(&raw_hwp->node, head);
>   		/* the first error event will be counted in action_result(). */
> -		if (ret)
> +		if (ret) {
>   			num_poisoned_pages_inc(page_to_pfn(page));
> +			update_per_node_mf_stats(page_to_pfn(page), MF_FAILED);
> +		}
>   	} else {
>   		/*
>   		 * Failed to save raw error info.  We no longer trace all

