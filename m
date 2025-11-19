Return-Path: <stable+bounces-195184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A9C6F8A3
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0CA634CE86
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1836C0A0;
	Wed, 19 Nov 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnYPV3Fp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD327CB0A
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563842; cv=none; b=pdqfZvnMmSrVcr8evZtFKE/YuH/IpnQmLYSMar6hMlXtrcgiQlqM26RlXxBDY6FJblz5JBru6UVdFc8PcXJEQgeRz8/w/Z2BbGGqz57O3KXMG0m3ITU2rKhWm2irGgVjMMHH/7gov842YRl3U3juV/qnfv5PfIqk7v1uFCxR/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563842; c=relaxed/simple;
	bh=C7L8AD1VDWfDXe49RsbapDdAr0DeidInHjCfxQzy1oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVfVcwCvnod/drGc3nfhy775y6oyCk3Q2NxZjvRgVPE+ouPygWs8VUZ04pf7+/33cWWjpnlXTtLe7PSnsrasmZ2TxLzx5Yw1mLFsMRaTvqvChV/+zP77UtZAQp6EbFNtY+fnp9zT6nyfXVTlj1ZBkSrbDkUTPqDSh863ECDKUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnYPV3Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C86C2BCC4;
	Wed, 19 Nov 2025 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563841;
	bh=C7L8AD1VDWfDXe49RsbapDdAr0DeidInHjCfxQzy1oE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JnYPV3FpUp/k3neEOsCT4TUGUOABBLtEtTBds/BCvGaYmoDK1B4JQrHn0Og4hJQ1R
	 mm6DB6h1vGPMo1xuOGCf1Xoue3IeRUyKKHwIgiKGbDUr3MbM5SQqHIzfylTfBYrVfw
	 9S8cd9ZuFMUb+4C9K1EaoRy1PEtYb0a8ou4jtFxJ4B9sywPuwm/0BTV+4GDV7kQosk
	 LnB67sh8fYLMrKuz/NyvpA7GJYUvQLENHU7XrogKzCz5mDpAQW2+iIGGzQjsWzs61F
	 PHRrx02sFscN6Gm639nIgqpXzQtC1x+UtWuUOxk1Xuuv5E0NFDThxJUK9NXYTw1xbP
	 FkgIa/M/CkjMQ==
Message-ID: <2528b24c-6a14-4270-b1cb-f417ecee59c6@kernel.org>
Date: Wed, 19 Nov 2025 15:50:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
 <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
 <4f9df538-f918-4036-b72c-3356a4fff81e@kernel.org>
 <FA37F8FD-DDAB-43B0-9BEA-2AC25986767E@nvidia.com>
 <822641bc-daea-46e1-b2cb-77528c32dae6@kernel.org>
 <14253d62-0a85-4f61-aed6-72da17bcef77@kernel.org>
 <9C8CDE11-44B2-4C55-897B-A4F3FD695EB5@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <9C8CDE11-44B2-4C55-897B-A4F3FD695EB5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 15:48, Zi Yan wrote:
> On 19 Nov 2025, at 9:46, David Hildenbrand (Red Hat) wrote:
> 
>> On 19.11.25 15:37, David Hildenbrand (Red Hat) wrote:
>>>>> Given folio_test_swapcache() might have false positives,
>>>>> I assume we'd need a
>>>>>
>>>>> 	folio_test_swapbacked() && folio_test_swapcache(folio)
>>>>>
>>>>> To detect large large shmem folios in the swapcache in all cases here.
>>>>>
>>>>> Something like the following would hopefully do:
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 2f2a521e5d683..57aab66bedbea 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>>            return ret;
>>>>>     }
>>>>>     +static bool folio_test_shmem_swapcache(struct folio *folio)
>>>>> +{
>>>>> +       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
>>>>> +       /* These folios do not have folio->mapping set. */
>>>>> +       return folio_test_swapbacked(folio) && folio_test_swapcache(folio);
>>>>> +}
>>>>> +
>>>>>     bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>>>                    bool warns)
>>>>>     {
>>>>> @@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>>>                                    "Cannot split to order-1 folio");
>>>>>                    if (new_order == 1)
>>>>>                            return false;
>>>>> +       } else if (folio_test_shmem_swapcache(folio)) {
>>>>> +               /* TODO: support shmem folios that are in the swapcache. */
>>>>> +               return false;
>>>>
>>>> With this, truncated shmem returns -EINVALID instead of -EBUSY now.
>>>> Can s390_wiggle_split_folio() such folios?
>>>
>>> [noting that s390_wiggle_split_folio() was just one caller where I new
>>> the return value differs. I suspect there might be more.]
>>>
>>> I am still not clear on that one.
>>>
>>> s390x obtains the folio while walking the page tables. In case it gets
>>> -EBUSY it simply retries to obtain the folio from the page tables.
>>>
>>> So assuming there was concurrent truncation and we returned -EBUSY, it
>>> would just retry walking the page tables (trigger a fault to map a
>>> folio) and retry with that one.
>>>
>>> I would assume that the shmem folio in the swapcache could never have
>>> worked before, and that there is no way to make progress really.
>>>
>>> In other words: do we know how we can end up with a shmem folio that is
>>> in the swapcache and does not have folio->mapping set?
>>>
>>> Could that think still be mapped into the page tables? (I hope not, but
>>> right now I am confused how that can happen )
>>>
>>
>> Ah, my memory comes back.
>>
>> vmscan triggers shmem_writeout() after unmapping the folio and after making sure that there are no unexpected folio references.
>>
>> shmem_writeout() will do the shmem_delete_from_page_cache() where we set folio->mapping = NULL.
>>
>> So anything walking the page tables (like s390x) could never find it.
>>
>>
>> Such shmem folios really cannot get split right now until we either reclaimed them (-> freed) or until shmem_swapin_folio() re-obtained them from the swapcache to re-add them to the swapcache through shmem_add_to_page_cache().
>>
>> So maybe we can just make our life easy and just keep returning -EBUSY for this scenario for the time being?
> 
> Exactly, also an easy backport.

Okay, let's do that then.

@Wei can you send a v2?

-- 
Cheers

David

