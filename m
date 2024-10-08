Return-Path: <stable+bounces-81536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6280B99429D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C92E294144
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05211DEFE1;
	Tue,  8 Oct 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbpGOyr8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208C1DEFDE
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375677; cv=none; b=mbol7dZctZh1KY8JbFFqCJMIv9+TkbasGKi4qr3RacjK4Vql8Dd9o4TXii36pn4oq0U6/ZNXzzQ4h6RdZQiaCSUvl40x5KB2MJyuVC6dI51bPkzH6PPvYPfmHQ72qD90dg1G4oOrptlUjfRCJsAjMRMqBfLAdioTi881m6GtsSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375677; c=relaxed/simple;
	bh=jIc5H1FXGoZrRnjNg1/Mn7Rw0fxijTdz12BOUiiwW2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AetH/92yWiXkCwXcE6AMllbJHG1RAswjbq+7juBRiImsPT/tiRr8QkwhM/kMqEKJPOrZa2KPexfQx+VVrUy4IwcqE2hTB516tWifYWr+06dBSXuWtydQ8PUzUHLDpThR1njPFvAKJwnWpgCFkvD4Lm6TDS6Bsn9MMzCqlBpNdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbpGOyr8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728375674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rqosfSkDCFYhrwQm7M66U0/q2w7YrSsk+o2s9MBJQz8=;
	b=AbpGOyr8QcQ7uXtu/b7S6Jojc1GuL1Es4E4KnCUxf928mv7AVM9J4A8M/NF7oBA0Yp6gLX
	qa2YohMRvd5cq6DgRGd1zJ5PYcOB6IOHtRbRkiF28VSuN4/Nzu5HN0ju1aR5ll6+szbJmb
	VJJS+1pou2B0KTxc/y/744VVKyNnLCI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-uE3-7p71MzCnYFK96Bl0wA-1; Tue, 08 Oct 2024 04:21:13 -0400
X-MC-Unique: uE3-7p71MzCnYFK96Bl0wA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37ccc188d6aso3600188f8f.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375672; x=1728980472;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqosfSkDCFYhrwQm7M66U0/q2w7YrSsk+o2s9MBJQz8=;
        b=ntd7AOvZQVZaHAP8D+NnG4ec+UNkPtSu4llCDJRpjAkClKcZaDsD+IZxMd2CZxhVR7
         EFt17bJYNoiJqJFjGlRVRhqL7Htz2vtTlk8eQQEMJG9lETGz1OxpYNq/f/m2r4bR3oyC
         hhKriyXcuoMHpglVuPGpgGRlZNxc92IJNk8LjfDqt0oBEYeSpSLYy8ABVRxOMBIos8Dx
         bb+8IfFCsdlmQA1f8FwOrLAAcGamKvLUmlZ6IKIo3Pb0REFLyZ0qYVsn/rCIlPZN74+n
         HRVnUHPjCOR7QCHnCeYHfCWwGQN2kWdh1bdHzKLuc5GTKXsQ+5zoXL8EKoDP6C60O8MZ
         KJ7w==
X-Forwarded-Encrypted: i=1; AJvYcCX7f2P88cKegnBYe2j0sRKYi5cXAvlPcrsKHhczOh3ceKtpZOi5K1wJe4PxWuuXGDfqN9f6TDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLsvaPLxyZqUvi0vJn3bSXqOn9QHvuoUpUQiqNEP49+AqxazD
	jygmoGiGsEE9CWaAHWfXdAB4Iz4IQyo4RNB3sgtkXkj08szyjPUCrSk/n3i6CnRRoEm4lNvgOgs
	Fc7Ujm01Hi7kHznVheAIbw2/xSZUydhNLIpedZF8Y+kwFZjaRYkkrdA==
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37d0e751784mr15394771f8f.28.1728375672223;
        Tue, 08 Oct 2024 01:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEegr1mPVmXtdGKRjNw0OWHkQoTIJu+ZQZHPVx3xgKvhAKp91NIZdq/o3yJ1fDZy5psZjQFpQ==
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37d0e751784mr15394755f8f.28.1728375671772;
        Tue, 08 Oct 2024 01:21:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm7476182f8f.28.2024.10.08.01.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:21:11 -0700 (PDT)
Message-ID: <7201c25f-0b6e-4a8b-b6a1-b09c6730fb32@redhat.com>
Date: Tue, 8 Oct 2024 10:21:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, willy@infradead.org, hughd@google.com,
 lorenzo.stoakes@oracle.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
 <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
 <b989a811-f764-4b3d-b536-be4e68c0638e@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <b989a811-f764-4b3d-b536-be4e68c0638e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.10.24 09:58, Qi Zheng wrote:
> 
> 
> On 2024/10/8 15:52, David Hildenbrand wrote:
>> On 08.10.24 05:53, Qi Zheng wrote:
>>> Hi Jann,
>>>
>>> On 2024/10/8 05:42, Jann Horn wrote:
>>>
>>> [...]
>>>
>>>>
>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>> index 24712f8dbb6b..dda09e957a5d 100644
>>>> --- a/mm/mremap.c
>>>> +++ b/mm/mremap.c
>>>> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct
>>>> *vma, unsigned long old_addr,
>>>>     {
>>>>         spinlock_t *old_ptl, *new_ptl;
>>>>         struct mm_struct *mm = vma->vm_mm;
>>>> +    bool res = false;
>>>>         pmd_t pmd;
>>>>         if (!arch_supports_page_table_move())
>>>> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct
>>>> vm_area_struct *vma, unsigned long old_addr,
>>>>         if (new_ptl != old_ptl)
>>>>             spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>>> -    /* Clear the pmd */
>>>>         pmd = *old_pmd;
>>>> +
>>>> +    /* Racing with collapse? */
>>>> +    if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
>>>
>>> Since we already hold the exclusive mmap lock, after a racing
>>> with collapse occurs, the pmd entry cannot be refilled with
>>> new content by page fault. So maybe we only need to recheck
>>> pmd_none(pmd) here?
>>
>> My thinking was that it is cheap and more future proof to check that we
>> really still have a page table here. For example, what if collapse code
>> is ever changed to replace the page table by the collapsed PMD?
> 
> Ah, make sense.
> 
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks a lot for your review!

-- 
Cheers,

David / dhildenb


