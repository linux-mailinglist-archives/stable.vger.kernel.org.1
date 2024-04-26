Return-Path: <stable+bounces-41497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A68B31B7
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 09:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2305BB2180D
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467313C66E;
	Fri, 26 Apr 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uk0+DRHt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3813A271
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118090; cv=none; b=jBpmm6PqEpWaBTwGoVzLrCPzk0mveDNfs8r7ekzS7AGQNcA0v2HV12nXLu3FPRCJukSAcPojq8r1Yk6gRdcqnaCT5yhksM7G1r3BzKThvaplaNMJarko6dGCpLEfQub9wEX1VrYSwXjz3HFbIdRr5jefVR8APc43bt/lhXnrX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118090; c=relaxed/simple;
	bh=DvaD7yH2p98w1uzgFXVKLv/Z2xerWWbHCkSviowNIvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5ZJm/2vps6vFk57XQqFREWfCYRZbo0+G+RNI1TPpNAE01+aphBL0UVcJI4a54Mu0vmOb1rg/zJ3vu/7rC838XtlpQl51l2U8/nkqArevvv0zFo/0Hoag9VTh3XmoHoVtbwBZEckhXvEDnbOiSJ417EgaFiX2RsDY8q4T3W9HfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uk0+DRHt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714118088; x=1745654088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DvaD7yH2p98w1uzgFXVKLv/Z2xerWWbHCkSviowNIvE=;
  b=Uk0+DRHtuONzWyhWRBhRf8DHvtQzDlhtXqw+RcQ5eVg+tlqS0WaI9KVB
   iMCugOcETqhpYnT5iou5MxAanccgYQSLW58RRAi95KNJA/ydptKSMUk1H
   GApLsfrg1kq+u0tflRtj6m99Ku+jp4+Z2/7ZCrnee4T0aBWFjPJbeZS4f
   jppz3FzHdrsbRrmN9mM8NYODDX/3RhxQEQxiKmiuagH5/bzIxsv88YJHG
   MHbKpU1157BjRTUhgM7mAdypEg+ATZqd0CBi53D5eUcz9sh2VEoOsQMRD
   RpsHudoMrF8l+Xnw6gsGYXsXPNd6ZfR6zRHIYXaQHijvCou083oJ2Ud7e
   g==;
X-CSE-ConnectionGUID: RhXgfabvT/+jvcGfq6ZJdg==
X-CSE-MsgGUID: KeQh4X+HTdu1/NIdaQn4qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10060530"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="10060530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 00:54:47 -0700
X-CSE-ConnectionGUID: lMOciEhxQVyS+1qATcUIXg==
X-CSE-MsgGUID: 7t+/lZjfSwGVxUAuWGW5HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="56517745"
Received: from unknown (HELO [10.245.244.184]) ([10.245.244.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 00:54:46 -0700
Message-ID: <d963ebff-6e27-458b-ae40-b226ca1f0dfc@intel.com>
Date: Fri, 26 Apr 2024 08:54:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] drm/xe/vm: prevent UAF with asid based
 lookup" failed to apply to 6.8-stable tree
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: matthew.brost@intel.com, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <2024042358-esteemed-fastball-c2d8@gregkh>
 <77xckfvuyzqksdfpbkxxegire3wipk77fylewqffs2bhkyyah2@nrcdumadjsfw>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <77xckfvuyzqksdfpbkxxegire3wipk77fylewqffs2bhkyyah2@nrcdumadjsfw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/04/2024 20:03, Lucas De Marchi wrote:
> On Tue, Apr 23, 2024 at 06:07:58AM GMT, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.8-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following 
>> commands:
>>
>> git fetch 
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ 
>> linux-6.8.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x ca7c52ac7ad384bcf299d89482c45fec7cd00da9
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to 
>> '2024042358-esteemed-fastball-c2d8@gregkh' --subject-prefix 'PATCH 
>> 6.8.y' HEAD^..
>>
>> Possible dependencies:
>>
>> ca7c52ac7ad3 ("drm/xe/vm: prevent UAF with asid based lookup")
>> 0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and 
>> userptr")
>> be7d51c5b468 ("drm/xe: Add batch buffer addresses to devcoredump")
>> 4376cee62092 ("drm/xe: Print more device information in devcoredump")
>> 98fefec8c381 ("drm/xe: Change devcoredump functions parameters to 
>> xe_sched_job")
> 
> Matt Auld, were we too aggressive saying this should be ported back to
> 6.8?  There's no platform in 6.8 with usm, so maybe we don't really need
> it there.  I don't think we want to bring any of the commits mentioned
> above back to 6.8 really.  If we need this change here, can you prepare
> a modified version with the conflicts resolved for 6.8?

I think it's fine to drop if there is indeed nothing in 6.8 that 
supports usm.

> 
> thanks
> Lucas De Marchi
> 
>>
>> thanks,
>>
>> greg k-h
>>
>> ------------------ original commit in Linus's tree ------------------
>>
>> From ca7c52ac7ad384bcf299d89482c45fec7cd00da9 Mon Sep 17 00:00:00 2001
>> From: Matthew Auld <matthew.auld@intel.com>
>> Date: Fri, 12 Apr 2024 12:31:45 +0100
>> Subject: [PATCH] drm/xe/vm: prevent UAF with asid based lookup
>>
>> The asid is only erased from the xarray when the vm refcount reaches
>> zero, however this leads to potential UAF since the xe_vm_get() only
>> works on a vm with refcount != 0. Since the asid is allocated in the vm
>> create ioctl, rather erase it when closing the vm, prior to dropping the
>> potential last ref. This should also work when user closes driver fd
>> without explicit vm destroy.
>>
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1594
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> Link: 
>> https://patchwork.freedesktop.org/patch/msgid/20240412113144.259426-4-matthew.auld@intel.com
>> (cherry picked from commit 83967c57320d0d01ae512f10e79213f81e4bf594)
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 62d1ef8867a8..3d4c8f342e21 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -1577,6 +1577,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
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
>> @@ -1592,24 +1602,15 @@ static void vm_destroy_work_func(struct 
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
>>

