Return-Path: <stable+bounces-181471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478EB95C25
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364B819C0711
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B70322DAC;
	Tue, 23 Sep 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIVlhxbU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25C321F33
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628812; cv=none; b=Ug1HY3Mgy8s+Mc5HWGgeYX93EFAprJCVId9MREKZgr5st+eKLl+4wFmOgNZDvnYM2zG/X9RS2BWtfpG99pSZ4Dz0MLZVQ75bEnZTCutxq6u34sgo/9vCP/cM2btUfkz+XTO7Eqm1wQs3z6tcvevJdpVlJIrApDGkrA9Uf+0R5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628812; c=relaxed/simple;
	bh=hcFGGSPQNGGJvK87LdPSGThfUr2y2MorbRJanIG4HEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9FsDR64suB7GTVXoLjshvHtaADZbgLQ8bzorY+jeuyH5pj+zrJlDm4h2GlHhV5CfjD0wQWwV8aXVm572MNEG2Fg/2i0TwIzsPCUAePSkwW/TTwDsQKxEyiisr2bV9R5S4IZ4Dcfsm38MLr3kvmn3Y0RNoi/jmj3VTAwNdc8los=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIVlhxbU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758628809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7mrXBzKlE98K4LjZsBmWzxI5rao/AqbDX4qmTQolpII=;
	b=eIVlhxbUjhJQyvWX7d1U6YbQx8d+VvLWzcsQegn0cAIEM9XFOjOmoKWmmwhJUmvzvuIkXW
	nyPg5l8+B/CGaZRcsQzhflVsv9JxhZKfmu+USmf1vTiJRHK+w72HGAtq0WK9hvl+k/u10N
	PcU77NZ+HGrYDOJ/lRZRZ8E7jBuV6C8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-MjJfwGX1OnuaKBizVeb0Tw-1; Tue, 23 Sep 2025 08:00:08 -0400
X-MC-Unique: MjJfwGX1OnuaKBizVeb0Tw-1
X-Mimecast-MFC-AGG-ID: MjJfwGX1OnuaKBizVeb0Tw_1758628807
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee888281c3so1938987f8f.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 05:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758628807; x=1759233607;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mrXBzKlE98K4LjZsBmWzxI5rao/AqbDX4qmTQolpII=;
        b=Ju4QKon19hpAEHW9YIAbrIj5+tJpLZTvFqAC/B6KfX3AhKKNgJLcM/05h2v9u6WU2I
         l/aaixaslIhiTFgA4lF7DxCH4R6Vckh/V4LAbh+sSRvQI/hnxGb8nLC+ewjx0CmDTwF9
         /l8kGWKrQGbLlM0rHAIwvY1HvCDW4S/wfJR4bBxSYhmYiIzVx07XODSJVnJ5Z+2o2LFI
         p7ViAvPONChhf3nE96hfV6bIywi7tgjwtI5WfuvVa10uiWESUw5oLWEtucJ1pnCx8Mow
         Kr44ZbPrzdyG0Dj6XftdEkMHn3T+0vfRIfJ/ehgp+GD1MQuGQrNe3CogBbeyLXul+dVn
         zBUw==
X-Forwarded-Encrypted: i=1; AJvYcCXrr/xld2HUGPoCbfFIMPaebtXfpwKEP3RsSztUqLsv1GkJFWti5QKgqonbSEV7z+HnFp4GeyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5xfBE6NNx1L8A5UYvjcWpa3Asa7hGZ5p9D+RMFT5xDUBVMav
	Fc8jDvXJlSP3GmIDWE5gM+RPOcH0AEqjHbrpGnsDCrUQbf3wu6rKuAQhO1UxVSewKPd/42WPJlv
	cjESaXirbDX7XGas5PfIGaQLS9tOa0MvNzFlwpF4NPUf5T+X+UZy0l/dbEA==
X-Gm-Gg: ASbGncvetTzs9njdQqToHS69/1M+5jjZ6WY2a9D5d+Qt/tUOQ6O+0k7/tLcBF0asNp9
	5vLIK5wXSvtseYW9i1uoX+bfb4PiwUHl/qVR3ViiGsgKWCGGlKf6FoVYRENYALdbMe/yt4PgQ8H
	MjjQiaUf8m/s8vv1bDeiTebzNTSJLeysKm03nOGfF+Le3lcZFnAhwLqv3F0uMV/mkh5cC1yueRr
	3HX40MUvC3+u5hgAI+YgoQddqwt+xVPQTJCJH20JQ6JlX0YHNQyMOZJXYJjqvydNiUDNRJK4Eus
	tuKw2EpT28VCZXaWBNJ6f0PxJ1yWO/dBvdExSKLlXSnxWUlA+5qTGJvVU5hhS/yt8/V3S2GXH2O
	CZPH4rpdQ1Gpic8au0rIjsgPKEIh7fjiSMFLkuB7VtVeSll8jQUDmXdXtsl5nSSeHpQ==
X-Received: by 2002:a05:6000:1816:b0:407:77f9:949e with SMTP id ffacd0b85a97d-40777f997b1mr755889f8f.21.1758628806761;
        Tue, 23 Sep 2025 05:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc0tnWNhOKVxns9wRVC1qKaXSvIIx3ibWsy3DFh5QbP9+zrm0E/5T5FrXDNhPOpzrAGAyoZg==
