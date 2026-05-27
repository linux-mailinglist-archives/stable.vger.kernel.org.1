Return-Path: <stable+bounces-254635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHDMDZ0fF2rw5AcAu9opvQ
	(envelope-from <stable+bounces-254635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:45:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601E5E7F50
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A12302BEB5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7860426687;
	Wed, 27 May 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxzXaZPL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3B410D24
	for <stable@vger.kernel.org>; Wed, 27 May 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899744; cv=none; b=XPVz4VPXfyYpPG08/DSJ75ENe6JtrxXA0Ggow2HFdbvTgBAsR2fv0kajABpn5lROfcVTgdqVrxRKQK2klgf/fkNHA4JJV1DqP545af7VgsC2Bvb32LKqhZLVQ7w/HIhAAOHQ5UR3eOdtfmE/ag5DbnuQGDNcy4rPfy+HHbodtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899744; c=relaxed/simple;
	bh=ipX5U4lue22rFA9cJIFFgKNOq8OnTI1hSGrKhPohkoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmFSuOGb/q0ZiDgZqIcAYRKwxly3wLQNC3aay1x3zPxUqJh93s0j/5vbFLxeWtYrcB9sou0GnrHVOQUDTeAxRKecX20isbZJ7VrDvWftXQG5gdUEcfUlNLkwgLrDyI/VCpWWdwMV+IT81GqhGGjHEFzne8iWJU0234pQz92Tuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxzXaZPL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779899741; x=1811435741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ipX5U4lue22rFA9cJIFFgKNOq8OnTI1hSGrKhPohkoA=;
  b=UxzXaZPL9R7WAu6sflniqdVeujOGHxCMVmZb2WK1Wyxtd535ZirIF16m
   C7a4jdLN1V2XYks24mc2NsRlI/xs6r86fEIDH2w3s2taio60LoxJRgrE4
   2iFFVVxj0O9PMJ+EI2slLSzpCF4u8CVq4XONPvT9Ov5CBk4gGUP/qRsUc
   Qe/M+a0Tz4NkYzt2/vozXlIo3CnIcVNdSfMtgy0o6flG3dc7ON8gOLNCL
   EtwcH/88bBP02/j1FoJuGijWCR93S31iMOpHCEfjSuTk7TlAGwCKaDlvu
   rc7KqfV3YoAJdn5OmZkGDvkkXHiHGoywGdijccWDFAY/5yqHkF5nGzMqF
   Q==;
X-CSE-ConnectionGUID: WWYLD6SjSGu3bUbFz8QdzA==
X-CSE-MsgGUID: Bg6bCv4AQSKYy4tj6qWI7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91843793"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91843793"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:35:40 -0700
X-CSE-ConnectionGUID: PRWWty1oTneEMZupCpZYIw==
X-CSE-MsgGUID: LfBlB69JTN6+86wOSFnAfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="242439757"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.24]) ([10.245.245.24])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:35:38 -0700
Message-ID: <f3e0a8cd-bd32-4ac7-9135-3c6f53e959c4@intel.com>
Date: Wed, 27 May 2026 17:35:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/xe/guc: Don't ban LR VM exec queues on PM
 suspend
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Tomasz Lis
 <tomasz.lis@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 stable@vger.kernel.org, Francois Dugast <francois.dugast@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260525133051.91636-1-thomas.hellstrom@linux.intel.com>
 <20260525133051.91636-3-thomas.hellstrom@linux.intel.com>
 <f0df867c-d4f4-4a9f-b2f0-58d05e5f8926@intel.com>
 <b3a30dfcf5eb035aca3e7e836b985155c419d9fe.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <b3a30dfcf5eb035aca3e7e836b985155c419d9fe.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254635-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 8601E5E7F50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/05/2026 11:19, Thomas Hellström wrote:
> On Tue, 2026-05-26 at 16:38 +0100, Matthew Auld wrote:
>> On 25/05/2026 14:30, Thomas Hellström wrote:
>>> When xe_guc_submit_stop() is called during an S3/S4 suspend or GT
>>> reset, guc_exec_queue_stop() bans any user exec queue that has a
>>> job
>>> which has started but not yet completed.  For normal (non-LR) exec
>>> queues this is the correct behaviour: a started-but-incomplete job
>>> at
>>> reset time may indicate a hung workload.
>>
>> Is it not too harsh to ban the user job for that? Say you are a well
>> behaved 3D workload, and forced suspend is triggered by the user, if
>> you
>> are very unlucky you can get banned, if you hit the queue_stop flow
>> with
>> a WIP job?
> 
> Actually (and this has bearing also on patch 1, I think) suspend /
> resume must not sit in the critical path of any dma-fence job. Meaning
> we explicitly have to wait for all outstanding dma-fences before
> suspending, and add that if that's not already done.

I guess that is missing? I assume it mostly works by fluke, since we 
likely end up evicting user buffers on suspend, which ends up also 
idling most WIP jobs, however that is only true for VRAM buffers on 
dgpu, and CCS buffers on igpu, which is not everything. Some igpu have 
CCS disabled, and on dgpu we still have non-VRAM buffers?

Also on igpu we want to make eviction on suspend limited only to s4, so 
wondering if this will be more noticable there, like with s3 + no evict.

