Return-Path: <stable+bounces-208423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E59D22E1F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B53B305CA8C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1A4325709;
	Thu, 15 Jan 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i8Qvm3nu";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i8Qvm3nu"
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C2285CAD;
	Thu, 15 Jan 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462618; cv=none; b=tyjGZvR6C5lWtszTH0zDMozSNsi85GkHmrxvjyuQqhCm25d7ExZb62lAwfES9FtWB0WSR6FGv/RM1iW7F1Nrb0exVWJ9WKdZtd5kU+F8MvgiQbKluOVqLGkBO9uJrsld9ZE/OgdGYieLJYQ4yIllmbiUZb9huugZxPgW1BFUvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462618; c=relaxed/simple;
	bh=MFWD60bjt2BHBEvzteHaV3yEy3QRGTMGczIUP59R9po=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OmxBD2UZSf4Fgv26hudKxAjUeivogPgtg8mp5Nh6gQNOeJ5fnvxE9jTHSb8oROcnpnlL2heNbBJJpiebcrMgW2udLx7KhCiVyFLQ1DpJgey6Nkpc1E7pUMaDFfXDot9fgDkXqDEIn0QLZiDsvenq3M6LIm+7GSjnyI3+l+hPiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i8Qvm3nu; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i8Qvm3nu; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wsoHXfGKt3B/B51JXv3tTX74yFtx2NWnS0/4JwvnR94=;
	b=i8Qvm3nu/VrzIgSeNDlupJ4SKtpdE219Zwf1kWeu9muK6WUKjeH0v0gMqSgODD5Ut9XcSPmrR
	axriDflO0fCWvLgFLhI0uBHzEhf7kik53beMcsiPVzIrru4LXv2cPjy/IuTQ80/Rw7E+M70GwIU
	gVnMEcnXDOxM4x9c2WNk4ag=
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dsFDD1r8mz1BG9d;
	Thu, 15 Jan 2026 15:36:44 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wsoHXfGKt3B/B51JXv3tTX74yFtx2NWnS0/4JwvnR94=;
	b=i8Qvm3nu/VrzIgSeNDlupJ4SKtpdE219Zwf1kWeu9muK6WUKjeH0v0gMqSgODD5Ut9XcSPmrR
	axriDflO0fCWvLgFLhI0uBHzEhf7kik53beMcsiPVzIrru4LXv2cPjy/IuTQ80/Rw7E+M70GwIU
	gVnMEcnXDOxM4x9c2WNk4ag=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dsF8X4QHXz1K96Q;
	Thu, 15 Jan 2026 15:33:32 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B0AE6402AB;
	Thu, 15 Jan 2026 15:36:50 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 15:36:50 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 15:36:49 +0800
Subject: Re: [PATCH v5 2/2] mm/memory-failure: teach kill_accessing_process to
 accept hugetlb tail page pfn
To: Jane Chu <jane.chu@oracle.com>
CC: <linux-mm@kvack.org>, <stable@vger.kernel.org>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@kernel.org>, <jiaqiyan@google.com>,
	<william.roche@oracle.com>, <rientjes@google.com>,
	<akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@Oracle.com>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <willy@infradead.org>, <clm@meta.com>, linux-kernel
	<linux-kernel@vger.kernel.org>
References: <20260114213721.2295844-1-jane.chu@oracle.com>
 <20260114213721.2295844-2-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d925a432-2773-3a02-6bf6-99a2e5e83727@huawei.com>
Date: Thu, 15 Jan 2026 15:36:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260114213721.2295844-2-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/1/15 5:37, Jane Chu wrote:
> When a hugetlb folio is being poisoned again, try_memory_failure_hugetlb()
> passed head pfn to kill_accessing_process(), that is not right.
> The precise pfn of the poisoned page should be used in order to
> determine the precise vaddr as the SIGBUS payload.
> 
> This issue has already been taken care of in the normal path, that is,
> hwpoison_user_mappings(), see [1][2].  Further more, for [3] to work
> correctly in the hugetlb repoisoning case, it's essential to inform
> VM the precise poisoned page, not the head page.
> 
> [1] https://lkml.kernel.org/r/20231218135837.3310403-1-willy@infradead.org
> [2] https://lkml.kernel.org/r/20250224211445.2663312-1-jane.chu@oracle.com
> [3] https://lore.kernel.org/lkml/20251116013223.1557158-1-jiaqiyan@google.com/
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
> v5, v4: No change.
> v2 -> v3:
>   incorporated suggestions from Miaohe and Matthew.
> v1 -> v2:
>   pickup R-B, add stable to cc list.
> ---
>  mm/memory-failure.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2563718c34c6..f6b806499caa 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -692,6 +692,8 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>  				unsigned long poisoned_pfn, struct to_kill *tk)
>  {
>  	unsigned long pfn = 0;
> +	unsigned long hwpoison_vaddr;
> +	unsigned long mask;
>  
>  	if (pte_present(pte)) {
>  		pfn = pte_pfn(pte);
> @@ -702,10 +704,12 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>  			pfn = softleaf_to_pfn(entry);
>  	}
>  
> -	if (!pfn || pfn != poisoned_pfn)
> +	mask = ~((1UL << (shift - PAGE_SHIFT)) - 1);
> +	if (!pfn || ((pfn & mask) != (poisoned_pfn & mask)))
>  		return 0;

Nit: Maybe "(!pfn || pfn != (poisoned_pfn & mask))" is enough?

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.


