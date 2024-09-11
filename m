Return-Path: <stable+bounces-75802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23577974CBB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D6A281B5C
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6F154425;
	Wed, 11 Sep 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkcuSRYx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF713B5A9
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043727; cv=none; b=fTGxQonIOuuPLJA1pa5uNCm4/FF2dN5kJdG43s4RuL26ChLUhAIR909bRDUi0CSOvYvpCaEHwSZSX8+c37llfZ/ONXupZSZcrWVTduvQlmzAaPsOeTKlUL3rXun8TLc8ccGCqPcAvPes8J1V/9AVLwr+0LXuBNPHwU42ubyAtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043727; c=relaxed/simple;
	bh=yNsD1Pwsc6IgI8eIFuuaKK/VsJIDLrR8k8TQWAQ1sfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOQRQ09OuAIf211N72VtFBdlrTo7khZ4zKQXyGydlJA5Uyct29dSfzH6F4mnZk610tSuM5dDV4RtUkMzFKevpMQmHeLVE+zSzo04d4Oub7/p59bsouZY7/V3/alikxL9D8y/aT+aM5abKMtV4s2WMfabHZt21Wb5DiwNUOMwj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkcuSRYx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726043726; x=1757579726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yNsD1Pwsc6IgI8eIFuuaKK/VsJIDLrR8k8TQWAQ1sfs=;
  b=JkcuSRYxZ9EdlEgPANKSdWLcgdJh0ML6L12/hmnvHAfcvbeKFRVaUpUg
   i0zo1sJzZs14sGsSc2lDlh0V3GeG9LT9Xb+I9W5g90iZYkDzK6rM7BwwA
   Slv7aD/RIjfFLkUKVrcmotvNo0dZswucMoX8O9j5T+BpzOVWgLaoGQLQj
   Ar6WBlQdbOR6LqGa6DOZypwDxN3cKLiRmS4HHUHSkXwLe05deNPfp/cvk
   9/4Q0nQanLi2KBtm+xJBGItanH2eu1S0Tn4awRzlJjrAx3LBTWttyTPy9
   IUh9LJ+/roPk7TeyeeP7ObN5FWRkIgZu3iEgBRuuVJoyhXfG/8pRGRlYO
   A==;
X-CSE-ConnectionGUID: DrS3FsIJRVii8RyO4XKvug==
X-CSE-MsgGUID: EJWrX13jSTqHKHP1DtmFIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24967191"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24967191"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:35:25 -0700
X-CSE-ConnectionGUID: aHDORpfURvmND6l5ypiRFw==
X-CSE-MsgGUID: QABO1tC+TUWKF7vfdwa8cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67133809"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.102]) ([10.245.244.102])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:35:24 -0700
Message-ID: <fea806cc-ed5e-4fd0-adf5-87d98ea5b99d@intel.com>
Date: Wed, 11 Sep 2024 09:35:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/xe/client: add missing bo locking in
 show_meminfo()
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240910131145.136984-5-matthew.auld@intel.com>
 <20240910131145.136984-6-matthew.auld@intel.com>
 <SJ1PR11MB620426C360C56AE7A55D6DA7819B2@SJ1PR11MB6204.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <SJ1PR11MB620426C360C56AE7A55D6DA7819B2@SJ1PR11MB6204.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 11/09/2024 06:39, Upadhyay, Tejas wrote:
