Return-Path: <stable+bounces-105534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FB9FA0FD
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 15:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D3E7A1BEB
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE321F8668;
	Sat, 21 Dec 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDKnGwTQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625EEDE
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734791543; cv=none; b=lMeOy/VdbhUuuubBeOBd172UsNyn0b4dOxyOD3akEBeP8tx5lX80ZE/1qcxT3Amlt6AGgCdWlKWMpuq3KJ8ql3bAsSh09tGv3QCqrD6yTQooKLPaEv2xDnPYhfhQmOY/H9Z7mitO9yuNO9xtu5EEJlLDQrmuG1sV/iykkPBwu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734791543; c=relaxed/simple;
	bh=V6aqePbPJihGnM15mCPSwijHPJigUDAJca9491+h02U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uszjfwCX76OLLm0Ob8xeFz4D1khrFTk+qlJmz5QB1EqVEon2aaQ0Gk+kSGpAKvpaFIrxUlLyLhlLIEl4XrX0hbj0zjMElmP7qc3H5YcWSQI5UdwjQEiwq1tFp0jupyzLCBdDuOc8rd4x7f91aUbqmjYKYapasn+YCkZdmRtZTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDKnGwTQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734791539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=glzaZ4GMQ7kx43PeLKg9UKk4Yr/KeQENxPVtTJNPfys=;
	b=IDKnGwTQt0z0w/5spaYxsPt8jyciH8SsvzkI8K4h4nI9VHUqVUxD3IpXP3fwMPdbdO3o1c
	epV7x4LK7OvqpSvSzNxg6KylOcRIKubzsgk7w9rLanSb+iidFTj2zBUU9pdpPnuuruEwJc
	+kXKdHV12Fgy9H+85JgsI7OjHW7eFmI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-W1ixLCALPrm9ky_V9wjc9A-1; Sat, 21 Dec 2024 09:32:15 -0500
X-MC-Unique: W1ixLCALPrm9ky_V9wjc9A-1
X-Mimecast-MFC-AGG-ID: W1ixLCALPrm9ky_V9wjc9A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ed79291eso1939235f8f.0
        for <stable@vger.kernel.org>; Sat, 21 Dec 2024 06:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734791534; x=1735396334;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=glzaZ4GMQ7kx43PeLKg9UKk4Yr/KeQENxPVtTJNPfys=;
        b=NoqUqsN/y+hInyy8LSDNf3Vsewcr5w1xyICS5sM6EigQ3H402+V51oPa5ehxBASC5f
         58JZu6TvKkJYGqPzWCcOZjuMtB8sI+qPc0a2GbzeO7wMFLZFJVsM8GaSvLbHPWPT4nro
         eBenYKR1F+oJqq8nqCh8GKO6hJqEHRXOxQEk9FEbCwn6tsrFglt9iESlso4ycGtx1cUw
         wksXV/c3qcgQS5fav3dp8afzr6JyC3ofMGvTuwPNzFXUX8kuA8gD0m0hLyToqeoD9d6h
         JL54DpC47Zy2hG0o+j2UibrrSYMuPrnAIz9LqmWtDf04wu6byc/gXcuGOtG8rAGu12e4
         x6/w==
X-Forwarded-Encrypted: i=1; AJvYcCXHdoK9sGmVvBexHA2XoFy8bbxpd9fada8lDT2wDsQYZUx4VQy2fEaAul8uB99frP3w0HfTMVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9e1YCZbFnZYToLEenWNn1Z6jOX23xBObBVobzRs+OavQgZmk
	3xfysm2nVbTtxIpsblHdKxVtvkszuHktVXplNzOg+ZHGc3cHAwde8eTnFNNT6QqDgiUl5IC0kn6
	B8up5PE/T9G2FwRg2om8QFARccVKRECZXQf9cT+SkRibgdfeOKpw4VA==
