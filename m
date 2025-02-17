Return-Path: <stable+bounces-116543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9326A37ECF
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC08165EDF
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413AC2153DD;
	Mon, 17 Feb 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbZjjzek"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3721155316
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785112; cv=none; b=iTqP5vZPlZiDgXZVc1IrEOLb7TccMottVPiaZZswanl5Kn0f/r3r+XVU5DTFOIahRtGv0P+QjdrmAwNNNViPJ9776NKGdJIudVVHBQS4tkzxlfSN1Bito/8uCQ9Ygjrfc6F32AyahHNqUrmi/9J5H3p6/a/P9TdUnd+IJwNUiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785112; c=relaxed/simple;
	bh=xH3Hy9dhQ6bLZ5I/SDFGnVKNoil9bC2Prv+SGWvQUR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZEv7ItjLfFROGn0NceNqiVWU4CaVvLijG4SHvj9SfK+zlQu6JcOVuqnpP2W7qWiR6DYc/SLGvhAPjw+vNseQGX8k3P/lZdI7Smo/l+/8nUPId4JXgjCDct4JrkWFvh0EFpVxX0+hxR758lnsmGwY2CzV+/zDMjVveLXDJ0KYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbZjjzek; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739785109; x=1771321109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xH3Hy9dhQ6bLZ5I/SDFGnVKNoil9bC2Prv+SGWvQUR4=;
  b=QbZjjzek1501wnwYEpa0AvQa9Yg9Vz3nxj9fAeFmYn7KOwbRzWSVUc46
   garkdNRRKda1lKgGnZV0/4Qo0ZqVKcJsbdR8WIX52B/29uG0B6BdRNmG7
   NGxkSnLOMl5tMOzZ0YiuDdshFRmQMdINQ1P0/onHDSwz9gMu8WQ5FHZMV
   M77DEACNC/v8qDBrcA+LTOiSjyXtGl6FzAB1U7CAWg+SHKcbessjNQNQX
   C9sjOFG4N6szifkgd9QcJOElwjowqGIYJowX1/1l+iQN8+LRqIl6PpmEd
   mdxoj/Sn3oA/oo12xSnHNTMS3OWkClwPVfp1HZZ3LTMsFOiLUfszmlyNM
   g==;
X-CSE-ConnectionGUID: Urk2//JPRe+sVAqQumtZHA==
X-CSE-MsgGUID: kXhBVf3rRkmZ2OBM0/sVNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="39648216"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="39648216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:38:29 -0800
X-CSE-ConnectionGUID: uXo9fve3QeKgAjAFvN0Akw==
X-CSE-MsgGUID: vFV/FOu/SjGBdlMfCgFiNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114048859"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.174]) ([10.245.244.174])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:38:28 -0800
Message-ID: <6fec16d5-cbf3-448b-9c07-85a079095f62@intel.com>
Date: Mon, 17 Feb 2025 09:38:26 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/xe/userptr: restore invalidation list on error
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 stable@vger.kernel.org
References: <20250214170527.272182-4-matthew.auld@intel.com>
 <Z6/ttCTrEuwNsD6w@lstrano-desk.jf.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <Z6/ttCTrEuwNsD6w@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/02/2025 01:28, Matthew Brost wrote:
> On Fri, Feb 14, 2025 at 05:05:28PM +0000, Matthew Auld wrote:
>> On error restore anything still on the pin_list back to the invalidation
>> list on error. For the actual pin, so long as the vma is tracked on
>> either list it should get picked up on the next pin, however it looks
>> possible for the vma to get nuked but still be present on this per vm
>> pin_list leading to corruption. An alternative might be then to instead
>> just remove the link when destroying the vma.
>>
>> Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>   drivers/gpu/drm/xe/xe_vm.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index d664f2e418b2..668b0bde7822 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -670,12 +670,12 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>>   	list_for_each_entry_safe(uvma, next, &vm->userptr.invalidated,
>>   				 userptr.invalidate_link) {
>>   		list_del_init(&uvma->userptr.invalidate_link);
>> -		list_move_tail(&uvma->userptr.repin_link,
>> -			       &vm->userptr.repin_list);
>> +		list_add_tail(&uvma->userptr.repin_link,
>> +			      &vm->userptr.repin_list);
> 
> Why this change?

Just that with this patch the repin_link should now always be empty at 
this point, I think. add should complain if that is not the case.

> 
>>   	}
>>   	spin_unlock(&vm->userptr.invalidated_lock);
>>   
>> -	/* Pin and move to temporary list */
>> +	/* Pin and move to bind list */
>>   	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
>>   				 userptr.repin_link) {
>>   		err = xe_vma_userptr_pin_pages(uvma);
>> @@ -691,10 +691,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>>   			err = xe_vm_invalidate_vma(&uvma->vma);
>>   			xe_vm_unlock(vm);
>>   			if (err)
>> -				return err;
>> +				break;
>>   		} else {
>> -			if (err < 0)
>> -				return err;
>> +			if (err)
>> +				break;
>>   
>>   			list_del_init(&uvma->userptr.repin_link);
>>   			list_move_tail(&uvma->vma.combined_links.rebind,
>> @@ -702,7 +702,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>>   		}
>>   	}
>>   
>> -	return 0;
>> +	if (err) {
>> +		down_write(&vm->userptr.notifier_lock);
> 
> Can you explain why you take the notifier lock here? I don't think this
> required unless I'm missing something.

For the invalidated list, the docs say:

"Removing items from the list additionally requires @lock in write mode, 
and adding items to the list requires the @userptr.notifer_lock in write 
mode."

Not sure if the docs needs to be updated here?

> 
> Matt
> 
>> +		spin_lock(&vm->userptr.invalidated_lock);
>> +		list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
>> +					 userptr.repin_link) {
>> +			list_del_init(&uvma->userptr.repin_link);
>> +			list_move_tail(&uvma->userptr.invalidate_link,
>> +				       &vm->userptr.invalidated);
>> +		}
>> +		spin_unlock(&vm->userptr.invalidated_lock);
>> +		up_write(&vm->userptr.notifier_lock);
>> +	}
>> +	return err;
>>   }
>>   
>>   /**
>> -- 
>> 2.48.1
>>


