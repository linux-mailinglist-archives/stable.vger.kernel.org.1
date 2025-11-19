Return-Path: <stable+bounces-195181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD6C6F77F
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB8FC4FA581
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B62E369202;
	Wed, 19 Nov 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ08OGem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72C364051
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563581; cv=none; b=tpFR4SAS26PWjjSVnFI5ZRorN0e7Thx/lyhtMtN9Wr+NX+Udki4S+3OY8dgQUoCLR5ekHXLQbEs2WBh68AGnGi0C5XDLh3pW1rAGD2WbwYuNJ8bpvYGVPwsCOVlgte2rsW66i7U7s8D1zyqXX5V3WNSTA4WNu4jovcMQReBk8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563581; c=relaxed/simple;
	bh=flOy/nWQ0wLVWoCwxnbCEkms8GbhSC0jwYnCdil2gFs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W+XPhCIjYncQMcvkrMb4Hh2OQhaN9Sl5u/BEn7e52ktghq5uE1rzSSuTHvgJuo4CSGe/4W+0QFEjrq/tUZGP3vSqRHXHc+HG0EAmb4/lTm2y8cIknJIkbXC8XKRG83kYnMvw7+CAYD+rPP9C5r22wyG0LSm0NNmJVY3Hzod9Qtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ08OGem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F23C19423;
	Wed, 19 Nov 2025 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563581;
	bh=flOy/nWQ0wLVWoCwxnbCEkms8GbhSC0jwYnCdil2gFs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UJ08OGemkRMHs/5BP9p6GxgNAJ3FfXkNSl61nyBQgUU1OOaQHXFuquLRTowbdkzWX
	 BpgTZbNM5/rdpcm4mXW+7H63io0Kn+vgdf8poUwDvYL3vTEbOJX4HY3kcz3yfqHf4B
	 6FWaR3gZglexrsjYE90E3lX6mvF1ofMUU23OG1APHtHIQlpTuRF0wPTMN3SONtFTUt
	 AFUmlWj3WIgLc8IlQzyUkFKJlW8RJlgYsJW/7Zo8R3wRO86neZ/sIL56mBYAL8JT8D
	 A/CAnPKnDtKarm8pGVC/ziVgzbPp6PTdP618XmoWM42rqlPsdUoQeDaSOdLw1tA7Rv
	 M9FMgQ4C8RzBg==
Message-ID: <14253d62-0a85-4f61-aed6-72da17bcef77@kernel.org>
Date: Wed, 19 Nov 2025 15:46:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
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
Content-Language: en-US
In-Reply-To: <822641bc-daea-46e1-b2cb-77528c32dae6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 15:37, David Hildenbrand (Red Hat) wrote:
>>> Given folio_test_swapcache() might have false positives,
>>> I assume we'd need a
>>>
>>> 	folio_test_swapbacked() && folio_test_swapcache(folio)
>>>
>>> To detect large large shmem folios in the swapcache in all cases here.
>>>
>>> Something like the following would hopefully do:
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2f2a521e5d683..57aab66bedbea 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>           return ret;
>>>    }
>>>    +static bool folio_test_shmem_swapcache(struct folio *folio)
>>> +{
>>> +       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
>>> +       /* These folios do not have folio->mapping set. */
>>> +       return folio_test_swapbacked(folio) && folio_test_swapcache(folio);
>>> +}
>>> +
>>>    bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>                   bool warns)
>>>    {
>>> @@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>                                   "Cannot split to order-1 folio");
>>>                   if (new_order == 1)
>>>                           return false;
>>> +       } else if (folio_test_shmem_swapcache(folio)) {
>>> +               /* TODO: support shmem folios that are in the swapcache. */
>>> +               return false;
>>
>> With this, truncated shmem returns -EINVALID instead of -EBUSY now.
>> Can s390_wiggle_split_folio() such folios?
> 
> [noting that s390_wiggle_split_folio() was just one caller where I new
> the return value differs. I suspect there might be more.]
> 
> I am still not clear on that one.
> 
> s390x obtains the folio while walking the page tables. In case it gets
> -EBUSY it simply retries to obtain the folio from the page tables.
> 
> So assuming there was concurrent truncation and we returned -EBUSY, it
> would just retry walking the page tables (trigger a fault to map a
> folio) and retry with that one.
> 
> I would assume that the shmem folio in the swapcache could never have
> worked before, and that there is no way to make progress really.
> 
> In other words: do we know how we can end up with a shmem folio that is
> in the swapcache and does not have folio->mapping set?
> 
> Could that think still be mapped into the page tables? (I hope not, but
> right now I am confused how that can happen )
> 

Ah, my memory comes back.

vmscan triggers shmem_writeout() after unmapping the folio and after making sure that there are no unexpected folio references.

shmem_writeout() will do the shmem_delete_from_page_cache() where we set folio->mapping = NULL.

So anything walking the page tables (like s390x) could never find it.


Such shmem folios really cannot get split right now until we either reclaimed them (-> freed) or until shmem_swapin_folio() re-obtained them from the swapcache to re-add them to the swapcache through shmem_add_to_page_cache().

So maybe we can just make our life easy and just keep returning -EBUSY for this scenario for the time being?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f2a521e5d683..5ce86882b2727 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3619,6 +3619,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
         if (folio != page_folio(split_at) || folio != page_folio(lock_at))
                 return -EINVAL;
  
+       /*
+        * Folios that just got truncated cannot get split. Signal to the
+        * caller that there was a race.
+        *
+        * TODO: this will also currently refuse shmem folios that are in
+        * the swapcache.
+        */
+       if (!is_anon && !folio->mapping)
+               return -EBUSY;
+
         if (new_order >= folio_order(folio))
                 return -EINVAL;
  
@@ -3659,17 +3669,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
                 gfp_t gfp;
  
                 mapping = folio->mapping;
-
-               /* Truncated ? */
-               /*
-                * TODO: add support for large shmem folio in swap cache.
-                * When shmem is in swap cache, mapping is NULL and
-                * folio_test_swapcache() is true.
-                */
-               if (!mapping) {
-                       ret = -EBUSY;
-                       goto out;
-               }
+               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
  
                 min_order = mapping_min_folio_order(folio->mapping);
                 if (new_order < min_order) {


-- 
Cheers

David

