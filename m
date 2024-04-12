Return-Path: <stable+bounces-39317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE68A3104
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5981C21E60
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676271420B9;
	Fri, 12 Apr 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We+rjn6S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5E1420BE
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932926; cv=none; b=mT5PeG/fRl7CSAn/rJLzl1qujOIi+AFW54kfN3j4A5+iX3xAYkacE98WfYytx90qYmu6m5hKC8ZG/zfztJts4CGwR7qLdELZDBpdigLwwpDKFpqBKePcP1YsTGhRAkYBkOuaXpZH+sRcqa9nq7ZOIAB0b2mRoTrbCbpiZD7R56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932926; c=relaxed/simple;
	bh=S7+Zq3Sp36ywGsSjIg+MnzoYOT71Y8aF8vKqMab4AmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiFPzur2kHTHDPNrC5+ebDsFP83xYDDQseyLBbaYXrbdqC8GraVYlL8bQlIioO7/RUho2iKYGUyOcXwvQd2iRCpVqRn3K3AEZKWxCcvZsoIKkZX106cmWq+6hF+poEjbGUo/C9ftWnvJwLRgm4Bs3/AbNfPIWO91drflEXXZthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We+rjn6S; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712932924; x=1744468924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S7+Zq3Sp36ywGsSjIg+MnzoYOT71Y8aF8vKqMab4AmU=;
  b=We+rjn6S7gsvf5OEpvwtWXa2lrth1DAF1rVxmKXfJedELtNfOVft7OFX
   kMCGJdIShjwOG32vmLLs+LSIjH0u2U4sRzQV8rpq17LLXj7IcItnwz9Ug
   X+u8WOfnNcn5kuPmVwgz8TCGwTgpxt/lAETnR+l71hn+aYRJlBS5e686E
   tFNCB+WXQmcyEMNv7gaHBFca81ECmSQGmExTR/vGQLwyzdexQGubPRYv1
   qsvrD9dboPz5cp2MG4Nax1CCu87hdZ15JswI7P4nBSw4oU2+nRTWiqToa
   0ODDksJvxylnmDjSdjiDZzPJJb8izCN5FU4MZZeB1qK8k+YlibfVaYq3X
   Q==;
X-CSE-ConnectionGUID: 0ruusLfhQo+lMiNIxiy7bw==
X-CSE-MsgGUID: 50eDVVnbSbaE/OAcGFGb9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8246706"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8246706"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:42:04 -0700
X-CSE-ConnectionGUID: WQdZVFjfRzC32G9Te2lM+g==
X-CSE-MsgGUID: t+IJUxbnRCm0Y+F2ErjGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25690968"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO [10.245.244.44]) ([10.245.244.44])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:42:02 -0700
Message-ID: <14259171-58af-4c64-8ed8-e210400d643e@intel.com>
Date: Fri, 12 Apr 2024 15:42:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/xe/vm: prevent UAF with asid based lookup
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20240412113144.259426-4-matthew.auld@intel.com>
 <sm2cs4zyl7yhnumfefky5kg4yatnfhbkoombgcupih6z6v2yos@ckz475ikjc5b>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <sm2cs4zyl7yhnumfefky5kg4yatnfhbkoombgcupih6z6v2yos@ckz475ikjc5b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/04/2024 15:06, Lucas De Marchi wrote:
> On Fri, Apr 12, 2024 at 12:31:45PM +0100, Matthew Auld wrote:
>> The asid is only erased from the xarray when the vm refcount reaches
>> zero, however this leads to potential UAF since the xe_vm_get() only
> 
> I'm not sure I understand the call chain an where xe_vm_get() is coming
> into play here.
> 
> 
>> works on a vm with refcount != 0. Since the asid is allocated in the vm
>> create ioctl, rather erase it when closing the vm, prior to dropping the
>> potential last ref. This should also work when user closes driver fd
>> without explicit vm destroy.
> 
> what seems weird is that you are moving it earlier in the call stack
> rather than later, outside of the worker, to prevent the UAF.
> 
> what exactly was the UAF on?

UAF on the vm object. From the bug report it's when servicing some GPU 
fault, so inside handle_pagefault(). At this stage it just has some asid 
which is meant to map to some vm AFAICT. The lookup dance relies on 
calling xe_vm_get() after getting back the vm pointer from the xarray. 
Currently the asid is only erased from the xarray in 
vm_destroy_work_func() which is long after the refcount reaches zero and 
we are about to free the memory for the vm.

However xe_vm_get() is only meant to be called if you are already 
holding a ref, so if the vm refcount is already zero it just throws an 
error and continues on, and the caller has no idea. If that happens then 
as soon as we drop the usm lock the memory can be freed and it's game 
over. This looks to be what happens with the vm refcount reaching zero, 
and the handle_pagefault() still being able to reach the 
soon-to-be-freed vm via the xarray. With this patch we now erase from 
the xarray before we drop what is potentially the final ref. That way if 
you can reach the vm via the xarray you should always be able get a 
valid ref.

> 
> Lucas De Marchi
> 
>>
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1594
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>> drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++++----------
>> 1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index a196dbe65252..c5c26b3d1b76 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -1581,6 +1581,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
>>         xe->usm.num_vm_in_fault_mode--;
>>     else if (!(vm->flags & XE_VM_FLAG_MIGRATION))
>>         xe->usm.num_vm_in_non_fault_mode--;
>> +
>> +    if (vm->usm.asid) {
>> +        void *lookup;
>> +
>> +        xe_assert(xe, xe->info.has_asid);
>> +        xe_assert(xe, !(vm->flags & XE_VM_FLAG_MIGRATION));
>> +
>> +        lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
>> +        xe_assert(xe, lookup == vm);
>> +    }
>>     mutex_unlock(&xe->usm.lock);
>>
>>     for_each_tile(tile, xe, id)
>> @@ -1596,24 +1606,15 @@ static void vm_destroy_work_func(struct 
>> work_struct *w)
>>     struct xe_device *xe = vm->xe;
>>     struct xe_tile *tile;
>>     u8 id;
>> -    void *lookup;
>>
>>     /* xe_vm_close_and_put was not called? */
>>     xe_assert(xe, !vm->size);
>>
>>     mutex_destroy(&vm->snap_mutex);
>>
>> -    if (!(vm->flags & XE_VM_FLAG_MIGRATION)) {
>> +    if (!(vm->flags & XE_VM_FLAG_MIGRATION))
>>         xe_device_mem_access_put(xe);
>>
>> -        if (xe->info.has_asid && vm->usm.asid) {
>> -            mutex_lock(&xe->usm.lock);
>> -            lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
>> -            xe_assert(xe, lookup == vm);
>> -            mutex_unlock(&xe->usm.lock);
>> -        }
>> -    }
>> -
>>     for_each_tile(tile, xe, id)
>>         XE_WARN_ON(vm->pt_root[id]);
>>
>> -- 
>> 2.44.0
>>

