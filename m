Return-Path: <stable+bounces-181859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70749BA7F24
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 06:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224473A4187
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 04:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F841386C9;
	Mon, 29 Sep 2025 04:44:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6A34BA50;
	Mon, 29 Sep 2025 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759121065; cv=none; b=jVQ53MjRKRisBbEQSFSjD0uLoPQUGEC9B7G0jnGeBc04B9DT+F9onR0VTmx/Lgo9aN9QU9dTgKkQQlsQBvHR6dwqQ7ZIGC7UP0/9GkaVS7wvn3CJdGd25xFEXEnjQUuWFGMnGMl/0EWR5QqFiJUrilU5z3UA2hc3vzM0HceBUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759121065; c=relaxed/simple;
	bh=3ZXXQLU0QKxHT4JrTnlId2Pc9wqCYziE2zGHji+O02Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCZeRvbGZ3hZ5SsVIfhflYrYpkB74460X7xZEQcwMOwI2A7WEkIgwBDZYzzX+DfHC8SYu8vJnNk9w/GJsTnIAFoRWuozsBZxP7a5bMxNYlJ95HP+ZPkvJhpgFkyi06bQg/2UmeFRqucf/PTU00pWWoKdKgjUlKNL2XbHhgbQpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AA0C150C;
	Sun, 28 Sep 2025 21:44:14 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37BD83F66E;
	Sun, 28 Sep 2025 21:44:13 -0700 (PDT)
Message-ID: <2065263d-a2c0-437e-a096-695c6d17f97a@arm.com>
Date: Mon, 29 Sep 2025 10:14:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping
 zero-filled mTHP subpage to shared zeropage
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org
References: <20250928044855.76359-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250928044855.76359-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 28/09/25 10:18 am, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> When splitting an mTHP and replacing a zero-filled subpage with the shared
> zeropage, try_to_map_unused_to_zeropage() currently drops the soft-dirty
> bit.
>
> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
> incremental snapshots, losing this bit means modified pages are missed,
> leading to inconsistent memory state after restore.
>
> Preserve the soft-dirty bit from the old PTE when creating the zeropage
> mapping to ensure modified pages are correctly tracked.
>
> Cc: <stable@vger.kernel.org>
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/migrate.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ce83c2c3c287..bf364ba07a3f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   
>   	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>   					pvmw->vma->vm_page_prot));
> +
> +	if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
> +		newpte = pte_mksoft_dirty(newpte);
> +
>   	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>   
>   	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));

I think this should work.

You can pass old_pte = ptep_get(pvmw->pte) to this function to avoid calling ptep_get()
multiple times.


