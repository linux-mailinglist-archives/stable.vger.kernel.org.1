Return-Path: <stable+bounces-138939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E570AA1AF6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1184A2A65
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8424EAB2;
	Tue, 29 Apr 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWEo3opM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621416DC28
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952971; cv=none; b=ELvR7wY/QWCYnAkF4bnsfkI4mjqpp0h5MWxy0UGlhLnFcmDFFB7df5PlwCdZSr/EjMYULtcThI6CSkEexiGK/MwKpSaGVXIxReXFMTZCqzL+ReL87UfmCWHiagvOybvsKHDS04nL6k5jiqJqj0jBLm25gWaQnyErEJMRisPTQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952971; c=relaxed/simple;
	bh=dKiTsSoDqzXVy7CyMbgG4W/S7RcPWdPULTirutq7xaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4pBOUA6H3ZfSPbP2O+9FLIRqvj8T5l2CfpVaU0tXsbIg5KCeg5iHjO3Z+33a+FONi1Cn49Feu3DfrtxuNcxgJM1nmvzazJlMUbkq30ssOp7dOJEBDp6+So8MYLIViipEnXV3n2TySV2dXwx/YZcfRPIrrKEzPL1aU9d7gGOKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWEo3opM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745952968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikFW+9ys6UWG9i7frkVdl58sM1oLqx9x/0wPtHF3Phk=;
	b=CWEo3opM0uSCUnEnieXFfxUAyiHrCg6wybWO0z0V15B+SiEUUj2/e83YQiXaaAZyJCePTt
	d2p48PClGK7cNdCxgzGyTdt9QbHA+uAUkUt9EJ53rNLR+0Vq9qpUw1TWGO9HL4CoXvWJcU
	YFhASRENH7hKGQlG+AXRqE9DZY1oHOs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-GoOdzoCTNFCYjLqnXX-zvg-1; Tue, 29 Apr 2025 14:56:06 -0400
X-MC-Unique: GoOdzoCTNFCYjLqnXX-zvg-1
X-Mimecast-MFC-AGG-ID: GoOdzoCTNFCYjLqnXX-zvg_1745952965
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fc9861cso1789306f8f.1
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 11:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952965; x=1746557765;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ikFW+9ys6UWG9i7frkVdl58sM1oLqx9x/0wPtHF3Phk=;
        b=a8xRViHkDR2PfzDnTl7CnaSemgKcf+qS95RE8exs5piq3mxjS113sAbNrT6iapF8ML
         +jqm6wJC3Q6BsvNopxzDQBUroRz2oXEa/cqlJX4SHadGhPWeEcn8HVpjRyWAqwZltjth
         VZjKndfnmJzG+YvqRt2N/pJAcYNMPUxB2wvyun1nS8lkTs+ClRnWrmubZwPYL5HK/l3T
         jYKYpPYnoSFLlpDub4e/iLk9+U4tpyM43SLHr+qMiHzKvclu/65ry9WpEx7I0f97PEHg
         +56VnpViHmtt6/k5/6dbBtoizALGQScMmT7YaOpsqUKlx8kayIoaK2pFEfAQEoOjRinU
         xg+w==
X-Forwarded-Encrypted: i=1; AJvYcCUkXbf9dKKiM7b0SBNHWjPoovCkRjcGb/wOQ+gHkpSVRMkOC94328jDE6HpS+uidkHSyrxe3+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgO1PoIGOCLB7qOYMj4uVwlbKK5owwM7GGTPW0mwhGpzlyKVKO
	8ktIzxq6apdyCAOsNT4E3x0mQ8GxAxiIcre1buJs2mNxrfYKaBqhiQLUPKNPBVsDjpOBZlv+Fq3
	3tiwT6AXWu/wJ04v4db4bWSl3FLPxcF0pdzuWmVPlJTSDfLt4s3lDYw==
X-Gm-Gg: ASbGnctftM2urqn9MjDEONAw4fqwUZcHBcmEHMvZAhO/W/J+SP3pcgV+0I9wxsz6/lS
	4nsztIBQeMNjyL6/hLBdpwplJVNUOk83m72f58DDcNB5z+H3P8/cJ7eyYu0UkwJWewVGzbvws6h
	EFOfB13uwZ0vftXJDiNSCbTnokMHULdMhdWX62tBPyFqEmbaIylmShYye5DB4Obmse1kjTNMIHN
	mPC2ozOkbNmqzl0aZqV0F2Qd26COXe1WL7HRgUXFv44vIIeFAndFibOU5V9E357ZwtOIt1ScsVM
	p83dm0FAWllEOwu8EITS5uNmjXd74yHVNqYp9F4=
