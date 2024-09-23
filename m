Return-Path: <stable+bounces-76888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE497E7E9
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D731C21358
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDE19414A;
	Mon, 23 Sep 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqMe3e6p"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600619343E
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081490; cv=none; b=uKU3jGqrrVyRcTtgJcs5XuhNs8l6V2tNKizVTU89uJYrUnBLGM+/HZ0oNHrBzJHEIddJ4+rDBMNSRLi69/EGv8h9rIFRBHVnJZtjt2ZGYRF+LUreF3F3/pyp/r2VnSsTnSQeglncAE9ucM/CxkWQQ/vZdONwx2iRGikBSvaNYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081490; c=relaxed/simple;
	bh=1y0T64dN966SFYT2yMo3eGD7BjZhc0Llgc4Upvk8Iwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGLegAI0vP7gpBZuTmyb4rA2UdX0n6LGuGZiHl9iN2ezKPFQd+yPGP/MPJERUJtcy6riwj9tODk7HxMrLO+u72hzRXoueB2Ezzrhi9WNCAOX8RUB/4MN2wRDjFl4odr5TbAtSXDkVxcmZBxCjhX9pwbTnHZNoiJV1DDhi5/Cbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqMe3e6p; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727081487; x=1758617487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1y0T64dN966SFYT2yMo3eGD7BjZhc0Llgc4Upvk8Iwo=;
  b=AqMe3e6p07MTuo8nwA8mBDn0mibAJ+gMHfMIUREmokcqAqh3uQKjkaXF
   GV8pImEz7xp8N4omIwd72KMEPzIb/Q0VdF+Pzi6fNif5umVBc3wSqT3VV
   OIJXyh21/yikHi4QpTcyB3Jc0Lo1DT3lJHscDi/RKB6whhi3Pa/TK2mMb
   1rQqmz3l+YhkPnpKa+urUGD/RA6M8xsbLibInDC1GQVXPMpB8LViwPTcE
   7yKHnkJtcTBK1gFDRLiQ3vC9/vq1JUXZ7ZFQP5CCPkjCV5e7OHJyB4o8i
   2FfUm0Lu4mdD86Tt/iW494UG3RkogeqdlfWHfUiPD0libS3uEOK8/AZ5e
   A==;
X-CSE-ConnectionGUID: igmMbONEQQ2wDqe9/gdJjg==
X-CSE-MsgGUID: GUHyLnuqQp2rDJG2Te2gEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29907111"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="29907111"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:51:27 -0700
X-CSE-ConnectionGUID: Ei0xYsHcT+qwvHUxsbR7PA==
X-CSE-MsgGUID: /T0AvtneTHeRLlQOtCL9Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="70588906"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.234]) ([10.245.245.234])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:51:26 -0700
Message-ID: <69bdc97f-d64e-4bd9-b56f-60c0d43fb2d5@intel.com>
Date: Mon, 23 Sep 2024 09:51:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: fix UAF around queue destruction
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
References: <20240920172559.208358-2-matthew.auld@intel.com>
 <Zu3MnI2HRDwAAVWS@DUT025-TGLU.fm.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <Zu3MnI2HRDwAAVWS@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2024 20:27, Matthew Brost wrote:
> On Fri, Sep 20, 2024 at 06:26:00PM +0100, Matthew Auld wrote:
>> We currently do stuff like queuing the final destruction step on a
>> random system wq, which will outlive the driver instance. With bad
> 
> I understand that job destruction is async but I thought our ref
> counting made this safe. I suppose we don't ref count the device which
> is likely a problem.

Yeah, there is no refcounting on the drm device. That looked the 
simplest however it would mean module unload would sometimes randomly 
fail, even though all clients are closed, so figured we need some kind 
of flush.

