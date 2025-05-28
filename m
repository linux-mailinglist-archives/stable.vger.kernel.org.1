Return-Path: <stable+bounces-147967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39FAC6BA8
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3803A7059
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9E28853E;
	Wed, 28 May 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTZeEBk1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2D82C60
	for <stable@vger.kernel.org>; Wed, 28 May 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442563; cv=none; b=LefajKBrbAYopFPYkQ7sbVlG0kQKWzUQw2lYLAskeutvB+Z6B8InxdV+27kdu2IpvhyL101dRFfQmPrwgo9de0ypGw/CTqtHM6Qy+ljuM2Ws9HBwoBrKa5fECaR7Ws8/j5Mw775+hv44QEbGUOZDZsYApvjGBV9lb64SeZTiab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442563; c=relaxed/simple;
	bh=e0S/gTOMg//Eq1SFXZ62YBZvCb8TAry7mGzzJKE2JWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6ckjVpXa8ih/OE/9tZcSljLCQN2kG+/UYGlHDE6MALR3nSLwUcQlmAg29KgZ20z6lWNMA6jkriorDvghmX+CAUUhMATyngTiRaMcuce0a15zNuFcAJh3Liv/0IbOl/9DxHdBaYAErrvj0DxstcA0BQYIBTJByaevGgWBZ5kOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTZeEBk1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748442562; x=1779978562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e0S/gTOMg//Eq1SFXZ62YBZvCb8TAry7mGzzJKE2JWI=;
  b=iTZeEBk1YFRo5EpRPbns4501Mhp34m8kfUxZH7gg+o58LPmcvNYbVHKo
   j9yqckFaiKfLGVTWjkiS4Yop134C6bQDDFDz0QeyRJ6/Duz7YDXX47rBL
   NxXRwDhXWLBuOooeqbFHJTMZs8j8MBxpjpnzaBmZR8F8/DKrKsBwx3lJl
   boUf+VmgcIaz7Oxnq25Z7cGtBIQi+w6AWh8ZVPoz3IkS0u5wcwfPTOi8Y
   lVP5LcxziTWjFKkPRG/W/Y0QIH6sI/clUH0r9KTIZpQZYdZACtIhO1vXx
   BchTR4Lfo9vcRTdJbmEMt/jvnVeNC0u6I9ZxkZnYQw+hZWqmW+xq+6XDQ
   w==;
X-CSE-ConnectionGUID: 3D4ZDEu5QPuTTMc0Q8deAg==
X-CSE-MsgGUID: WVLv0dEGQHGmebiqsUd/+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67886798"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="67886798"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:29:21 -0700
X-CSE-ConnectionGUID: 1MKYeqnOQMKaoQYk/cyjwA==
X-CSE-MsgGUID: uOZky1GESH+5WiIbLfl6gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148116675"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.144]) ([10.245.245.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:29:19 -0700
Message-ID: <aabaf5db-92aa-4ec9-b0a8-6eb9694fa7c7@intel.com>
Date: Wed, 28 May 2025 15:29:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "Tseng, William" <william.tseng@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250528113328.289392-2-matthew.auld@intel.com>
 <SJ1PR11MB6204E84396E9C554AE7E80328167A@SJ1PR11MB6204.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <SJ1PR11MB6204E84396E9C554AE7E80328167A@SJ1PR11MB6204.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2025 14:06, Upadhyay, Tejas wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
