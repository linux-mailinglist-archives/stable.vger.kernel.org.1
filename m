Return-Path: <stable+bounces-195169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70AC6EB48
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA5344F1FD1
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806E2E62B5;
	Wed, 19 Nov 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onMr3WZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3132ABDC
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556893; cv=none; b=P+X8pMw6U3/oB3k2yi58prpp+UhhqZPt7WODSlaQ7UkekKKKQdtdPt041NYSh4Fi34iq8FAxpst+jD1tqmUfiO3is2pCs2rDWE79xcW3zoZMDFRNpuDLwDx6LnHLbZX8DW+lL6+BqgDkssaR/Wes+FZVPQoQpu6+SxKGtfFIsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556893; c=relaxed/simple;
	bh=pEzIFnffdX0dHeSUOEWfyrJx4vS+HbyKds+OL9ZS4Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8ffRtePCF6nPya789duw5MXl7aruOeRnJUBneu6/Z9XUWtyKh+j67eob8nfjeLwTQViv4n/eVrkI1DN/iexndRSY0KP2HuGRdiMUthfcUxo40fEEEdWLm2j/0i1Dd9XY/Iu+2bO5GUJgop9fc2U66hsfUIfd2WpOlORWjP6y68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onMr3WZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062DEC2BC87;
	Wed, 19 Nov 2025 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763556892;
	bh=pEzIFnffdX0dHeSUOEWfyrJx4vS+HbyKds+OL9ZS4Yc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=onMr3WZNqee7RsOHlX1laMRPO98IL+mncRJmjC9IzvDxZiO1ZHUH6LrS7gXQnCkrm
	 XYZO6nhXifE2Ac9d1BlxZO/JwLmyiQQ8/H/QusIzj7dCtiCbUSjdCVVKN4KpRzPop1
	 VZ2hWfoDvrPopZfn9299LCV8QvOq5ek9rPL+3C5gO0BB2KvBYFQb8c3F4TkulErUEt
	 nr54hZE5BesF7WZrp/xsbhVZKovJvnjSreOo9PQVq90GC/aBPmGICm+vaeXXDtAqIV
	 60ndnsa6aivy3FwJ492whR411EePEkZk6awDTZBpO+9R6eqM0nAOWeKVRzlg/wVEAM
	 0v3dsr122e2Iw==
Message-ID: <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
Date: Wed, 19 Nov 2025 13:54:45 +0100
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
 <20251119122325.cxolq3kalokhlvop@master>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119122325.cxolq3kalokhlvop@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
>> So I think we should try to keep truncation return -EBUSY. For the shmem
>> case, I think it's ok to return -EINVAL. I guess we can identify such folios
>> by checking for folio_test_swapcache().
>>
> 
> Hmm... Don't get how to do this nicely.
> 
> Looks we can't do it in folio_split_supported().
> 
> Or change folio_split_supported() return error code directly?


On upstream, I would do something like the following (untested):

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f2a521e5d683..33fc3590867e2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
                                 "Cannot split to order-1 folio");
                 if (new_order == 1)
                         return false;
+       } else if (folio_test_swapcache(folio)) {
+               /* TODO: support shmem folios that are in the swapcache. */
+               return false;
         } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
             !mapping_large_folio_support(folio->mapping)) {
                 /*
@@ -3556,6 +3559,9 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
                                 "Cannot split to order-1 folio");
                 if (new_order == 1)
                         return false;
+       } else if (folio_test_swapcache(folio)) {
+               /* TODO: support shmem folios that are in the swapcache. */
+               return false;
         } else  if (new_order) {
                 if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
                     !mapping_large_folio_support(folio->mapping)) {
@@ -3619,6 +3625,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
         if (folio != page_folio(split_at) || folio != page_folio(lock_at))
                 return -EINVAL;
  
+       /*
+        * Folios that just got truncated cannot get split. Signal to the
+        * caller that there was a race.
+        *
+        * TODO: support shmem folios that are in the swapcache.
+        */
+       if (!is_anon && !folio->mapping && !folio_test_swapcache(folio))
+               return -EBUSY;
+
         if (new_order >= folio_order(folio))
                 return -EINVAL;
  
@@ -3659,17 +3674,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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


So rule out the truncated case earlier, leaving only the swapcache check to be handled
later.

Thoughts?

> 
>>
>> Probably worth mentioning that this was identified by code inspection?
>>
> 
> Agree.
> 
>>>
>>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: <stable@vger.kernel.org>
>>
>> Hmm, what would this patch look like when based on current upstream? We'd
>> likely want to get that upstream asap.
>>
> 
> This depends whether we want it on top of [1].
> 
> Current upstream doesn't have it [1] and need to fix it in two places.
> 
> Andrew mention prefer a fixup version in [2].
> 
> [1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.com
> [2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux-foundation.org

As we will want to backport this patch, likely we want to have it apply on current master.

Bur Andrew can comment what he prefers in this case of a stable fix.

-- 
Cheers

David

