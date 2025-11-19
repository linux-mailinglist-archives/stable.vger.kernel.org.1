Return-Path: <stable+bounces-195175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259CBC6F2DD
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C90B62ED0E
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EE36654D;
	Wed, 19 Nov 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4IUf4A6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980ED238C3B
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561602; cv=none; b=Gvh8K8Uok0m2GZQjixzZgqrlvQuhR7AffGiVrP7icpiwfp7VDIfDIMbIaIIppCyOTMfDEGAM3FV6aKvz1AQpDYdy7WFEcaYXoIMEwqPVYW44vhJaRA/hEz+gqc4Ikab0kdp+Vfmfquc7SoYeR3M7cGnp/cT9Td+bjELleQRWW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561602; c=relaxed/simple;
	bh=rqjqNRbRszjQKubEqVaUkt2FhKH4pijMfhuEdiOhbZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9pHxfisdqQvMXUQygg/bEEBjEXLQ/+WxN8JsMHlDncfJ/UtlwbuF/eJ3PDo6u5at1fXv+yRPf7qgFlShFrsC2XZzR6clKfEp0yrOMA0cEcrNQRXcbYPTZIoJFv+Haqd1hQ3d7gQ8f89RW5KneD9tTVlQfpxBMT2YNRJRiUnOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4IUf4A6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF76C116B1;
	Wed, 19 Nov 2025 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561602;
	bh=rqjqNRbRszjQKubEqVaUkt2FhKH4pijMfhuEdiOhbZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R4IUf4A6uAWakKXxbOj1j8lpcMRpRa2rxLkvIsOG3ALqxvAyy9QdxfzlX/Hz/Rl6x
	 PsDI8UfD6YfYkjGRINHuRSELcX39I2mbYNrJ1zQMwAo6kiSCUmah77Tiqeya4uinCF
	 bwfPG3GGF0mI2BRK/sAYfo8ckgxPT84njcyL848wxhbBjJHrkwfCQ49wpfAfTy049y
	 8nO08anlebl7fJVrg6FICllu2vl6YoxMGg4PHQbvFcN4BnjsuzD+zKTtwuwWYF8ApK
	 USUQjBKrnVNA97C+uYnrFPUFaD+qkIkllIkaATGXlMkhaLoKkYgf64PXNJa3ntVlYZ
	 3P0rID4Qb4+FQ==
Message-ID: <dfb089d4-0be9-4dfa-a45c-0888cd2c7bc4@kernel.org>
Date: Wed, 19 Nov 2025 15:13:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119124229.e4cpozqapmfeqykr@master>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119124229.e4cpozqapmfeqykr@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 13:42, Wei Yang wrote:
> On Wed, Nov 19, 2025 at 09:57:58AM +0100, David Hildenbrand (Red Hat) wrote:
>> On 19.11.25 02:26, Wei Yang wrote:
>>> Commit c010d47f107f ("mm: thp: split huge page to any lower order
>>> pages") introduced an early check on the folio's order via
>>> mapping->flags before proceeding with the split work.
>>>
>>> This check introduced a bug: for shmem folios in the swap cache, the
>>> mapping pointer can be NULL. Accessing mapping->flags in this state
>>> leads directly to a NULL pointer dereference.
>>
>> Under which circumstances would that be the case? Only for large shmem folios
>> in the swapcache or also for truncated folios? So I'd assume this
>> would also affect truncated folios and we should spell that out here?
>>
>>>
>>> This commit fixes the issue by moving the check for mapping != NULL
>>> before any attempt to access mapping->flags.
>>>
>>> This fix necessarily changes the return value from -EBUSY to -EINVAL
>>> when mapping is NULL. After reviewing current callers, they do not
>>> differentiate between these two error codes, making this change safe.
>>
>> The doc of __split_huge_page_to_list_to_order() would now be outdated and has
>> to be updated.
>>
>> Also, take a look at s390_wiggle_split_folio(): returning -EINVAL instead of
>> -EBUSY will make a difference on concurrent truncation. -EINVAL will be
>> propagated and make the operation fail, while -EBUSY will be translated to
>> -EAGAIN and the caller will simply lookup the folio again and retry.
>>
>> So I think we should try to keep truncation return -EBUSY. For the shmem
>> case, I think it's ok to return -EINVAL. I guess we can identify such folios
>> by checking for folio_test_swapcache().
>>
> 
> I come up a draft:
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7c69572b6c3f..3e140fa1ca13 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3696,6 +3696,18 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>                                  "Cannot split to order-1 folio");
>                  if (new_order == 1)
>                          return -EINVAL;
> +       } else if (!folio->mapping) {
> +               /*
> +                * If there is no mapping that the folio was truncated and we
> +                * cannot split.
> +                *
> +                * TODO: large shmem folio in the swap cache also don't
> +                * currently have a mapping but folio_test_swapcache() is true
> +                * for them.
> +                */
> +               if (folio_test_swapcache(folio))

As per discussions, that would likely have to be

	folio_test_swapbacked() && folio_test_swapcache()


> +                       return -EINVAL;
> +               return -EBUSY;
>          } else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>                  if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>                      !mapping_large_folio_support(folio->mapping)) {
> @@ -3931,8 +3943,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>          if (new_order >= old_order)
>                  return -EINVAL;
>   
> -       if (!folio_split_supported(folio, new_order, split_type, /* warn = */ true))
> -               return -EINVAL;
> +       ret = folio_split_supported((folio, new_order, split_type, /* warn = */ true));
> +       if (ret)

I'd prefer if folio_split_supported() would keep returning a boolen, 
such that we detect the truncation case earlier and just return -EBUSY.

But no strong opinion. Important part is that truncation handling is not 
changed without taking a lot of care.

-- 
Cheers

David