X-Received: by 2002:a05:6000:40cb:b0:3a0:7d15:1d8a with SMTP id ffacd0b85a97d-3a08f7c8592mr343860f8f.38.1745952964973;
        Tue, 29 Apr 2025 11:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQgDOIUOMtUqM8Yrzjr5zZGrbip6+9JYEzDp4h0EqxTldiWkXoXrJMA4X9XN0sE8X98LPCJA==
X-Received: by 2002:a05:6000:40cb:b0:3a0:7d15:1d8a with SMTP id ffacd0b85a97d-3a08f7c8592mr343845f8f.38.1745952964552;
        Tue, 29 Apr 2025 11:56:04 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c613e.dip0.t-ipconnect.de. [91.12.97.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e4684csm14681657f8f.76.2025.04.29.11.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 11:56:04 -0700 (PDT)
Message-ID: <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>
Date: Tue, 29 Apr 2025 20:56:03 +0200
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
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
 <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.04.25 20:33, Petr Vaněk wrote:
> On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
>> On 29.04.25 16:52, David Hildenbrand wrote:
>>> On 29.04.25 16:45, Petr Vaněk wrote:
>>>> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
>>>>> On 29.04.25 16:22, Petr Vaněk wrote:
>>>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
>>>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
>>>>>> memory also happens to be zero. The loop doesn't break in such a case
>>>>>> because pte_same() returns true, and the batch size is advanced by one
>>>>>> more than it should be.
>>>>>>
>>>>>> To fix this, bail out early if a non-present PTE is encountered,
>>>>>> preventing the invalid comparison.
>>>>>>
>>>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
>>>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
>>>>>> bisect.
>>>>>>
>>>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>>>>>> ---
>>>>>>      mm/internal.h | 2 ++
>>>>>>      1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>> index e9695baa5922..c181fe2bac9d 100644
>>>>>> --- a/mm/internal.h
>>>>>> +++ b/mm/internal.h
>>>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>>>>      			dirty = !!pte_dirty(pte);
>>>>>>      		pte = __pte_batch_clear_ignored(pte, flags);
>>>>>>      
>>>>>> +		if (!pte_present(pte))
>>>>>> +			break;
>>>>>>      		if (!pte_same(pte, expected_pte))
>>>>>>      			break;
>>>>>
>>>>> How could pte_same() suddenly match on a present and non-present PTE.
>>>>
>>>> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
>>>> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
>>>
>>> Observe that folio_pte_batch() was called *with a present pte*.
>>>
>>> do_zap_pte_range()
>>> 	if (pte_present(ptent))
>>> 		zap_present_ptes()
>>> 			folio_pte_batch()
>>>
>>> How can we end up with an expected_pte that is !present, if it is based
>>> on the provided pte that *is present* and we only used pte_advance_pfn()
>>> to advance the pfn?
>>
>> I've been staring at the code for too long and don't see the issue.
>>
>> We even have
>>
>> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>>
>> So the initial pteval we got is present.
>>
>> I don't see how
>>
>> 	nr = pte_batch_hint(start_ptep, pte);
>> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
>>
>> would suddenly result in !pte_present(expected_pte).
> 
> The issue is not happening in __pte_batch_clear_ignored but later in
> following line:
> 
>    expected_pte = pte_advance_pfn(expected_pte, nr);
> 
> The issue seems to be in __pte function which converts PTE value to
> pte_t in pte_advance_pfn, because warnings disappears when I change the
> line to
> 
>    expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };
> 
> The kernel probably uses __pte function from
> arch/x86/include/asm/paravirt.h because it is configured with
> CONFIG_PARAVIRT=y:
> 
>    static inline pte_t __pte(pteval_t val)
>    {
>    	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
>    					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
>    }
> 
> I guess it might cause this weird magic, but I need more time to
> understand what it does :)

What XEN does with basic primitives that convert between pteval and 
pte_t is beyond horrible.

How come set_ptes() that uses pte_next_pfn()->pte_advance_pfn() does not 
run into this?

Is it only a problem if we exceed a certain pfn?

-- 
Cheers,

David / dhildenb


