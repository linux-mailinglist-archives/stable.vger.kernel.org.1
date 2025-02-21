Return-Path: <stable+bounces-118578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC9A3F5C6
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF44019E158C
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614992B9BC;
	Fri, 21 Feb 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljKixekd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631320E024
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143869; cv=none; b=eTZK/4jgMpK6XKpuKpfSYOpjZCeWG+X8z/QJPWkFXCkIc8qQTi9DI5wkEJ9TomVYGLHPnt/S3mqY3zE213s65QXGLhlIGRus2k8nFdKUg5dFzgFNJOBBmEJXwrjd6dd3FrPIqzcN8JibeCEiJgP4WhPK36we/RG7nKtMk+s6zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143869; c=relaxed/simple;
	bh=xnUqeIWCrmg8DU9rq/e1dKU0Pq5M/RjNk7iPdkVfGYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eb21Z/nLOsEAF602C8UcoRL1d0L1wp8yMR5jOHgnZCMVuGt3nolQwRup32v9Q1H7zXDyfBDtkYRUAp4JkmDUoVdTd0mIkcRY7n8ETdd2C72nMIbORrkmuUJvV4CZny6T61mNeqUiOompnZmqa1WVbdDVe6MF6/K024qCtqxP4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljKixekd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740143867; x=1771679867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xnUqeIWCrmg8DU9rq/e1dKU0Pq5M/RjNk7iPdkVfGYU=;
  b=ljKixekdILn+pqWrpjyAHZyTqFbvjjPtK1+zwBZC6Sw3X3gfPopLVCWp
   3+xrKoJu5LXA2eaToSOWgbe7IyL9W12FIWoJnK1Sn/IEe9/MzcsFI+vDi
   Gy3skFRMlTbQL/l5nkNkhWkXa8t5bCa9MxeEMcXTdZeZ+PT162vZOuvTq
   OneF9nzsOGSihb4/MpRz2MmBhgWAEyhk/q6Fdti0UVinBnUmgJyQSWAUh
   KNLQUjQ+s9PjKxzHoTh/KBM3OArWDfEOIuOSC08VWQo12lO2EJFgGiJQn
   SYQ/zh+9qzrRD7+Wx5D0EiQsFX2UgdB7j6asA1/+2lhm2xRcFJvcaI9ku
   g==;
