Return-Path: <stable+bounces-181616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98220B9AC4F
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911CB189621A
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA371E1C02;
	Wed, 24 Sep 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHcN/Pvt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90D64A8F
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729146; cv=none; b=lZAvZihp+XLBY9E8kBICJfZE837mlkW8Lbt9CvSVmQPBx7/fhXIa8oOIg36k7/MC0djwUJi10wIuPQuPiL3TtB+tiyjgMFKw53VzgeA5MoFkMm3pZOtIMZMx8+39+G0dnQbkaivecua4+11QP5WgqGnopoRI3csKrQtvyxxsOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729146; c=relaxed/simple;
	bh=+DEXZi3qzjU4aY3NE2OfKM6akp4TM+MaA1F2vtkAdpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPZwUnzCqRdJ0b2s0+7eKJ6qgEOlYb6tomI7McHXVKHw2h/7akM9ZmccojOUYbUJENVM3vYZ5lB1Janr8qPEHbKGr/tW1I1JDVnAAjDmjiRzXZ6p0Ye72VAcI1DIO2XhhhbjnUFW6/Q9VFewcNUBZRk33Oix/p5SP4sywKzJwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHcN/Pvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758729144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XzVixmsYq6hZpBtrPyWTw9f2SWf0I2tYU6xFVpkJp/M=;
	b=cHcN/PvtQqRGfbI/rcw4fiKWcDYmUWzB1YH0eu1wSawrIN1/U3Ak7LGTu+DUPVpDUQwtsc
	5HQ1g9YcIoJ4fPM7lYL6ib3GtXoFNcU7t+2cq26CAdeh8Xnw5m2PzSuBivAX1AaHguln0j
	3PEsAZVaf4t8XqFNOWE/4upDCZS9b7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-Zfzss-CcOFG_Or28C0YB2g-1; Wed, 24 Sep 2025 11:52:18 -0400
X-MC-Unique: Zfzss-CcOFG_Or28C0YB2g-1
X-Mimecast-MFC-AGG-ID: Zfzss-CcOFG_Or28C0YB2g_1758729137
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de27bf706so38792935e9.0
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 08:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729137; x=1759333937;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzVixmsYq6hZpBtrPyWTw9f2SWf0I2tYU6xFVpkJp/M=;
        b=ly+HbDEMwjQbnj0BC2GgQdV8/ml+q43dw9c9IGit0MsECsVgGeDgEbp5IGjanu7z6q
         iY8/d4VSfpcPgCjEF90ClUH+aCJX7wUdRTj4vZxabREBvOXzUwgkeWd4dpVwT4XKcZKu
         q4A6CUTNVrIa4cW6JWuWtYB2QeWnB+qCAm9vRuwM0pMde2POpxxUN8Cv3GUtKWnK6xGH
         HFjGRAK7e9CyKdj4+ljMkHz3FVz8bTsPbVaeswM1d4HYnkcYIWOAm+BMuEnsgWy70kkL
         0DNKHnyhf1e6gmCJwaa1T4mJ5BPa4Cph6/mFgLjFdhQI02XnWpof6+zkZ7EiRz8JyS+4
         p2RA==
X-Forwarded-Encrypted: i=1; AJvYcCXIj9gcxFWdTFVc1wBuiPfCl1IhwY7kjBnmyNnq/8FGXntMdvSSB2iEGl2/MSPX+H7K6IiXdCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tJO8wAtKx3i461H+9OHpR9kaZD7pqLsA/ojqTIIgWvmKRTgn
	yplubcG88C+LvqVPSSR/YxVPyyRnHDM9DQxln+pPedZjbnhJuXemnOH3PIFSbNHtn2FE1InIV4m
	SF4qbJ2pXI3nGQNagnwXIJ+k5I5PQW6mWyZxTKYdfNhvD5n8Fq+vNdWUvbA==
X-Gm-Gg: ASbGncuknAzOVGvjAH2lvUW8WdwrfvqT54sJOv3nDVYcthFtm4W7l/kcf/KalV1ksj1
	EkH1xFIs92omQJiUKaGefvmPVw5gx3QF5aUwN+gX4F2DfOS7SlM1oCa7Qts3SoR3YM4xWlYWCWA
	d4vpX916zE7WW5/cZv3RxJ8F9w46tY3mEQeXeqPD7U7vz4s0XhxbTvMnwZU7N5o8VNbmWGvvPx7
	LeLLIlecMybUaZg6rGEONPLnQQiakMbsMebMJouVED2vveLlDELo7aOIrS6H8jord2arfnNJs3a
	bdFSysmwUc25tqzMaHfglGLCWi+0eZFgqWvoiD4v475l9UktSVkwpWGbFXJDbhVjpM0u71E2Vi6
	IiiD276O2rBAiRN3pxlk2Fb5sw1NFzPjcSyf0vxngUTZunVedBaelx5EWHNLsMGdX+g==
