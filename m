Return-Path: <stable+bounces-66014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE0294B9A1
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4030E1C21A97
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D96146A93;
	Thu,  8 Aug 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yZayPp/n"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0208C0B;
	Thu,  8 Aug 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109143; cv=none; b=uEIQS+4OAmXgEjDSunQdBDZ20/zVKFbHZSwJhK0OFF1WyLTxnNLON0ewg5SyQFtbag6/yIy42M+ufZeWKUV1PFoIker/56sxaQ3XAs6xBA4Y4C9zNfPUtRWzm9b42oDt5BtVXvzmCgwY5XoyYCmrq9zjlwZsSgfdZaZ6R7jU5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109143; c=relaxed/simple;
	bh=Bs/fM66kNUesp8I3kdiBJAsvR94cBNh+5NInJ20SHDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z71EJe8swePqeSJhnkWg0YLQ4T0qKP0LV/3DrFCgeyLRnPliBhJRPxjnoUuIxcfv5RIMDIXpuY6CwTHgJfmY8ZyDGt+TXCD9HixN6ys32zvLIV2ajhwd6mtpm66X3PFakVn+NXjmuDaQ81Hd+dUcHp2JRcCQ3AT0yTAaa1CaIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yZayPp/n; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723109138; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pXCJkAPkhTG7MXZaWb8NJHl6lRqrO2/QVfKwU5lsJJY=;
	b=yZayPp/n/RFQDb+Ns3z6jnbfAjKjhEgQ6VW6yR9rGvwo+5INE6FMB3WmpFvzGH/YAV1ZjibUKEgbv2LQ60ETk//SKZ9LF/0/uFa0zOzyWuGnMk/ve688t6hyK89JZfHz581eUPqA/VMr8QEvk0uK1mnu24aPIOrOwBCIPbDXtMQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WCM6yhO_1723109137;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCM6yhO_1723109137)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 17:25:38 +0800
Message-ID: <3a509a3a-9bdd-4f7e-a3a8-309739776d28@linux.alibaba.com>
Date: Thu, 8 Aug 2024 17:25:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
To: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/8 16:22, David Hildenbrand wrote:
> On 08.08.24 05:19, Baolin Wang wrote:
>>
>>
>> On 2024/8/8 02:47, Zi Yan wrote:
>>> When handling a numa page fault, task_numa_fault() should be called by a
>>> process that restores the page table of the faulted folio to avoid
>>> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
>>> TLB flush via delaying mapping on hint page fault") restructured
>>> do_numa_page() and do_huge_pmd_numa_page() and did not avoid
>>> task_numa_fault() call in the second page table check after a numa
>>> migration failure. Fix it by making all !pte_same()/!pmd_same() return
>>> immediately.
>>>
>>> This issue can cause task_numa_fault() being called more than necessary
>>> and lead to unexpected numa balancing results (It is hard to tell 
>>> whether
>>> the issue will cause positive or negative performance impact due to
>>> duplicated numa fault counting).
>>>
>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>> Closes: 
>>> https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying 
>>> mapping on hint page fault")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>
>> The fix looks reasonable to me. Feel free to add:
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> (Nit: These goto labels are a bit confusing and might need some cleanup
>> in the future.)
> 
> Agreed, maybe we should simply handle that right away and replace the 
> "goto out;" users by "return 0;".
> 
> Then, just copy the 3 LOC.
> 
> For mm/memory.c that would be:
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 67496dc5064f..410ba50ca746 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
> 
>          if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>                  pte_unmap_unlock(vmf->pte, vmf->ptl);
> -               goto out;
> +               return 0;
>          }
> 
>          pte = pte_modify(old_pte, vma->vm_page_prot);
> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault 
> *vmf)
>                  vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>                                                 vmf->address, &vmf->ptl);
>                  if (unlikely(!vmf->pte))
> -                       goto out;
> +                       return 0;
>                  if (unlikely(!pte_same(ptep_get(vmf->pte), 
> vmf->orig_pte))) {
>                          pte_unmap_unlock(vmf->pte, vmf->ptl);
> -                       goto out;
> +                       return 0;
>                  }
>                  goto out_map;
>          }
> 
> -out:
>          if (nid != NUMA_NO_NODE)
>                  task_numa_fault(last_cpupid, nid, nr_pages, flags);
>          return 0;
> @@ -5552,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>                  numa_rebuild_single_mapping(vmf, vma, vmf->address, 
> vmf->pte,
>                                              writable);
>          pte_unmap_unlock(vmf->pte, vmf->ptl);
> -       goto out;
> +       if (nid != NUMA_NO_NODE)
> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
> +       return 0;
>   }

Thanks. Looks better:)

