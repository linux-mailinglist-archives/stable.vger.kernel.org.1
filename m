Return-Path: <stable+bounces-182020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D998BAB6B6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196903AB20F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD5235061;
	Tue, 30 Sep 2025 04:50:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC5288DB;
	Tue, 30 Sep 2025 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207829; cv=none; b=ngXKXd1v/yglbO8mMPmjOole/0tsMT22D3qea5kdvTAtG+v8jMm+fdpONgQqMzt05lxQ7Bq4x0CK3tt0n/MHkFxDfo0OOeRYC9JxjMKCQu3Keb1zEfSb4xUIfJWbXGLAomk9wcYEhXW2ohfEtKhkuacgAq5ImOlSpF15CKqD0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207829; c=relaxed/simple;
	bh=q7JKcLc5rFsue9IeSq60djpSLcwWdKNibnqwpCcjTG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxnBxFxiZyjDotR//q50SD4+CVPJVcDaCQoqPlpr3vGW7aTR+4Yz9C3Kgs3aBv5wL0f0pQq4BoQhMkCIkQldveUT4M+xCBt8CtAe6SqPZt6Si6O3k1n8yMX/yKEH410Qc1OooyzF5kmXXCDt4IrkanH/lhfLnCvBgbTpLbSJadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70691424;
	Mon, 29 Sep 2025 21:50:17 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78AB33F66E;
	Mon, 29 Sep 2025 21:50:17 -0700 (PDT)
Message-ID: <0c498301-7434-4b2b-b7bc-73abe2057b67@arm.com>
Date: Tue, 30 Sep 2025 10:20:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, ryan.roberts@arm.com, npache@redhat.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 usamaarif642@gmail.com, yuzhao@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250930043351.34927-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250930043351.34927-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/09/25 10:03 am, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> When splitting an mTHP and replacing a zero-filled subpage with the shared
> zeropage, try_to_map_unused_to_zeropage() currently drops several important
> PTE bits.
>
> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
> incremental snapshots, losing the soft-dirty bit means modified pages are
> missed, leading to inconsistent memory state after restore.
>
> As pointed out by David, the more critical uffd-wp bit is also dropped.
> This breaks the userfaultfd write-protection mechanism, causing writes
> to be silently missed by monitoring applications, which can lead to data
> corruption.
>
> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
> creating the new zeropage mapping to ensure they are correctly tracked.
>
> Cc: <stable@vger.kernel.org>
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v1 -> v2:
>   - Avoid calling ptep_get() multiple times (per Dev)
>   - Double-check the uffd-wp bit (per David)
>   - Collect Acked-by from David - thanks!
>   - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/
>
>   mm/migrate.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ce83c2c3c287..50aa91d9ab4e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -300,13 +300,14 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   					  unsigned long idx)
>   {
>   	struct page *page = folio_page(folio, idx);
> +	pte_t oldpte = ptep_get(pvmw->pte);

What I meant to say was, you can pass oldpte from remove_migration_pte to this
function. Basically define old_pte = ptep_get(pvmw.pte) in the declarations of
the start of the while block in remove_migration_pte and remove the existing
one. That will ensure ptep_get() gets called only once per iteration.

>   	pte_t newpte;
>   
>   	if (PageCompound(page))
>   		return false;
>   	VM_BUG_ON_PAGE(!PageAnon(page), page);
>   	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> +	VM_BUG_ON_PAGE(pte_present(oldpte), page);
>   
>   	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>   	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> @@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   
>   	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>   					pvmw->vma->vm_page_prot));
> +
> +	if (pte_swp_soft_dirty(oldpte))
> +		newpte = pte_mksoft_dirty(newpte);
> +	if (pte_swp_uffd_wp(oldpte))
> +		newpte = pte_mkuffd_wp(newpte);
> +
>   	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>   
>   	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));

