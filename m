Return-Path: <stable+bounces-195174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40103C6F303
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8288F346BF4
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AB337B8B;
	Wed, 19 Nov 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZyVdCtr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2D21B195
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561384; cv=none; b=mAPnRlBunhCCUBwXcZgPyfOHlSvK/mPe02qtJNqrfWSNE3ldblceuWwAp6nHnfVj2bqlLrBywhATZdb/nkKSPsI2PN/m4OkwuuMnp1tl8yV/uBtbX7g5PFKXPNAOjhXIk7R7jH11TuuEsgWbKnOXttjJrdrNlcHBW/91CF8PjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561384; c=relaxed/simple;
	bh=UVyGG1Tv0zXtgSd/kXTDkK9fw4Aoqn/vp/kNJbgoBYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRHM/nMxxZOswlfAx4A2I6Pj1vpvf1l3e8Fb4Nbq7xdk3qIoVv2f7PUMkMv1+z9NVAmJ/XK0lnwsrx17qMAV2VzaHBM+TI9qRyv4RieU2/gvbVIdAfAMwWUynfK+ejuSkXc8UdQ6rKv+I/1XYYrdculYM0+IIsflzQl9A5sCq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZyVdCtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDFAC2BCB4;
	Wed, 19 Nov 2025 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561384;
	bh=UVyGG1Tv0zXtgSd/kXTDkK9fw4Aoqn/vp/kNJbgoBYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fZyVdCtrFUa4d0MTb0Iv1ACe2kYtgAuUwvCOLufjmtLUVuM00rKFpaIpkGw3oLt9y
	 Cx8COTeKtqKQKwmPqzljVGtnu7JgnzGVvuYoebp7+fdVD1OkdnIs6Ejm8zbNFMiOxw
	 KA0AbAPibeJ7H6G4VanoBigo2B0AXUDDq6pORVkbuwtvzG2UfnRa/F7v7KHQjdCanH
	 gwpMZAPbHLPhlACrWIseejmBJjvXEN7j035IY4N/wXuohLettQpKLtmaU9VcxymUql
	 kTucd83NUQOTHJYufxS9DWPZuZTpOEYqFo3HEvZ9t2SdQq8JcHcbq6i3u75/OUSPEW
	 Aam4gDN6OztcQ==
Message-ID: <4f9df538-f918-4036-b72c-3356a4fff81e@kernel.org>
Date: Wed, 19 Nov 2025 15:09:37 +0100
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 14:08, Zi Yan wrote:
> On 19 Nov 2025, at 7:54, David Hildenbrand (Red Hat) wrote:
> 
>>>
>>>> So I think we should try to keep truncation return -EBUSY. For the shmem
>>>> case, I think it's ok to return -EINVAL. I guess we can identify such folios
>>>> by checking for folio_test_swapcache().
>>>>
>>>
>>> Hmm... Don't get how to do this nicely.
>>>
>>> Looks we can't do it in folio_split_supported().
>>>
>>> Or change folio_split_supported() return error code directly?
>>
>>
>> On upstream, I would do something like the following (untested):
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2f2a521e5d683..33fc3590867e2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>                                  "Cannot split to order-1 folio");
>>                  if (new_order == 1)
>>                          return false;
>> +       } else if (folio_test_swapcache(folio)) {
>> +               /* TODO: support shmem folios that are in the swapcache. */
>> +               return false;
>>          } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>              !mapping_large_folio_support(folio->mapping)) {
>>                  /*
>> @@ -3556,6 +3559,9 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>>                                  "Cannot split to order-1 folio");
>>                  if (new_order == 1)
>>                          return false;
>> +       } else if (folio_test_swapcache(folio)) {
>> +               /* TODO: support shmem folios that are in the swapcache. */
>> +               return false;
> You are splitting the truncate case into shmem one and page cache one.
> This is only for shmem in the swap cache and ...
> 
>>          } else  if (new_order) {
>>                  if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>                      !mapping_large_folio_support(folio->mapping)) {
>> @@ -3619,6 +3625,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>          if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>>                  return -EINVAL;
>>   +       /*
>> +        * Folios that just got truncated cannot get split. Signal to the
>> +        * caller that there was a race.
>> +        *
>> +        * TODO: support shmem folios that are in the swapcache.
> 
> this is for page cache one. So this TODO is not needed.

I added the TODO because we'd like to detect truncation there as well I think. Hm.

> 
>> +        */
>> +       if (!is_anon && !folio->mapping && !folio_test_swapcache(folio))
>> +               return -EBUSY;
>> +

Given folio_test_swapcache() might have false positives,
I assume we'd need a

	folio_test_swapbacked() && folio_test_swapcache(folio)

To detect large large shmem folios in the swapcache in all cases here.

Something like the following would hopefully do:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f2a521e5d683..57aab66bedbea 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
         return ret;
  }
  
+static bool folio_test_shmem_swapcache(struct folio *folio)
+{
+       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
+       /* These folios do not have folio->mapping set. */
+       return folio_test_swapbacked(folio) && folio_test_swapcache(folio);
+}
+
  bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
                 bool warns)
  {
@@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
                                 "Cannot split to order-1 folio");
                 if (new_order == 1)
                         return false;
+       } else if (folio_test_shmem_swapcache(folio)) {
+               /* TODO: support shmem folios that are in the swapcache. */
+               return false;
         } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
             !mapping_large_folio_support(folio->mapping)) {
                 /*
@@ -3556,6 +3566,9 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
                                 "Cannot split to order-1 folio");
                 if (new_order == 1)
                         return false;
+       } else if (folio_test_shmem_swapcache(folio)) {
+               /* TODO: support shmem folios that are in the swapcache. */
+               return false;
         } else  if (new_order) {
                 if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
                     !mapping_large_folio_support(folio->mapping)) {
@@ -3619,6 +3632,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
         if (folio != page_folio(split_at) || folio != page_folio(lock_at))
                 return -EINVAL;
  
+       /*
+        * Folios that just got truncated cannot get split. Signal to the
+        * caller that there was a race.
+        */
+       if (!is_anon && !folio->mapping && !folio_test_shmem_swapcache(folio))
+               return -EBUSY;
+
         if (new_order >= folio_order(folio))
                 return -EINVAL;
  
@@ -3659,17 +3679,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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

>>>
>>>>
>>>> Probably worth mentioning that this was identified by code inspection?
>>>>
>>>
>>> Agree.
>>>
>>>>>
>>>>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> Hmm, what would this patch look like when based on current upstream? We'd
>>>> likely want to get that upstream asap.
>>>>
>>>
>>> This depends whether we want it on top of [1].
>>>
>>> Current upstream doesn't have it [1] and need to fix it in two places.
>>>
>>> Andrew mention prefer a fixup version in [2].
>>>
>>> [1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.com
>>> [2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux-foundation.org
>>
>> As we will want to backport this patch, likely we want to have it apply on current master.
>>
>> Bur Andrew can comment what he prefers in this case of a stable fix.
> 
> That could mess up with mm-new tree[1] based on Andrew's recent feedback.

Right, a similar fix could be had against mm-new.

-- 
Cheers

David

