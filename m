Return-Path: <stable+bounces-183012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EDABB2AD1
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D109171BA1
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F66239E81;
	Thu,  2 Oct 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlspaazB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4446B5
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389394; cv=none; b=V2PVKikYX2uqKnnieqPkDlPyW2SQ2RTHSUHlRE7ajUXMHtf9gOKfgaDQ0/qsEfvJl/ws4ngoeQfsx5VUcwh+FLah82yuUwJdz78ZDINo5OwMkhU8JOOZMdnehLR9opZKRn4XRd9Qjp4gkkVXW7Iv+JRr4gCktMaSef3p+dD7UHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389394; c=relaxed/simple;
	bh=n5ZSxNO4t/TOFZGhLcIxdeG09rvBoDF61zs2BKIZhxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsaCO84uRT8BscJo2c6lns/pznGSArTBpkIT5YRcUdBFlgdzciI+nmHINm696peVcFhIh7qiFGqDCvv3gxQkt7uvd9PJwBFmrEWlW93xzrd9I3CrchnypoWQHH00NLa2Pk3S3Rae6kAESgYAtreNrn5T4GmlTASZAjb8JX6/+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlspaazB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759389390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1GSMR27hsPUoie6UnsgaJIavv0xUMmpLJvLfbvZzpyw=;
	b=YlspaazBlQh1BarHTPBqv9I27CMw6aOSV08y4uAxh7fVgcxMVuItiBdtL0JZ9pqlPNE2JS
	/FC02PMgw4kZ0nubHKDu1w0FeH1masPdTs1Uvaqm4asqntGhmZYdex8TZuJNFCFLWO6d57
	OaHg9GwlQVODzSukM+94BLGfL+q4Acw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-ehXmJ4B_NzuvAQHGcoh5Qw-1; Thu, 02 Oct 2025 03:16:27 -0400
X-MC-Unique: ehXmJ4B_NzuvAQHGcoh5Qw-1
X-Mimecast-MFC-AGG-ID: ehXmJ4B_NzuvAQHGcoh5Qw_1759389386
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so737843f8f.1
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 00:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389386; x=1759994186;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GSMR27hsPUoie6UnsgaJIavv0xUMmpLJvLfbvZzpyw=;
        b=pt8Rvkpkn45IYLOka9hmrw4uGAFK4GKcAI0zTaXHda2wLzhZBAz/8GWU7xv5HKJcAd
         m4Sb+EhJj59IB5Zx/+Dz8cHAkSrgU4Jvs5dRnJ6btSXhT6wUkOIJwAwMEuTCMLBRPzc5
         QaGbAuXoJR4PQIC7PuQcEPabwAUNZWfYVkz7jTSDgCYtwDDO//OJ7KyJ7ARGr4Oq66n1
         KkhLMJdj5l/jutiWqavShoJ2+D3o9Q7SNWlv0J++rBrXiuJcgh6Uth6LZMIW2lzGkGMf
         w986r/06TpLOj5i8SY/GEXhcx7H/A/ywzQok7awGbJM47I8nShhJw1IapJPTRWQ1Egkq
         F1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzC+UKpGobBrV87CQ6Tj83hVqKUNJ2s/TZMYcrsEWjqJlCuMMBuTsWyC680rIQHQO/OYXmy7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqoi3owGCd2xttS0Awl2YxSTZ9uMx/olAZ8BTuT8VryT+euNb
	WtbN1Q4rZi479e68uqyjUO395XAdxNf0abuq8RJGFtowoZmwgsPT88fSZzhw9IxtZwJUXOEPm/e
	oVT2K+q35I3mYjXbgSl/z3GvzK58m7p+6EfaojF4V43muDGUTpJTrVNfJkg==
X-Gm-Gg: ASbGncsqgRPdSoQUkxUvWIgR5YeQG6YhTSq7LMi5cQmkFcYQUNIy4Tka6i0wP0bog1H
	TzovGbz2mfQXjNXTTU2PY/e6kvo7xNVNTLVTTIV8okftR04Cg2kaJ4NOEGZ/7GEuvTkdUfnDkSj
	4AHwZx+haFo9qPmQL+hxzsorgpMf/RQLsioRcTz3pg6k9GiT2exxZt2Pt63v7rCHR4azGKmeeKm
	fDU2LQDMpGqbAuOIBvwvXLGwrWBxlHP3ROZBmxyfwfqdZA3dyFSs6mC0MLtBZdEd3QZ0oeLIa7B
	Xxx76nPw0fFwOppzti+WmUOGGiVvlG8qk9gh74Srzc5aQSYwkbE1XR4T/Q/HvJIDgTF5BQya1ZC
	9sNjUgcrj
