Return-Path: <stable+bounces-61834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288893CF30
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8589B1C21AA5
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D81741FB;
	Fri, 26 Jul 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSdTNFDb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034317556C
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981066; cv=none; b=mTQjMGTFpSFgXLYOAgLRQZMcohw7YHIIDbsv25D+DUj3ZwOltq59sqiwzlspetxv9daxgznz2jZurnZmDqs08PV1hizJrHWFx/tzyQMjHtXqQjI8Lo+dUptHdbWz+0lhwqX/bJHlS2xo4I2AiPBhyi8SpHS+q5H+NQqO9GQgBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981066; c=relaxed/simple;
	bh=REJWuCBMl0Tw97R7jHNW9FHI5r1WqSr83sDttcXTEjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGHbErvl9Am8C4V0MjEohY6/2pCiQF6C0vKY/aRv2MiGT3vT7i789c7/xoBdU/4wDSSLHp/5ag+FddRxy5tyOuXguPJ8N2Lzb1j87D9A05lC00NAyxlEMQiNaC+zKqznq44YGAnbhvuN5rN2Tj5uOPeB64oPp3TqaqwZaaG9mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSdTNFDb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721981064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J1HYMRlnQn1MQefom9eD0BJRVC7D0U8jwjXWsjZgyqY=;
	b=SSdTNFDb0tDopZSuAGBPZYI21xreeuvXrNQQ41vYKhi7YHTImH32odG2AysO2PlIqXHgns
	xOyAk+ogdjYiU+OaajquTWigp9xigHFhLvsM5OTV1LFVAcejUrM4BgB3CjKH0HQESDYIjU
	YQJvy7ZJyDPMe5gqbHAZSOs+k12qMag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-0hd0JD3ZMayacTthJduDHQ-1; Fri, 26 Jul 2024 04:04:21 -0400
X-MC-Unique: 0hd0JD3ZMayacTthJduDHQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so3780785e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 01:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981060; x=1722585860;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1HYMRlnQn1MQefom9eD0BJRVC7D0U8jwjXWsjZgyqY=;
        b=OLPJ7XKVopO9ZPOxczlfIfzKtC71tsWfqj+LHKI7x7YZR6yfvFpcbMOIy8tDW0iwbB
         ufDkj0w05rD4VfvQr+GnahM5f4ZmejCQvBFc1i8QNs0CrWJZxG8WdFC1HN5ohlZCBs23
         Ko9yYdpiNFMmcoiKzvYmWANNz6p1RQpu8Drz/o1qW0psgJkG2vJfFQvLGd5vrayFGp55
         VT+yi7MPJG6febE8mg+T3xTZNLKV2PqPJqlvvr+87xkGf9qS77g77BqufC9czoUMfb4R
         VbUHS4gM0hEZGnHAmdVI8Zvwmli2S2PaFpeEcjatD12hSU5s85ptOOJRg+/BazW3hl3A
         bEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCrFXNRRFruo751AgE7+HRRuj4REQSofwkXB6JwrOYBjYpGNl/lcmr3jzK5e3kaiaX7GY4IvjieUptLTBenRRutSnVpEJL
X-Gm-Message-State: AOJu0YyogJuG6Rkol0ozFK/guJlHgzEisqY8sTM2L5WwuRPkU4TWIodi
	677XAL5Rdw3NzPa/FkHMfGiQn1tyu3GSa5mvZNenNvEQV8uacmN+xtyP6tI6FBk75XaSB/Xefz+
	xVXgRTqXYyj1WfkwUJf6lNwzYdfxqC0H+Z6JR48YAYV83szG+gMQazw==
X-Received: by 2002:a05:600c:a04:b0:426:6618:146a with SMTP id 5b1f17b1804b1-42806b6c56bmr31004885e9.2.1721981060410;
        Fri, 26 Jul 2024 01:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcKv3Ky9Q9GET2wHSB83UBYaKLubm2oVUYqx1thpMUZher6azQKx5bQEqdRk/KmVfqFLQyZw==
X-Received: by 2002:a05:600c:a04:b0:426:6618:146a with SMTP id 5b1f17b1804b1-42806b6c56bmr31004535e9.2.1721981059803;
        Fri, 26 Jul 2024 01:04:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280ca10aa6sm13416515e9.26.2024.07.26.01.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 01:04:19 -0700 (PDT)
Message-ID: <c16a731f-1029-4ede-bbea-af2218c566d1@redhat.com>
Date: Fri, 26 Jul 2024 10:04:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
 <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.07.24 04:33, Baolin Wang wrote:
> 
> 
> On 2024/7/26 02:39, David Hildenbrand wrote:
>> We recently made GUP's common page table walking code to also walk
>> hugetlb VMAs without most hugetlb special-casing, preparing for the
>> future of having less hugetlb-specific page table walking code in the
>> codebase. Turns out that we missed one page table locking detail: page
>> table locking for hugetlb folios that are not mapped using a single
>> PMD/PUD.
>>
>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>> lock.
>>
>> However, hugetlb that concurrently modifies these page tables would
>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>> locks would differ. Something similar can happen right now with hugetlb
>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>
>> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
>> core-mm page table walker would.
> 
> Thanks for raising the issue again. I remember fixing this issue 2 years
> ago in commit fac35ba763ed ("mm/hugetlb: fix races when looking up a
> CONT-PTE/PMD size hugetlb page"), but it seems to be broken again.
> 

Ah, right! We fixed it by rerouting to hugetlb code that we then removed :D

Did we have a reproducer back then that would make my live easier?

>> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
>> folio being mapped using two PTE page tables. While hugetlb wants to take
>> the PMD table lock, core-mm would grab the PTE table lock of one of both
>> PTE page tables. In such corner cases, we have to make sure that both
>> locks match, which is (fortunately!) currently guaranteed for 8xx as it
>> does not support SMP.
>>
>> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    include/linux/hugetlb.h | 25 ++++++++++++++++++++++---
>>    1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index c9bf68c239a01..da800e56fe590 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -944,10 +944,29 @@ static inline bool htlb_allow_alloc_fallback(int reason)
>>    static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>>    					   struct mm_struct *mm, pte_t *pte)
>>    {
>> -	if (huge_page_size(h) == PMD_SIZE)
>> +	VM_WARN_ON(huge_page_size(h) == PAGE_SIZE);
>> +	VM_WARN_ON(huge_page_size(h) >= P4D_SIZE);
>> +
>> +	/*
>> +	 * hugetlb must use the exact same PT locks as core-mm page table
>> +	 * walkers would. When modifying a PTE table, hugetlb must take the
>> +	 * PTE PT lock, when modifying a PMD table, hugetlb must take the PMD
>> +	 * PT lock etc.
>> +	 *
>> +	 * The expectation is that any hugetlb folio smaller than a PMD is
>> +	 * always mapped into a single PTE table and that any hugetlb folio
>> +	 * smaller than a PUD (but at least as big as a PMD) is always mapped
>> +	 * into a single PMD table.
> 
> ARM64 also supports cont-PMD size hugetlb, which is 32MiB size with a 4
> KiB base page size. This means the PT locks for 32MiB hugetlb may race
> again, as we currently only hold one PMD lock for several PMD entries of
> a cont-PMD size hugetlb.

Exactly, that's the case where all cont-PMD entries fall into the same 
page table.

That's also what I will try reproducing with (migration racing with 
GUP). But the race window is small and a lot of other stuff is protected 
by the VMA lock.

-- 
Cheers,

David / dhildenb


