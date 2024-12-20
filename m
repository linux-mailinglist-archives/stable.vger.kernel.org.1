Return-Path: <stable+bounces-105513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41499F9990
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 19:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073B316AD72
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36121E094;
	Fri, 20 Dec 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2AB1JUr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816B721CA16
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719544; cv=none; b=FBnOgtRfLETWr6+vpiDwHG4EuiQd39t+XUApDRncmWwf8+EyTx+tuOAuwr0KS/sBp5OtmirZU2oCOJXSZxdB8cu4dzUDwG9GRu0h2+o1FUGF8qpB8tLZiGj92xn0pXz/1crPSaFuJAlFjZR9Tupyy4JharxtTXzcnRMsOQaYFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719544; c=relaxed/simple;
	bh=Vci4LLcm6Y5vRTzxa0nmCkcTAo1LgSIFh1khEw9PnXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu9V+Fa90vKu0o2fmrUQqJzb6r4ZspGNaBOrAXhdx5u4jQxTd2vuqOxoB3DD94hmGE2YzKcR5EEws93Z0yXND1YtlGOVUMK4VjKmsCJNWXqOvVSxDF4n3Etk7J9Jfj1KIjBpb5vzMWmIIFBagejA8ymhhyxsR3E7+3Ou90gKZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2AB1JUr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734719542; x=1766255542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vci4LLcm6Y5vRTzxa0nmCkcTAo1LgSIFh1khEw9PnXw=;
  b=m2AB1JUra6CcUiprNNJj85Mz3xJMratPslnj1orochiRdSzJ94mNQ3iB
   tQRFFgDBcbj0Vl/sT9/r9xs0sjwkubo+TkimGz4yU0fkeoyrjPNknd0Ze
   vsGdojTePT8VVAkuKn+CF6jWUXvtQIX5HusFACKVAj4jEHqZfvKbwg3PZ
   dQG7PFokEvEoAMTYXhmAWBSyn+q/LN4Ps1kvg5BMWoHvsmN9te0nmPLRu
   q9ClcT/Ps2YV3guhSf72ZdUF/GdExc7vVHD6L5dNIMmZAQLnQC6UgLFUH
   KoBUS3AqX7VDMFgDowqhHmLgiffWcEaq2VgIP983jKUN8ehLZsiUKzutx
   A==;
X-CSE-ConnectionGUID: xoBegRHqSJufj7ZIFkE8Jg==
X-CSE-MsgGUID: uUSyH7ebSMuNE+Z7VyScgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35167072"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35167072"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 10:32:21 -0800
X-CSE-ConnectionGUID: VsSVJkf0ReCMhVq1lhPwiA==
X-CSE-MsgGUID: z7Rr3ojeR1Gb7NxOxipl3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98786885"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.108.128])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 10:32:21 -0800
Date: Fri, 20 Dec 2024 12:32:16 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: intel-xe@lists.freedesktop.org, matthew.brost@intel.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z2SGzHYsJ+CRoF9p@orsosgc001>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z2SGzHYsJ+CRoF9p@orsosgc001>

On Thu, Dec 19, 2024 at 12:49:16PM -0800, Umesh Nerlige Ramappa wrote:
>On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
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
>
>Like I said in the past, this is not trivial to solve and I would hate 
>to add anything in the KMD to do so.

I think the best we can do in the kernel side is to try to guarantee the
correlated counters are sampled together... And that is already very
good per my tests. Also, it'd not only be good from a testing
perspective, but for any userspace trying to make sense of the 2
counters.

Note that this is not much different from how e.g. perf samples group
events:

	The unit of scheduling in perf is not an individual event, but rather an
	event group, which may contain one or more events (potentially on
	different PMUs). The notion of an event group is useful for ensuring
	that a set of mathematically related events are all simultaneously
	measured for the same period of time. For example, the number of L1
	cache misses should not be larger than the number of L2 cache accesses.
	Otherwise, it may happen that the events get multiplexed and their
	measurements would no longer be comparable, making the analysis more
	difficult.

See __perf_event_read() that will call pmu->read() on all sibling events
while disabling preemption:

	perf_event_read()
	{
		...
		preempt_disable();
		event_cpu = __perf_event_read_cpu(event, event_cpu);
		...
		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
		preempt_enable();
		...
	}

so... at least there's prior art for that... for the same reason that
userspace should see the values sampled together.

>
>For IGT, why not just take 4 samples for the measurement (separate out 
>the 2 counters)
>
>1. get gt timestamp in the first sample
>2. get run ticks in the second sample
>3. get run ticks in the third sample
>4. get gt timestamp in the fourth sample
>
>Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for run ticks 
>delta.

this won't fix it for the general case: you get rid of the > 100% case,
you make the < 100% much worse.

For a testing perspective I think the non-flaky solution is to stop
calculating percentages and rather check that the execution timestamp
recorded by the GPU very closely matches (minus gpu scheduling delays)
the one we got via fdinfo once the fence signals and we wait for the job
completion.

Lucas De Marchi

>
>A user can always sample them together, but rather than focus on few 
>values, they should just normalize the utilization over a longer 
>period of time to get smoother stats.
>
>Thanks,
>Umesh
>
>>
>>Test scenario:
>>
>>	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
>>	* Platform: LNL, where CI occasionally reports failures
>>	* `stress -c $(nproc)` running in parallel to disturb the
>>	  system
>>
>>This brings a first failure from "after ~150 executions" to "never
>>occurs after 1000 attempts".
>>
>>Cc: stable@vger.kernel.org # v6.11+
>>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
>>1 file changed, 3 insertions(+), 6 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>>index 298a587da7f17..e307b4d6bab5a 100644
>>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>>@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>>
>>	/* Accumulate all the exec queues from this client */
>>	mutex_lock(&xef->exec_queue.lock);
>>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>>-		xe_exec_queue_get(q);
>>-		mutex_unlock(&xef->exec_queue.lock);
>>+	preempt_disable();
>>
>>+	xa_for_each(&xef->exec_queue.xa, i, q)
>>		xe_exec_queue_update_run_ticks(q);
>>
>>-		mutex_lock(&xef->exec_queue.lock);
>>-		xe_exec_queue_put(q);
>>-	}
>>+	preempt_enable();
>>	mutex_unlock(&xef->exec_queue.lock);
>>
>>	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>>-- 
>>2.47.0
>>

