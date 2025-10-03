Return-Path: <stable+bounces-183229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512BBB7132
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D97204EBADC
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8818FC97;
	Fri,  3 Oct 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iMS901TJ"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E56134BD
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499387; cv=none; b=EXqo6pOwLpcgO1Ue+7cBXiuc8OH0wSqf2zdeb48FbssbR2JnWx7A2xG4w17uIjWu/hlycdNDTOgTMkWyn9dpuYnqi8AMg3Am+eXdYg5LH55C5LO0wxluWgz1wmiGXKcw2sZPKN/ecLTP16yvHUwSbq9aDpN20w+g1ylnfF9bpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499387; c=relaxed/simple;
	bh=ltOfk9/oigyxPNEs7cigl7qhUXMxN4/fNEU7LKXx2FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+qGch0nU6COdHrOJ39prn8Z75gdPEQgSD9NbHhqVJN/U+0R5QpJ84s0y0XLlLPmRbn2lKGsneE0fhddehkqWj5DFbczy2F5rY0MVg2VGQ6u9IUOBPCrSy7Dj3SVrZFibY0YpNXi6jYf0073RgG2/Dkd/EuPFwne2i+Gzivh6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iMS901TJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759499382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1O4lGRBUIO8tMHHDJsnRMdq/TLfJSS09aZziMz7CPOo=;
	b=iMS901TJmkXV6yhuEmITcV9H9/1QSDuf7iyoTHlxjbI7yzc8sOXgRL4HpfNEJI4k4vF+8K
	SNUi5sAKcTdp2Fj8BHxwrCU38Mnz4T5nKS4QjqdxdSB9l7OYu+kEJgEdqyvrY4xgS3dgdA
	PbsZWQ2G1tPlvaK0Q0rurQ3k0NP08Cc=
Date: Fri, 3 Oct 2025 21:49:28 +0800
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
Cc: linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 wangkefeng.wang@huawei.com, stable@vger.kernel.org, ziy@nvidia.com,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com,
 baohua@kernel.org, akpm@linux-foundation.org, david@redhat.com
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hey Wei,

On 2025/10/2 09:38, Wei Yang wrote:
> We add pmd folio into ds_queue on the first page fault in
> __do_huge_pmd_anonymous_page(), so that we can split it in case of
> memory pressure. This should be the same for a pmd folio during wp
> page fault.
> 
> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
> to add it to ds_queue, which means system may not reclaim enough memory

IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
started unconditionally adding all new anon THPs to _deferred_list :)

> in case of memory pressure even the pmd folio is under used.
> 
> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
> folio installation consistent.
> 
> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")

Shouldn't this rather be the following?

Fixes: dafff3f4c850 ("mm: split underused THPs")

Thanks,
Lance

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: <stable@vger.kernel.org>
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


