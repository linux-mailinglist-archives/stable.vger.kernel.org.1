Return-Path: <stable+bounces-195173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E7C6F278
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6373C4F71A9
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E829354ACC;
	Wed, 19 Nov 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/CZAhY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5A342C8E
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560700; cv=none; b=S0PZ0K03L3GYEd7+UdTlD45BB4tpatOuFLj27n3Q6CBWZ/bcF4c7YuX/J2lIWOeMBD80QHQHcen/TVrS0MpU5rv6JpgISLfs140trRRQTJtoEEmMR+WFgVjkgdyVjsfqgOueYP1HRATadhOXo4OzQYbhPjtg36wvj/Zc9uYAEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560700; c=relaxed/simple;
	bh=JRxfngDvQAz26XpSeqsn2PHhq06Y1ysuGPxFMQy3pGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILLH2XMkbLNjwqEcvcxQPUtMzUFVwP9GoGlWqJbmR83mjDS4RtcVSWlitgqDu2gOvRuZT+tjP5gO9nvgi1K2UoN8zl2oomMQ43upWNC9+WpUfbfoRi3A7VFOnm6Bv4WuK6mpt2pS3fk19Vub/BG7S40skfl7ZmDu7PQKBp0v2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/CZAhY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1880C2BC9E;
	Wed, 19 Nov 2025 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560699;
	bh=JRxfngDvQAz26XpSeqsn2PHhq06Y1ysuGPxFMQy3pGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j/CZAhY7IOXTGtYHDrPVJN3J24w7oj9tqLskEU3HV9HITpVTB3d0UdEh2KH0Qs8ep
	 nKPaoJmIRi1gviOyvSWcNhxIMWHqheenctHKlyCtXNY1HH5FwUqwkbb7l4TDKndDGe
	 nuL+ijtZWUlG+SiFQ6AclgX7a3OFwAWuJ5P5XSC8OpBXawA9b66vy3xHEdZHYdcIRV
	 AJBVKInh6gSCz1an+HSvObyG+JSgIt5gPJ6uxiyxA28fO1rRFetrdnahXS+Yobqlu4
	 jIcjZkwTmOVXdrQOn8B7SJ7mCP5lOv1QO9dVuhxloM6ffLbiAiX7HOay6JcUn2Y7xo
	 E9WwH60FLE4bw==
Message-ID: <86b1e36b-02a4-45c5-9670-543cc635bb65@kernel.org>
Date: Wed, 19 Nov 2025 14:58:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
To: Wei Yang <richard.weiyang@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
 <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
 <20251119134106.t7jmnl2k5w265en6@master>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119134106.t7jmnl2k5w265en6@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 14:41, Wei Yang wrote:
> On Wed, Nov 19, 2025 at 08:08:01AM -0500, Zi Yan wrote:
>> On 19 Nov 2025, at 7:54, David Hildenbrand (Red Hat) wrote:
>>
>>>>
>>>>> So I think we should try to keep truncation return -EBUSY. For the shmem
>>>>> case, I think it's ok to return -EINVAL. I guess we can identify such folios
>>>>> by checking for folio_test_swapcache().
>>>>>
>>>>
>>>> Hmm... Don't get how to do this nicely.
>>>>
>>>> Looks we can't do it in folio_split_supported().
>>>>
>>>> Or change folio_split_supported() return error code directly?
>>>
>>>
>>> On upstream, I would do something like the following (untested):
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2f2a521e5d683..33fc3590867e2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>                                  "Cannot split to order-1 folio");
>>>                  if (new_order == 1)
>>>                          return false;
>>> +       } else if (folio_test_swapcache(folio)) {
>>> +               /* TODO: support shmem folios that are in the swapcache. */
>>> +               return false;
> 
> Hmm... we are filtering out all swapcache instead of just shmem swapcache?
> 
> Is it possible for (folio->mapping && folio_test_swapcache(folio)) reach here?
> Looks the logic is little different, but maybe I missed something.
> 
> OK, my brain is out of state. Hope I don't make stupid mistake.

It's tricky. folio_test_swapcache() only applies to anon and shmem.

But looking at it, we have

	PG_swapcache = PG_owner_priv_1,

PG_owner_priv_1 is also used for
* XEN stuff
* vmemmap_self_hosted

Which is not important for us IIRC.

But we have

	/* Some filesystems */
	PG_checked = PG_owner_priv_1

So maybe we could indeed have false positives here.


So I guess we cannot rely on folio_test_swapcache() ... here. What a mess.

-- 
Cheers

David

