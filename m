Return-Path: <stable+bounces-139457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4FAA6BC2
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C841BA2622
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323519DF4F;
	Fri,  2 May 2025 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YztEvjP8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D21A0BC9
	for <stable@vger.kernel.org>; Fri,  2 May 2025 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171471; cv=none; b=BkD6YLe3uSFl8PEKpto3QutsaNQ+cupcKmzRp0xE2J6WjoPGpCSjr3G36hU0rQKS19TvAJmHzp5Tpgr4DAcmwAnn1hZaVAEV7MCeoiZjtotKHxLlgx/CZ2a7/jRgjxA0v7sVkHv16X7Q37yPpUO3OjvL3SuVItgUuq9wPX/CLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171471; c=relaxed/simple;
	bh=Un8AN6+W7hdXCGs5FakehGp8gQb8LyaMepwlot1T11k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kf8PThFcKL0kzpRtGtoKUW28hqJOdKfIYpR2mTPQMIIM6G9b61H0RY08UdsveXRrOSk391fusqFFyxAg2S0xj8u5sFANKM8mFAZh4Fq6tPWSsh122epnaycfIRD61ympe/6/vMLkwVvOIYj5bQ5SLReOzseHHMaf1pT+XGg5b6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YztEvjP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746171468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q87iNuAOCQ7MPJb31XTFDqu25SSlsYHKaJtmZwAFnHA=;
	b=YztEvjP8iF6hSiNEVLqq/WR8QhPRXkav2esRMvv37iFXC+5ZSznA4rjFzvVlchOf2otsVQ
	IvQMEBEWPWTfbMM7XQp2cCaRq9UTIjDzJAXjpC3Qp7CGWHNA+Q+zOPc3EGcEikOH23Wfmt
	nUzaAhXX9ZghEmeJf+DZwtrr6OHO5rI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-EslgRFNPNLufxhxGxEcR2w-1; Fri, 02 May 2025 03:37:47 -0400
X-MC-Unique: EslgRFNPNLufxhxGxEcR2w-1
X-Mimecast-MFC-AGG-ID: EslgRFNPNLufxhxGxEcR2w_1746171466
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aea90b4so674359f8f.2
        for <stable@vger.kernel.org>; Fri, 02 May 2025 00:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171466; x=1746776266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q87iNuAOCQ7MPJb31XTFDqu25SSlsYHKaJtmZwAFnHA=;
        b=SAl7O7/Ponphlq/tpjaNEGeDAJ0JNI2TUnbjyavB2z9l6ZGqlAZt9Qc0VBx/hygi1o
         8ZyLme4Y48kIPDx7omWZagNWEtRrU/jp003yiHn6hztlXuaKE9vvG4nCoLtPDmo7J/8m
         oCsSNIzl1VS2Z7gcBduzYiVhDcss7/m4/lZNzB0hGUQoi554I6CXUQrOmgfhwoxrQsUv
         9gMvqrV15nTrbb2uXRVAFaxlOXUHGLP2WFZOqkgf04T9I/zdslHEubYJNZwqLKNMBxpb
         wKO3C8HkZt01OeFjLAVM120n6twyhqlopX7tZoHlLGcZndlqj9RDqxl5H6xXYANJRUVb
         C5gw==
X-Forwarded-Encrypted: i=1; AJvYcCXqTt0Z4S2c+sS3TK7WG7sLETq2uD7agzJZ5nGBBoJFbcTe1/nMWjnI5rZQaPRbhXQPB28DTJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfuStvr3iFeh9Xo7GuwjpdH4ukVOElSidy4VYa/mDFa2QCYJ3
	X257nLnCkSZ7ACdxWQL+uVb+q78sH3sYLhKXrTu+EMFLAVLXFcuZaJPNrSQOxXANQQKiL/PsPZw
	qItqrXN1p1T8ZdLdAQTJ/0O3X6bT8Apj8yTmW8j/N6tPrwrMaNyK0Ew==