> 
> /Thomas
> 
> 
>>
>>>
>>> For exec queues attached to Long Running (LR) VMs the same
>>> condition
>>> is always true during normal operation: LR jobs are designed to run
>>> indefinitely and are never "completed" in the DRM scheduler sense —
>>> they are preempted and resumed via the preempt-fence mechanism.
>>> Banning such an exec queue on PM suspend permanently prevents the
>>> job
>>> from restarting after resume, causing the userspace compute
>>> workload to
>>> fail silently.
>>>
>>> Fix this by not banning LR VM exec queues when a system suspend or
>>> hibernation is in progress, while preserving the ban for GT reset
>>> where
>>> a started-but-incomplete job is a legitimate indicator of a hang.
>>>
>>> Fixes: f6375fb3aa94 ("drm/xe: Track LR jobs in DRM scheduler
>>> pending list")
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Tomasz Lis <tomasz.lis@intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.19+
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
>>> ---
>>>    drivers/gpu/drm/xe/xe_device_types.h |  8 ++++++++
>>>    drivers/gpu/drm/xe/xe_guc_submit.c   | 10 +++++++++-
>>>    drivers/gpu/drm/xe/xe_pm.c           |  5 ++++-
>>>    3 files changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h
>>> b/drivers/gpu/drm/xe/xe_device_types.h
>>> index 32dd2ffbc796..9dbf7b3a0c49 100644
>>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>>> @@ -433,6 +433,14 @@ struct xe_device {
>>>    	struct notifier_block pm_notifier;
>>>    	/** @pm_block: Completion to block validating tasks on
>>> suspend / hibernate prepare */
>>>    	struct completion pm_block;
>>> +	/**
>>> +	 * @pm_suspend_in_progress: True while the device is going
>>> through
>>> +	 * system suspend or hibernation (set at xe_pm_suspend()
>>> entry, cleared
>>> +	 * at xe_pm_resume() entry or on suspend error). Used to
>>> suppress exec
>>> +	 * queue bans that should only apply during GT reset, not
>>> PM suspend.
>>> +	 * Serialised by the PM suspend sequence; no lock
>>> required.
>>> +	 */
>>> +	bool pm_suspend_in_progress;
>>>    	/** @rebind_resume_list: List of wq items to kick on
>>> resume. */
>>>    	struct list_head rebind_resume_list;
>>>    	/** @rebind_resume_lock: Lock to protect the
>>> rebind_resume_list */
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> index 2b8b316c0ca3..f1a6f13011b5 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> @@ -2268,8 +2268,16 @@ static void guc_exec_queue_stop(struct
>>> xe_guc *guc, struct xe_exec_queue *q)
>>>    	 * Ban any engine (aside from kernel and engines used for
>>> VM ops) with a
>>>    	 * started but not complete job or if a job has gone
>>> through a GT reset
>>>    	 * more than twice.
>>> +	 *
>>> +	 * LR VM exec queues are excluded from this ban during PM
>>> suspend: their
>>> +	 * jobs are intentionally long-running and are preempted
>>> and resumed via
>>> +	 * the preempt-fence mechanism. Banning them on PM suspend
>>> would
>>> +	 * permanently prevent the job from restarting after
>>> resume.
>>> +	 * On GT reset however we do want to ban them, as that may
>>> indicate a
>>> +	 * genuinely hung workload.
>>>    	 */
>>> -	if (!(q->flags & (EXEC_QUEUE_FLAG_KERNEL |
>>> EXEC_QUEUE_FLAG_VM))) {
>>> +	if (!(q->flags & (EXEC_QUEUE_FLAG_KERNEL |
>>> EXEC_QUEUE_FLAG_VM)) &&
>>> +	    !(q->vm && xe_vm_in_lr_mode(q->vm) && guc_to_xe(guc)-
>>>> pm_suspend_in_progress)) {
>>>    		struct xe_sched_job *job =
>>> xe_sched_first_pending_job(sched);
>>>    		bool ban = false;
>>>    
>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c
>>> b/drivers/gpu/drm/xe/xe_pm.c
>>> index c203a59d7000..76d211986822 100644
>>> --- a/drivers/gpu/drm/xe/xe_pm.c
>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>>> @@ -176,6 +176,7 @@ int xe_pm_suspend(struct xe_device *xe)
>>>    	int err;
>>>    
>>>    	drm_dbg(&xe->drm, "Suspending device\n");
>>> +	xe->pm_suspend_in_progress = true;
>>>    	xe_pm_block_begin_signalling();
>>>    	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>>>    
>>> @@ -217,6 +218,7 @@ int xe_pm_suspend(struct xe_device *xe)
>>>    	xe_pxp_pm_resume(xe->pxp);
>>>    err:
>>>    	drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
>>> +	xe->pm_suspend_in_progress = false;
>>>    	xe_pm_block_end_signalling();
>>>    	return err;
>>>    }
>>> @@ -234,8 +236,9 @@ int xe_pm_resume(struct xe_device *xe)
>>>    	u8 id;
>>>    	int err;
>>>    
>>> -	xe_pm_block_begin_signalling();
>>> +	xe->pm_suspend_in_progress = false;
>>>    	drm_dbg(&xe->drm, "Resuming device\n");
>>> +	xe_pm_block_begin_signalling();
>>>    	trace_xe_pm_resume(xe, __builtin_return_address(0));
>>>    
>>>    	for_each_gt(gt, xe, id)


