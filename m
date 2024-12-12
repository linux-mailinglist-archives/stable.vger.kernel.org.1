Return-Path: <stable+bounces-103944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479F9EFED4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 22:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FE2282A62
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 21:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3EE1B21AA;
	Thu, 12 Dec 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwYDEv/8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD92F2F
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040412; cv=none; b=AVQGLpYGtQI9a5DR44Wx/hblkDK8kO5gWitdEY8M8uvntQN7UeIvv8J9EpKtDwM4iFAUq0FnCuB7JvA7Eo7jtNPIvRhzV+N36AeK4CZw2NUk4d394WmY7d/v0JABKWeNiBLXDnzufoQTH13BZhRjityGA6CFmrBKzqbonO2f8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040412; c=relaxed/simple;
	bh=EZgd3qCvIcKqGwz89O1AUrquGdCJj7Z4nTegOvN1dVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvjvPsMmoF0L/gyeNHs2u4AhfQRVuhNKV6iFGSIyMVZfHmY6PX6y7JhKd/NYHgimURqMxcuvT0QjMxod2CTmKhvR9tzzE57M9jAWVRpOy9qJaa94NgiuRbMj4zi2IA2vHhQHtv29KsCyucUGVK3Tn85yXn07GTNiRfRW7krv0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwYDEv/8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734040411; x=1765576411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZgd3qCvIcKqGwz89O1AUrquGdCJj7Z4nTegOvN1dVk=;
  b=KwYDEv/8KMkRgde/9y17tJ9px6RVyvWuH5cZkJTk7sy1v1XaHFBQANO1
   eARc3tQ7+Zl6xi71gezLW3lm3RzyQPLTwCtYvLCUgS82OackLs+DwYRly
   nayAbCSovzFr8gZAVSRVqkwlvj9socVAst3GfJmNwTcJJVoiZNy9I/vFK
   BzeGOSuv3nQT/FijjJWmTM/ydyBY4HTgY07lzrFBo45Vl+OuX8l5b+DWd
   1sSY5Uda5qBb0O0fv3lZDjUD4ix+9PhgHuHVjuV/kchqaZcKD/jeBGDSu
   hJFitNHkav7Vp/Jda2JTSaSHQZbqk1O15eWBvIdi1u36k2I5ybAqDtAoq
   g==;
X-CSE-ConnectionGUID: yta7GamuQTyn4xXCdzMJaQ==
X-CSE-MsgGUID: d8L9qHpXQvqWHITc3Mg1ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34613136"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34613136"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:53:30 -0800
X-CSE-ConnectionGUID: 7yTZk0a3TvaEnddmN45K5A==
X-CSE-MsgGUID: lTA3uTQ1RQCBNi1Oh93tKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96763266"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:53:29 -0800
Date: Thu, 12 Dec 2024 15:53:21 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, 
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <esvcbb7t6wbtuzdvbntdustpcurafkxh73syizig3gz7eth5qs@ouhq6b6bgu3t>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241212173432.1244440-1-lucas.demarchi@intel.com>

On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>queue file lock usage."). While it's desired to have the mutex to
>protect only the reference to the exec queue, getting and dropping each
>mutex and then later getting the GPU timestamp, doesn't produce a
>correct result: it introduces multiple opportunities for the task to be
>scheduled out and thus wrecking havoc the deltas reported to userspace.
>
>Also, to better correlate the timestamp from the exec queues with the
>GPU, disable preemption so they can be updated without allowing the task
>to be scheduled out. We leave interrupts enabled as that shouldn't be
>enough disturbance for the deltas to matter to userspace.
>
>Test scenario:
>
>	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
>	* Platform: LNL, where CI occasionally reports failures
>	* `stress -c $(nproc)` running in parallel to disturb the
>	  system
>
>This brings a first failure from "after ~150 executions" to "never
>occurs after 1000 attempts".