> 
> 
>> -----Original Message-----
>> From: Auld, Matthew <matthew.auld@intel.com>
>> Sent: Tuesday, September 10, 2024 6:42 PM
>> To: intel-xe@lists.freedesktop.org
>> Cc: Ghimiray, Himal Prasad <himal.prasad.ghimiray@intel.com>; Upadhyay,
>> Tejas <tejas.upadhyay@intel.com>; Thomas Hellström
>> <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
>> Subject: [PATCH 2/4] drm/xe/client: add missing bo locking in
>> show_meminfo()
>>
>> bo_meminfo() wants to inspect bo state like tt and the ttm resource, however
>> this state can change at any point leading to stuff like NPD and UAF, if the bo
>> lock is not held. Grab the bo lock when calling bo_meminfo(), ensuring we
>> drop any spinlocks first. In the case of object_idr we now also need to hold a
>> ref.
>>
>> Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>   drivers/gpu/drm/xe/xe_drm_client.c | 37 +++++++++++++++++++++++++++---
>>   1 file changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_drm_client.c
>> b/drivers/gpu/drm/xe/xe_drm_client.c
>> index badfa045ead8..3cca741c500c 100644
>> --- a/drivers/gpu/drm/xe/xe_drm_client.c
>> +++ b/drivers/gpu/drm/xe/xe_drm_client.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/types.h>
>>
>> +#include "xe_assert.h"
>>   #include "xe_bo.h"
>>   #include "xe_bo_types.h"
>>   #include "xe_device_types.h"
>> @@ -151,10 +152,13 @@ void xe_drm_client_add_bo(struct xe_drm_client
>> *client,
>>    */
>>   void xe_drm_client_remove_bo(struct xe_bo *bo)  {
>> +	struct xe_device *xe = ttm_to_xe_device(bo->ttm.bdev);
>>   	struct xe_drm_client *client = bo->client;
>>
>> +	xe_assert(xe, !kref_read(&bo->ttm.base.refcount));
>> +
>>   	spin_lock(&client->bos_lock);
>> -	list_del(&bo->client_link);
>> +	list_del_init(&bo->client_link);
>>   	spin_unlock(&client->bos_lock);
>>
>>   	xe_drm_client_put(client);
>> @@ -207,7 +211,20 @@ static void show_meminfo(struct drm_printer *p,
>> struct drm_file *file)
>>   	idr_for_each_entry(&file->object_idr, obj, id) {
>>   		struct xe_bo *bo = gem_to_xe_bo(obj);
>>
>> -		bo_meminfo(bo, stats);
>> +		if (dma_resv_trylock(bo->ttm.base.resv)) {
>> +			bo_meminfo(bo, stats);
>> +			xe_bo_unlock(bo);
>> +		} else {
>> +			xe_bo_get(bo);
>> +			spin_unlock(&file->table_lock);
>> +
>> +			xe_bo_lock(bo, false);
>> +			bo_meminfo(bo, stats);
>> +			xe_bo_unlock(bo);
>> +
>> +			xe_bo_put(bo);
>> +			spin_lock(&file->table_lock);
>> +		}
>>   	}
>>   	spin_unlock(&file->table_lock);
>>
>> @@ -217,7 +234,21 @@ static void show_meminfo(struct drm_printer *p,
>> struct drm_file *file)
>>   		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
>>   			continue;
>>
> 
> While we have ref to BO, why would it need lock here, can you please explain if I am missing something. I though BO cant be deleted till will hold ref?

The ref is just about protecting the lifetime of the bo, however the 
internal bo state in particular the ttm stuff, is all protected by 
holding the dma-resv bo lock.

For example the bo can be moved/evicted around at will and the object 
state changes with it, but that should be done only when also holding 
the bo lock. If we are holding the bo lock here then the object state 
should be stable, making it safe to inspect stuff like bo->ttm.ttm and 
bo->ttm.resource. As an example, if you look at ttm_bo_move_null() and 
imagine xe_bo_has_pages() racing with that, then NPD or UAF is possible.

> 
> Thanks,
> Tejas
>> -		bo_meminfo(bo, stats);
>> +		if (dma_resv_trylock(bo->ttm.base.resv)) {
>> +			bo_meminfo(bo, stats);
>> +			xe_bo_unlock(bo);
>> +		} else {
>> +			spin_unlock(&client->bos_lock);
>> +
>> +			xe_bo_lock(bo, false);
>> +			bo_meminfo(bo, stats);
>> +			xe_bo_unlock(bo);
>> +
>> +			spin_lock(&client->bos_lock);
>> +			/* The bo ref will prevent this bo from being removed
>> from the list */
>> +			xe_assert(xef->xe, !list_empty(&bo->client_link));
>> +		}
>> +
>>   		xe_bo_put_deferred(bo, &deferred);
>>   	}
>>   	spin_unlock(&client->bos_lock);
>> --
>> 2.46.0
> 

