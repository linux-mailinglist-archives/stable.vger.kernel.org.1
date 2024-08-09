Return-Path: <stable+bounces-66103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CD94C80B
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 03:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E895285B7C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BDBE5E;
	Fri,  9 Aug 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7lpqTrG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523769463;
	Fri,  9 Aug 2024 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166945; cv=none; b=VCZ7xB5zFrA7BxoRXIMTf1+dl5BmXdbk98Kq/kAqJWvvVhL5s6hbEbf5Uo/pL1VSPzNnR0tXRKL2o9IfDOhV8rQ8d6Oy90iroq5PeMYGX40amAbsocgoesQLazg71wOU5PfSX3/p4JK4KE2zVGFDkGRY77kY9aYQ1raKoDb+ZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166945; c=relaxed/simple;
	bh=k9x0enger3+Cez75silnJ1YZv/0QsAY5Gv07Be4bXcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UjQUh/oZMGcN+xJHJW+Mg7/lvsqWXdUgpCgBDHld68VoUgSghxW97BaLy/TisOCKesS9rGX5jCf6vDIsK+EOxbOPkIkEa9tryZOtJXnPnpRFsVSz+VR0UlR/TZiay6byw1G+raA+ZeMX6GSsbDmDOvDpiEIi4kYcyBitDTzGZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7lpqTrG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723166943; x=1754702943;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=k9x0enger3+Cez75silnJ1YZv/0QsAY5Gv07Be4bXcA=;
  b=E7lpqTrG5+tfxqUnDlFNlk7LQJYDqwwZNZLXiinkuXpZev8S9Q4hc6PP
   yvxMOL4d7T8dh35QXwUHQ6jrcO8OnvKNFXsr6HaT9Gkm+r9SCwRrsVTbM
   E8CULpRlypHmoKSfBIq2URF9jUmNAA94gp60TVU99RdCduepseryRlTE0
   rjEj8pfXnMkcimUSPRMRzfmFB9eBMvhEykUTdMVRIo1SP30hPfvCsbdmg
   2hQJKlJ8cZ4d/Uwtnyl+NjJMlDjd4qyNgFPx5ebpHpn6g82i8l2aiTPFB
   KEGGx07vBq3HvCehyv1d0kRjRY39Va3/YrJA1Ky8SvOg0UQwUKwCjOIKQ
   w==;
X-CSE-ConnectionGUID: xrC67Tm4S7GcCWnCKgvN7A==
X-CSE-MsgGUID: LERLuwtLTfaANRLNGD7LBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31999469"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="31999469"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:29:03 -0700
X-CSE-ConnectionGUID: o1fcKy9AQMWzjENkrUWCwA==
X-CSE-MsgGUID: Z3v00sjsS9+fKS1IpN7lUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="62252264"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:29:01 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Zi Yan <ziy@nvidia.com>,  David Hildenbrand <david@redhat.com>,  "Andrew
 Morton" <akpm@linux-foundation.org>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
In-Reply-To: <b0b94a65-51f1-459e-879f-696baba85399@huawei.com> (Kefeng Wang's
	message of "Thu, 8 Aug 2024 22:36:59 +0800")
References: <20240807184730.1266736-1-ziy@nvidia.com>
	<956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
	<1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
	<09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
	<052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
	<8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
	<b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
Date: Fri, 09 Aug 2024 09:25:27 +0800
Message-ID: <87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> On 2024/8/8 22:21, Zi Yan wrote:
>> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
>> 
>>> On 08.08.24 16:13, Zi Yan wrote:
>>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>>
>>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>>
>>>>>>
> ...
>>>>> Agreed, maybe we should simply handle that right away and replace the "goto out;" users by "return 0;".
>>>>>
>>>>> Then, just copy the 3 LOC.
>>>>>
>>>>> For mm/memory.c that would be:
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 67496dc5064f..410ba50ca746 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>> -               goto out;
>>>>> +               return 0;
>>>>>           }
>>>>>            pte = pte_modify(old_pte, vma->vm_page_prot);
>>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>>                   vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>>>                                                  vmf->address, &vmf->ptl);
>>>>>                   if (unlikely(!vmf->pte))
>>>>> -                       goto out;
>>>>> +                       return 0;
>>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
>>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>> -                       goto out;
>>>>> +                       return 0;
>>>>>                   }
>>>>>                   goto out_map;
>>>>>           }
>>>>>    -out:
>>>>>           if (nid != NUMA_NO_NODE)
>>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>>>           return 0;
>
> Maybe drop this part too,
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 410ba50ca746..07343c1469e0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>                 nid = target_nid;
>                 flags |= TNF_MIGRATED;
> +               goto out;
>         } else {
>                 flags |= TNF_MIGRATE_FAIL;
>                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> @@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>                         return 0;
>                 }
> -               goto out_map;
>         }
>
> -       if (nid != NUMA_NO_NODE)
> -               task_numa_fault(last_cpupid, nid, nr_pages, flags);
> -       return 0;
>  out_map:
>         /*
>          * Make it present again, depending on how arch implements

IMHO, migration success is normal path, while migration failure is error
processing path.  If so, it's better to use "goto" for error processing
instead of normal path.

> @@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>                 numa_rebuild_single_mapping(vmf, vma, vmf->address,
>                 vmf->pte,
>                                             writable);
>         pte_unmap_unlock(vmf->pte, vmf->ptl);
> +out:
>         if (nid != NUMA_NO_NODE)
>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>         return 0;
>
>

--
Best Regards,
Huang, Ying

