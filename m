Return-Path: <stable+bounces-183013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9153BB2AF0
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CE13C20B1
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0B2BE641;
	Thu,  2 Oct 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="loFmx088"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6833F6
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389976; cv=none; b=GOTOC2++IRuu/ppyPKM3hXaARoVn2lx6z/aHb95z8JRKNvvvkFrjrOIco0omFCFyyvZkQ2MuIe7GBnGXqRorj0YXd4UywjpxLMBHvsyyywKoByyOqyXTzlukim6p/WkCDdE/WXlK1r636h/ZA6J/o7F+wznMCv9fX1hoFRyA7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389976; c=relaxed/simple;
	bh=2W4uiY8ft3y/Z+5ko7tsg8AH03/ohFyUdLkL1/HsEVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r22NIH5EH7KAW1XBYmkfRS5KGJxkq2Cm3sbPaZ/D2beBux2oytre/THm7DSE6Yshy2ShKSFB6KtMnnrDtWom7+yyr0BCP1RtxfonUwwRVAf7ydiJus1txlNoAOexnfXphfd3wqgfjoR2SvZQm5RPtXtQMNAxING1Ar8PBiIcjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=loFmx088; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6788269-ac34-407a-9a5c-b94a90724a52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759389971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcfqctUWyMyKjwwrVZORei8dkKTWNNNgmJPwVrqv29Y=;
	b=loFmx0885gwXjnfIOCVEplFjluOdPJ+4irqQ3udyeTsxUCFyE9/aKOMTcQGJipS4gutdlD
	JKieqM6UTA3YPS8U1/l3j+/HvX4J4v5g9LWuRj9MABc3ed/X6W/QiRQCHOIXJbHw4jJmgp
	348lCGCcsfsBDoVc2k11eeV3ojgVJK8=
Date: Thu, 2 Oct 2025 15:26:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, npache@redhat.com,
 lorenzo.stoakes@oracle.com, baohua@kernel.org, ziy@nvidia.com,
 dev.jain@arm.com, wangkefeng.wang@huawei.com, baolin.wang@linux.alibaba.com,
 david@redhat.com, ryan.roberts@arm.com, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/2 09:38, Wei Yang wrote:
> We add pmd folio into ds_queue on the first page fault in
> __do_huge_pmd_anonymous_page(), so that we can split it in case of
> memory pressure. This should be the same for a pmd folio during wp
> page fault.
> 
> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
> to add it to ds_queue, which means system may not reclaim enough memory
> in case of memory pressure even the pmd folio is under used.
> 
> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
> folio installation consistent.
> 
> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: <stable@vger.kernel.org>

Cool. LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 
> ---
> v2:
>    * add fix, cc stable and put description about the flow of current
>      code
>    * move deferred_split_folio() into map_anon_folio_pmd()
> ---
>   mm/huge_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1b81680b4225..f13de93637bf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1232,6 +1232,7 @@ static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
>   	count_vm_event(THP_FAULT_ALLOC);
>   	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>   	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +	deferred_split_folio(folio, false);
>   }
>   
>   static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> @@ -1272,7 +1273,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>   		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>   		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
>   		mm_inc_nr_ptes(vma->vm_mm);
> -		deferred_split_folio(folio, false);
>   		spin_unlock(vmf->ptl);
>   	}
>   


