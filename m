Return-Path: <stable+bounces-254385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPrUAZfFFWqxawcAu9opvQ
	(envelope-from <stable+bounces-254385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:08:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF715D958A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94379314EFF3
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41636D9E7;
	Tue, 26 May 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdbyKWyp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F836CDEB
	for <stable@vger.kernel.org>; Tue, 26 May 2026 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809886; cv=none; b=CmYfn0ez/dK8UZR0oxgdmv2jIc1J1J6IACJmUKmQMbRijxos/5eIRTmr3EqiW8j8/eZ+xSdHm0/QeUD8cBvGR/nBIXErHvasar+GMDL7GAbkWxg/htyjgd5VzR59kf/Y1TGMEtOhMayCmRc57sj9+0p5db4jqV8goVzxsSYZzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809886; c=relaxed/simple;
	bh=iK0I8nuXf7OqXuOOfpzgWEFQbnlWuRxky/3JOn5vq2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQBa5gaYJYT4e0qwv8O4ykWPI3B2f4MOUQbMuOmYadxLQq6Wv9PxmKZMZhqAIHVf+a615bWMvlySHwjVIXIDOold+4N41jvPo7rN53AMi0kUK6njOMi/pgnlGbT+2JE39eLiqf9MCKXBGR0GzEKpEBxFNHfbLyf83lGZuhi6dgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdbyKWyp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779809886; x=1811345886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iK0I8nuXf7OqXuOOfpzgWEFQbnlWuRxky/3JOn5vq2U=;
  b=DdbyKWypUZNbUUnpLkNdhad+Gvd+4TVwWbST4RMlENplsqJUSjOMBBOM
   bOP7nSTcv0lvjMTwYW2jbk+JXCyDP+W4O01S5PgMnVw35ZGRgZSXnTFRp
   GiT8yhmi6iHjjFy6u1CqWlTnff9nxUw5IAiXy0zQWiu+B+9DP8Dsj/Bx6
   7rGnntIOMYDLogcbaDsTv2DGTAiay+4NEPVqRYNZHBuZhwg7jWTSuuppj
   igprSw2oClR+r7U1/h8YxrSc44rgAEI9Ay9tYJGkG9aB6JfQfnSNs01ed
   G/F2hQXeGlqYSR6V7QTHr0lfDjDaVJPiwgAZVLRLeXkcrx/mBJZ/8JRCb
   Q==;
X-CSE-ConnectionGUID: 27XuZNPCQkiyb/n8PUDQwA==
X-CSE-MsgGUID: vbASQp6XSwCPVU9Hhw093A==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80609235"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80609235"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:38:05 -0700
X-CSE-ConnectionGUID: bqsMeBGNQza7WHIKpoM/OA==
X-CSE-MsgGUID: pFsqrtYvR06cijmp3GzpeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="247033219"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.244.128]) ([10.245.244.128])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:38:03 -0700
Message-ID: <f0df867c-d4f4-4a9f-b2f0-58d05e5f8926@intel.com>
Date: Tue, 26 May 2026 16:38:01 +0100
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
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260525133051.91636-3-thomas.hellstrom@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-254385-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CF715D958A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/05/2026 14:30, Thomas Hellström wrote:
> When xe_guc_submit_stop() is called during an S3/S4 suspend or GT
> reset, guc_exec_queue_stop() bans any user exec queue that has a job
> which has started but not yet completed.  For normal (non-LR) exec
> queues this is the correct behaviour: a started-but-incomplete job at
> reset time may indicate a hung workload.

Is it not too harsh to ban the user job for that? Say you are a well 
behaved 3D workload, and forced suspend is triggered by the user, if you 
are very unlucky you can get banned, if you hit the queue_stop flow with 
a WIP job?

