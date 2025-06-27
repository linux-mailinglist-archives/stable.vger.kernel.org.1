Return-Path: <stable+bounces-158793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82982AEBC5E
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC91790A7
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E917A317;
	Fri, 27 Jun 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwimZiQo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DBA2E8E05
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039376; cv=none; b=MvlYpLiAina5qTLWa88Pj/X0wTE+7e+ttZcnA4IiP3b6ShYLrFKEFvC9N2OTN1qTNarrKd4qq0VJffrnIjFp6nv/EkY/uojTpPqyP6HacCYb7/ocueQdibWE0fs+0V1j/Hb53Hl2pqWnwMZEFwaW/QPx4fcWYaLNi4Rhq4TWJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039376; c=relaxed/simple;
	bh=f64SEwLK9b7ad0nHJH3zjaMBGQV5wKwKHgtulzsNvRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW4LgH2Tl9L7eyD5Yj00PdLwbfWH6KlEAfFTzvWG6nbh6mavbYvXOp9sx/MCmPzjDRe3DhzGKo0ZPdDD6PEAej9zH2L5xGlNPbgw60bouzzoKC+cNRVJG9gZnb97xZEQtnrQJJ97RgIToVamhm/esBGiwLvV75YZv3YpoqzTtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwimZiQo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751039373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MWpQhfcMYiannUA+rJ5gOh1mNCZnzLMoO5gh2F8JmmM=;
	b=VwimZiQo0Kp19uGnL33rMp1lfWE4Tvk+S7VOTmuFkUyBMxgiTFjNzjEbMKYPWfrHi6/RcN
	IDNUNPrCmnMLwJeMlvbtySFiJmZ/qYjiRXsbqvzpMYEz0TCLTbdgLoZbHBXgAQnnxOl08o
	DXC99YD8ii3ihqIpQR3AcDKdEDuxco8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-LmVxvt-fN06TvprqePGBvg-1; Fri, 27 Jun 2025 11:49:31 -0400
X-MC-Unique: LmVxvt-fN06TvprqePGBvg-1
X-Mimecast-MFC-AGG-ID: LmVxvt-fN06TvprqePGBvg_1751039370
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso98195e9.2
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 08:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039370; x=1751644170;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MWpQhfcMYiannUA+rJ5gOh1mNCZnzLMoO5gh2F8JmmM=;
        b=VZ6tugp0opJipPJYtI734AIaOYhViRjxDWxQnRUDnUEbbm9Cs/Xlk003pvVi+e2LVl
         Q7XNbf4odwthCw4CpfrO+PUIMNZJ8oukaSJt0e7ZHwg2J3WW+H76kXy4DDixzFwbNzH7
         d8CJsiJwPMAXLIQmJQAo7rj86dRkc5UNMpQd3nYv0gnGvAoEnOEMYficLf5RrlLgO3GX
         jIYIhWmCV5pvBeU02H6rWN9hlVnXChG7pRy1GtFCr9QSg5z8Z/rYrBteWqLNCUEcCVFC
         On7LWyScmQJFrifnnLc96EXshYnLwJ1DCJFdzHwRm2ZHrYMFQZ7pG/U35SeS8mPuewS9
         mMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyXHHNG/QDjUJVYLRSr9jd4knUhvw5QhWwCv5tMt7N+l1UE0tYm8cl+sBbcz2TrLfASnWSQqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+Ylss7lrRjsXXfGqv5hMjY4iDAb/WBaR3PoRlS1sIbVXfZsh
	7alpQF+1Y+toljFS5d8+FMNhvvfkvVdAyIj+sGZGCJWRRXLpmBwIUAfcLE1DZG5HERt6F0u6T3q
	ZvTehqxa3s8KQsrZILqf4ZIHp+npPnGXlWM7gGQ2S8qPYJHZfI3ppaWLc4Q==
