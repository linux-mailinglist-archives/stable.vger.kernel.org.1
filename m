Return-Path: <stable+bounces-181954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBFBA9F82
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB103C502A
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D430B504;
	Mon, 29 Sep 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnX/ylYg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC52EB5AF
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162331; cv=none; b=N14FcMLTapNagG2QWBcEA0xTKcNaiJs36Sjcv5z/dQbtUAbs6qe2sNZcBeIboCli5lathRNg3lFG/1wj6esKUC6t+5DAgujIN1WDF76LjtaWxMBqdimGK/qDwKTnAEatIwKrN34ff+SClMkc3K3j1vbXkP/JB7vHo6770E3GGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162331; c=relaxed/simple;
	bh=/dNPXNNTrg4oakHaeJ3kr6dQTgW4ydsjx+QV4mQXBBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSjW0usfMnr9XIZ6O7R+4oUo8741LjL9apxPEQBKfDg6QWwWIzd0qKeW2OGKP4Wm3SgwaxRChD40O+wAIegFQyJz5rgZqzUDbPYYzvkcH6nbANJhYRVpHqzYQHYyunCnzKnRsFMfPoidUZoeFAMT/ropPq+j8T5FkAZC+ESddtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnX/ylYg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759162328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lW3umbnn2U+i47M0Kxw/zaZzRyBwQr9J+IoqgDAnoAQ=;
	b=MnX/ylYgogCCQ9kCbxmN/UWLoMFqBQHRh947gDrdEw/1J9mqCS1QgKvKOe0pb0b8oW2Kkj
	kuueCswMpSTPLU+Le9jzi/PSmDm89PZrnbfBKrYluph9NY5wTNfud7IgQ0fCnxfI+z3coK
	pM0TeQRsEfnptwW3dNRPcYBNm8HHin0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-LYkMXXmsOhWJ8cjwU44K1g-1; Mon, 29 Sep 2025 12:12:03 -0400
X-MC-Unique: LYkMXXmsOhWJ8cjwU44K1g-1
X-Mimecast-MFC-AGG-ID: LYkMXXmsOhWJ8cjwU44K1g_1759162322
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so37223595e9.2
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162322; x=1759767122;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW3umbnn2U+i47M0Kxw/zaZzRyBwQr9J+IoqgDAnoAQ=;
        b=NK9jQRnRV4qDR4AjrvJkozMOxU9/GapofzCQtw/f6U0o55hVtYWkZz1af6Uh8pfLxt
         ejAJ4Ai7iyN3I83svIHXiFZwGoymLaUjRjGi2wUE+4ALyRjVapc5+6NV0s8ktSYCrdvI
         jii3OAS4iYokv90jSYOforQ4nHfak+G4q/Rx1Uc7ypq9LmKeIBmq6gmJazZHNSPyqmFC
         dTwMt+KoOPIxUQKMb+Sbm71qGmbCvjUWNV1quRwj9ahACViwD5RHSkpiKnqWzrknztJv
         TXwCXEH7MOyewFh5S5o3VeseAngg7mrf0yGXiuDRQSll0cZ7P8YUNeTL4kN5/rEm+tBF
         S+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkSiTFuUHfU914hIbDRijrgtZnyCvl/E9edwMvG2YkvNKG8I6H8MYRNeIBxTPxHNBIcK8eILU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmliSBJI/Q1z63ABd4xfCu6jSNwdjapwJnnpcsAPpOkLeANwbS
	+LxXBuU5Q/1FQmvCYsecC3lKcCIrhC/SlR6QD5mwAX+SyBORs5Eut/q5JYRxnjbM8pC7JfU3pp9
	ezwZilq5p4niiLLl7aBfQZ9G57jTOb+TNm/cpNs+dsJrdXjwKvD0jyA4pNQ==
X-Gm-Gg: ASbGncu/jwGNKgPorXDtlo+5ydRgvdqR1tw1R620W8CmWQ3m8HxtEfJwvTcQHEcBET9
	b1eNSwHgfQ0rXk2xCeLkXsHY1rH7JjmmR60UUPcRbPjR0hzurKE9bzHew91/h31udoKM2/r5g7B
	tEUZiGRc62Csf3+2jov4me7Ge7QpNBrTwOJqcQwnDAFrOO7ZeqtWPeGhxWdDSu3lIHAAraKv8GY
	UGVjM9a9I2tdzwmT/3ypVJA0z0DZIS37/+DZ5XmmrlFUcr1fO3Icc1Qtm+U1m7DfBVhipoXhvIH
	FyBfaxXn/aJc2zRUk9PJTZWU8nRgXmI9xu01pzgNfVQYh/BXquLSnGd4ID9drLBjP1ISI1QVhrb
	w+3Y=
X-Received: by 2002:a05:600c:a43:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e329e4aa5mr149358865e9.22.1759162321898;
        Mon, 29 Sep 2025 09:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHATh8Zy5jKwZGDwOw3Gds07nQEvZPlgZdVLrdT3lSvHBbbw0pqU2Gxo6cq9HH0mFtbCklTYA==
X-Received: by 2002:a05:600c:a43:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e329e4aa5mr149358485e9.22.1759162321411;
        Mon, 29 Sep 2025 09:12:01 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab6a514sm231311635e9.22.2025.09.29.09.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:12:00 -0700 (PDT)