>> Matthew Auld
>> Sent: 28 May 2025 17:03
>> To: intel-xe@lists.freedesktop.org
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>; Brost, Matthew
>> <matthew.brost@intel.com>; Tseng, William <william.tseng@intel.com>;
>> stable@vger.kernel.org
>> Subject: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
>>
>> Customer is reporting a really subtle issue where we get random DMAR faults,
>> hangs and other nasties for kernel migration jobs when stressing stuff like
>> s2idle/s3/s4. The explosions seems to happen somewhere after resuming the
>> system with splats looking something like:
>>
>> PM: suspend exit
>> rfkill: input handler disabled
>> xe 0000:00:02.0: [drm] GT0: Engine reset: engine_class=bcs, logical_mask:
>> 0x2, guc_id=0 xe 0000:00:02.0: [drm] GT0: Timedout job: seqno=24496,
>> lrc_seqno=24496, guc_id=0, flags=0x13 in no process [-1] xe 0000:00:02.0:
>> [drm] GT0: Kernel-submitted job timed out
>>
>> The likely cause appears to be a race between suspend cancelling the worker
>> that processes the free_job()'s, such that we still have pending jobs to be
>> freed after the cancel. Following from this, on resume the pending_list will
>> now contain at least one already complete job, but it looks like we call
>> drm_sched_resubmit_jobs(), which will then call
>> run_job() on everything still on the pending_list. But if the job was already
>> complete, then all the resources tied to the job, like the bb itself, any memory
>> that is being accessed, the iommu mappings etc. might be long gone since
>> those are usually tied to the fence signalling.
>>
>> This scenario can be seen in ftrace when running a slightly modified xe_pm
>> (kernel was only modified to inject artificial latency into free_job to make the
>> race easier to hit):
>>
>> xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0,
>> lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
>> xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0,
>> guc_state=0x0, flags=0x13
>> xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=1,
>> guc_state=0x0, flags=0x4
>> xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=0,
>> guc_state=0x0, flags=0x3
>> xe_exec_queue_stop:   dev=0000:00:02.0, 1:0x1, gt=1, width=1, guc_id=1,
>> guc_state=0x0, flags=0x3
>> xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=2,
>> guc_state=0x0, flags=0x3
>> xe_exec_queue_resubmit: dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0,
>> guc_state=0x0, flags=0x13
>> xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0,
>> lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
>> .....
>> xe_exec_queue_memory_cat_error: dev=0000:00:02.0, 3:0x2, gt=0, width=1,
>> guc_id=0, guc_state=0x3, flags=0x13
>>
>> So the job_run() is clearly triggered twice for the same job, even though the
>> first must have already signalled to completion during suspend. We can also
>> see a CAT error after the re-submit.
>>
>> To prevent this try to call xe_sched_stop() to forcefully remove anything on
>> the pending_list that has already signalled, before we re-submit.
>>
>> v2:
>>    - Make sure to re-arm the fence callbacks with sched_start().
>> v3 (Matt B):
>>    - Stop using drm_sched_resubmit_jobs(), which appears to be deprecated
>>      and just open-code a simple loop such that we skip calling run_job()
>>      and anything already signalled.
>>
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4856
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: William Tseng <william.tseng@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>   drivers/gpu/drm/xe/xe_gpu_scheduler.h | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
>> b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
>> index c250ea773491..308061f0cf37 100644
>> --- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
>> +++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
>> @@ -51,7 +51,15 @@ static inline void xe_sched_tdr_queue_imm(struct
>> xe_gpu_scheduler *sched)
>>
>>   static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)  {
>> -	drm_sched_resubmit_jobs(&sched->base);
>> +	struct drm_sched_job *s_job;
>> +
>> +	list_for_each_entry(s_job, &sched->base.pending_list, list) {
>> +		struct drm_sched_fence *s_fence = s_job->s_fence;
>> +		struct dma_fence *hw_fence = s_fence->parent;
>> +
>> +		if (hw_fence && !dma_fence_is_signaled(hw_fence))
>> +			sched->base.ops->run_job(s_job);
>> +	}
> 
> While this change looks correct, what about those hanging contexts which is indicated to waiters by dma_fence_set_error(&s_fence->finished, -ECANCELED);!

I think a hanging context will usually be banned, so we shouldn't reach 
this point AFAICT. Can you share some more info on what your concern is 
here? I don't think we would normally want to call run_job() again on 
jobs from a hanging context. It looks like our run_job() will bail if 
the hw fence is marked with an error.

> 
> Tejas
>>   }
>>
>>   static inline bool
>> --
>> 2.49.0
> 


