Return-Path: <stable+bounces-108057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EE7A06D7B
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 06:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FA93A3FCC
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435391FE468;
	Thu,  9 Jan 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6TamWFK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB12BA2D
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736400001; cv=none; b=Ovizq2rAFzIb2X5TlaxzN5/2PC9N0le8ZNRtOJrKMq2arKZTPsnuO0fB14VDxEQlvKlz7fYCjB1MpIZG5OKNesQpN+LGhHduBfmq+T3owSk0O4U+y9hHIoBySrCd1qyA/xem0txY/SJDWqikFgBuaHPJN2E29/aBFkdjtL/87+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736400001; c=relaxed/simple;
	bh=nZWNMiqEO5uyXvZif4210iU+zlVcNCsXPA9QYCufdU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blG0xwK9hqaCrqYsSS8UakbSKMji2I+Zc1PUSRiP6JLV1SvWr8QonoM7Al4224GKsNOcHpSQxZ0EjMDGabVAt4tq/NGDIamtMwJEF3FvuAcxHdvtWITzfw9MJCPjahLxk9x+U/dIC5YAGHnk+FupsX2Iz0pyo0X3nC6x1tT6F00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6TamWFK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736399999; x=1767935999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nZWNMiqEO5uyXvZif4210iU+zlVcNCsXPA9QYCufdU0=;
  b=K6TamWFKDZD+9VhNI6oAU2duJWSiK3Te229fFdkK8jyfMB44OczhGmEd
   FFNddY8qDYO9gYkga/fy35YWQbB65qwsZJN4QEt0JpIt1YOWikKxo+yga
   iL2q67L1NbdMtMAt5XPYayBzbX4lj8I6YuoZAXaJgUHwFYszIzPpLHUEL
   l+4tJsBZmSbBoQ4JESTVni9ziF1ND6bztPUxqTKascKCv7EaGiPrh/UJS
   2a+/v0lF16Wb0YmVnZ+rCOrLl3OxnIS3tjK+aNw3NnVP1MRplgsv1qX62
   FVMhT3LihSQ9n09GDsii1is+ChuztGDlFsLz7z80BzNHJ5Q9F38mSbI1K
   Q==;
X-CSE-ConnectionGUID: JokYLi/cRl6qcwhMCceQsg==
X-CSE-MsgGUID: rzDRl6IsRqOKoyceD8337A==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47220152"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47220152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 21:19:58 -0800
X-CSE-ConnectionGUID: rpbB2moGSqKuYTgKHX9x1g==
X-CSE-MsgGUID: KL1OkryuRLm5Af9BVEehUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="134139554"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.77])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 21:19:57 -0800
Date: Wed, 8 Jan 2025 23:19:52 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, 
	intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <ngkbkvqre4d4hvaiwtqcm7oz76b3wcbuzq3ueoazjd7ff3luym@lrjlwmac2mf7>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z2SGzHYsJ+CRoF9p@orsosgc001>
 <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
 <Z2YMiTq5P81dmjVH@orsosgc001>
 <7bvt3larl4sobadx57a255cvu7i5lkjpt2tdxa4baa324v6va6@ijl7gzqjh7qo>
 <jamrxboal2ppniepfxpq5uzksd2v35ypymo7irt56oewcan5vh@zxmofyra5ruz>
 <Z39Vo5FEZsapkQaA@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z39Vo5FEZsapkQaA@lstrano-desk.jf.intel.com>