Message-ID: <1718aee4-1201-4362-885b-e707f536a065@redhat.com>
Date: Mon, 29 Sep 2025 18:11:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping
 zero-filled mTHP subpage to shared zeropage
To: Lance Yang <lance.yang@linux.dev>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
References: <20250928044855.76359-1-lance.yang@linux.dev>
 <b19b4880-169f-4946-8c50-e82f699bb93b@redhat.com>
 <900d0314-8e9a-4779-a058-9bb3cc8840b8@linux.dev>
 <1f66374a-a901-49e7-95c8-96b1e5a5f22d@linux.dev>
 <69b463e5-9854-496d-b461-4bf65e82bc0a@redhat.com>
 <0701c9d9-b9b3-4313-8783-8e6d1dbec94d@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <0701c9d9-b9b3-4313-8783-8e6d1dbec94d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.09.25 15:22, Lance Yang wrote:
> 
> 
> On 2025/9/29 20:08, David Hildenbrand wrote:
>> On 29.09.25 13:29, Lance Yang wrote:
>>>
>>>
>>> On 2025/9/29 18:29, Lance Yang wrote:
>>>>
>>>>
>>>> On 2025/9/29 15:25, David Hildenbrand wrote:
>>>>> On 28.09.25 06:48, Lance Yang wrote:
>>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>>
>>>>>> When splitting an mTHP and replacing a zero-filled subpage with the
>>>>>> shared
>>>>>> zeropage, try_to_map_unused_to_zeropage() currently drops the soft-
>>>>>> dirty
>>>>>> bit.
>>>>>>
>>>>>> For userspace tools like CRIU, which rely on the soft-dirty mechanism
>>>>>> for
>>>>>> incremental snapshots, losing this bit means modified pages are
>>>>>> missed,
>>>>>> leading to inconsistent memory state after restore.
>>>>>>
>>>>>> Preserve the soft-dirty bit from the old PTE when creating the
>>>>>> zeropage
>>>>>> mapping to ensure modified pages are correctly tracked.
>>>>>>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage
>>>>>> when splitting isolated thp")
>>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>>> ---
>>>>>>     mm/migrate.c | 4 ++++
>>>>>>     1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>> index ce83c2c3c287..bf364ba07a3f 100644
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct
>>>>>> page_vma_mapped_walk *pvmw,
>>>>>>         newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>>>>>                         pvmw->vma->vm_page_prot));
>>>>>> +
>>>>>> +    if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
>>>>>> +        newpte = pte_mksoft_dirty(newpte);
>>>>>> +
>>>>>>         set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>>>>>         dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
>>>>>
>>>>> It's interesting that there isn't a single occurrence of the stof-
>>>>> dirty flag in khugepaged code. I guess it all works because we do the
>>>>>
>>>>>        _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>>>>
>>>>> and the pmd_mkdirty() will imply marking it soft-dirty.
>>>>>
>>>>> Now to the problem at hand: I don't think this is particularly
>>>>> problematic in the common case: if the page is zero, it likely was
>>>>> never written to (that's what the unerused shrinker is targeted at),
>>>>> so the soft-dirty setting on the PMD is actually just an over-
>>>>> indication for this page.
>>>>
>>>> Cool. Thanks for the insight! Good to know that ;)
>>>>
>>>>>
>>>>> For example, when we just install the shared zeropage directly in
>>>>> do_anonymous_page(), we obviously also don't set it dirty/soft-dirty.
>>>>>
>>>>> Now, one could argue that if the content was changed from non-zero to
>>>>> zero, it ould actually be soft-dirty.
>>>>
>>>> Exactly. A false negative could be a problem for the userspace tools,
>>>> IMO.
>>>>
>>>>>
>>>>> Long-story short: I don't think this matters much in practice, but
>>>>> it's an easy fix.
>>>>>
>>>>> As said by dev, please avoid double ptep_get() if possible.
>>>>
>>>> Sure, will do. I'll refactor it in the next version.
>>>>
>>>>>
>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>>
>>>> Thanks!
>>>>
>>>>>
>>>>>
>>>>> @Lance, can you double-check that the uffd-wp bit is handled
>>>>> correctly? I strongly assume we lose that as well here.
>>>
>>> Yes, the uffd-wp bit was indeed being dropped, but ...
>>>
>>> The shared zeropage is read-only, which triggers a fault. IIUC,
>>> The kernel then falls back to checking the VM_UFFD_WP flag on
>>> the VMA and correctly generates a uffd-wp event, masking the
>>> fact that the uffd-wp bit on the PTE was lost.
>>
>> That's not how VM_UFFD_WP works :)
> 
> My bad! Please accept my apologies for the earlier confusion :(
> 
> I messed up my test environment (forgot to enable mTHP), which
> led me to a completely wrong conclusion...
> 
> You're spot on. With mTHP enabled, the WP fault was not caught
> on the shared zeropage after it replaced a zero-filled subpage
> during an mTHP split.
> 
> This is because do_wp_page() requires userfaultfd_pte_wp() to
> be true, which in turn needs both userfaultfd_wp(vma) and
> pte_uffd_wp(pte).
> 
> static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> 				      pte_t pte)
> {
> 	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
> }
> 
> userfaultfd_pte_wp() fails as we lose the uffd-wp bit on the PTE ...

That's my understanding. And FWIW, that's a much more important fix. (in 
contrast to soft-dirty, uffd-wp actually is precise)

Can you test+send a fix ... please? :)

-- 
Cheers

David / dhildenb