X-Gm-Gg: ASbGncs49lssKntkWJdErMUegNGOuer5dUBrc2SqRz0kXaYmeeoWI/0uLXMuHySNXbb
	sF6i7uNxXZShvfqC6iFXZHRrDdhlnOs9OkSJszfYTshsDg64V+X6JYSC2HRWdIl/XjTzmDXrueI
	UJ4KOGoNR162C3UBiwJu8rEH2C312DexdDFNXm/w1Me+9ehp1xG0yQgRs+U1rSw7ClXmkmOJy3J
	TJ8Ms8cwL1pswTrv9DiY8vV5jhji0IknlfAt7P9Ho9dfz6aIAOhVPquwVzyvHCAhUNVsOtMl8Fe
	np8NM/dBvrU1uWki3z5WXMtgZEWkCGISWmrCq2+uTfzQCPiNhzaYZZzjX5SZKA7B3zZ6RHiU9zG
	rWH8h6xx3
X-Received: by 2002:a5d:5d09:0:b0:386:4570:ee3d with SMTP id ffacd0b85a97d-38a22a4c983mr5810361f8f.24.1734791534472;
        Sat, 21 Dec 2024 06:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCMDZk/93Kg60YQwF51fyaC60CAIZCXyZ7BqG62+zVeO+S8Cz54v+G8U7DmDs50F+Vm3RtSg==
