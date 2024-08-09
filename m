Return-Path: <stable+bounces-66118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF794CBB5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575141F21DBC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79193185E6E;
	Fri,  9 Aug 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpysBue7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D451552EB;
	Fri,  9 Aug 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190160; cv=none; b=lmzPA4Rlx3pu3TRhvPT7Iu2qVbK1HdRNqLnKHBpiYP8deld3Jq9jXnMUCkRZXx1P9rkfuldy2GLcZWJrG1E1xN1aEV04rlw5Yu+awWR/3Kr+XxNz/Cf/9Ul4LTHsVzFL+5kXS+OFdoB7nXA/m9KaZiyHutTxxx22Os8XgukjtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190160; c=relaxed/simple;
	bh=94lZVQDuVX0rmJEGUMmn2REy9MejZbsiPG+f8IK032c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJFpaGpACBd/hiVpy2P4LZ1TxdGf2+hEYB55Ym/yK557zp46G+MKxDXmPZEtPx9mlpgJ1sQrrX73Yy44JB/x1Lw01FBzi0bH5VZ2ANe6azh6o1TVsicJRi58/kFhLDPEK0AbMSvuNTfQ/9s0KK5QAqyD6r4tHxfVUi45KgEVSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpysBue7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723190159; x=1754726159;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=94lZVQDuVX0rmJEGUMmn2REy9MejZbsiPG+f8IK032c=;
  b=dpysBue7TMxusw7gnCl9g1ETwXNd0afHnVI5TJRowBYaBGSE4SZeHYAw
   uWrYIhkF6Ku5x2GKVmOpj01Js6IXfB4nqNm1AbylK1LO0BRQsCfLxnUod
   dcQmrP4B1Axo6BFBd2gF0Wavb0raeQAipCfnSmh7DXDH2/FMxetoaKW+x
   DGuysvWXDouDWOHWoTxlN0nSmgJ9Bdr4M4NxI5EyABwdOSnwHZ+E/j7S5
   z/+2Lp+lkRE6fM4ifso7t/EY23ARqOXXkoWoZzkHhFUd8nsJ4CQQz3bAe
   Ho20bN0DzDFpfpPfLONUtqtcCHqnSyuyd36ImhLXn4+LyVOlNLQaLLyh4
   Q==;
X-CSE-ConnectionGUID: 6p6gpEmLS6amcQpOOPRILw==
X-CSE-MsgGUID: RdSOdTS0SYqL7euCHEKjQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25120793"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="25120793"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:55:58 -0700
X-CSE-ConnectionGUID: 7LbPVeFGRV2/faFvfItgpw==
X-CSE-MsgGUID: ET6+4kdqS+uqbJmnhFPo1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="58204970"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:55:55 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,  David Hildenbrand
 <david@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
In-Reply-To: <03D403CE-5893-456D-AB4B-67C9E9F0F532@nvidia.com> (Zi Yan's
	message of "Thu, 08 Aug 2024 22:05:52 -0400")
References: <20240807184730.1266736-1-ziy@nvidia.com>
	<956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
	<1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
	<09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
	<052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
	<8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
	<b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
	<87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<03D403CE-5893-456D-AB4B-67C9E9F0F532@nvidia.com>
Date: Fri, 09 Aug 2024 15:52:22 +0800
Message-ID: <874j7uyvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

