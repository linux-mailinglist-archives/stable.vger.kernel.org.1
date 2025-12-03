Return-Path: <stable+bounces-199912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC0CA1783
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC763010281
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2D33509B;
	Wed,  3 Dec 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJbzG9Kz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AC33508F
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791151; cv=none; b=FI1cZmkmfaAUIyP9XtdLNxwbXLVZlusDRVbWw9uMtxllkq+1n/ImpqB8AXRjwqo64j0OEAO8get88p5QRom3Jr6conAekmOqBB4CFITnWye04DcMWBZpXy20BHeYWB5B42tkw2i4cnInS7/W4uIAbRgf8nyIO13WcPCHvcq6/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791151; c=relaxed/simple;
	bh=vkxqp0flOaunzJWApUWlsmuTw4iqR9L5WSt8ObioPfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnoKj1CSyUp14HbXlaYVizAO+sdZM4aUUugZLNas9YTQtEFsIh9jMBVyYyLCzGTOCtOHnePlxYeAmJqrAaHf7KN9G7ZW3UrRBi3uWw9UVh51LcQx4GcxGYLwoPUMPVSHO7XQkXrJfn2zwSgYVgRCsWzSDGF8pdPzkZ9sgTvv/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJbzG9Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF83CC4CEF5;
	Wed,  3 Dec 2025 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764791150;
	bh=vkxqp0flOaunzJWApUWlsmuTw4iqR9L5WSt8ObioPfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RJbzG9Kz8dgE0fDAOb6IxvZaIdwzFenvo9aaJTpV3loVoSdQTXr/Q/gv1KFtiUsBQ
	 m6wC2+vz2Bqr7+/xwKOyCcopT1SwxFgj+YG3zuGvEOIp3HzspB45TLfPAlBaMp56p2
	 BgGZlbgQY5isxP0V1K2/3VxF23rW9j50QhwkpR/rMU++RMCVekXE0f6bzVhp7yOA4V
	 SXVGqhM1g/OU1fVbFZhYvArR097WG4xiIeTa7oT5cUMdmfQ21S85DTp3ZG880bIasO
	 OTZX/xQKy60ADE7ZiEMuZt2Z49+KztJ5L4nDWZQ4IMWB6xP+vSMPuWD0dzmEUc3wuS
	 MZhEDc2E85GIQ==
Message-ID: <2b9272ab-8757-48ee-ad18-d0e38b3223d2@kernel.org>
Date: Wed, 3 Dec 2025 20:45:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Uschakow, Stanislav" <suschako@amazon.de>, Jann Horn <jannh@google.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 Liam Howlett <liam.howlett@oracle.com>, "osalvador@suse.de"
 <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
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
 <8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org>
 <A8EA24F8-7A13-472A-9AB0-C7125205C3D3@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <A8EA24F8-7A13-472A-9AB0-C7125205C3D3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 18:22, Prakash Sangappa wrote:
> 
> 
>> On Nov 20, 2025, at 7:47 AM, David Hildenbrand (Red Hat) <david@kernel.org> wrote:
>>
>> On 11/19/25 17:31, David Hildenbrand (Red Hat) wrote:
>>> On 19.11.25 17:29, David Hildenbrand (Red Hat) wrote:
>>>>>>
>>>>>> So what I am currently looking into is simply reducing (batching) the number
>>>>>> of IPIs.
>>>>>
>>>>> As in the IPIs we are now generating in tlb_remove_table_sync_one()?
>>>>>
>>>>> Or something else?
>>>>
>>>> Yes, for now. I'm essentially reducing the number of
>>>> tlb_remove_table_sync_one() calls.
>>>>
>>>>>
>>>>> As this bug is only an issue when we don't use IPIs for pgtable freeing right
>>>>> (e.g. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set), as otherwise
>>>>> tlb_remove_table_sync_one() is a no-op?
>>>>
>>>> Right. But it's still confusing: I think for page table unsharing we
>>>> always need an IPI one way or the other to make sure GUP-fast was called.
>>>>
>>>> At least for preventing that anybody would be able to reuse the page
>>>> table in the meantime.
>>>>
>>>> That is either:
>>>>
>>>> (a) The TLB shootdown implied an IPI
>>>>
>>>> (b) We manually send one
>>>>
>>>> But that's where it gets confusing: nowadays x86 also selects
>>>> MMU_GATHER_RCU_TABLE_FREE, meaning we would get a double IPI?
>>>>
>>>> This is so complicated, so I might be missing something.
>>>>
>>>> But it's the same behavior we have in collapse_huge_page() where we first
>>> ... flush and then call tlb_remove_table_sync_one().
>>
>> Okay, I pushed something to
>>
>> https://github.com/davidhildenbrand/linux.git hugetlb_unshare
> 
> For testing had to backport the fix to v5.15. Used top 8 commits from the above tree.
> v5.15 kernel does not have ptdesc and hugetlb vma locking.
> 
> With that change, our DB team has verified that it fixes the regression.

Great, thanks for testing!

> 
> Will you push this fix to LTS trees after it is reviewed and merged?

I can further clean this up and send it out. There is something about 
the mmu_gather integration that I don't enjoy, but I didn't find a 
better solution so far.

I can try backporting it, I would likely have to try to minimize the 
prereq cleanups. Let me see to which degree this can be done in a 
sensible way!

-- 
Cheers

David