X-Received: by 2002:a05:600c:c4ac:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-46e329f7c36mr3653565e9.17.1758729137105;
        Wed, 24 Sep 2025 08:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtIjjK5EmtNWj4tkdf++2VKpJZBRqmaieXYSJIlJmYT2U4IUZmCf1YtUJmt1dosqc2FgOgoA==
X-Received: by 2002:a05:600c:c4ac:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-46e329f7c36mr3653175e9.17.1758729136675;
        Wed, 24 Sep 2025 08:52:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996da2sm45549245e9.5.2025.09.24.08.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:52:16 -0700 (PDT)
Message-ID: <9b05b974-7478-4c99-9c4f-6593e0fd4f93@redhat.com>
Date: Wed, 24 Sep 2025 17:52:14 +0200
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
 <6e4f6a37-2449-4089-8b3d-234ba86878e2@redhat.com> <aNPb3qVCZTf2xMkN@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNPb3qVCZTf2xMkN@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 13:54, Harry Yoo wrote:
> On Tue, Sep 23, 2025 at 04:09:06PM +0200, David Hildenbrand wrote:
>> On 23.09.25 13:46, Harry Yoo wrote:
>>> On Tue, Sep 23, 2025 at 11:00:57AM +0200, David Hildenbrand wrote:
>>>> On 22.09.25 01:27, Harry Yoo wrote:
>>>> This is all because we are trying to be smart and walking page tables
>>>> without the page table lock held. This is just absolutely nasty.
>>>
>>> commit 175ad4f1e7a2 ("mm: mprotect: use pmd_trans_unstable instead of
>>> taking the pmd_lock") did this :(
>>
>> Right. I can understand why we would not want to grab the lock when there is
>> a leaf page table. But everything else is just asking for trouble (as we saw
>> :) ).
>>>> What about the following check:
>>>>
>>>> if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
>>>>
>>>> Couldn't we have a similar race there when we are concurrently migrating?
>>>
>>> An excellent point! I agree that there could be a similar race,
>>> but with something other than "bad pmd" error.
>>
>> Right, instead we'd go into change_pte_range() where we check
>> pmd_trans_unstable().
> 
> Uh, my brain hurts again... :)

Yeah, that's why I gave up faster than you trying to understand these 
horrible, horrible functions in the stable kernel :)

> 
> In case is_swap_pmd() or pmd_trans_huge() returned true, but another
> kernel thread splits THP after we checked it, __split_huge_pmd() or
> change_huge_pmd() will just return without actually splitting or changing
> pmd entry, if it turns out that evaluating
> (is_swap_pmd() || pmd_trans_huge() || pmd_devmap()) as true
> was false positive due to race condition, because they both double check
> after acquiring pmd lock:
> 
> 1) __split_huge_pmd() checks if it's either pmd_trans_huge(), pmd_devmap()
> or is_pmd_migration_entry() under pmd lock.
> 
> 2) change_huge_pmd() checks if it's either is_swap_pmd(),
> pmd_trans_huge(), or pmd_devmap() under pmd lock.
> 
> And if either function simply returns because it was not a THP,
> pmd migration entry, or pmd devmap, khugepaged cannot colleapse
> huge page because we're holding mmap_lock in read mode.
> 
> And then we call change_pte_range() and that's safe.
> 
>> After that, I'm not sure ... maybe we'll just retry
> 
> Or as you mentioned, if we are misled into thinking it is not a THP,
> PMD devmap, or swap PMD due to race condition, we'd end up going into
> change_pte_range().
> 
>> or we'll accidentally try treating it as a PTE table.
> 
> But then pmd_trans_unstable() check should prevent us from treating
> it as PTE table (and we're still holding mmap_lock here).
> In such case we don't retry but skip it instead.
> 
>> Looks like
>> pmd_trans_unstable()->pud_none_or_trans_huge_or_dev_or_clear_bad() would
> 
> I think you mean
> pmd_trans_unstable()->pmd_none_or_trans_huge_or_clear_bad()?

Yes!

> 
>> return "0"
>> in case we hit migration entry? :/
> 
> pmd_none_or_trans_huge_or_clear_bad() open-coded is_swap_pmd(), as it
> eventually checks !pmd_none() && !pmd_present() case.

Ah, right, I missed the pmd_present() while skimming over this extremely 
horrible function.

So pmd_trans_unstable()->pmd_none_or_trans_huge_or_clear_bad() would 
return "1" and make us retry.

> 
>>> It'd be more robust to do something like:
>>
>> That's also what I had in mind. But all this lockless stuff makes me a bit
>> nervous :)
> 
> Yeah the code is not very straightforward... :/
> 
> But technically the diff that I pasted here should be enough to fix
> this... or do you have any alternative approach in mind?

Hopefully, I'm not convinced this code is not buggy, but at least 
regarding concurrent migration it should be fine with that.

-- 
Cheers

David / dhildenb