> On 8 Aug 2024, at 21:25, Huang, Ying wrote:
>
>> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>>
>>> On 2024/8/8 22:21, Zi Yan wrote:
>>>> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
>>>>
>>>>> On 08.08.24 16:13, Zi Yan wrote:
>>>>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>>>>
>>>>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>
>>> ...
>>>>>>> Agreed, maybe we should simply handle that right away and replace the "goto out;" users by "return 0;".
>>>>>>>
>>>>>>> Then, just copy the 3 LOC.
>>>>>>>
>>>>>>> For mm/memory.c that would be:
>>>>>>>
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index 67496dc5064f..410ba50ca746 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>>> -               goto out;
>>>>>>> +               return 0;
>>>>>>>           }
>>>>>>>            pte = pte_modify(old_pte, vma->vm_page_prot);
>>>>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>>>>                   vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>>>>>                                                  vmf->address, &vmf->ptl);
>>>>>>>                   if (unlikely(!vmf->pte))
>>>>>>> -                       goto out;
>>>>>>> +                       return 0;
>>>>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
>>>>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>>> -                       goto out;
>>>>>>> +                       return 0;
>>>>>>>                   }
>>>>>>>                   goto out_map;
>>>>>>>           }
>>>>>>>    -out:
>>>>>>>           if (nid != NUMA_NO_NODE)
>>>>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>>>>>           return 0;
>>>
>>> Maybe drop this part too,
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 410ba50ca746..07343c1469e0 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>>                 nid = target_nid;
>>>                 flags |= TNF_MIGRATED;
>>> +               goto out;
>>>         } else {
>>>                 flags |= TNF_MIGRATE_FAIL;
>>>                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>> @@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>                         return 0;
>>>                 }
>>> -               goto out_map;
>>>         }
>>>
>>> -       if (nid != NUMA_NO_NODE)
>>> -               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>> -       return 0;
>>>  out_map:
>>>         /*
>>>          * Make it present again, depending on how arch implements
>>
>> IMHO, migration success is normal path, while migration failure is error
>> processing path.  If so, it's better to use "goto" for error processing
>> instead of normal path.
>>
>>> @@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>                 numa_rebuild_single_mapping(vmf, vma, vmf->address,
>>>                 vmf->pte,
>>>                                             writable);
>>>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> +out:
>>>         if (nid != NUMA_NO_NODE)
>>>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>         return 0;
>>>
>>>
>
> How about calling task_numa_fault and return in the migration successful path?
> (target_nid cannot be NUMA_NO_NODE, so if is not needed)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 3441f60d54ef..abdb73a68b80 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5526,7 +5526,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>                 nid = target_nid;
>                 flags |= TNF_MIGRATED;
> -               goto out;
> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
> +               return 0;
>         } else {
>                 flags |= TNF_MIGRATE_FAIL;
>                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> @@ -5550,7 +5551,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>                 numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
>                                             writable);
>         pte_unmap_unlock(vmf->pte, vmf->ptl);
> -out:
>         if (nid != NUMA_NO_NODE)
>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>         return 0;
>

This looks better for me, or change it further.

       if (migrate_misplaced_folio(folio, vma, target_nid))
               goto out_map_pt;

       nid = target_nid;
       flags |= TNF_MIGRATED;
       task_numa_fault(last_cpupid, nid, nr_pages, flags);

       return 0;

out_map_pt:
       flags |= TNF_MIGRATE_FAIL;
       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
       ...
        
>
>
> Or move the make-present code inside migration failed branch? This one
> does not duplicate code but others can jump into this branch.
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 3441f60d54ef..c9b4e7099815 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5526,7 +5526,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>                 nid = target_nid;
>                 flags |= TNF_MIGRATED;
> -               goto out;
>         } else {
>                 flags |= TNF_MIGRATE_FAIL;
>                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> @@ -5537,20 +5536,20 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>                         return 0;
>                 }
> -       }
>  out_map:
> -       /*
> -        * Make it present again, depending on how arch implements
> -        * non-accessible ptes, some can allow access by kernel mode.
> -        */
> -       if (folio && folio_test_large(folio))
> -               numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable,
> -                                          pte_write_upgrade);
> -       else
> -               numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
> -                                           writable);
> -       pte_unmap_unlock(vmf->pte, vmf->ptl);
> -out:
> +               /*
> +                * Make it present again, depending on how arch implements
> +                * non-accessible ptes, some can allow access by kernel mode.
> +                */
> +               if (folio && folio_test_large(folio))
> +                       numa_rebuild_large_mapping(vmf, vma, folio, pte,
> +                                       ignore_writable, pte_write_upgrade);
> +               else
> +                       numa_rebuild_single_mapping(vmf, vma, vmf->address,
> +                                       vmf->pte, writable);
> +               pte_unmap_unlock(vmf->pte, vmf->ptl);
> +       }
> +
>         if (nid != NUMA_NO_NODE)
>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>         return 0;
>
>
> Of course, I will need to change mm/huge_memory.c as well.
>

--
Best Regards,
Huang, Ying