X-Received: by 2002:a5d:5d09:0:b0:386:4570:ee3d with SMTP id ffacd0b85a97d-38a22a4c983mr5810339f8f.24.1734791534022;
        Sat, 21 Dec 2024 06:32:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:d000:4622:73e7:6184:8f0d? (p200300cbc70ed000462273e761848f0d.dip0.t-ipconnect.de. [2003:cb:c70e:d000:4622:73e7:6184:8f0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ace0esm6517219f8f.106.2024.12.21.06.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 06:32:12 -0800 (PST)
Message-ID: <433fb64d-80e1-4d96-904e-10b51e40898d@redhat.com>
Date: Sat, 21 Dec 2024 15:32:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0b41cc6b-5c93-408f-801f-edd9793cb979@redhat.com>
 <1241b567-88b6-462c-9088-8f72a45788b7@126.com>
 <fe57ef80-bbdb-44dc-97d9-b390778430a4@redhat.com>
 <333e584c-2688-4a3f-bc1f-2e84d5215005@126.com>
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
In-Reply-To: <333e584c-2688-4a3f-bc1f-2e84d5215005@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.12.24 13:04, Ge Yang wrote:
> 
> 
> 在 2024/12/21 0:30, David Hildenbrand 写道:
>> On 20.12.24 09:56, Ge Yang wrote:
>>>
>>>
>>> 在 2024/12/20 0:40, David Hildenbrand 写道:
>>>> On 18.12.24 07:33, yangge1116@126.com wrote:
>>>>> From: yangge <yangge1116@126.com>
>>>>
>>>> CCing Oscar, who worked on migrating these pages during memory offlining
>>>> and alloc_contig_range().
>>>>
>>>>>
>>>>> My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
>>>>> have configured each NUMA node with 16GB of CMA and 16GB of in-use
>>>>> hugetlb pages. The allocation of contiguous memory via the
>>>>> cma_alloc() function can fail probabilistically.
>>>>>
>>>>> The cma_alloc() function may fail if it sees an in-use hugetlb page
>>>>> within the allocation range, even if that page has already been
>>>>> migrated. When in-use hugetlb pages are migrated, they may simply
>>>>> be released back into the free hugepage pool instead of being
>>>>> returned to the buddy system. This can cause the
>>>>> test_pages_isolated() function check to fail, ultimately leading
>>>>> to the failure of the cma_alloc() function:
>>>>> cma_alloc()
>>>>>        __alloc_contig_migrate_range() // migrate in-use hugepage
>>>>>        test_pages_isolated()
>>>>>            __test_page_isolated_in_pageblock()
>>>>>                 PageBuddy(page) // check if the page is in buddy
>>>>
>>>> I thought this would be working as expected, at least we tested it with
>>>> alloc_contig_range / virtio-mem a while ago.
>>>>
>>>> On the memory_offlining path, we migrate hugetlb folios, but also
>>>> dissolve any remaining free folios even if it means that we will going
>>>> below the requested number of hugetlb pages in our pool.
>>>>
>>>> During alloc_contig_range(), we only migrate them, to then free them up
>>>> after migration.
>>>>
>>>> Under which circumstances doe sit apply that "they may simply be
>>>> released back into the free hugepage pool instead of being returned to
>>>> the buddy system"?
>>>>
>>>
>>> After migration, in-use hugetlb pages are only released back to the
>>> hugetlb pool and are not returned to the buddy system.
>>
>> We had
>>
>> commit ae37c7ff79f1f030e28ec76c46ee032f8fd07607
>> Author: Oscar Salvador <osalvador@suse.de>
>> Date:   Tue May 4 18:35:29 2021 -0700
>>
>>       mm: make alloc_contig_range handle in-use hugetlb pages
>>       alloc_contig_range() will fail if it finds a HugeTLB page within the
>>       range, without a chance to handle them.  Since HugeTLB pages can be
>>       migrated as any LRU or Movable page, it does not make sense to bail
>> out
>>       without trying.  Enable the interface to recognize in-use HugeTLB
>> pages so
>>       we can migrate them, and have much better chances to succeed the call.
>>
>>
>> And I am trying to figure out if it never worked correctly, or if
>> something changed that broke it.
>>
>>
>> In start_isolate_page_range()->isolate_migratepages_block(), we do the
>>
>>       ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
>>
>> to add these folios to the cc->migratepages list.
>>
>> In __alloc_contig_migrate_range(), we migrate the pages using
>> migrate_pages().
>>
>>
>> After that, the src hugetlb folios should still be isolated?
> Yes.
> 
> But I'm
>> getting
>> confused when these pages get un-silated and putback to hugetlb/freed.
>>
> If the migration is successful, call folio_putback_active_hugetlb to
> release the src hugetlb folios back to the free hugetlb pool.
> 
> trace:
> unmap_and_move_huge_page
>       folio_putback_active_hugetlb
>           folio_put
>               free_huge_folio
> 
> alloc_contig_range_noprof
>       __alloc_contig_migrate_range
>       if (test_pages_isolated())  //to determine if hugetlb pages in buddy
>           isolate_freepages_range //grab isolated pages from freelists.
>       else
>           undo_isolate_page_range //undo isolate

Ah, now I remember, thanks.

So when we free an ordinary page, we put it onto the buddy isolate list, 
from where we can grab it later and nobody can allocate it in the meantime.

In case of hugetlb, we simply free it back to hugetlb, from where it can 
likely even get allocated immediately again.

I think that can actually happen in your proposal: the now-free page 
will get reallocated, for example for migrating the next folio. Or some 
concurrent system activity can simply allocate the now-free folio. Or am 
I missing something that prevents these now-free hugetlb folios from 
getting re-allocated after migration succeeded?


Conceptually, I think we would want migration code in the case of 
alloc_contig_range() to allocate a new folio from the buddy, and to free 
the old one back to the buddy immediately, without ever allowing 
re-allocation of it.

What needs to be handled is detecting that

(a) we want to allocate a fresh hugetlb folio as migration target
(b) if migration succeeds, we have to free the hugetlb folio back to the 
buddy
(c) if migation fails, we have to free the allocated hugetlb foliio back 
to the buddy


We could provide a custom alloc_migration_target that we pass to 
migrate_page to allocate a fresh hugetlb folio to handle (a). Using the 
put_new_folio callback we could handle (c). (b) would need some thought.

Maybe we can also just mark the source folio as we isolate it, and 
enlighten migration+freeing code to handle it automatically?

Hoping to get some feedback from hugetlb maintainers.

-- 
Cheers,

David / dhildenb


