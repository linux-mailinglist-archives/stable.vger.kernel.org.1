Return-Path: <stable+bounces-108557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71AA0FD6F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D473A769C
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8A171BB;
	Tue, 14 Jan 2025 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ2WYusl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD235940
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815102; cv=none; b=Ja31AXgpuq2Rgeb6pkpwZpS0IubvFWzJGWOURow/Jo01aUJg/uoDyFbJ6rZyJjFTvOqmTmT4T210Dsu1cHt6ogWwnAlw3PJEZoh8/LZ8A6XJJ9cteyYLNC8+SGOA3/EIkSO9zZHL4dHFJWGSyRG1i+sDmYZrILKwoF4SCXJxRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815102; c=relaxed/simple;
	bh=Qf5688TKZXlcU5M9fcryaFnjnfJY8S5eOl5Vvg3SAo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBQMTXEI/L/ecHHLtNIG6UkGJ5xxD05JnDd9cmrghBFXTPu3JENlykWE2S992wQGGwnVdhPPhtKeMkTLnskQMoIlvzW7A1/CH1UWfWQRVL6UIQYdZjmBn9yACQ6aZli+XivI3aQPXTSU/I2yNEA5AZCYltvmhEtc80gp+hry0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJ2WYusl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736815100; x=1768351100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qf5688TKZXlcU5M9fcryaFnjnfJY8S5eOl5Vvg3SAo4=;
  b=JJ2WYuslljcK8ffJgV9pAX8hcHcw+h5WMUZ+G7vQzV/AJi0nVsfGynQ9
   hZhSJ1wgqFGX1JVQYCUmmTflzHUmEBbXzRStP/DQScuZyeWrQNbHYZgdr
   0z/SpZel2fIjoMe27BmS2HTrTsfXjRahjdaxeo/tAxM9IL9dCtvpQBuVy
   cmOO2h7cy4QoXVMfP8V6gN8duuhsiAP3rjK150DPVCY1Nuxh/VMNNxsRL
   Zt6gckXTPjn3uyfTRuQlJ4sd/QaKjJ89+w8UnmJtwzFjx0fHTknzdGkNq
   6ZmASR2cKCvPXcQNCXbW67jWnb13MMYXx/h/oo7SwDWfG7ZVfbimgwVDU
   Q==;
X-CSE-ConnectionGUID: q0dM75YjRFuTikjI7zLvMQ==
X-CSE-MsgGUID: KsdzUxmvTUevR2XSD+apDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="54514249"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="54514249"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 16:38:16 -0800
X-CSE-ConnectionGUID: UlpYGskBRLK88uzykW4qCA==
X-CSE-MsgGUID: nhSUie/fTfGnE43+F/w52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="135471751"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.108.113])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 16:38:16 -0800
Date: Mon, 13 Jan 2025 18:38:11 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org, 
	Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH v2] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <dzljhhqyjtekkpb3uasqa23czry4vidubrhtyfxixdebscptwi@adfnn4pbfzme>
References: <20250109200340.1774314-1-lucas.demarchi@intel.com>
 <Z4WbJ4DMaPS+LfJ5@orsosgc001>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z4WbJ4DMaPS+LfJ5@orsosgc001>

On Mon, Jan 13, 2025 at 03:00:55PM -0800, Umesh Nerlige Ramappa wrote:
>On Thu, Jan 09, 2025 at 12:03:40PM -0800, Lucas De Marchi wrote:
>>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>>queue file lock usage."). While it's desired to have the mutex to
>>protect only the reference to the exec queue, getting and dropping each
>>mutex and then later getting the GPU timestamp, doesn't produce a
>>correct result: it introduces multiple opportunities for the task to be
>>scheduled out and thus wrecking havoc the deltas reported to userspace.
>>
>>Also, to better correlate the timestamp from the exec queues with the
>>GPU, disable preemption so they can be updated without allowing the task
>>to be scheduled out. We leave interrupts enabled as that shouldn't be
>>enough disturbance for the deltas to matter to userspace.
>>
>>Test scenario:
>>
>>	* IGT'S `xe_drm_fdinfo --r utilization-single-full-load`
>>	* Platform: LNL, where CI occasionally reports failures
>>	* `stress -c $(nproc)` running in parallel to disturb the
>>	  system
>>
>>This brings a first failure from "after ~150 executions" to "never
>>occurs after 1000 attempts".
>>
>>v2: Also keep xe_hw_engine_read_timestamp() call inside the
>>   preemption-disabled section (Umesh)
>>
>>Cc: stable@vger.kernel.org # v6.11+
>>Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>>Cc: Matthew Brost <matthew.brost@intel.com>
>>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>drivers/gpu/drm/xe/xe_drm_client.c | 14 ++++++--------
>>1 file changed, 6 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>>index 7d55ad846bac5..2220a09bf9751 100644
>>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>>@@ -337,20 +337,18 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>>		return;
>>	}
>>
>>+	/* Let both the GPU timestamp and exec queue be updated together */
>>+	preempt_disable();
>>+	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>>+
>>	/* Accumulate all the exec queues from this client */
>>	mutex_lock(&xef->exec_queue.lock);
>
>mutex_lock could sleep and you have disabled preemption above, so not 
>a good idea. I think it will bug check if the lock is contended.
>
>Earlier you had mutex_lock on the outside, so that was fine.

yeah... saw that in the CI test results.

So far with the igt patches it seems we eliminated all the issues. I
will come back to this eventually, but priority is now pretty low.

thanks
Lucas De Marchi

>
>Thanks,
>Umesh
>
>>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>>-		xe_exec_queue_get(q);
>>-		mutex_unlock(&xef->exec_queue.lock);
>>
>>+	xa_for_each(&xef->exec_queue.xa, i, q)
>>		xe_exec_queue_update_run_ticks(q);
>>
>>-		mutex_lock(&xef->exec_queue.lock);
>>-		xe_exec_queue_put(q);
>>-	}
>>	mutex_unlock(&xef->exec_queue.lock);
>>-
>>-	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>>+	preempt_enable();
>>
>>	xe_force_wake_put(gt_to_fw(hwe->gt), fw_ref);
>>	xe_pm_runtime_put(xe);
>>-- 
>>2.47.0
>>