X-CSE-ConnectionGUID: LIGK3NEaR8GnVy/QJZgriw==
X-CSE-MsgGUID: /Sgxd0rFS2aspW+17EaRdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40976771"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40976771"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:17:46 -0800
X-CSE-ConnectionGUID: 6STKgVxbR8y/dPo+6jbmHw==
X-CSE-MsgGUID: csJD0VCMSounkNUFM75AcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="146229392"
Received: from sosterlu-desk.ger.corp.intel.com (HELO [10.245.245.44]) ([10.245.245.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:17:45 -0800
Message-ID: <f2c9136f-ecb4-4b60-92f5-6938ec242c2e@intel.com>
Date: Fri, 21 Feb 2025 13:17:43 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/xe/userptr: restore invalidation list on error
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
References: <20250214170527.272182-4-matthew.auld@intel.com>
 <Z6/ttCTrEuwNsD6w@lstrano-desk.jf.intel.com>
 <6fec16d5-cbf3-448b-9c07-85a079095f62@intel.com>
 <Z7QFUy9ZyBRhPwuY@lstrano-desk.jf.intel.com>
 <Z7fAIjU/3wW8eMQL@lstrano-desk.jf.intel.com>
 <cfbcea7a-bcba-4e7a-9b63-398a48da789d@intel.com>
 <a6ac4585efaabc710c377b786d042177e0df48ad.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <a6ac4585efaabc710c377b786d042177e0df48ad.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2025 11:20, Thomas Hellström wrote:
> On Fri, 2025-02-21 at 11:11 +0000, Matthew Auld wrote:
>> On 20/02/2025 23:52, Matthew Brost wrote:
>>> On Mon, Feb 17, 2025 at 07:58:11PM -0800, Matthew Brost wrote:
>>>> On Mon, Feb 17, 2025 at 09:38:26AM +0000, Matthew Auld wrote:
>>>>> On 15/02/2025 01:28, Matthew Brost wrote:
>>>>>> On Fri, Feb 14, 2025 at 05:05:28PM +0000, Matthew Auld wrote:
>>>>>>> On error restore anything still on the pin_list back to the
>>>>>>> invalidation
>>>>>>> list on error. For the actual pin, so long as the vma is
>>>>>>> tracked on
>>>>>>> either list it should get picked up on the next pin,
>>>>>>> however it looks
>>>>>>> possible for the vma to get nuked but still be present on
>>>>>>> this per vm
>>>>>>> pin_list leading to corruption. An alternative might be
>>>>>>> then to instead
>>>>>>> just remove the link when destroying the vma.
>>>>>>>
>>>>>>> Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
>>>>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>>> Cc: <stable@vger.kernel.org> # v6.8+
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/xe/xe_vm.c | 26 +++++++++++++++++++-----
>>>>>>> --
>>>>>>>     1 file changed, 19 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_vm.c
>>>>>>> b/drivers/gpu/drm/xe/xe_vm.c
>>>>>>> index d664f2e418b2..668b0bde7822 100644
>>>>>>> --- a/drivers/gpu/drm/xe/xe_vm.c
>>>>>>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>>>>>>> @@ -670,12 +670,12 @@ int xe_vm_userptr_pin(struct xe_vm
>>>>>>> *vm)
>>>>>>>     	list_for_each_entry_safe(uvma, next, &vm-
>>>>>>>> userptr.invalidated,
>>>>>>>     				 userptr.invalidate_link)
>>>>>>> {
>>>>>>>     		list_del_init(&uvma-
>>>>>>>> userptr.invalidate_link);
>>>>>>> -		list_move_tail(&uvma->userptr.repin_link,
>>>>>>> -			       &vm->userptr.repin_list);
>>>>>>> +		list_add_tail(&uvma->userptr.repin_link,
>>>>>>> +			      &vm->userptr.repin_list);
>>>>>>
>>>>>> Why this change?
>>>>>
>>>>> Just that with this patch the repin_link should now always be
>>>>> empty at this
>>>>> point, I think. add should complain if that is not the case.
>>>>>
>>>>
>>>> If it is always expected to be empty, then yea maybe add a
>>>> xe_assert for
>>>> this as the list management is pretty tricky.
>>>>
>>>>>>
>>>>>>>     	}
>>>>>>>     	spin_unlock(&vm->userptr.invalidated_lock);
>>>>>>> -	/* Pin and move to temporary list */
>>>>>>> +	/* Pin and move to bind list */
>>>>>>>     	list_for_each_entry_safe(uvma, next, &vm-
>>>>>>>> userptr.repin_list,
>>>>>>>     				 userptr.repin_link) {
>>>>>>>     		err = xe_vma_userptr_pin_pages(uvma);
>>>>>>> @@ -691,10 +691,10 @@ int xe_vm_userptr_pin(struct xe_vm
>>>>>>> *vm)
>>>>>>>     			err = xe_vm_invalidate_vma(&uvma-
>>>>>>>> vma);
>>>>>>>     			xe_vm_unlock(vm);
>>>>>>>     			if (err)
>>>>>>> -				return err;
>>>>>>> +				break;
>>>>>>>     		} else {
>>>>>>> -			if (err < 0)
>>>>>>> -				return err;
>>>>>>> +			if (err)
>>>>>>> +				break;
>>>>>>>     			list_del_init(&uvma-
>>>>>>>> userptr.repin_link);
>>>>>>>     			list_move_tail(&uvma-
>>>>>>>> vma.combined_links.rebind,
>>>>>>> @@ -702,7 +702,19 @@ int xe_vm_userptr_pin(struct xe_vm
>>>>>>> *vm)
>>>>>>>     		}
>>>>>>>     	}
>>>>>>> -	return 0;
>>>>>>> +	if (err) {
>>>>>>> +		down_write(&vm->userptr.notifier_lock);
>>>>>>
>>>>>> Can you explain why you take the notifier lock here? I don't
>>>>>> think this
>>>>>> required unless I'm missing something.
>>>>>
>>>>> For the invalidated list, the docs say:
>>>>>
>>>>> "Removing items from the list additionally requires @lock in
>>>>> write mode, and
>>>>> adding items to the list requires the @userptr.notifer_lock in
>>>>> write mode."
>>>>>
>>>>> Not sure if the docs needs to be updated here?
>>>>>
>>>>
>>>> Oh. I believe the part of comment for 'adding items to the list
>>>> requires the @userptr.notifer_lock in write mode' really means
>>>> something
>>>> like this:
>>>>
>>>> 'When adding to @vm->userptr.invalidated in the notifier the
>>>> @userptr.notifer_lock in write mode protects against concurrent
>>>> VM binds
>>>> from setting up newly invalidated pages.'
>>>>
>>>> So with above and since this code path is in the VM bind path
>>>> (i.e. we
>>>> are not racing with other binds) I think the
>>>> vm->userptr.invalidated_lock is sufficient. Maybe ask Thomas if
>>>> he
>>>> agrees here.
>>>>
>>>
>>> After some discussion with Thomas, removing notifier lock here is
>>> safe.
>>
>> Thanks for confirming.
> 
> So basically that was to protect exec when it takes the notifier lock
> in read mode, and checks that there are no invalidated userptr, that
> needs to stay true as lock as the notifier lock is held.
> 
> But as MBrost pointed out, the vm lock is also held, so I think the
> kerneldoc should be updated so that the requirement is that either the
> notifier lock is held in write mode, or the vm lock in write mode.
> 
> As a general comment these locking protection docs are there to
> simplify reading and writing of the code so that when new code is
> written and reviewed, we should just keep to the rules to avoid
> auditing all locations in the driver where the protected data-structure
> is touched. If we want to update those docs I think a complete such
> audit needs to be done and all use-cases are understood.

For this patch is the preference to go with the slightly overzealous 
locking for now? Circling back around later, fixing the doc when adding 
the new helper, and at the same time also audit all callers?

> 
> /Thomas
> 
> 
>>
>>>
>>> However, for adding is either userptr.notifer_lock || vm->lock to
>>> also
>>> avoid races between binds, execs, and rebind worker.
>>>
>>> I'd like update the documentation and add a helper like this:
>>>
>>> void xe_vma_userptr_add_invalidated(struct xe_userptr_vma *uvma)
>>> {
>>>          struct xe_vm *vm = xe_vma_vm(&uvma->vma);
>>>
>>>          lockdep_assert(lock_is_held_type(&vm->lock.dep_map, 1) ||
>>>                         lock_is_held_type(&vm-
>>>> userptr.notifier_lock.dep_map, 1));
>>>
>>>          spin_lock(&vm->userptr.invalidated_lock);
>>>          list_move_tail(&uvma->userptr.invalidate_link,
>>>                         &vm->userptr.invalidated);
>>>          spin_unlock(&vm->userptr.invalidated_lock);
>>> }
>>
>> Sounds good.
>>
>>>
>>> However, let's delay the helper until this series and recently post
>>> series of mine [1] merge as both are fixes series and hoping for a
>>> clean
>>> backport.
>>
>> Makes sense.
>>
>>>
>>> Matt
>>>
>>> [1] https://patchwork.freedesktop.org/series/145198/
>>>
>>>> Matt
>>>>
>>>>>>
>>>>>> Matt
>>>>>>
>>>>>>> +		spin_lock(&vm->userptr.invalidated_lock);
>>>>>>> +		list_for_each_entry_safe(uvma, next, &vm-
>>>>>>>> userptr.repin_list,
>>>>>>> +					
>>>>>>> userptr.repin_link) {
>>>>>>> +			list_del_init(&uvma-
>>>>>>>> userptr.repin_link);
>>>>>>> +			list_move_tail(&uvma-
>>>>>>>> userptr.invalidate_link,
>>>>>>> +				       &vm-
>>>>>>>> userptr.invalidated);
>>>>>>> +		}
>>>>>>> +		spin_unlock(&vm-
>>>>>>>> userptr.invalidated_lock);
>>>>>>> +		up_write(&vm->userptr.notifier_lock);
>>>>>>> +	}
>>>>>>> +	return err;
>>>>>>>     }
>>>>>>>     /**
>>>>>>> -- 
>>>>>>> 2.48.1
>>>>>>>
>>>>>
>>
> 


