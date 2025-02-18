Return-Path: <stable+bounces-116810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B76A3A41A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 18:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8DC167CA5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E41246348;
	Tue, 18 Feb 2025 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbvDT6x7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5D26F47F
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899342; cv=none; b=F1Hf1aZQryv0VOS72DUxACcxYdUESyaisuvwiILcgXmODLRa+WFN5wzG0zoNN/SDtaykOOxerr9ZgQScwct82c3WgCre5Y3plGLYA3xFsdASz0QxAyqW5Ypng1pnOtdD6gPmRbPykSMbGqEkGWr32fiaFnCWAWR69GCYv5YfNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899342; c=relaxed/simple;
	bh=zNXWygFF5WwyY2RSj5lK41tUAkBXNcGkho6GIAFp9MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etxpzZK9QLMKe26vRE5DJDYCfQWDA/WHY8dYpWerG234K6487ShoJVEkb+1yxOOMeaPLguSdvo8arsOO4ppKc5hnU2SHoo+rZXen7RmoZS2iW4GR80zlTBaBlKcThwC3uADPMcbwLpMTxKSZDLtCNSeyN5Q/C9TTT/QYEYqvaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbvDT6x7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739899339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HOkfCPqk5UIId4b15nkOwnQ9Epjg3ttPPXcm9pqlEiM=;
	b=WbvDT6x73+7eRm21RLRv6Va4VV6h+qlNfW2/0VRgir5c1aRiwAvqDhfQvKrKy4jZQUvvCj
	mMGix83I3EP1SgPlL2nhuwuNC+QUjvMqEi8mHwSoLKrSGucBuLW9gAeCiHUZ+63oQZfYFw
	g6Z41HCWBXBAgKx7WTB7ffAtwmOErwk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-Ks7AHfEuPNOAMntQ3VBisQ-1; Tue, 18 Feb 2025 12:22:18 -0500
X-MC-Unique: Ks7AHfEuPNOAMntQ3VBisQ-1
X-Mimecast-MFC-AGG-ID: Ks7AHfEuPNOAMntQ3VBisQ_1739899335
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f2726c0faso5387725f8f.0
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 09:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899335; x=1740504135;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HOkfCPqk5UIId4b15nkOwnQ9Epjg3ttPPXcm9pqlEiM=;
        b=BmSvL1kaoUwd5ftdYNNceQP6Vy+Kt6nui0ANVkPJhijV0fU37xznWziU3EiLaEi7y8
         g3BOhZ8MqegKuYEjxDEsByp79SALFbnhmxJUEjUjX4X8cL3GU+WVMK9C7eHuyHKbF9FX
         GB3nC+0scGpfsoeX9052BKfIZx2XR6nE+4pkdtMqSmHwlvwilLRvmkkeIf+zuVrN4qw5
         d4jzukAxF+5BJYm6Dslf79pDLzAF36CAQYgH0dQWBFyuTjQAK9QP6i/O7qaY2awgacir
         v3N8pYPzkD8KI1qmb4LKxioDWp7TLINjLw5K4bax+aR54SArYxDfDQN/8FxerrItp6Qe
         AVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2tU+XFkJcBD2FiFPpQRZUCpYocGDGSY6K+1B9UczJ1O2l62bstd3RTJtiz4nOZgmCz0/KY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABqZZl6PI9u1eHigAenVRYoygTDcpWHJiuKLMOy03UbTb/AYU
	DoWkJSxTApPLaD6wz9EghP2aBllt+KTMwPAC79lrJI/JhwAsK9t0n8etCyDZd+SqfudQ6lcgdDI
	I3kN+xdkpSb5t75p260NYOv8aLwBiZ/yg9hOXnWyk6VIi2PlyHhE8/w==
X-Gm-Gg: ASbGnctHKzVImmBqnmzvoR1DzpfWLq8pyJw5e+cbM4wLBGGj7/CyhqfmsT+18Tgmnz1
	Z3scRzRkQ6NMT+PBc2HqJWQB7YQpYCNz23V6WGSEVCBEWggor2b7CnZIZn6HgWGbe7UIdKec24F
	OygFnMTkEyWXJhQNPr5NaLM8K7rib3w5jySKAXG7K+a7hiHSaudLqsgb6Aa1h0134jamA72+lYq
	NEXz2jxMfETXG5su5g4K85tHbG1hOmEuvbdzWredPOsMbAitzVhFmDC+N4Z804mOVxTjKPLNMZk
	ehV+L/T9nJKrYiYyVaJ1SrdS16pSauv1EBYvaY3CwZCPCh2YQlB9pjBJEtX+fsU2PQJYKRWIjPr
	e6V743h6i0gpeOern2WA/XSolvAgF5aHI
