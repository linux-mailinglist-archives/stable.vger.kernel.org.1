Return-Path: <stable+bounces-181507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20241B96270
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E00B18831BF
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E91FBC8E;
	Tue, 23 Sep 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6mhYrdp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D22AF00
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636559; cv=none; b=ZD4IJFOBBSxyVeUe9HsT5DZHOee46fgMgwx4tZDoTDqkxH1b6NAtbdTFlRUPrPJ3v+eEgAqyyrU2WIDrbMwng0fQzO+AUoclK79TO2b5RQLxHO8U1JPWUzRIQc/6AG4xeh6FfACCuSXOxYQRKguAM/P2y+KoIOrmoGurVaeXQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636559; c=relaxed/simple;
	bh=V7GLlLmMCr7b9TsH7K/x6ATJUbrJcUS9QJbO72X5PUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFrPh8w+/VrjmnrNg/hSLO3oGkF4FsnD5LppBrLCpCRVnAwSwypM2BgR2mwlgtz/7u3aolu/Ymk+TYqG4Ag2T4Ieb90NKPrfw0l9/c0SJRyQVaOCN4VpJn564KmxPZQ8qfzX7zxOWaN/ymykJfaOm5DuQ1zYvVPW9sluwZrYrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6mhYrdp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758636555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OvfYmC09eC/jmHHiazmzVWdrgG996HkuXHBuyideCqI=;
	b=g6mhYrdp4lJATZZrW3aNu5Ls8yCeBRM/hIgqwmqe0G/u0QK8UbGts0yUrQcRYrvXAaWTEh
	kNGm/qWub69FNxSusx3ibXJ3p24RhO9EpyodH/2d2J1PjipRs1pEFNbDXYMrElBJPsnsHj
	J4a+iTVGSxkyYxJ4OFfNBTLK31ThX+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-sAvq_C2SNw2JffCK5feO5g-1; Tue, 23 Sep 2025 10:09:14 -0400
X-MC-Unique: sAvq_C2SNw2JffCK5feO5g-1
X-Mimecast-MFC-AGG-ID: sAvq_C2SNw2JffCK5feO5g_1758636553
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e23a66122so3257835e9.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 07:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758636553; x=1759241353;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvfYmC09eC/jmHHiazmzVWdrgG996HkuXHBuyideCqI=;
        b=bI/ATFXzvUbbM/YNSfDYR7M+hHUUdxlRWm7lLarWiaLS4F0GAQSvMRt3lsS+VTDgZ/
         9gUqt8Eobj+3QlJQANHmiPmUC6djE7QsPurqUjzuvRBwiK/uf0JMK/2w5JiTcuzZL4P3
         h+BmFj0WyJiFL22Zmzqb3/KjdgnLCE7/XvLWT2Qai2b0yWM1COnm1Z4Ac5RSWUHoi5x/
         8cc1k3TMoRAUQA+DS+B3w3fikQKv3tPw6WHdzmu2fhwacuPG0AfdYCO6H1ZarqGEIPZl
         rMvNemTI/8fTjs6iQaQwMeYn3oheDymsP4hq7I00yULJ5B1+0k+y3CiCEGD4oqAant5H
         Pqhg==
X-Forwarded-Encrypted: i=1; AJvYcCWQZczcSj3WqqkRv2sbTL9VjRbHWas9LgWPPVFJIL/PVrlSkFujUWVKxUiZ5EvIA5DfPMf0+Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQWU9/rr0MjSiPsHXGsnUSkxbAP74iq9lvKqI33+fNIYDyq9H
	bI0mpmsjf7vwqm82er6v+kW2UmE/mMUvAQCUA4t013FBrsyFFijxHPmxTIr/flJl8iB7ecSZr1W
	EvQPCap9R/cBv7g1LxKlUAk8y1n/z6Y9Mn7Y1eCUIp8QgNG7WimkzM8TWSw==
X-Gm-Gg: ASbGncuUkpaGAZ3WcHkDevDxxgM/Q7b8a6Tzzu24CFqfXFScjRz7TYtZbdhlMLHy13W
	9zGw4v3accMGnUhMsdEhZHtTyjyvoNxJXCqzddRFKqNaD4sT68Ri+EaHA2nHLqD1lSB+Pt4Xkkm
	MOXbYgUCSp3yv3hTa9lUjp1o2lCfb+8zJWlSmz2s8Obl8LlaFEjwFbPmXY5Mq9SY3nrcrTePpX9
	ynmJRMSfPullqSjOGUYbtAJzBW1EVHJKnmovXrtf0m8112TZT2rJaAzMNKuxHwE4pPdydil5TQ5
	CXp/4vjptHb/yaCUoOJwF0mWwQj7AIdPgVu02XbKYPEZQVc6udCheoTFYq9vtz9l2Ldt0i/pOju
	qCBH9aMG9tH3769XHnfGSFhwfElMJ7lgv0d4Wai+/cF3Cly3qJCci2FiNqjLM3q040A==