X-Gm-Gg: ASbGncvH3n5KVkNwUHvGYY6XMKXQ491JHNBs8GwZfAajh1iJIiM5FGMt/c8qG5ifPpQ
	pN42M4dI2R06FWgZiOxXToDEHis0id1FEZSHi5GTM8YhxzJ/b1CekEQlVRDq3TfqlzT8xnYJv/J
	SjWmpQ7fruiSXJ717dNJJ2Ctdvg4OxUI3ZLwZetU2YCJEuqGrkE/aVTIwjC6R2L2noylwgAtbr6
	m8aON7QQbN+hQ+7g9uyrv6OqcurBi+YZnhHwFQhxSv08Kzyr8dkXP4cXsFnYz7B9ukNpieNgLsT
	hPjcZn26YH66TjWG4XNTlWJmg4gOeFsfHk+CViz2ab4KcOBPndHPv3xZhsBjpV+bRtura5bXRT4
	+tEXr+xRff3oLhNm40HwkSPuIDqPTNYsP/brGNZE=
X-Received: by 2002:a05:6000:18ac:b0:39c:3107:c503 with SMTP id ffacd0b85a97d-3a099ade134mr1118189f8f.31.1746171465757;
        Fri, 02 May 2025 00:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6LK4gg7MWrcfnIs9ZPGWqEpStvztLzi4/OGUyN+TyGu/HXImDYYR7x2Rv5Mj4MnOzp9ctyw==
X-Received: by 2002:a05:6000:18ac:b0:39c:3107:c503 with SMTP id ffacd0b85a97d-3a099ade134mr1118171f8f.31.1746171465370;
        Fri, 02 May 2025 00:37:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0bb5sm1349695f8f.7.2025.05.02.00.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 00:37:44 -0700 (PDT)
Message-ID: <0e029877-4ca9-40f0-933f-6d0779c95d72@redhat.com>
Date: Fri, 2 May 2025 09:37:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
To: =?UTF-8?Q?Petr_Van=C4=9Bk?= <arkamar@atlas.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
 <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
 <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>
 <202543011526-aBIO5nq6Olsmq2E--arkamar@atlas.cz>
 <9c412f4f-3bdf-43c0-a3cd-7ce52233f4e5@redhat.com>
 <202543016037-aBJJJdupFVd_6FTX-arkamar@atlas.cz>
 <91c4e7e6-e4c2-4ff0-8b13-7b3ff138e98e@redhat.com>
 <20255174537-aBMmobhpYTFtoONI-arkamar@atlas.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20255174537-aBMmobhpYTFtoONI-arkamar@atlas.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.05.25 09:45, Petr Vaněk wrote:
