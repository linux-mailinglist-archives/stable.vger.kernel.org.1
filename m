Return-Path: <stable+bounces-195180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A4C6F7BC
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 524DE4F1E4E
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27077368294;
	Wed, 19 Nov 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKMfSFVz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368234F469
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563090; cv=none; b=uFKWKtg3eatSaphAPinfdoxFgczCBV4Q9dCrBEOI4gl8zOj/EcvcOmJQFiOSA/ECBhp6uojxxYVusg9FXV5geVUemx1vOVDIKKTBZsLrLlhz4KJUBlq4z5Fi+Jjt05f2tjhkSVeQ8TSYYCo+sUtOVOYkt7GFxYqY/+n1sVBGGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563090; c=relaxed/simple;
	bh=sJG2/+R0rJL191YTA4A2S55TEWYO2JvU1RwZ4f+4YNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8pVF3Fk+1n/W+30FhLAert5Eb7n0RrlGz5TRgS3Pc1fKd9prKjCtg1aCglTDGpqy75S5m5zmuoI4x0bzjCt+XhcRyjPViYg4q6dedNSzY5fmjxvxkXslYXNK5pYNxHbIJQh153bf5Zfl0Cpzgk9ZyUBJyV6TPzuNvIJTczRAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKMfSFVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F1EC4DE0A;
	Wed, 19 Nov 2025 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563082;
	bh=sJG2/+R0rJL191YTA4A2S55TEWYO2JvU1RwZ4f+4YNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jKMfSFVz2qOpvNz6eqyEBidWOwuxu7xLDnpn3FZSq2NfkbzUTLHiO3zI+4r5+cOq9
	 7k0FCHXq4sfQ0xy54hLyYsWK8r78RI1AFGEsX0ETIQrtXMW02YhzqcSN/0YD9P5WTd
	 tS7Yj3vKqq17Mg43IEbqBnP2PxE2Gh8w/8joQozmW/9TEtseN+E0mV+1IzM7So5/lY
	 TPuykFsNmp7RZggWdpi+2WIQuZ+AeDae45rJWdDguLVoq5OzMYlS1DmTri3v5AhhIV
	 udSpogpO6eEjIIFCC7ThcwpdVkAWzHqEj3VwFcULq9O8+TIrMuw6bvyWl5SS9fXwpr
	 fjvYZpkEbmeyw==
Message-ID: <822641bc-daea-46e1-b2cb-77528c32dae6@kernel.org>
Date: Wed, 19 Nov 2025 15:37:53 +0100
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <FA37F8FD-DDAB-43B0-9BEA-2AC25986767E@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Given folio_test_swapcache() might have false positives,
>> I assume we'd need a
>>
>> 	folio_test_swapbacked() && folio_test_swapcache(folio)
>>
>> To detect large large shmem folios in the swapcache in all cases here.
>>
>> Something like the following would hopefully do:
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2f2a521e5d683..57aab66bedbea 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>>          return ret;
>>   }
>>   +static bool folio_test_shmem_swapcache(struct folio *folio)
>> +{
>> +       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
>> +       /* These folios do not have folio->mapping set. */
>> +       return folio_test_swapbacked(folio) && folio_test_swapcache(folio);
>> +}
>> +
>>   bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>                  bool warns)
>>   {
>> @@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>                                  "Cannot split to order-1 folio");
>>                  if (new_order == 1)
>>                          return false;
>> +       } else if (folio_test_shmem_swapcache(folio)) {
>> +               /* TODO: support shmem folios that are in the swapcache. */
>> +               return false;
> 
> With this, truncated shmem returns -EINVALID instead of -EBUSY now.
> Can s390_wiggle_split_folio() such folios?

[noting that s390_wiggle_split_folio() was just one caller where I new 
the return value differs. I suspect there might be more.]

I am still not clear on that one.

s390x obtains the folio while walking the page tables. In case it gets 
-EBUSY it simply retries to obtain the folio from the page tables.

So assuming there was concurrent truncation and we returned -EBUSY, it 
would just retry walking the page tables (trigger a fault to map a 
folio) and retry with that one.

I would assume that the shmem folio in the swapcache could never have 
worked before, and that there is no way to make progress really.

In other words: do we know how we can end up with a shmem folio that is 
in the swapcache and does not have folio->mapping set?

Could that think still be mapped into the page tables? (I hope not, but 
right now I am confused how that can happen )

-- 
Cheers

David

