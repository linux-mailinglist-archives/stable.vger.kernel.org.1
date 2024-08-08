Return-Path: <stable+bounces-66055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28F94BFBA
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC341F21E8D
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7D18E038;
	Thu,  8 Aug 2024 14:37:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D511EA90;
	Thu,  8 Aug 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127828; cv=none; b=RmD0vgfFiOGTACGU9ZuXcrRKqomcXBzHraYfkrTWqw3wjybxaMCTmo5bk5Z8ahhXy4NjAe4+9f6xWbZ1hjPDUucImLiVboZrY8g8OECgXyWRAKhpb87kUkUJpMKcCeb8I3Rb7oRaDmFFmQcrHvNPpbXUxYa0zkzUV2qVZh6sJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127828; c=relaxed/simple;
	bh=JDnTYJb1g+gaWVx0QrFOokMjCAaSEvr2P3mNa85rsJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r5N82EO674X8pJfjQckkoFO4TJgqsxvZ744eBx9BHjdhm+A9/Mcv/Do8CU8hTu1xYupsKxOajsQh7R26669ppc9PehfiYntplIy06BkPtwdHWxjxDpEcZ2KGDzRGhV9Kt+bxR480JMQP42FmMyJ80DkOYFLhxyiFwCC3QjdLB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WfqN51cPDzpTCr;
	Thu,  8 Aug 2024 22:35:49 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CAE2180AE5;
	Thu,  8 Aug 2024 22:37:01 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 22:37:00 +0800
Message-ID: <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
Date: Thu, 8 Aug 2024 22:36:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>, "Huang,
 Ying" <ying.huang@intel.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/8/8 22:21, Zi Yan wrote:
> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
> 
>> On 08.08.24 16:13, Zi Yan wrote:
>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>
>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>
>>>>>
...
>>>> Agreed, maybe we should simply handle that right away and replace the "goto out;" users by "return 0;".
>>>>
>>>> Then, just copy the 3 LOC.
>>>>
>>>> For mm/memory.c that would be:
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 67496dc5064f..410ba50ca746 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>> -               goto out;
>>>> +               return 0;
>>>>           }
>>>>            pte = pte_modify(old_pte, vma->vm_page_prot);
>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>                   vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>>                                                  vmf->address, &vmf->ptl);
>>>>                   if (unlikely(!vmf->pte))
>>>> -                       goto out;
>>>> +                       return 0;
>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>> -                       goto out;
>>>> +                       return 0;
>>>>                   }
>>>>                   goto out_map;
>>>>           }
>>>>    -out:
>>>>           if (nid != NUMA_NO_NODE)
>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>>           return 0;

Maybe drop this part too,

diff --git a/mm/memory.c b/mm/memory.c
index 410ba50ca746..07343c1469e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
                 nid = target_nid;
                 flags |= TNF_MIGRATED;
+               goto out;
         } else {
                 flags |= TNF_MIGRATE_FAIL;
                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
@@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
                         pte_unmap_unlock(vmf->pte, vmf->ptl);
                         return 0;
                 }
-               goto out_map;
         }

-       if (nid != NUMA_NO_NODE)
-               task_numa_fault(last_cpupid, nid, nr_pages, flags);
-       return 0;
  out_map:
         /*
          * Make it present again, depending on how arch implements
@@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
                 numa_rebuild_single_mapping(vmf, vma, vmf->address, 
vmf->pte,
                                             writable);
         pte_unmap_unlock(vmf->pte, vmf->ptl);
+out:
         if (nid != NUMA_NO_NODE)
                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
         return 0;


>>>> @@ -5552,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>                   numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
>>>>                                               writable);
>>>>           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>> -       goto out;
>>>> +       if (nid != NUMA_NO_NODE)
>>>> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>> +       return 0;
>>>>    }
>>>
>>> Looks good to me. Thanks.
>>>
>>> Hi Andrew,
>>>
>>> Should I resend this for an easy back porting? Or you want to fold David’s
>>> changes in directly?
>>
>> Note that I didn't touch huge_memory.c. So maybe just send a fixup on top?
> 
> Got it. The fixup is attached.
> 
> Best Regards,
> Yan, Zi