On Wed, Jan 08, 2025 at 08:50:43PM -0800, Matthew Brost wrote:
>On Sat, Jan 04, 2025 at 01:19:59AM -0600, Lucas De Marchi wrote:
>> On Fri, Dec 20, 2024 at 06:42:09PM -0600, Lucas De Marchi wrote:
>> > On Fri, Dec 20, 2024 at 04:32:09PM -0800, Umesh Nerlige Ramappa wrote:
>> > > On Fri, Dec 20, 2024 at 12:32:16PM -0600, Lucas De Marchi wrote:
>> > > > On Thu, Dec 19, 2024 at 12:49:16PM -0800, Umesh Nerlige Ramappa wrote:
>> > > > > On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>> > > > > > This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>> > > > > > queue file lock usage."). While it's desired to have the mutex to
>> > > > > > protect only the reference to the exec queue, getting and dropping each
>> > > > > > mutex and then later getting the GPU timestamp, doesn't produce a
>> > > > > > correct result: it introduces multiple opportunities for the task to be
>> > > > > > scheduled out and thus wrecking havoc the deltas reported to userspace.
>> > > > > >
>> > > > > > Also, to better correlate the timestamp from the exec queues with the
>> > > > > > GPU, disable preemption so they can be updated without allowing the task
>> > > > > > to be scheduled out. We leave interrupts enabled as that shouldn't be
>> > > > > > enough disturbance for the deltas to matter to userspace.
>> > > > >
>> > > > > Like I said in the past, this is not trivial to solve and I
>> > > > > would hate to add anything in the KMD to do so.
>> > > >
>> > > > I think the best we can do in the kernel side is to try to guarantee the
>> > > > correlated counters are sampled together... And that is already very
>> > > > good per my tests. Also, it'd not only be good from a testing
>> > > > perspective, but for any userspace trying to make sense of the 2
>> > > > counters.
>> > > >
>> > > > Note that this is not much different from how e.g. perf samples group
>> > > > events:
>> > > >
>> > > > 	The unit of scheduling in perf is not an individual event, but rather an
>> > > > 	event group, which may contain one or more events (potentially on
>> > > > 	different PMUs). The notion of an event group is useful for ensuring
>> > > > 	that a set of mathematically related events are all simultaneously
>> > > > 	measured for the same period of time. For example, the number of L1
>> > > > 	cache misses should not be larger than the number of L2 cache accesses.
>> > > > 	Otherwise, it may happen that the events get multiplexed and their
>> > > > 	measurements would no longer be comparable, making the analysis more
>> > > > 	difficult.
>> > > >
>> > > > See __perf_event_read() that will call pmu->read() on all sibling events
>> > > > while disabling preemption:
>> > > >
>> > > > 	perf_event_read()
>> > > > 	{
>> > > > 		...
>> > > > 		preempt_disable();
>> > > > 		event_cpu = __perf_event_read_cpu(event, event_cpu);
>> > > > 		...
>> > > > 		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
>> > > > 		preempt_enable();
>> > > > 		...
>> > > > 	}
>> > > >
>> > > > so... at least there's prior art for that... for the same reason that
>> > > > userspace should see the values sampled together.
>> > >
>> > > Well, I have used the preempt_disable/enable when fixing some
>> > > selftest (i915), but was not happy that there were still some rare
>> > > failures. If reducing error rates is the intention, then it's fine.
>> > > In my mind, the issue still exists and once in a while we would end
>> > > up assessing such a failure. Maybe, in addition, fixing up the IGTs
>> > > like you suggest below is a worthwhile option.
>
>IMO, we should strive to avoid using low-level calls like
>preempt_disable and preempt_enable, as they lead to unmaintainable
>nonsense, as seen in the i915.
>
>Sure, in Umesh's example, this is pretty clear and not an unreasonable
>usage. However, I’m more concerned that this sets a precedent in Xe that
>doing this is acceptable.

each such usage needs to be carefully reviewed, but there are cases
in which it's useful and we shouldn't ban it. In my early reply on
wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4  I even
showed how the same construct is used by perf when reading counters
that should be sampled together.

I will post a new version, but I will delay in a week or so merging it.
That's because I want to check the result of the other patch series that
changes the test in igt and afaics should give all green results all the
time: https://patchwork.freedesktop.org/series/143204/

Lucas De Marchi

>
>Not a blocker, just expressing concerns.
>
>Matt
>
>> >
>> > for me this fix is not targeted at tests, even if it improves them a
>> > lot. It's more for consistent userspace behavior.
>> >
>> > >
>> > > >
>> > > > >
>> > > > > For IGT, why not just take 4 samples for the measurement
>> > > > > (separate out the 2 counters)
>> > > > >
>> > > > > 1. get gt timestamp in the first sample
>> > > > > 2. get run ticks in the second sample
>> > > > > 3. get run ticks in the third sample
>> > > > > 4. get gt timestamp in the fourth sample
>> > > > >
>> > > > > Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for
>> > > > > run ticks delta.
>> > > >
>> > > > this won't fix it for the general case: you get rid of the > 100% case,
>> > > > you make the < 100% much worse.
>> > >
>> > > yeah, that's quite possible.
>> > >
>> > > >
>> > > > For a testing perspective I think the non-flaky solution is to stop
>> > > > calculating percentages and rather check that the execution timestamp
>> > > > recorded by the GPU very closely matches (minus gpu scheduling delays)
>> > > > the one we got via fdinfo once the fence signals and we wait for the job
>> > > > completion.
>> > >
>> > > Agree, we should change how we validate the counters in IGT.
>> >
>> > I have a wip patch to cleanup and submit to igt. I will submit it soon.
>>
>> Just submitted that as the last patch in the series:
>> https://lore.kernel.org/igt-dev/20250104071548.737612-8-lucas.demarchi@intel.com/T/#u
>>
>> but I'd also like to apply this one in the kernel and still looking for
>> a review.
>>
>> thanks
>> Lucas De Marchi

