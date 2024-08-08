Return-Path: <stable+bounces-66046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4E94BF7F
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DE31F294EC
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431F18FDDA;
	Thu,  8 Aug 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRayW/+1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51BC190059
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126500; cv=none; b=r52karO7iNhLK2CGkBqoAiVRk1XV/qHErSAmyCoXI8ytqDuKSx0qYRi1Nc1OT+B0m+MHTRZ5K3f3e8sRnIT29fUM9wlYCSrQRpmS4+Az/3H9tpoE2BVu3QSFt0jJNdahU+/98V4/ZlZ6TlICRjK4tDgr+UDdHWbGNkQixe9IChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126500; c=relaxed/simple;
	bh=sP3z9fGxDaDrdSdND7c85plxwQEaZsUhwNiHb9S4rsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUPeKQiskrJqgjW4AlvKHaSy4AJprCAd0fHrlH2WV1NiGYym1yG4lA2HwwLDNcDI9k4HrOtDyJEykH648drdpEfP1LrHc4C4Edbji9snlnBb252/qkqOoazVj150CVvxCQ3Qr+i1m8EU7keg+t0KnssELAKNRM+K7I4vZ2ijYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRayW/+1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723126496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XpyM0ZcOAfekhvDa5kuyYRkQ/QG2fsi7dMmBIVBRfVg=;
	b=IRayW/+18EKEZL/QIDKjTwtQZRtmAMgmZlZ8DA7GRsOTkN6fHsOqO1TQyg8oYzyy5eC4so
	+jtfIn+pWpKFwsOTvfLUz0C+Zx4YH53JvcItisUI8QXtir88Xwc0Da0JA+M4pstXCRzwep
	QDaP4nWTfdpdBRUHJlx9mVtoo0IJ0bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-e8NonU_INSeax947Bt41dw-1; Thu, 08 Aug 2024 10:14:55 -0400
X-MC-Unique: e8NonU_INSeax947Bt41dw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42808685ef0so7171345e9.2
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 07:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126494; x=1723731294;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpyM0ZcOAfekhvDa5kuyYRkQ/QG2fsi7dMmBIVBRfVg=;
        b=kVm7Quzw7Y7MlsKRkR4kUAjlJf2tZxfwDLwOBFJkL7s4k0MyBOjf96bTCTMn49wxrA
         OVa3OvwPtNBAuPXWOGpZOybPU0G+7LzXs8ypfbIqAEy/I0AJuaUBavk8HqK783kbzlVJ
         iVNJdMGfh/rA5Ps/QFW8ijhduAVUPPjno8RIf8lSLNDRSwV7dgDJi3oaeTEF0U9QhT3Q
         4PXRUdBOuchVSxBuFP6SfNa+mh4Z8sToUwixSANamG64iVxoZ7mpK/YLbAKEmdJTdSZw
         oeyfArl4dBJ/Jnc8w/uuk23CX2dU+lf9GvclUrsDm+V35DoPlrecLyhNfgxbf+eXpNy0
         BC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJXwI6A7eG+JF6yM1Wf4eS7PsTEHzVfPZLCwPTMDiavHLqA/q4ChibTLt6VLK4fwsjUcJb+mq+lBJ7XYrUDMeQl/WVC5YF
X-Gm-Message-State: AOJu0YwSsLzoOxqNvmdnwGZMrETb0htHZq5YvHoEX98WiZhJdOQ4IAjh
	fgtSRfuxFizrmbmfIb1wiKASAPranVsOx8C5uZouC7z+G5CP1uXUBnmyRG4rYk9kwh5DvQAntIh
	zi7HLOrSmkWxVfNxs3TfACkElL9cj1oURyo+3B/9QEild720yqOzg5nD84jeS2RZJ
X-Received: by 2002:a05:600c:4e52:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-4290aedfed8mr19701035e9.5.1723126493785;
        Thu, 08 Aug 2024 07:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqFBuseuueEU8ak93bWgt//sN3N8s5SOP1wsW2FHAikGPlKWsoYiOtFgvYq1EqakpFVd5TNQ==
X-Received: by 2002:a05:600c:4e52:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-4290aedfed8mr19700795e9.5.1723126493301;
        Thu, 08 Aug 2024 07:14:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971993sm78289725e9.16.2024.08.08.07.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:14:52 -0700 (PDT)
Message-ID: <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
Date: Thu, 8 Aug 2024 16:14:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.24 16:13, Zi Yan wrote:
> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
> 
>> On 08.08.24 05:19, Baolin Wang wrote:
>>>
>>>
>>> On 2024/8/8 02:47, Zi Yan wrote:
>>>> When handling a numa page fault, task_numa_fault() should be called by a
>>>> process that restores the page table of the faulted folio to avoid
>>>> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
>>>> TLB flush via delaying mapping on hint page fault") restructured
>>>> do_numa_page() and do_huge_pmd_numa_page() and did not avoid
>>>> task_numa_fault() call in the second page table check after a numa
>>>> migration failure. Fix it by making all !pte_same()/!pmd_same() return
>>>> immediately.
>>>>
>>>> This issue can cause task_numa_fault() being called more than necessary
>>>> and lead to unexpected numa balancing results (It is hard to tell whether
>>>> the issue will cause positive or negative performance impact due to
>>>> duplicated numa fault counting).
>>>>
>>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>>> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>
>>> The fix looks reasonable to me. Feel free to add:
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>
>>> (Nit: These goto labels are a bit confusing and might need some cleanup
>>> in the future.)
>>
>> Agreed, maybe we should simply handle that right away and replace the "goto out;" users by "return 0;".
>>
>> Then, just copy the 3 LOC.
>>
>> For mm/memory.c that would be:
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 67496dc5064f..410ba50ca746 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>           if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>                  pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -               goto out;
>> +               return 0;
>>          }
>>           pte = pte_modify(old_pte, vma->vm_page_prot);
>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>                  vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>                                                 vmf->address, &vmf->ptl);
>>                  if (unlikely(!vmf->pte))
>> -                       goto out;
>> +                       return 0;
>>                  if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
>>                          pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -                       goto out;
>> +                       return 0;
>>                  }
>>                  goto out_map;
>>          }
>>   -out:
>>          if (nid != NUMA_NO_NODE)
>>                  task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>          return 0;
>> @@ -5552,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>                  numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
>>                                              writable);
>>          pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -       goto out;
>> +       if (nid != NUMA_NO_NODE)
>> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>> +       return 0;
>>   }
> 
> Looks good to me. Thanks.
> 
> Hi Andrew,
> 
> Should I resend this for an easy back porting? Or you want to fold David’s
> changes in directly?

Note that I didn't touch huge_memory.c. So maybe just send a fixup on top?

-- 
Cheers,

David / dhildenb


