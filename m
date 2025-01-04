Return-Path: <stable+bounces-106745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE7A012E4
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE29718849ED
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3D17C69;
	Sat,  4 Jan 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4PVFynW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C62914
	for <stable@vger.kernel.org>; Sat,  4 Jan 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735975208; cv=none; b=pfNUZpE3mJpemZHjH1M+OhWehG4syuNLf4DUEvMKI+26j68wz5Oi8arn9hZopuaraDYm0lCRNT8broXa4hkemiBv/t0O5Q+7gkWRFAdSrePETmT3NIQe0FbGD4FvqzCI9Ta2D+fZuzKxLwxcR4MiS9GLX1zB5VBnbS78CpIhyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735975208; c=relaxed/simple;
	bh=1wJJKmjS5umCABm6Goxeyjj7FjPU3ZKUhTI3lyi/VpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daCTLAaqahHELM7YMXGS1fs7ghDkdvXnam+GGesFAyD681vt0pKMD3+XnZoqQ/WjBuNidAIaIXsCsZMIkUjahxDuwo8LH75HO13kj37qVSyoX4ZIz/3ph1ayZGtaEwa6YyCDtGxhjlwH2rQDtvBu/G9tqjJIEQstELN2N4ahsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4PVFynW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735975207; x=1767511207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wJJKmjS5umCABm6Goxeyjj7FjPU3ZKUhTI3lyi/VpE=;
  b=X4PVFynWMvFkHIro6O4EOaHx5Ir/kisxD5CbyATZo4rnIXx2t4BsbKyP
   8Y7gXcnidXpfAbi6ucoDB2p68aAYeW5PRUoHXk/DhFIVhq48VTIVmWgf7
   TljcDiWWgkaUBx2fVKMhkw9h87yvo8vbgAk25TznzlRkUO+HvCZycfbG2
   tECKFhQzoSdganW9hK/zVk0WWUQCx3Uz+mX4+NIZmoxNemBHCXav/ITLA
   52LUQFEuwpsBkfR7tWH0+OcKeoaYkLeW6qUywu68UAKpEFS8l98rCyUq4
   OpX+rbg87Yr8ExOwe7mlMyUxce7ZHi5LP9TopDxDOwgDrgJGXOAlcOb3P
   g==;
X-CSE-ConnectionGUID: PwncvcRpSeGPT2eid6nVHg==
X-CSE-MsgGUID: hEcPfcgITlKwBbE4WdxoQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="23806785"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="23806785"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 23:20:06 -0800
X-CSE-ConnectionGUID: EGz4RfmLSCKUVdcEIxjh7g==
X-CSE-MsgGUID: aFvnHJtUTlqgRbhhv2ccRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="102442703"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.22])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 23:20:05 -0800
Date: Sat, 4 Jan 2025 01:19:59 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: intel-xe@lists.freedesktop.org, matthew.brost@intel.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <jamrxboal2ppniepfxpq5uzksd2v35ypymo7irt56oewcan5vh@zxmofyra5ruz>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z2SGzHYsJ+CRoF9p@orsosgc001>
 <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
 <Z2YMiTq5P81dmjVH@orsosgc001>
 <7bvt3larl4sobadx57a255cvu7i5lkjpt2tdxa4baa324v6va6@ijl7gzqjh7qo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7bvt3larl4sobadx57a255cvu7i5lkjpt2tdxa4baa324v6va6@ijl7gzqjh7qo>