X-Received: by 2002:a5d:47c3:0:b0:38f:3c6c:28ff with SMTP id ffacd0b85a97d-38f3c6c2ce0mr11538840f8f.23.1739899335430;
        Tue, 18 Feb 2025 09:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjr0BuWvCU++Cx+Qo0SfQPUhHk8GBDbj83u/CGlwnXpvr46jVjrhMK5u2EO8raNUzQVPvHJg==
X-Received: by 2002:a5d:47c3:0:b0:38f:3c6c:28ff with SMTP id ffacd0b85a97d-38f3c6c2ce0mr11538820f8f.23.1739899335092;
        Tue, 18 Feb 2025 09:22:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b439dsm15395861f8f.8.2025.02.18.09.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:22:13 -0800 (PST)
Message-ID: <950cae5a-bff0-49e6-8fe4-a2447c63d8bc@redhat.com>
Date: Tue, 18 Feb 2025 18:22:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mm/hugetlb: wait for hugetlb folios to be freed
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739878828-9960-1-git-send-email-yangge1116@126.com>
 <f5c31616-41e8-464b-84ec-8aa0cedfa556@redhat.com>
 <17ad5bf5-545c-4418-8d08-459ce6ef54cb@126.com>
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
In-Reply-To: <17ad5bf5-545c-4418-8d08-459ce6ef54cb@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.02.25 13:19, Ge Yang wrote:
> 
> 
> 在 2025/2/18 19:45, David Hildenbrand 写道:
>> On 18.02.25 12:40, yangge1116@126.com wrote:
>>> From: Ge Yang <yangge1116@126.com>
>>>
>>> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer
>>> freeing
>>> of huge pages if in non-task context"), which supports deferring the
>>> freeing of hugetlb pages, the allocation of contiguous memory through
>>> cma_alloc() may fail probabilistically.
>>>
>>> In the CMA allocation process, if it is found that the CMA area is
>>> occupied
>>> by in-use hugetlb folios, these in-use hugetlb folios need to be migrated
>>> to another location. When there are no available hugetlb folios in the
>>> free hugetlb pool during the migration of in-use hugetlb folios, new
>>> folios
>>> are allocated from the buddy system. A temporary state is set on the
>>> newly
>>> allocated folio. Upon completion of the hugetlb folio migration, the
>>> temporary state is transferred from the new folios to the old folios.
>>> Normally, when the old folios with the temporary state are freed, it is
>>> directly released back to the buddy system. However, due to the deferred
>>> freeing of hugetlb pages, the PageBuddy() check fails, ultimately leading
>>> to the failure of cma_alloc().
>>>
>>> Here is a simplified call trace illustrating the process:
>>> cma_alloc()
>>>       ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>>>           ->unmap_and_move_huge_page()
>>>               ->folio_putback_hugetlb() // Free old folios
>>>       ->test_pages_isolated()
>>>           ->__test_page_isolated_in_pageblock()
>>>                ->PageBuddy(page) // Check if the page is in buddy
>>>
>>> To resolve this issue, we have implemented a function named
>>> wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
>>> folios are properly released back to the buddy system after their
>>> migration
>>> is completed. By invoking wait_for_freed_hugetlb_folios() before calling
>>> PageBuddy(), we ensure that PageBuddy() will succeed.
>>>
>>> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in
>>> non-task context")
>>> Signed-off-by: Ge Yang <yangge1116@126.com>
>>> Cc: <stable@vger.kernel.org>
>>
>>
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>> +void wait_for_freed_hugetlb_folios(void)
>>> +{
>>> +    flush_work(&free_hpage_work);
>>
>> BTW, I was wondering if we could optimize out some calls here by sensing
>> if there is actually work.
>>
> for_each_hstate(h) {
> 	if (hugetlb_vmemmap_optimizable(h)) {
> 		flush_work(&free_hpage_work);
 > 		break;> 	}
> }
> Is this adjustment okay?

I think that's better, except that it would still trigger in scenarios 
where hugetlb is completely unused if 
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is around.

Can't we check hpage_freelist?

if (llist_empty(&hpage_freelist))
	return;
flush_work(&free_hpage_work);

It should be able to deal with races (we don't care if something is 
getting added concurrently, only if there is something right now).

-- 
Cheers,

David / dhildenb