so it fails after 2704 runs, but it seems like it's for a reason other than
what's fixed here that was previously failing at ~150 runs. See below.
Relevant lines from the log are marked

	####################################### 2705/10000
	IGT-Version: 1.29-g19f996f8b (x86_64) (Linux: 6.13.0-rc2-xe+ x86_64)
	Using IGT_SRANDOM=1734033293 for randomisation
	Opened device: /dev/dri/card0
	Starting subtest: utilization-single-full-load
	(xe_drm_fdinfo:40147) CRITICAL: Test assertion failure function check_results, file ../tests/intel/xe_drm_fdinfo.c:528:
	(xe_drm_fdinfo:40147) CRITICAL: Failed assertion: percent < 105.0
	(xe_drm_fdinfo:40147) CRITICAL: error: 105.811345 >= 105.000000
	Stack trace:
	  #0 ../lib/igt_core.c:2051 __igt_fail_assert()
	  #1 ../tests/intel/xe_drm_fdinfo.c:520 check_results()
	  #2 ../tests/intel/xe_drm_fdinfo.c:464 utilization_single()
	  #3 ../tests/intel/xe_drm_fdinfo.c:852 __igt_unique____real_main806()
	  #4 ../tests/intel/xe_drm_fdinfo.c:806 main()
	  #5 ../sysdeps/nptl/libc_start_call_main.h:74 __libc_start_call_main()
	  #6 ../csu/libc-start.c:128 __libc_start_main@@GLIBC_2.34()
	  #7 [_start+0x25]
	Subtest utilization-single-full-load failed.
	**** DEBUG ****
	(xe_drm_fdinfo:40147) DEBUG: rcs: spinner started
	(xe_drm_fdinfo:40147) DEBUG: rcs: spinner ended (timestamp=19184279)
	(xe_drm_fdinfo:40147) DEBUG: rcs: sample 1: cycles 0, total_cycles 325162895781
	(xe_drm_fdinfo:40147) DEBUG: rcs: sample 2: cycles 19184523, total_cycles 325182184120
	(xe_drm_fdinfo:40147) DEBUG: rcs: percent: 99.461763
	(xe_drm_fdinfo:40147) DEBUG: bcs: spinner started
	(xe_drm_fdinfo:40147) DEBUG: bcs: spinner ended (timestamp=19193059)
	(xe_drm_fdinfo:40147) DEBUG: bcs: sample 1: cycles 0, total_cycles 325182330134
	(xe_drm_fdinfo:40147) DEBUG: bcs: sample 2: cycles 19193168, total_cycles 325201552996
	(xe_drm_fdinfo:40147) DEBUG: bcs: percent: 99.845522
	(xe_drm_fdinfo:40147) DEBUG: ccs: spinner started
	(xe_drm_fdinfo:40147) DEBUG: ccs: spinner ended (timestamp=19200849)
	(xe_drm_fdinfo:40147) DEBUG: ccs: sample 1: cycles 0, total_cycles 325201742269
	(xe_drm_fdinfo:40147) DEBUG: ccs: sample 2: cycles 19201013, total_cycles 325220974694
	(xe_drm_fdinfo:40147) DEBUG: ccs: percent: 99.836666
	(xe_drm_fdinfo:40147) DEBUG: vcs: spinner started
	(xe_drm_fdinfo:40147) DEBUG: vcs: spinner ended (timestamp=19281420)
	(xe_drm_fdinfo:40147) DEBUG: vcs: sample 1: cycles 0, total_cycles 325221246644
	(xe_drm_fdinfo:40147) DEBUG: vcs: sample 2: cycles 19281506, total_cycles 325240467813
	(xe_drm_fdinfo:40147) DEBUG: vcs: percent: 100.313904
	(xe_drm_fdinfo:40147) DEBUG: vecs: spinner started
[0]--->	(xe_drm_fdinfo:40147) DEBUG: vecs: spinner ended (timestamp=20348520)
[1]--->	(xe_drm_fdinfo:40147) DEBUG: vecs: sample 1: cycles 0, total_cycles 325242482039
[2]--->	(xe_drm_fdinfo:40147) DEBUG: vecs: sample 2: cycles 20348601, total_cycles 325261713058
	(xe_drm_fdinfo:40147) DEBUG: vecs: percent: 105.811345
	(xe_drm_fdinfo:40147) CRITICAL: Test assertion failure function check_results, file ../tests/intel/xe_drm_fdinfo.c:528:
	(xe_drm_fdinfo:40147) CRITICAL: Failed assertion: percent < 105.0
	(xe_drm_fdinfo:40147) CRITICAL: error: 105.811345 >= 105.000000



It fails because total_cyles is smaller than the reported delta.
However [0] shows the timestamp recorded by the GPU itself, which is
reasonably close to the delta cycles (there are schedule gpu schedule
latencies that are accounted in one vs the other, so it's not exact).
So, it indeed executed for (at least) 20348520 cycles, but the reported
delta for total_cycles is 325261713058 - 325242482039 == 19231019

For me the reason for the failure is the first sample. It reads
cycles == 0, which means the ctx wasn't scheduled out yet to update the
counter. So, depending of how fast the CPU can read the first sample, it
may read a total_cycles that is actually more than the timestamp it
should have been: cycles may remain the same for some time while
total_cycles is still ticking.

I still think this patch here makes sense from a user perspective: we
should try to get the gpu timestamp and client timestamp close together
if user is expected to calculate a ratio between them.

 From a testing perspective, maybe it'd better to check if the timestamp
reported by the GPU ([0]) closely matches the one reported via client
info ([1]) rather than calculating any percentage, which means leaving
the total_cycles out of the equation for igt.  Thoughts?

Lucas De Marchi

>
>Cc: stable@vger.kernel.org # v6.11+
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>index 298a587da7f17..e307b4d6bab5a 100644
>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>
> 	/* Accumulate all the exec queues from this client */
> 	mutex_lock(&xef->exec_queue.lock);
>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>-		xe_exec_queue_get(q);
>-		mutex_unlock(&xef->exec_queue.lock);
>+	preempt_disable();
>
>+	xa_for_each(&xef->exec_queue.xa, i, q)
> 		xe_exec_queue_update_run_ticks(q);
>
>-		mutex_lock(&xef->exec_queue.lock);
>-		xe_exec_queue_put(q);
>-	}
>+	preempt_enable();
> 	mutex_unlock(&xef->exec_queue.lock);
>
> 	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>-- 
>2.47.0
>