> 
> For exec queues attached to Long Running (LR) VMs the same condition
> is always true during normal operation: LR jobs are designed to run
> indefinitely and are never "completed" in the DRM scheduler sense —
> they are preempted and resumed via the preempt-fence mechanism.
> Banning such an exec queue on PM suspend permanently prevents the job
> from restarting after resume, causing the userspace compute workload to
> fail silently.
> 
> Fix this by not banning LR VM exec queues when a system suspend or
> hibernation is in progress, while preserving the ban for GT reset where
> a started-but-incomplete job is a legitimate indicator of a hang.
> 
> Fixes: f6375fb3aa94 ("drm/xe: Track LR jobs in DRM scheduler pending list")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Tomasz Lis <tomasz.lis@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.19+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> ---
>   drivers/gpu/drm/xe/xe_device_types.h |  8 ++++++++
>   drivers/gpu/drm/xe/xe_guc_submit.c   | 10 +++++++++-
>   drivers/gpu/drm/xe/xe_pm.c           |  5 ++++-
>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 32dd2ffbc796..9dbf7b3a0c49 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -433,6 +433,14 @@ struct xe_device {
>   	struct notifier_block pm_notifier;
>   	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
>   	struct completion pm_block;
> +	/**
> +	 * @pm_suspend_in_progress: True while the device is going through
> +	 * system suspend or hibernation (set at xe_pm_suspend() entry, cleared
> +	 * at xe_pm_resume() entry or on suspend error). Used to suppress exec
> +	 * queue bans that should only apply during GT reset, not PM suspend.
> +	 * Serialised by the PM suspend sequence; no lock required.
> +	 */
> +	bool pm_suspend_in_progress;
>   	/** @rebind_resume_list: List of wq items to kick on resume. */
>   	struct list_head rebind_resume_list;
>   	/** @rebind_resume_lock: Lock to protect the rebind_resume_list */
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 2b8b316c0ca3..f1a6f13011b5 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -2268,8 +2268,16 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>   	 * Ban any engine (aside from kernel and engines used for VM ops) with a
>   	 * started but not complete job or if a job has gone through a GT reset
>   	 * more than twice.
> +	 *
> +	 * LR VM exec queues are excluded from this ban during PM suspend: their
> +	 * jobs are intentionally long-running and are preempted and resumed via
> +	 * the preempt-fence mechanism. Banning them on PM suspend would
> +	 * permanently prevent the job from restarting after resume.
> +	 * On GT reset however we do want to ban them, as that may indicate a
> +	 * genuinely hung workload.
>   	 */
> -	if (!(q->flags & (EXEC_QUEUE_FLAG_KERNEL | EXEC_QUEUE_FLAG_VM))) {
> +	if (!(q->flags & (EXEC_QUEUE_FLAG_KERNEL | EXEC_QUEUE_FLAG_VM)) &&
> +	    !(q->vm && xe_vm_in_lr_mode(q->vm) && guc_to_xe(guc)->pm_suspend_in_progress)) {
>   		struct xe_sched_job *job = xe_sched_first_pending_job(sched);
>   		bool ban = false;
>   
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index c203a59d7000..76d211986822 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -176,6 +176,7 @@ int xe_pm_suspend(struct xe_device *xe)
>   	int err;
>   
>   	drm_dbg(&xe->drm, "Suspending device\n");
> +	xe->pm_suspend_in_progress = true;
>   	xe_pm_block_begin_signalling();
>   	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>   
> @@ -217,6 +218,7 @@ int xe_pm_suspend(struct xe_device *xe)
>   	xe_pxp_pm_resume(xe->pxp);
>   err:
>   	drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
> +	xe->pm_suspend_in_progress = false;
>   	xe_pm_block_end_signalling();
>   	return err;
>   }
> @@ -234,8 +236,9 @@ int xe_pm_resume(struct xe_device *xe)
>   	u8 id;
>   	int err;
>   
> -	xe_pm_block_begin_signalling();
> +	xe->pm_suspend_in_progress = false;
>   	drm_dbg(&xe->drm, "Resuming device\n");
> +	xe_pm_block_begin_signalling();
>   	trace_xe_pm_resume(xe, __builtin_return_address(0));
>   
>   	for_each_gt(gt, xe, id)


