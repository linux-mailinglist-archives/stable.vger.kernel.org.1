Return-Path: <stable+bounces-195093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9FC68BCD
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 707222D1D9
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929652DA758;
	Tue, 18 Nov 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4NITz2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA84330B3B
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460195; cv=none; b=hJvs4xYvxHVMxkEEUyqg/2IIXfk1f1USMhaKBU84bfOm+EdJBHNyxmRlySkbQa6dcmIazl1DFWrxZdTAm1lhgdYxVjxj4faeJpnfR+1lEhHCHefNVTnFJQaqjje+1MYlVYARETKdXqOP+2nrxu29Qxv+4eo4xPbbLb8lAMFH0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460195; c=relaxed/simple;
	bh=yN17U6/arJFZbWy7v+5E/AzgDQnFBqjDoOQeqwGAn4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jciKPheRj9TiutfLAAm/m/Vl8iUSsYx29BOXIx5xHKC21Tsozw0PgxhAAuAFRQzz2jqmO3Z+TqPIOW32EgiEowWV/pxbM2f1CXhG7d0EaG+QQdjU1T7WscEp4U6a18M4+QszAIujEFw3RCqaNMMUCi9ea6dc8KrpO60NnO2uThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4NITz2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAE7C2BCAF;
	Tue, 18 Nov 2025 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763460194;
	bh=yN17U6/arJFZbWy7v+5E/AzgDQnFBqjDoOQeqwGAn4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4NITz2L4WhpFnnyGQGlVfOhx1ER8y3eEy0+tVBmYypjVn7vXOyhNliG5FvDbCyR5
	 lxTp0Q1jxhouDc2CwUFz62DVqghmgE2RSmgJITSckOFak9Pf9Ytrqxb3e/YWu9WpPt
	 ajH4UG6vqcsidnfSaKEoknhVBb+pCYkVdU5YxQIvcIilJzfD3fesuYgRmz2d5VZdcC
	 bdvcNL6UhkLQKc5LOGCt/xaqTBl/aUsOzvhG8yV0vTNXyXqquSIxe6KW8HyjzhrUpC
	 NTZi5t3UFIf6emePcwMuRm0xMgv+S+vdfPYFJDY3Bs3fvvTvA3JG4bnSMHYxohnyWW
	 Ku2CTQFctpeVg==
Message-ID: <944a09b0-77a6-40c9-8bea-d6b86a438d8a@kernel.org>
Date: Tue, 18 Nov 2025 11:03:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
 "osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
 <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 19:02, Lorenzo Stoakes wrote:
> On Wed, Oct 29, 2025 at 05:19:54PM +0100, David Hildenbrand wrote:
>>>>>> Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?
>>>>>
>>>>> Because nothing else on that path is guaranteed to send any IPIs
>>>>> before the page table becomes reusable in another process.
>>>>
>>>> I feel that David's suggestion of just disallowing the use of shared page
>>>> tables like this (I mean really does it actually come up that much?) is the
>>>> right one then.
>>>
>>> Yeah, I also like that suggestion.
>>
>> I started hacking on this (only found a bit of time this week), and in
>> essence, we'll be using the mmu_gather when unsharing to collect the pages
>> and handle the TLB flushing etc.
>>
>> (TLB flushing in that hugetlb area is a mess)
>>
>> It almost looks like a cleanup.
>>
>> Having that said, it will take a bit longer to finish it and, of course, I
>> first have to test it then to see if it even works.
>>
>> But it looks doable. :)
> 
> Ohhhh nice :)
> 
> I look forward to it!

As shared offline already, it looked simple, but there is one nasty 
corner case: if we never reuse a shared page table, who will take care 
of unmapping all pages?

I played with various ideas, but it just ended up looking more 
complicated and possibly even slower.

So what I am currently looking into is simply reducing (batching) the 
number of IPIs.

In essence, we only have to send one IPI when unsharing multiple page 
tables, and we only have to send one when we are the last one sharing 
the page table (before it can get reused).

While at it, I'm looking into making also the TLB flushing easier to 
understand here.

I'm hacking on a prototype and should likely have something to test this 
week.

[I guess what I am doing now is aligned with Jann's initial ideas to 
optimize this ]

-- 
Cheers

David

