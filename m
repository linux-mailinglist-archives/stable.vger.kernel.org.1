Return-Path: <stable+bounces-195279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6FC75345
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5B24F8B36
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934C376BDD;
	Thu, 20 Nov 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6IinNc8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D1376BCD
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653631; cv=none; b=Gr9ov6YgjXvv9jVmGIobIm8O9hUFmmOsrQqloJLkLcb4VaY6cb8UNDXvQz0X41VTtfF5f+AWC7cLxQxJ7RUzn252I8voLw06f+795E9whjNCzNA/KBS+VMGlFbwdm3n+ValG5EDIvgJUfeB2Q5/DrZIypRb7/ppZqNvRkfZljfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653631; c=relaxed/simple;
	bh=GyakaMWsNirCElnFGlF0PhH2jsCrYzoEa8R31fAqmT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E24ETwzg4V5Sc7YDl5XCwwGKELCEdJG3pSvfGjIRitWS6K7IgiPJmoez6cX97WgL7Y/KMX2QkHbQQ1Fwmwr4ua4cq9CAvmADQZ7J8P/EeJd5kJ/p3ag4dhx8JheE8nI9gP1mrwLCyXEQbg5VKjKdZKlsq6kMWB5aB4RmOtfENdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6IinNc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DD4C4CEF1;
	Thu, 20 Nov 2025 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653631;
	bh=GyakaMWsNirCElnFGlF0PhH2jsCrYzoEa8R31fAqmT8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=E6IinNc89Ul4bxxUG3YY2rPJ47AElRdBBS9kRLJr8Qxi53o6ng3WYveLEIKspbJnC
	 DxqPiKYqeXae/hu+CbRvbCYZJX8LM3CYD9XIYch3a71HwpDznhzg7YgGtnE+3nZw+j
	 DQBPJngJohjPfyhfxXFiHIgU5YjM6gmOWwLXx+/mc9sVYoIhmQsC+yS3TISwzxJDIa
	 jiWvpL8StdmGQz/KyE/7IlOPWgBv+bPLrrU9+sgVidOweLEvLB/IH7aTOlGyOnlDYm
	 FladlDL1C+y6Mf/OiM5xCshvjNGXCqwQdUXrIoVAh77raTMjuRBFh8vrk8gop5353F
	 ESwg5Tt5E1j5Q==
Message-ID: <8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org>
Date: Thu, 20 Nov 2025 16:47:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Uschakow, Stanislav" <suschako@amazon.de>,
 Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Jann Horn <jannh@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "trix@redhat.com" <trix@redhat.com>, "nathan@kernel.org"
 <nathan@kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "muchun.song@linux.dev"
 <muchun.song@linux.dev>, "mike.kravetz@oracle.com"
 <mike.kravetz@oracle.com>, "liam.howlett@oracle.com"
 <liam.howlett@oracle.com>, "osalvador@suse.de" <osalvador@suse.de>,
 "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
 <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
 <944a09b0-77a6-40c9-8bea-d6b86a438d8a@kernel.org>
 <1d53ef79-c88c-4c5b-af82-1eb22306993b@lucifer.local>
 <968d5458-7d2b-4a8d-a2a6-0931cd87898f@kernel.org>
 <c798628d-9bce-4057-a515-8bc02457f370@kernel.org>
Content-Language: en-US
In-Reply-To: <c798628d-9bce-4057-a515-8bc02457f370@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 17:31, David Hildenbrand (Red Hat) wrote:
> On 19.11.25 17:29, David Hildenbrand (Red Hat) wrote:
>>>>
>>>> So what I am currently looking into is simply reducing (batching) the number
>>>> of IPIs.
>>>
>>> As in the IPIs we are now generating in tlb_remove_table_sync_one()?
>>>
>>> Or something else?
>>
>> Yes, for now. I'm essentially reducing the number of
>> tlb_remove_table_sync_one() calls.
>>
>>>
>>> As this bug is only an issue when we don't use IPIs for pgtable freeing right
>>> (e.g. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set), as otherwise
>>> tlb_remove_table_sync_one() is a no-op?
>>
>> Right. But it's still confusing: I think for page table unsharing we
>> always need an IPI one way or the other to make sure GUP-fast was called.
>>
>> At least for preventing that anybody would be able to reuse the page
>> table in the meantime.
>>
>> That is either:
>>
>> (a) The TLB shootdown implied an IPI
>>
>> (b) We manually send one
>>
>> But that's where it gets confusing: nowadays x86 also selects
>> MMU_GATHER_RCU_TABLE_FREE, meaning we would get a double IPI?
>>
>> This is so complicated, so I might be missing something.
>>
>> But it's the same behavior we have in collapse_huge_page() where we first
> 
> ... flush and then call tlb_remove_table_sync_one().
> 

Okay, I pushed something to

https://github.com/davidhildenbrand/linux.git hugetlb_unshare

I did a quick test and my house did not burn down. But I don't have a 
beefy machine to really stress+benchmark PMD table unsharing.

Could one of the original reporters (Stanislav? Prakash?) try it out to 
see if that would help fix the regression or if it would be a dead end?

-- 
Cheers

David