X-Received: by 2002:a05:600c:3145:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-46e1dabacbcmr32403395e9.23.1758636552693;
        Tue, 23 Sep 2025 07:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1zjPRIiQxlgM2iBL3rrO4un1h7Jg85y2tIFmA5e46tCx8kH1YetoLKfOErBY9uGt01qh48g==
X-Received: by 2002:a05:600c:3145:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-46e1dabacbcmr32402755e9.23.1758636552006;
        Tue, 23 Sep 2025 07:09:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e0d08996csm62883165e9.11.2025.09.23.07.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 07:09:10 -0700 (PDT)
Message-ID: <6e4f6a37-2449-4089-8b3d-234ba86878e2@redhat.com>
Date: Tue, 23 Sep 2025 16:09:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Fixing bad pmd due to a race condition between
 change_prot_numa() and THP migration in pre-6.5 kernels.
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, stable@vger.kernel.org
References: <20250921232709.1608699-1-harry.yoo@oracle.com>
 <b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com> <aNKIVVPLlxdX2Slj@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNKIVVPLlxdX2Slj@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 13:46, Harry Yoo wrote:
> On Tue, Sep 23, 2025 at 11:00:57AM +0200, David Hildenbrand wrote:
>> On 22.09.25 01:27, Harry Yoo wrote:
>>> Hi. This is supposed to be a patch, but I think it's worth discussing
>>> how it should be backported to -stable, so I've labeled it as [DISCUSSION].
>>>
>>> The bug described below was unintentionally fixed in v6.5 and not
>>> backported to -stable. So technically I would need to use "Option 3" [A],
>>
>> What is option 3?
> 
> Citing Option 3 from [A]:

Ah, I see.

>> Send the patch, after verifying that it follows the above rules, to
>> stable@vger.kernel.org and mention the kernel versions you wish it to be
>> applied to. When doing so, you must note the upstream commit ID in the
>> changelog of your submission with a separate line above the commit text,
>>
>> like this:
>> commit <sha1> upstream.
>>
>> Or alternatively:
>> [ Upstream commit <sha1> ]
>>
>> If the submitted patch deviates from the original upstream patch
>> (for example because it had to be adjusted for the older API),
>> this must be very clearly documented and justified in the patch description.
> 
>> Just to clarify: it's fine to do a backport of a commit
>> even though it was not tagged as a fix.
> 
> Thanks for looking into it, David!
> 
> Ok, I was worried that the original patch's description will confuse
> people because 1) we don't allow pte_map_offset_lock() to fail in older
> kernels, which the original patch relies on, and 2) the patch does not
> mention the race condition (because it fixed the race 'accidentaly' :D).
> 
> I'll backport the original patch but make it clear that:
> 
> 1. while the original patch did not mention the race condition,
>     the patch fixes a it, and add link to this discussion.
> 
> 2. we can't remove 1) pmd_trans_unstable() check in change_pte_range(),
>     and 2) "bad" pmd check in change_pmd_range() because we don't allow
>     pte_offset_map_lock() to fail().
> 
> 3. pmd_read_atomic() is used instead of pmdp_get_lockless() beucase it
>     does not exist in older kernels.

Right, and backporting all the prerequisites might not be 
feasible/desirable.

[...]

>>>    			goto next;
>>
>> This is all because we are trying to be smart and walking page tables
>> without the page table lock held. This is just absolutely nasty.
> 
> commit 175ad4f1e7a2 ("mm: mprotect: use pmd_trans_unstable instead of
> taking the pmd_lock") did this :(

Right. I can understand why we would not want to grab the lock when 
there is a leaf page table. But everything else is just asking for 
trouble (as we saw :) ).

> 
>> What about the following check:
>>
>> if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
>>
>> Couldn't we have a similar race there when we are concurrently migrating?
> 
> An excellent point! I agree that there could be a similar race,
> but with something other than "bad pmd" error.

Right, instead we'd go into change_pte_range() where we check 
pmd_trans_unstable().

After that, I'm not sure ... maybe we'll just retry or we'll 
accidentally try treating it as a PTE table.

Looks like 
pmd_trans_unstable()->pud_none_or_trans_huge_or_dev_or_clear_bad() would 
return "0"
in case we hit migration entry? :/

> 
> It'd be more robust to do something like:

That's also what I had in mind. But all this lockless stuff makes me a 
bit nervous :)

-- 
Cheers

David / dhildenb