> 
>> timing we can teardown the driver with one or more work workqueue still
>> being alive leading to various UAF splats. Add a fini step to ensure
>> user queues are properly torn down. At this point GuC should already be
>> nuked so queue itself should no longer be referenced from hw pov.
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2317
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>   drivers/gpu/drm/xe/xe_device.c       |  6 +++++-
>>   drivers/gpu/drm/xe/xe_device_types.h |  3 +++
>>   drivers/gpu/drm/xe/xe_guc_submit.c   | 32 +++++++++++++++++++++++++++-
>>   3 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>> index cb5a9fd820cf..90b3478ed7cd 100644
>> --- a/drivers/gpu/drm/xe/xe_device.c
>> +++ b/drivers/gpu/drm/xe/xe_device.c
>> @@ -297,6 +297,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>>   	if (xe->unordered_wq)
>>   		destroy_workqueue(xe->unordered_wq);
>>   
>> +	if (xe->destroy_wq)
>> +		destroy_workqueue(xe->destroy_wq);
>> +
>>   	ttm_device_fini(&xe->ttm);
>>   }
>>   
>> @@ -360,8 +363,9 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
>>   	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq", 0);
>>   	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
>>   	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", 0, 0);
>> +	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", 0, 0);
>>   	if (!xe->ordered_wq || !xe->unordered_wq ||
>> -	    !xe->preempt_fence_wq) {
>> +	    !xe->preempt_fence_wq || !xe->destroy_wq) {
>>   		/*
>>   		 * Cleanup done in xe_device_destroy via
>>   		 * drmm_add_action_or_reset register above
>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>> index 5ad96d283a71..515385b916cc 100644
>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>> @@ -422,6 +422,9 @@ struct xe_device {
>>   	/** @unordered_wq: used to serialize unordered work, mostly display */
>>   	struct workqueue_struct *unordered_wq;
>>   
>> +	/** @destroy_wq: used to serialize user destroy work, like queue */
>> +	struct workqueue_struct *destroy_wq;
>> +
>>   	/** @tiles: device tiles */
>>   	struct xe_tile tiles[XE_MAX_TILES_PER_DEVICE];
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>> index fbbe6a487bbb..66441efa0bcd 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>> @@ -276,10 +276,37 @@ static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
>>   }
>>   #endif
>>   
>> +static void guc_exec_queue_fini_async(struct xe_exec_queue *q);
>> +
>> +static void xe_guc_submit_fini(struct xe_guc *guc)
>> +{
>> +	struct xe_device *xe = guc_to_xe(guc);
>> +	struct xe_exec_queue *q;
>> +	unsigned long index;
>> +
>> +	mutex_lock(&guc->submission_state.lock);
>> +	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q) {
>> +		struct xe_gpu_scheduler *sched = &q->guc->sched;
>> +
>> +		xe_assert(xe, !kref_read(&q->refcount));
>> +
>> +		xe_sched_submission_stop(sched);
>> +
>> +		if (exec_queue_registered(q) && !exec_queue_wedged(q))
>> +			guc_exec_queue_fini_async(q);
> 
> I don't think this is safe. Jobs ref count the 'q' and if those are
> flushing out in the scheduler that seems like it could be problem is the
> free of queue happens while jobs are still around. At this point all
> queues should have 'kill' called on them and are naturally cleaning
> themselves up.
> 
> Can we just wait for 'xa_empty(&guc->submission_state.exec_queue_lookup)'
> and then call 'drain_workqueue(xe->destroy_wq)'? The wait could be
> implemented via a simple wait queue. Would that work? Seems safer.

Ok, and I guess with some kind of timeout. Let me try that. Thanks for 
taking a look.

> 
> Matt
> 
>> +	}
>> +	mutex_unlock(&guc->submission_state.lock);
>> +
>> +	drain_workqueue(xe->destroy_wq);
>> +
>> +	xe_assert(xe, xa_empty(&guc->submission_state.exec_queue_lookup));
>> +}
>> +
>>   static void guc_submit_fini(struct drm_device *drm, void *arg)
>>   {
>>   	struct xe_guc *guc = arg;
>>   
>> +	xe_guc_submit_fini(guc);
>>   	xa_destroy(&guc->submission_state.exec_queue_lookup);
>>   	free_submit_wq(guc);
>>   }
>> @@ -1268,13 +1295,16 @@ static void __guc_exec_queue_fini_async(struct work_struct *w)
>>   
>>   static void guc_exec_queue_fini_async(struct xe_exec_queue *q)
>>   {
>> +	struct xe_guc *guc = exec_queue_to_guc(q);
>> +	struct xe_device *xe = guc_to_xe(guc);
>> +
>>   	INIT_WORK(&q->guc->fini_async, __guc_exec_queue_fini_async);
>>   
>>   	/* We must block on kernel engines so slabs are empty on driver unload */
>>   	if (q->flags & EXEC_QUEUE_FLAG_PERMANENT || exec_queue_wedged(q))
>>   		__guc_exec_queue_fini_async(&q->guc->fini_async);
>>   	else
>> -		queue_work(system_wq, &q->guc->fini_async);
>> +		queue_work(xe->destroy_wq, &q->guc->fini_async);
>>   }
>>   
>>   static void __guc_exec_queue_fini(struct xe_guc *guc, struct xe_exec_queue *q)
>> -- 
>> 2.46.0
>>

