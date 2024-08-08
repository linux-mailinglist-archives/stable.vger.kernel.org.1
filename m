Return-Path: <stable+bounces-66008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB494B8EF
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227B528AB0E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB55189513;
	Thu,  8 Aug 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzjAR4zF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4D145B0C
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105378; cv=none; b=g0DAvkcrkFjKDYiBC35J47bbyj5GjmDk0zQyFDU1ofAmWO2aoksLs648YuRqM1GMAk+2zANL3enT4zsOLi+9kOEv3e/tRUbdN7dWOZikHXNNtMb8NEQN9zutVu43NiojIsa9Zcir6b1B8LSQX3dhe2ksDhvlf6MZcecT8bcJswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105378; c=relaxed/simple;
	bh=sq65un/oxhnmyKHS8t6PfDmZu8oN7DJm2znS4qkay4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqcWYz6GmohhCV0SVpAY85OSRVXWfcuDlaGvskdu32BfggNyrSv1bvx2PaFpX2PRWcmi9BTYZsSVdJ004gnb+iDajkmWG4uw8AGg62HmKlICPgrdRcmPLnSnNoLZEKytvwHjGNTjMGaTPR1b/dn6hNW4aHAcRiuEzfhIrR5OMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzjAR4zF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723105375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBOa+iBKOlZAR7CtrCD45hB+YFcxzO/ihnHiEvwPdKQ=;
	b=fzjAR4zFpwQ7f/NEEADJ4+GWLTKCXueeonNzw7waW5SqtgPUTV30JAjykErv4g0q9CyZw+
	CJXmLskDN97a4ubTez7RA/My1u2uS1NKKIpUOPcehRI2cO3RvsRhLUl4CrZpCDIwiUsRf5
	uNgGVNh8s8O0Hpp/t07LQTfKBJx/d6E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Q-WSJ6LwM9CqY-k446MANg-1; Thu, 08 Aug 2024 04:22:53 -0400
X-MC-Unique: Q-WSJ6LwM9CqY-k446MANg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52efc9f2080so622401e87.3
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 01:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723105372; x=1723710172;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBOa+iBKOlZAR7CtrCD45hB+YFcxzO/ihnHiEvwPdKQ=;
        b=NWBKbGI7z4ut30jZozfkraywXv+6hJp4EgELSQIzulc554u0Ts1E80cJoNUkGfTo+D
         jrucwKrMckAfk+wZ4pOr2d4ob5EIWaVQsVLlYeaUcBEPaHAmiaByh5YJutnubPc3/Mhw
         AdpXtmDuO42UDYG8j1+D5Bllyhjz+T9WsQa+dOJv5+5jGW3lXukeXUsETscR6pxljUJK
         Fdarwk8yeoTsxeiKYU9EcyktvB8rb3uBjyYiT9bJp0jYOniaejSAgWILKB9qa68k+keT
         vBiI+F7CIOVmkeEGDBPN8ODlntZKIWkCXmK6yqYc29zl0HMfAYRWKLKVOHdOMvuHFUyg
         ka4g==
X-Forwarded-Encrypted: i=1; AJvYcCVQOFcgsUs88oYOxO37/pM0kb+lygI5+hXzBd6fJ0VB4ofeSiN3sQuMD+nygEqgfbk7a+bNHTuclb6TVR9SU6tmm1G9Z1q0
X-Gm-Message-State: AOJu0YzkhEyx8LbVvbr6ckKb7oW0nleV0RzY4cP75xSWvKCi74mIBFYD
	F/b5O0JFQ6DQoxy1vJvaIcHRGWZzmKkg203zzIG69jp0c1hIeB6VlZ1ZQpyVQHdkndZ901t5DrA
	Ywydmz/4VpXfaqrclyFCXcOlE8lHRaUfClrUtvAv4fRmzm79KTMY9Ww==
X-Received: by 2002:a05:6512:224a:b0:52c:d750:bd19 with SMTP id 2adb3069b0e04-530e5815811mr771792e87.8.1723105372083;
        Thu, 08 Aug 2024 01:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpOQVfn+dhBFkGIFYzM9dXqBv/DIiWSOoMDaIlVKokm4AmIjr1t8Guo55YiOrpBwf+2i4xpA==
X-Received: by 2002:a05:6512:224a:b0:52c:d750:bd19 with SMTP id 2adb3069b0e04-530e5815811mr771762e87.8.1723105371409;
        Thu, 08 Aug 2024 01:22:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d272095c6sm1083008f8f.86.2024.08.08.01.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:22:51 -0700 (PDT)
Message-ID: <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
Date: Thu, 8 Aug 2024 10:22:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
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
In-Reply-To: <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 05:19, Baolin Wang wrote:
> 
> 
> On 2024/8/8 02:47, Zi Yan wrote:
>> When handling a numa page fault, task_numa_fault() should be called by a
>> process that restores the page table of the faulted folio to avoid
>> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
>> TLB flush via delaying mapping on hint page fault") restructured
>> do_numa_page() and do_huge_pmd_numa_page() and did not avoid
>> task_numa_fault() call in the second page table check after a numa
>> migration failure. Fix it by making all !pte_same()/!pmd_same() return
>> immediately.
>>
>> This issue can cause task_numa_fault() being called more than necessary
>> and lead to unexpected numa balancing results (It is hard to tell whether
>> the issue will cause positive or negative performance impact due to
>> duplicated numa fault counting).
>>
>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
>> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> 
> The fix looks reasonable to me. Feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> (Nit: These goto labels are a bit confusing and might need some cleanup
> in the future.)

Agreed, maybe we should simply handle that right away and replace the "goto out;" users by "return 0;".

Then, just copy the 3 LOC.

For mm/memory.c that would be:

diff --git a/mm/memory.c b/mm/memory.c
index 67496dc5064f..410ba50ca746 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
  
         if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
                 pte_unmap_unlock(vmf->pte, vmf->ptl);
-               goto out;
+               return 0;
         }
  
         pte = pte_modify(old_pte, vma->vm_page_prot);
@@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
                                                vmf->address, &vmf->ptl);
                 if (unlikely(!vmf->pte))
-                       goto out;
+                       return 0;
                 if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
                         pte_unmap_unlock(vmf->pte, vmf->ptl);
-                       goto out;
+                       return 0;
                 }
                 goto out_map;
         }
  
-out:
         if (nid != NUMA_NO_NODE)
                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
         return 0;
@@ -5552,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
                 numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
                                             writable);
         pte_unmap_unlock(vmf->pte, vmf->ptl);
-       goto out;
+       if (nid != NUMA_NO_NODE)
+               task_numa_fault(last_cpupid, nid, nr_pages, flags);
+       return 0;
  }


-- 
Cheers,

David / dhildenb


