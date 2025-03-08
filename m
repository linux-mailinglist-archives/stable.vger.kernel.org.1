Return-Path: <stable+bounces-121526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778AA577CB
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 04:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9842F7A8157
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08454F8C;
	Sat,  8 Mar 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dqMSs7qi"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E8182CD;
	Sat,  8 Mar 2025 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741403048; cv=none; b=lE1+E1Rp4BhAUvytRXG9TUU1LuGhRTIS7HDdiwwO4Ur56c4O2L5FnWdsmFC/maS6TtH8YMej6eZjOMbZ+4BvrTxKUwDQGNowhbQUgrpZfNDqntyvaoj8vaobmZyfhfGKENAZpcn8lrXBPcmXx0owlPwQ+oI81/dXA2gZBAleAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741403048; c=relaxed/simple;
	bh=ueLBGNQ3QKmyrdZPjUrFVyltMuc0Q0BmNicBG5Ct8VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkmHJvrQCDTB0kfMZoCKs83e4+mEJXTOW/Ufwk4JI9oy2Ih2ES7uFKjSKeRsBv0E9+c8W2fQn2K09PfLqPlt9nPwqkqVjJVKM4R/m06GB0XHsXKLh0yMUw6yDnpntZCxG/iJNOh6u2rhaEuwetui4nlB3UehRi5POYQR4bHF/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dqMSs7qi; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741403041; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F93G/xQwuaQ+L3SjO6Q3R0jadY1LvGXIeiTnrx0dWo0=;
	b=dqMSs7qi4lCOSXYaDd6/0h+SshGGGOsbMxamAQ6/5hXHHVC++xlhzCUcDdtCVotxMpwxNCXgKvI1Yy7dYmnAlyBCJJCpGJmVyGcNYQswZXOtdQRQjn29JWRtz0Jx3m0KUW24qPTFM1C687DzBR8YwYCBLS3IEZxt9zKJt16BC84=
Received: from 30.221.80.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQtkU0i_1741403039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Mar 2025 11:03:59 +0800
Message-ID: <b59be306-e891-4957-b50c-103d941d0b7e@linux.alibaba.com>
Date: Sat, 8 Mar 2025 11:03:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/migrate: fix shmem xarray update during migration
To: Zi Yan <ziy@nvidia.com>, Liu Shixin <liushixin2@huawei.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song
 <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305200403.2822855-1-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250305200403.2822855-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/6 04:04, Zi Yan wrote:
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

Thanks for fixing the issue.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/migrate.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fb4afd31baf0..c0adea67cd62 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -518,15 +518,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   	if (folio_test_anon(folio) && folio_test_large(folio))
>   		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>   	folio_ref_add(newfolio, nr); /* add cache reference */
> -	if (folio_test_swapbacked(folio)) {
> +	if (folio_test_swapbacked(folio))
>   		__folio_set_swapbacked(newfolio);
> -		if (folio_test_swapcache(folio)) {
> -			folio_set_swapcache(newfolio);
> -			newfolio->private = folio_get_private(folio);
> -		}
> +	if (folio_test_swapcache(folio)) {
> +		folio_set_swapcache(newfolio);
> +		newfolio->private = folio_get_private(folio);
>   		entries = nr;
>   	} else {
> -		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>   		entries = 1;
>   	}
>   

