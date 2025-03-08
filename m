Return-Path: <stable+bounces-121527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCDA577D5
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 04:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2554518987E3
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9472B33987;
	Sat,  8 Mar 2025 03:17:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128F33E4;
	Sat,  8 Mar 2025 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741403868; cv=none; b=F88qsY2Gwf0B8A4+1BhEvs1uconABmDMP3HZAkORGGXoFzEAg9eAHjoXAgkr4ML4nIN8pBdRfFohlxhUtfYFOyQXRoE84GvPpi3N64ZAgsq9weTbNByJRjdxebQZxwDT8UNoOf04OC4k4fr8iBIY95iD+QssakT0o8kBYBWDmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741403868; c=relaxed/simple;
	bh=LcG19RuXtMOcSaf4ikCJ4v1EU2os9GEM0FqhrYn1QLw=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ewPN6hvI6LkElGbUAQuqCBP1OtGyErp1TEIhEFna1AA7OHoizmFkW6udic2Qb3OyN5pWktTG3KB80egl9yVqf7yyQsSxznJ2YTp57uiamW1c0ncKVHg5fBhZUwUdE1eJAXl+vq06mfy3cCyM40DlEDB1TrQCI+Xc5jWHxZx9KLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z8pBt3gs9z2SSjT;
	Sat,  8 Mar 2025 11:13:26 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 909131402C3;
	Sat,  8 Mar 2025 11:17:42 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 kwepemg200013.china.huawei.com (7.202.181.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Mar 2025 11:17:41 +0800
Subject: Re: [PATCH v3] mm/migrate: fix shmem xarray update during migration
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	<linux-mm@kvack.org>
References: <20250305200403.2822855-1-ziy@nvidia.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, Hugh Dickins
	<hughd@google.com>, Charan Teja Kalla <quic_charante@quicinc.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <00295311-2367-e210-c0bb-e410ba84d4ac@huawei.com>
Date: Sat, 8 Mar 2025 11:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250305200403.2822855-1-ziy@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200013.china.huawei.com (7.202.181.64)



On 2025/3/6 4:04, Zi Yan wrote:
> A shmem folio can be either in page cache or in swap cache, but not at the
> same time. Namely, once it is in swap cache, folio->mapping should be NULL,
> and the folio is no longer in a shmem mapping.
>
> In __folio_migrate_mapping(), to determine the number of xarray entries
> to update, folio_test_swapbacked() is used, but that conflates shmem in
> page cache case and shmem in swap cache case. It leads to xarray
> multi-index entry corruption, since it turns a sibling entry to a
> normal entry during xas_store() (see [1] for a userspace reproduction).
> Fix it by only using folio_test_swapcache() to determine whether xarray
> is storing swap cache entries or not to choose the right number of xarray
> entries to update.
>
> [1] https://lore.kernel.org/linux-mm/Z8idPCkaJW1IChjT@casper.infradead.org/
>
> Note:
> In __split_huge_page(), folio_test_anon() && folio_test_swapcache() is used
> to get swap_cache address space, but that ignores the shmem folio in swap
> cache case. It could lead to NULL pointer dereferencing when a
> in-swap-cache shmem folio is split at __xa_store(), since
> !folio_test_anon() is true and folio->mapping is NULL. But fortunately,
> its caller split_huge_page_to_list_to_order() bails out early with EBUSY
> when folio->mapping is NULL. So no need to take care of it here.
>
> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> Reported-by: Liu Shixin <liushixin2@huawei.com>
> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org
Thanks for the patch, it works for me.
> ---
>  mm/migrate.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fb4afd31baf0..c0adea67cd62 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -518,15 +518,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>  	if (folio_test_anon(folio) && folio_test_large(folio))
>  		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>  	folio_ref_add(newfolio, nr); /* add cache reference */
> -	if (folio_test_swapbacked(folio)) {
> +	if (folio_test_swapbacked(folio))
>  		__folio_set_swapbacked(newfolio);
> -		if (folio_test_swapcache(folio)) {
> -			folio_set_swapcache(newfolio);
> -			newfolio->private = folio_get_private(folio);
> -		}
> +	if (folio_test_swapcache(folio)) {
> +		folio_set_swapcache(newfolio);
> +		newfolio->private = folio_get_private(folio);
>  		entries = nr;
>  	} else {
> -		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>  		entries = 1;
>  	}
>  