X-Gm-Gg: ASbGncsG2Ay13gOj69UNaHBr6Ak3jpf/icrgpoayFQNuteLo0RH2tuT0FaCWZKkzH7C
	KvXQBOlEvR7ApK4Bz3HIRws9s85ZHIibzk+UFKBoF6O3woNGK3XGNzm7FCSWaZH4xFHEbkd96uj
	5waBhRj/JwOoyr4XFxKOJv2OpAUalxx9XCrjbQ03rRpoMKl8BZasqNXAukOPDzO4K+wJr+vPDVo
	YX9SWPHUL970UDVvijgNqe73Oyy401gm8iWgVx1udydjYZlvG3TObXHJjs81GB/FnBTLDVkUCSS
	3/uwudB9Yw8MJYGnJdOe764unIBxVB0FBQFFoBPUs4obhOE9U5X7I/NGHg6BnQKpETdQPRbKC29
	67xtUt+8P8Fa3g88tolWS17aAxZYjkz680WNkcVjLk4s3x0+Xwg==
X-Received: by 2002:a05:600c:4e8b:b0:453:8a63:b484 with SMTP id 5b1f17b1804b1-4538ee75d5emr46069315e9.30.1751039369719;
        Fri, 27 Jun 2025 08:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf34PqbJ8qzLhvpscXunFC56wXeCg2MQwLGMyj61jFGMywYScq+JOuap9GUf8ACPcIqst2ow==
X-Received: by 2002:a05:600c:4e8b:b0:453:8a63:b484 with SMTP id 5b1f17b1804b1-4538ee75d5emr46068935e9.30.1751039369204;
        Fri, 27 Jun 2025 08:49:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:5d00:f1a3:2f30:6575:9425? (p200300d82f2d5d00f1a32f3065759425.dip0.t-ipconnect.de. [2003:d8:2f2d:5d00:f1a3:2f30:6575:9425])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453923a22fbsm13811675e9.34.2025.06.27.08.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 08:49:28 -0700 (PDT)
Message-ID: <790e550f-3d6e-4eb2-be3c-a5feaaac1ce0@redhat.com>
Date: Fri, 27 Jun 2025 17:49:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lance Yang <lance.yang@linux.dev>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org,
 huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 mingzhe.yang@ly.com, stable@vger.kernel.org, Lance Yang <ioworker0@gmail.com>
References: <20250627062319.84936-1-lance.yang@linux.dev>
 <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
 <CAGsJ_4z+DU-FhNk9vkS-epdxgUMjrCvh31ZBwoAs98uWnbTK-A@mail.gmail.com>
 <1d39b66e-4009-4143-a8fa-5d876bc1f7e7@linux.dev>
 <CAGsJ_4xX+kW1msaXpEPqX7aQ-GYG9QVMo+JYBc18BfLCs8eFyA@mail.gmail.com>
 <609409c7-91a8-4898-ab29-fa00eb36df02@redhat.com>
 <530101b3-34d2-49bb-9a12-c7036b0c0a69@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <530101b3-34d2-49bb-9a12-c7036b0c0a69@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.06.25 17:29, Lance Yang wrote:
> 
> 
> On 2025/6/27 18:13, David Hildenbrand wrote:
>> On 27.06.25 09:36, Barry Song wrote:
>>> On Fri, Jun 27, 2025 at 7:15 PM Lance Yang <lance.yang@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/6/27 14:55, Barry Song wrote:
>>>>> On Fri, Jun 27, 2025 at 6:52 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Jun 27, 2025 at 6:23 PM Lance Yang <ioworker0@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>>>
>>>>>>> As pointed out by David[1], the batched unmap logic in
>>>>>>> try_to_unmap_one()
>>>>>>> can read past the end of a PTE table if a large folio is mapped
>>>>>>> starting at
>>>>>>> the last entry of that table. It would be quite rare in practice, as
>>>>>>> MADV_FREE typically splits the large folio ;)
>>>>>>>
>>>>>>> So let's fix the potential out-of-bounds read by refactoring the
>>>>>>> logic into
>>>>>>> a new helper, folio_unmap_pte_batch().
>>>>>>>
>>>>>>> The new helper now correctly calculates the safe number of pages
>>>>>>> to scan by
>>>>>>> limiting the operation to the boundaries of the current VMA and
>>>>>>> the PTE
>>>>>>> table.
>>>>>>>
>>>>>>> In addition, the "all-or-nothing" batching restriction is removed to
>>>>>>> support partial batches. The reference counting is also cleaned up
>>>>>>> to use
>>>>>>> folio_put_refs().
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/
>>>>>>> a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
>>>>>>>
>>>>>>
>>>>>> What about ?
>>>>>>
>>>>>> As pointed out by David[1], the batched unmap logic in
>>>>>> try_to_unmap_one()
>>>>>> may read past the end of a PTE table when a large folio spans
>>>>>> across two PMDs,
>>>>>> particularly after being remapped with mremap(). This patch fixes the
>>>>>> potential out-of-bounds access by capping the batch at vm_end and
>>>>>> the PMD
>>>>>> boundary.
>>>>>>
>>>>>> It also refactors the logic into a new helper,
>>>>>> folio_unmap_pte_batch(),
>>>>>> which supports batching between 1 and folio_nr_pages. This improves
>>>>>> code
>>>>>> clarity. Note that such cases are rare in practice, as MADV_FREE
>>>>>> typically
>>>>>> splits large folios.
>>>>>
>>>>> Sorry, I meant that MADV_FREE typically splits large folios if the
>>>>> specified
>>>>> range doesn't cover the entire folio.
>>>>
>>>> Hmm... I got it wrong as well :( It's the partial coverage that triggers
>>>> the split.
>>>>
>>>> how about this revised version:
>>>>
>>>> As pointed out by David[1], the batched unmap logic in
>>>> try_to_unmap_one()
>>>> may read past the end of a PTE table when a large folio spans across two
>>>> PMDs, particularly after being remapped with mremap(). This patch fixes
>>>> the potential out-of-bounds access by capping the batch at vm_end and
>>>> the
>>>> PMD boundary.
>>>>
>>>> It also refactors the logic into a new helper, folio_unmap_pte_batch(),
>>>> which supports batching between 1 and folio_nr_pages. This improves code
>>>> clarity. Note that such boundary-straddling cases are rare in
>>>> practice, as
>>>> MADV_FREE will typically split a large folio if the advice range does
>>>> not
>>>> cover the entire folio.
>>>
>>> I assume the out-of-bounds access must be fixed, even though it is very
>>> unlikely. It might occur after a large folio is marked with MADV_FREE and
>>> then remapped to an unaligned address, potentially crossing two PTE
>>> tables.
>>
>> Right. If it can be triggered from userspace, it doesn't matter how
>> likely/common/whatever it is. It must be fixed.
> 
> Agreed. It must be fixed regardless of how rare the scenario is ;)
> 
>>
>>>
>>> A batch size between 2 and nr_pages - 1 is practically rare, as we
>>> typically
>>> split large folios when MADV_FREE does not cover the entire folio range.
>>> Cases where a batch of size 2 or nr_pages - 1 occurs may only happen if a
>>> large folio is partially unmapped after being marked MADV_FREE, which is
>>> quite an unusual pattern in userspace.
>>
>> I think the point is rather "Simplify the code by not special-casing for
>> completely mapped folios, there is no real reason why we cannot batch
>> ranges that don't cover the complete folio.".
> 
> Yeah. That makes the code cleaner and more generic, as there is no
> strong reason to special-case for fully mapped folios ;)
> 
> Based on that, I think we're on the same page now. I'd like to post
> the following commit message for the next version:
> 
> ```
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio's PTE mappings
> are not fully contained within a single page table.
> 
> While this scenario might be rare, an issue triggerable from userspace must
> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> access by refactoring the logic into a new helper, folio_unmap_pte_batch().
> 
> The new helper correctly calculates the safe batch size by capping the
> scan at both the VMA and PMD boundaries. To simplify the code, it also
> supports partial batching (i.e., any number of pages from 1 up to the
> calculated safe maximum), as there is no strong reason to special-case
> for fully mapped folios.
> ```
> 
> So, wdyt?

Sounds good to me.

-- 
Cheers,

David / dhildenb


