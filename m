Return-Path: <stable+bounces-195195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D0C70376
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7DC13C58A3
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2435A95B;
	Wed, 19 Nov 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmaDy11S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA4346780
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569900; cv=none; b=Fd5ZTtrqpBYUAIaoodaGLPW/pntuonZhZxbzdSgYoqb9KmrFvr6oAcDk+0CnPoMhaqOhWwIkgcMB3DqHfWNIge/alC8TQAX4aEw07G3fOHR5p5v46HhwHp9kncP/5Wk0b18cKXxg4FW2QrtyGYJPjj7gQnC6ncRwUQsDiRUf5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569900; c=relaxed/simple;
	bh=1l5JKzzB/X/aOY4SRfPTDUqyy1NGJefVlVFQlGnGZ6Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKi0oum0BnF3/mymbYSmViV8xesaultyGaD7AlXcAW6g86fqLhzaZaTCpyR2E7ePpy+9ytUcQ62eYULbBtCHd8jwKqZU3lbzUWSoqLeeBQjjPYj43ddMS4qG+tSmdQ1IZwP6yu/o6KteyvJ1xTdxo22+xNPvp5GoUOWMmvQrkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmaDy11S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3EEC4CEF5;
	Wed, 19 Nov 2025 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763569900;
	bh=1l5JKzzB/X/aOY4SRfPTDUqyy1NGJefVlVFQlGnGZ6Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TmaDy11SGNssyolc2WtbIKKTe8xhNDd843YXydYaEuj9vMLmiZt6HRZ6k7ozQkAN0
	 THsHhXPKb8i7tuV7KStL6maJD0F78ec3xLR/MjRdHCDmerCpvjmmNdLXnB26znxqKT
	 i/419SDSuqqkWRlZjx4MgJNqBG74vpICCIecuAOZ+x9eZ+fCccmbf4Mvj4Qyt7cmiM
	 si/X0tYEDwx7i4ZbCJqbkledCQlFl1yJ/aWhTOEANUKnJzei581xkiWCYKLagHsJAD
	 p5B1s7Dnda+d57w57xauHyHAoJHyNGI4RlyAyr0kC9frMbAIo1MxGh2SvSj3a9azcG
	 Wc9Pa1Tg8spUg==
Message-ID: <c798628d-9bce-4057-a515-8bc02457f370@kernel.org>
Date: Wed, 19 Nov 2025 17:31:35 +0100
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
Content-Language: en-US
In-Reply-To: <968d5458-7d2b-4a8d-a2a6-0931cd87898f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 17:29, David Hildenbrand (Red Hat) wrote:
>>>
>>> So what I am currently looking into is simply reducing (batching) the number
>>> of IPIs.
>>
>> As in the IPIs we are now generating in tlb_remove_table_sync_one()?
>>
>> Or something else?
> 
> Yes, for now. I'm essentially reducing the number of
> tlb_remove_table_sync_one() calls.
> 
>>
>> As this bug is only an issue when we don't use IPIs for pgtable freeing right
>> (e.g. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set), as otherwise
>> tlb_remove_table_sync_one() is a no-op?
> 
> Right. But it's still confusing: I think for page table unsharing we
> always need an IPI one way or the other to make sure GUP-fast was called.
> 
> At least for preventing that anybody would be able to reuse the page
> table in the meantime.
> 
> That is either:
> 
> (a) The TLB shootdown implied an IPI
> 
> (b) We manually send one
> 
> But that's where it gets confusing: nowadays x86 also selects
> MMU_GATHER_RCU_TABLE_FREE, meaning we would get a double IPI?
> 
> This is so complicated, so I might be missing something.
> 
> But it's the same behavior we have in collapse_huge_page() where we first

... flush and then call tlb_remove_table_sync_one().

-- 
Cheers

David