X-Received: by 2002:a05:6000:1816:b0:407:77f9:949e with SMTP id ffacd0b85a97d-40777f997b1mr755855f8f.21.1758628806098;
        Tue, 23 Sep 2025 05:00:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f9c62d083esm11713443f8f.32.2025.09.23.05.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:00:04 -0700 (PDT)
Message-ID: <8bf8302a-6aba-4f7e-8356-a933bcf9e4a1@redhat.com>
Date: Tue, 23 Sep 2025 14:00:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, usamaarif642@gmail.com, yuzhao@google.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 voidice@gmail.com, Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com,
 hannes@cmpxchg.org, kaleshsingh@google.com, npache@redhat.com,
 riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, ryncsn@gmail.com,
 shakeel.butt@linux.dev, surenb@google.com, hughd@google.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, qun-wei.lin@mediatek.com,
 Andrew.Yang@mediatek.com, casper.li@mediatek.com,
 chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com> <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNKJ5glToE4hMhWA@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 13:52, Catalin Marinas wrote:
> On Mon, Sep 22, 2025 at 07:59:00PM +0200, David Hildenbrand wrote:
>> On 22.09.25 19:24, Catalin Marinas wrote:
>>> On Mon, Sep 22, 2025 at 10:14:58AM +0800, Lance Yang wrote:
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 32e0ec2dde36..28d4b02a1aa5 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -4104,29 +4104,20 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>>>>    static bool thp_underused(struct folio *folio)
>>>>    {
>>>>    	int num_zero_pages = 0, num_filled_pages = 0;
>>>> -	void *kaddr;
>>>>    	int i;
>>>>    	for (i = 0; i < folio_nr_pages(folio); i++) {
>>>> -		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>>>> -		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
>>>> -			num_zero_pages++;
>>>> -			if (num_zero_pages > khugepaged_max_ptes_none) {
>>>> -				kunmap_local(kaddr);
>>>> +		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
>>>> +			if (++num_zero_pages > khugepaged_max_ptes_none)
>>>>    				return true;
>>>
>>> I wonder what the overhead of doing a memcmp() vs memchr_inv() is. The
>>> former will need to read from two places. If it's noticeable, it would
>>> affect architectures that don't have an MTE equivalent.
>>>
>>> Alternatively we could introduce something like folio_has_metadata()
>>> which on arm64 simply checks PG_mte_tagged.
>>
>> We discussed something similar in the other thread (I suggested
>> page_is_mergable()). I'd prefer to use pages_identical() for now, so we have
>> the same logic here and in ksm code.
>>
>> (this patch here almost looks like a cleanup :) )
>>
>> If this becomes a problem, what we could do is in pages_identical() would be
>> simply doing the memchr_inv() in case is_zero_pfn(). KSM might benefit from
>> that as well when merging with the shared zeropage through
>> try_to_merge_with_zero_page().
> 
> Yes, we can always optimise it later.
> 
> I just realised that on arm64 with MTE we won't get any merging with the
> zero page even if the user page isn't mapped with PROT_MTE. In
> cpu_enable_mte() we zero the tags in the zero page and set
> PG_mte_tagged. The reason is that we want to use the zero page with
> PROT_MTE mappings (until tag setting causes CoW). Hmm, the arm64
> memcmp_pages() messed up KSM merging with the zero page even before this
> patch.
> 
> The MTE tag setting evolved a bit over time with some locking using PG_*
> flags to avoid a set_pte_at() race trying to initialise the tags on the
> same page. We also moved the swap restoring to arch_swap_restore()
> rather than the set_pte_at() path. So it is safe now to merge with the
> zero page if the other page isn't tagged. A subsequent set_pte_at()
> attempting to clear the tags would notice that the zero page is already
> tagged.
> 
> We could go a step further and add tag comparison (I had some code
> around) but I think the quick fix is to just not treat the zero page as
> tagged.

I assume any tag changes would result in CoW.

It would be interesting to know if there are use cases with VMs or other 
workloads where that could be beneficial with KSM.

> Not fully tested yet:
> 
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e5e773844889..72a1dfc54659 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -73,6 +73,8 @@ int memcmp_pages(struct page *page1, struct page *page2)
>   {
>   	char *addr1, *addr2;
>   	int ret;
> +	bool page1_tagged = page_mte_tagged(page1) && !is_zero_page(page1);
> +	bool page2_tagged = page_mte_tagged(page2) && !is_zero_page(page2);
>   
>   	addr1 = page_address(page1);
>   	addr2 = page_address(page2);
> @@ -83,11 +85,10 @@ int memcmp_pages(struct page *page1, struct page *page2)
>   
>   	/*
>   	 * If the page content is identical but at least one of the pages is
> -	 * tagged, return non-zero to avoid KSM merging. If only one of the
> -	 * pages is tagged, __set_ptes() may zero or change the tags of the
> -	 * other page via mte_sync_tags().
> +	 * tagged, return non-zero to avoid KSM merging. Ignore the zero page
> +	 * since it is always tagged with the tags cleared.
>   	 */
> -	if (page_mte_tagged(page1) || page_mte_tagged(page2))
> +	if (page1_tagged || page2_tagged)
>   		return addr1 != addr2;

That looks reasonable to me.

@Lance as you had a test setup, could you give this a try as well with 
KSM shared zeropage deduplication enabled whether it now works as 
expected as well?

Then, this should likely be an independent fix.

For KSM you likely have to enable it first through 
/sys/kernel/mm/ksm/use_zero_pages.

-- 
Cheers

David / dhildenb