X-Received: by 2002:a05:6000:1a86:b0:3ec:dfe5:17e8 with SMTP id ffacd0b85a97d-4255d294d2emr1524309f8f.6.1759389386164;
        Thu, 02 Oct 2025 00:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Q/M2OlgijeOAdFrqP6QBlh2tyKnC3lcVltauGf5917JFuF4BsL0kpGZDKPSm1P3cI2xQpQ==
X-Received: by 2002:a05:6000:1a86:b0:3ec:dfe5:17e8 with SMTP id ffacd0b85a97d-4255d294d2emr1524284f8f.6.1759389385675;
        Thu, 02 Oct 2025 00:16:25 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm2378053f8f.8.2025.10.02.00.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:16:25 -0700 (PDT)
Message-ID: <a4b5589a-1607-4e67-939d-f86f98a395a6@redhat.com>
Date: Thu, 2 Oct 2025 09:16:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
To: Wei Yang <richard.weiyang@gmail.com>, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 wangkefeng.wang@huawei.com, linux-mm@kvack.org, stable@vger.kernel.org
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <20251002014604.d2ryohvtrdfn7mvf@master>
 <fa3f9e82-c6c8-43f2-803f-b8bb0fe56f37@linux.dev>
 <20251002031743.4anbofbyym5tlwrt@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251002031743.4anbofbyym5tlwrt@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.25 05:17, Wei Yang wrote:
> On Thu, Oct 02, 2025 at 10:31:53AM +0800, Lance Yang wrote:
>>
>>
>> On 2025/10/2 09:46, Wei Yang wrote:
>>> On Thu, Oct 02, 2025 at 01:38:25AM +0000, Wei Yang wrote:
>>>> We add pmd folio into ds_queue on the first page fault in
>>>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>>>> memory pressure. This should be the same for a pmd folio during wp
>>>> page fault.
>>>>
>>>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>>>> to add it to ds_queue, which means system may not reclaim enough memory
>>>> in case of memory pressure even the pmd folio is under used.
>>>>
>>>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>>>> folio installation consistent.
>>>>
>>>
>>> Since we move deferred_split_folio() into map_anon_folio_pmd(), I am thinking
>>> about whether we can consolidate the process in collapse_huge_page().
>>>
>>> Use map_anon_folio_pmd() in collapse_huge_page(), but skip those statistic
>>> adjustment.
>>
>> Yeah, that's a good idea :)
>>
>> We could add a simple bool is_fault parameter to map_anon_folio_pmd()
>> to control the statistics.
>>
>> The fault paths would call it with true, and the collapse paths could
>> then call it with false.
>>
>> Something like this:
>>
>> ```
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1b81680b4225..9924180a4a56 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1218,7 +1218,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct
>> vm_area_struct *vma,
>> }
>>
>> static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
>> -		struct vm_area_struct *vma, unsigned long haddr)
>> +		struct vm_area_struct *vma, unsigned long haddr, bool is_fault)
>> {
>> 	pmd_t entry;
>>
>> @@ -1228,10 +1228,15 @@ static void map_anon_folio_pmd(struct folio *folio,
>> pmd_t *pmd,
>> 	folio_add_lru_vma(folio, vma);
>> 	set_pmd_at(vma->vm_mm, haddr, pmd, entry);
>> 	update_mmu_cache_pmd(vma, haddr, pmd);
>> -	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>> -	count_vm_event(THP_FAULT_ALLOC);
>> -	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>> -	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>> +
>> +	if (is_fault) {
>> +		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>> +		count_vm_event(THP_FAULT_ALLOC);
>> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>> +		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>> +	}
>> +
>> +	deferred_split_folio(folio, false);
>> }
>>
>> static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d0957648db19..2eddd5a60e48 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1227,17 +1227,10 @@ static int collapse_huge_page(struct mm_struct *mm,
>> unsigned long address,
>> 	__folio_mark_uptodate(folio);
>> 	pgtable = pmd_pgtable(_pmd);
>>
>> -	_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
>> -	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>> -
>> 	spin_lock(pmd_ptl);
>> 	BUG_ON(!pmd_none(*pmd));
>> -	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>> -	folio_add_lru_vma(folio, vma);
>> 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
>> -	set_pmd_at(mm, address, pmd, _pmd);
>> -	update_mmu_cache_pmd(vma, address, pmd);
>> -	deferred_split_folio(folio, false);
>> +	map_anon_folio_pmd(folio, pmd, vma, address, false);
>> 	spin_unlock(pmd_ptl);
>>
>> 	folio = NULL;
>> ```
>>
>> Untested, though.
>>
> 
> This is the same as I thought.
> 
> Will prepare a patch for it.

Let's do that as an add-on patch, though.

-- 
Cheers

David / dhildenb


