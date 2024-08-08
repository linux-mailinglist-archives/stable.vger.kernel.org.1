Return-Path: <stable+bounces-65987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5594B566
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 05:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EB41C21A2B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 03:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFD2CCC2;
	Thu,  8 Aug 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F0rHUfO2"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4926AF7;
	Thu,  8 Aug 2024 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087192; cv=none; b=MTCp45M8QE/m22Y8/gvKwGQt7pHuRlZuEyIl75vzEmPR8XgG7QbvzdgUdK5/a5W9c86YUp9x286EfFqkG0GNPzBU0TaC9ZGTkCy6r66K3X+K7VstzKYlJ3FP+xFSyY/hjjeQvV3zYdf1CZ6L4f8BffwADk+COhRPjZFOwApHZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087192; c=relaxed/simple;
	bh=87CxHOKq0kNJehvIMkR7RL19dZosGYXI/PahHRyFwJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6iMre8GKZ2n2C6XJZNtHizJ0cVzakm8v7gCFwjKc1Nz+Mjy+UFzJjoyaqLQa26xl9fNIp22FQ3BFIprtfkNjghHBVgfijnpKlL+PwUkCkOPsbVE/EyGNudlpeyhMaZz0fYFEq3EzRciZ60S2FLdS6F/AU915OYxzUfROWBfozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F0rHUfO2; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723087180; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0rkHMmEUTOaBgGZOGrto0UZr62DAOrQ41ZYJAPw9h/E=;
	b=F0rHUfO2XjZ9YbdHovDUUrDPy3y90nRoC3qBva24VH2q6CGgZRTJdgsyH0/LgSSGZMr+88CNsC84jTW8VdGsCHLSdTXH/NEZPa8steYXPfdyjaqavjD47/DpK90hJ9oEMuQlMxkCpU5hA3YxSvGu+0t4cczPsyGZG5hKiJkzgYk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WCKrVau_1723087178;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCKrVau_1723087178)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 11:19:39 +0800
Message-ID: <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
Date: Thu, 8 Aug 2024 11:19:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240807184730.1266736-1-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240807184730.1266736-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/8 02:47, Zi Yan wrote:
> When handling a numa page fault, task_numa_fault() should be called by a
> process that restores the page table of the faulted folio to avoid
> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
> TLB flush via delaying mapping on hint page fault") restructured
> do_numa_page() and do_huge_pmd_numa_page() and did not avoid
> task_numa_fault() call in the second page table check after a numa
> migration failure. Fix it by making all !pte_same()/!pmd_same() return
> immediately.
> 
> This issue can cause task_numa_fault() being called more than necessary
> and lead to unexpected numa balancing results (It is hard to tell whether
> the issue will cause positive or negative performance impact due to
> duplicated numa fault counting).
> 
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

The fix looks reasonable to me. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

(Nit: These goto labels are a bit confusing and might need some cleanup 
in the future.)

> ---
>   mm/huge_memory.c | 5 +++--
>   mm/memory.c      | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0024266dea0a..a3c018f2b554 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1734,10 +1734,11 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   		goto out_map;
>   	}
>   
> -out:
> +count_fault:
>   	if (nid != NUMA_NO_NODE)
>   		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>   
> +out:
>   	return 0;
>   
>   out_map:
> @@ -1749,7 +1750,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
>   	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>   	spin_unlock(vmf->ptl);
> -	goto out;
> +	goto count_fault;
>   }
>   
>   /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 67496dc5064f..503d493263df 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5536,9 +5536,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   		goto out_map;
>   	}
>   
> -out:
> +count_fault:
>   	if (nid != NUMA_NO_NODE)
>   		task_numa_fault(last_cpupid, nid, nr_pages, flags);
> +out:
>   	return 0;
>   out_map:
>   	/*
> @@ -5552,7 +5553,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
>   					    writable);
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
> -	goto out;
> +	goto count_fault;
>   }
>   
>   static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)