> On Wed, Apr 30, 2025 at 11:25:56PM +0200, David Hildenbrand wrote:
>> On 30.04.25 18:00, Petr Vaněk wrote:
>>> On Wed, Apr 30, 2025 at 04:37:21PM +0200, David Hildenbrand wrote:
>>>> On 30.04.25 13:52, Petr Vaněk wrote:
>>>>> On Tue, Apr 29, 2025 at 08:56:03PM +0200, David Hildenbrand wrote:
>>>>>> On 29.04.25 20:33, Petr Vaněk wrote:
>>>>>>> On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
>>>>>>>> On 29.04.25 16:52, David Hildenbrand wrote:
>>>>>>>>> On 29.04.25 16:45, Petr Vaněk wrote:
>>>>>>>>>> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
>>>>>>>>>>> On 29.04.25 16:22, Petr Vaněk wrote:
>>>>>>>>>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
>>>>>>>>>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
>>>>>>>>>>>> memory also happens to be zero. The loop doesn't break in such a case
>>>>>>>>>>>> because pte_same() returns true, and the batch size is advanced by one
>>>>>>>>>>>> more than it should be.
>>>>>>>>>>>>
>>>>>>>>>>>> To fix this, bail out early if a non-present PTE is encountered,
>>>>>>>>>>>> preventing the invalid comparison.
>>>>>>>>>>>>
>>>>>>>>>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
>>>>>>>>>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
>>>>>>>>>>>> bisect.
>>>>>>>>>>>>
>>>>>>>>>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>>>>>>>>>>>> ---
>>>>>>>>>>>>         mm/internal.h | 2 ++
>>>>>>>>>>>>         1 file changed, 2 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>>>>>>> index e9695baa5922..c181fe2bac9d 100644
>>>>>>>>>>>> --- a/mm/internal.h
>>>>>>>>>>>> +++ b/mm/internal.h
>>>>>>>>>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>>>>>>>>>>         			dirty = !!pte_dirty(pte);
>>>>>>>>>>>>         		pte = __pte_batch_clear_ignored(pte, flags);
>>>>>>>>>>>>         
>>>>>>>>>>>> +		if (!pte_present(pte))
>>>>>>>>>>>> +			break;
>>>>>>>>>>>>         		if (!pte_same(pte, expected_pte))
>>>>>>>>>>>>         			break;
>>>>>>>>>>>
>>>>>>>>>>> How could pte_same() suddenly match on a present and non-present PTE.
>>>>>>>>>>
>>>>>>>>>> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
>>>>>>>>>> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
>>>>>>>>>
>>>>>>>>> Observe that folio_pte_batch() was called *with a present pte*.
>>>>>>>>>
>>>>>>>>> do_zap_pte_range()
>>>>>>>>> 	if (pte_present(ptent))
>>>>>>>>> 		zap_present_ptes()
>>>>>>>>> 			folio_pte_batch()
>>>>>>>>>
>>>>>>>>> How can we end up with an expected_pte that is !present, if it is based
>>>>>>>>> on the provided pte that *is present* and we only used pte_advance_pfn()
>>>>>>>>> to advance the pfn?
>>>>>>>>
>>>>>>>> I've been staring at the code for too long and don't see the issue.
>>>>>>>>
>>>>>>>> We even have
>>>>>>>>
>>>>>>>> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>>>>>>>>
>>>>>>>> So the initial pteval we got is present.
>>>>>>>>
>>>>>>>> I don't see how
>>>>>>>>
>>>>>>>> 	nr = pte_batch_hint(start_ptep, pte);
>>>>>>>> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
>>>>>>>>
>>>>>>>> would suddenly result in !pte_present(expected_pte).
>>>>>>>
>>>>>>> The issue is not happening in __pte_batch_clear_ignored but later in
>>>>>>> following line:
>>>>>>>
>>>>>>>       expected_pte = pte_advance_pfn(expected_pte, nr);
>>>>>>>
>>>>>>> The issue seems to be in __pte function which converts PTE value to
>>>>>>> pte_t in pte_advance_pfn, because warnings disappears when I change the
>>>>>>> line to
>>>>>>>
>>>>>>>       expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };
>>>>>>>
>>>>>>> The kernel probably uses __pte function from
>>>>>>> arch/x86/include/asm/paravirt.h because it is configured with
>>>>>>> CONFIG_PARAVIRT=y:
>>>>>>>
>>>>>>>       static inline pte_t __pte(pteval_t val)
>>>>>>>       {
>>>>>>>       	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
>>>>>>>       					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
>>>>>>>       }
>>>>>>>
>>>>>>> I guess it might cause this weird magic, but I need more time to
>>>>>>> understand what it does :)
>>>>>
>>>>> I understand it slightly more. __pte() uses xen_make_pte(), which calls
>>>>> pte_pfn_to_mfn(), however, mfn for this pfn contains INVALID_P2M_ENTRY
>>>>> value, therefore the pte_pfn_to_mfn() returns 0, see [1].
>>>>>
>>>>> I guess that the mfn was invalidated by xen-balloon driver?
>>>>>
>>>>> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/mmu_pv.c?h=v6.15-rc4#n408
>>>>>
>>>>>> What XEN does with basic primitives that convert between pteval and
>>>>>> pte_t is beyond horrible.
>>>>>>
>>>>>> How come set_ptes() that uses pte_next_pfn()->pte_advance_pfn() does not
>>>>>> run into this?
>>>>>
>>>>> I don't know, but I guess it is somehow related to pfn->mfn translation.
>>>>>
>>>>>> Is it only a problem if we exceed a certain pfn?
>>>>>
>>>>> No, it is a problem if the corresponding mft to given pfn is invalid.
>>>>>
>>>>> I am not sure if my original patch is a good fix.
>>>>
>>>> No :)
>>>>
>>>> Maybe it would be
>>>>> better to have some sort of native_pte_advance_pfn() which will use
>>>>> native_make_pte() rather than __pte(). Or do you think the issue is in
>>>>> Xen part?
>>>>
>>>> I think what's happening is that -- under XEN only -- we might get garbage when
>>>> calling pte_advance_pfn() and the next PFN would no longer fall into the folio. And
>>>> the current code cannot deal with that XEN garbage.
>>>>
>>>> But still not 100% sure.
>>>>
>>>> The following is completely untested, could you give that a try?
>>>
>>> Yes, it solves the issue for me.
>>
>> Cool!
>>
>>>
>>> However, maybe it would be better to solve it with the following patch.
>>> The pte_pfn_to_mfn() actually returns the same value for non-present
>>> PTEs. I suggest to return original PTE if the mfn is INVALID_P2M_ENTRY,
>>> rather than empty non-present PTE, but the _PAGE_PRESENT bit will be set
>>> to zero. Thus, we will not loose information about original pfn but it
>>> will be clear that the page is not present.
>>>
>>>   From e84781f9ec4fb7275d5e7629cf7e222466caf759 Mon Sep 17 00:00:00 2001
>>> From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
>>> Date: Wed, 30 Apr 2025 17:08:41 +0200
>>> Subject: [PATCH] x86/mm: Reset pte _PAGE_PRESENT bit for invalid mft
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=UTF-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>>> ---
>>>    arch/x86/xen/mmu_pv.c | 9 +++------
>>>    1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
>>> index 38971c6dcd4b..92a6a9af0c65 100644
>>> --- a/arch/x86/xen/mmu_pv.c
>>> +++ b/arch/x86/xen/mmu_pv.c
>>> @@ -392,28 +392,25 @@ static pteval_t pte_mfn_to_pfn(pteval_t val)
>>>    static pteval_t pte_pfn_to_mfn(pteval_t val)
>>>    {
>>>    	if (val & _PAGE_PRESENT) {
>>>    		unsigned long pfn = (val & PTE_PFN_MASK) >> PAGE_SHIFT;
>>>    		pteval_t flags = val & PTE_FLAGS_MASK;
>>>    		unsigned long mfn;
>>>    
>>>    		mfn = __pfn_to_mfn(pfn);
>>>    
>>>    		/*
>>> -		 * If there's no mfn for the pfn, then just create an
>>> -		 * empty non-present pte.  Unfortunately this loses
>>> -		 * information about the original pfn, so
>>> -		 * pte_mfn_to_pfn is asymmetric.
>>> +		 * If there's no mfn for the pfn, then just reset present pte bit.
>>>    		 */
>>>    		if (unlikely(mfn == INVALID_P2M_ENTRY)) {
>>> -			mfn = 0;
>>> -			flags = 0;
>>> +			mfn = pfn;
>>> +			flags &= ~_PAGE_PRESENT;
>>>    		} else
>>>    			mfn &= ~(FOREIGN_FRAME_BIT | IDENTITY_FRAME_BIT);
>>>    		val = ((pteval_t)mfn << PAGE_SHIFT) | flags;
>>>    	}
>>>    
>>>    	return val;
>>>    }
>>>    
>>>    __visible pteval_t xen_pte_val(pte_t pte)
>>>    {
>>
>> That might do as well.
>>
>>
>> I assume the following would also work? (removing the early ==1 check)
> 
> Yes, it also works in my case and the removal makes sense to me.
> 
>> It has the general benefit of removing the pte_pfn() call from the
>> loop body, which is why I like that fix. (almost looks like a cleanup)
> 
> Indeed, it looks like a cleanup to me as well :)

Okay, let me polish the patch up and send it out later.

> 
> I am still considering if it would make sense to send both patches, I am
> not sure if reseting _PAGE_PRESENT flag is enough, because of swapping
> or other areas which I am not aware of.

The problem I'm having with pte_mfn_to_pfn() updates is that I don't 
understand what the expected output is even supposed to be. You should 
probably ask XEN folks (I realized that they are not CCed).

-- 
Cheers,

David / dhildenb