On Fri, Dec 20, 2024 at 06:42:09PM -0600, Lucas De Marchi wrote:
>On Fri, Dec 20, 2024 at 04:32:09PM -0800, Umesh Nerlige Ramappa wrote:
>>On Fri, Dec 20, 2024 at 12:32:16PM -0600, Lucas De Marchi wrote:
>>>On Thu, Dec 19, 2024 at 12:49:16PM -0800, Umesh Nerlige Ramappa wrote:
>>>>On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>>>>>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>>>>>queue file lock usage."). While it's desired to have the mutex to
>>>>>protect only the reference to the exec queue, getting and dropping each
>>>>>mutex and then later getting the GPU timestamp, doesn't produce a
>>>>>correct result: it introduces multiple opportunities for the task to be
>>>>>scheduled out and thus wrecking havoc the deltas reported to userspace.
>>>>>
>>>>>Also, to better correlate the timestamp from the exec queues with the
>>>>>GPU, disable preemption so they can be updated without allowing the task
>>>>>to be scheduled out. We leave interrupts enabled as that shouldn't be
>>>>>enough disturbance for the deltas to matter to userspace.
>>>>
>>>>Like I said in the past, this is not trivial to solve and I 
>>>>would hate to add anything in the KMD to do so.
>>>
>>>I think the best we can do in the kernel side is to try to guarantee the
>>>correlated counters are sampled together... And that is already very
>>>good per my tests. Also, it'd not only be good from a testing
>>>perspective, but for any userspace trying to make sense of the 2
>>>counters.
>>>
>>>Note that this is not much different from how e.g. perf samples group
>>>events:
>>>
>>>	The unit of scheduling in perf is not an individual event, but rather an
>>>	event group, which may contain one or more events (potentially on
>>>	different PMUs). The notion of an event group is useful for ensuring
>>>	that a set of mathematically related events are all simultaneously
>>>	measured for the same period of time. For example, the number of L1
>>>	cache misses should not be larger than the number of L2 cache accesses.
>>>	Otherwise, it may happen that the events get multiplexed and their
>>>	measurements would no longer be comparable, making the analysis more
>>>	difficult.
>>>
>>>See __perf_event_read() that will call pmu->read() on all sibling events
>>>while disabling preemption:
>>>
>>>	perf_event_read()
>>>	{
>>>		...
>>>		preempt_disable();
>>>		event_cpu = __perf_event_read_cpu(event, event_cpu);
>>>		...
>>>		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
>>>		preempt_enable();
>>>		...
>>>	}
>>>
>>>so... at least there's prior art for that... for the same reason that
>>>userspace should see the values sampled together.
>>
>>Well, I have used the preempt_disable/enable when fixing some 
>>selftest (i915), but was not happy that there were still some rare 
>>failures. If reducing error rates is the intention, then it's fine. 
>>In my mind, the issue still exists and once in a while we would end 
>>up assessing such a failure. Maybe, in addition, fixing up the IGTs 
>>like you suggest below is a worthwhile option.
>
>for me this fix is not targeted at tests, even if it improves them a
>lot. It's more for consistent userspace behavior.
>
>>
>>>
>>>>
>>>>For IGT, why not just take 4 samples for the measurement 
>>>>(separate out the 2 counters)
>>>>
>>>>1. get gt timestamp in the first sample
>>>>2. get run ticks in the second sample
>>>>3. get run ticks in the third sample
>>>>4. get gt timestamp in the fourth sample
>>>>
>>>>Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for run 
>>>>ticks delta.
>>>
>>>this won't fix it for the general case: you get rid of the > 100% case,
>>>you make the < 100% much worse.
>>
>>yeah, that's quite possible.
>>
>>>
>>>For a testing perspective I think the non-flaky solution is to stop
>>>calculating percentages and rather check that the execution timestamp
>>>recorded by the GPU very closely matches (minus gpu scheduling delays)
>>>the one we got via fdinfo once the fence signals and we wait for the job
>>>completion.
>>
>>Agree, we should change how we validate the counters in IGT.
>
>I have a wip patch to cleanup and submit to igt. I will submit it soon.

Just submitted that as the last patch in the series:
https://lore.kernel.org/igt-dev/20250104071548.737612-8-lucas.demarchi@intel.com/T/#u

but I'd also like to apply this one in the kernel and still looking for
a review.

thanks
Lucas De Marchi

