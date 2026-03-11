Return-Path: <stable+bounces-224732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOUOKUWlsWn4EAAAu9opvQ
	(envelope-from <stable+bounces-224732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:24:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100AC267FA6
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A4B31F312F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51430C621;
	Wed, 11 Mar 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzAcIQrD"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AE30EF8F;
	Wed, 11 Mar 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249550; cv=none; b=mu3f9KXFJxporOMPL2084S0mwVervvSisd+NQcYHbam2gf1M8GPWLvd/6wJBj+X4JuSzmscLOhwtLuvx5tMnR5DU4dy+0xxcaKkvI9zIQdGQQM82kOFpHVyh4L8RT/wlsM/8BqXa0vgQS6VIcVDDwz1mpiKlYcq/pdB0m4qfVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249550; c=relaxed/simple;
	bh=pK3BGPL3cQ7krGzPQI4H7J/3WARl0VGGLszyWKCDVlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3xIWf9/FbTJOjDLPAv2UmBTQPoB3oNryXHMAMYUYF4HGX07Gj4Uoai5cFiIEBs5kSn8D//an8LDmDfwouufiQzVJCAXnBgsN7Cq6WiRbEhPw0evp96YuKgpkqXhCaeVqo/P1qm1//NHmnE3RTFDn8wpQvekKrRelLD/4dpU5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jzAcIQrD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=K2n9jrMR1Fhiz/vfUJ3TSNQTfu2pG1vVDmOLvPlPTWw=; b=jzAcIQrDoqfjmnkGtryL3hRhrs
	L55RoXVs6p3QmnfZ7aAPzACSLzF73D7BkK6QcBGkN3bhoiSUubVTPAnp/cWdgl4tccxuXWu/Pk3UL
	OJu0yx0x6t5SzhvgYFXmpHGZVjeqFahGeVd+Qr7I0ut1EKnF2bVil+B9gVRQidX0stk7PNakKbut9
	8P5kQ+XG4XMABgCgXSMvUPd4/BETiUxozj5qkDYqRRpELZmMxWJ7F7bscdVT0TZiscE9d7ZbwOQ2O
	vgs2gJ6q1eVx2oaAtEdy3/7Y9B0ENFUOKWTqqBU2+ylEP0WZ6ySpKeS2aFO0e+n+dSKzN4LWSI3lz
	7tDIysqg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0NCu-0000000HOyZ-0LfM;
	Wed, 11 Mar 2026 17:18:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 795B7300462; Wed, 11 Mar 2026 18:18:50 +0100 (CET)
Date: Wed, 11 Mar 2026 18:18:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
Message-ID: <20260311171850.GQ606826@noisy.programming.kicks-ass.net>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224732-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,infradead.org:dkim]
X-Rspamd-Queue-Id: 100AC267FA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 10:04:10AM +0800, Mi, Dapeng wrote:
> 
> On 3/10/2026 6:13 PM, Breno Leitao wrote:
> > A production AMD EPYC system crashed with a NULL pointer dereference
> > in the PMU NMI handler:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000198
> >   RIP: x86_perf_event_update+0xc/0xa0
> >   Call Trace:
> >    <NMI>
> >    amd_pmu_v2_handle_irq+0x1a6/0x390
> >    perf_event_nmi_handler+0x24/0x40
> >
> > The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=0,
> > corresponding to the `if (unlikely(!hwc->event_base))` check in
> > x86_perf_event_update() where hwc = &event->hw and event is NULL.
> >
> > drgn inspection of the vmcore on CPU 106 showed a mismatch between
> > cpuc->active_mask and cpuc->events[]:
> >
> >   active_mask: 0x1e (bits 1, 2, 3, 4)
> >   events[1]:   0xff1100136cbd4f38  (valid)
> >   events[2]:   0x0                 (NULL, but active_mask bit 2 set)
> >   events[3]:   0xff1100076fd2cf38  (valid)
> >   events[4]:   0xff1100079e990a90  (valid)
> >
> > The event that should occupy events[2] was found in event_list[2]
> > with hw.idx=2 and hw.state=0x0, confirming x86_pmu_start() had run
> > (which clears hw.state and sets active_mask) but events[2] was
> > never populated.
> >
> > Another event (event_list[0]) had hw.state=0x7 (STOPPED|UPTODATE|ARCH),
> > showing it was stopped when the PMU rescheduled events, confirming the
> > throttle-then-reschedule sequence occurred.
> >
> > The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
> > and potential PEBS record loss") which moved the cpuc->events[idx]
> > assignment out of x86_pmu_start() and into step 2 of x86_pmu_enable(),
> > after the PERF_HES_ARCH check. This broke any path that calls
> > pmu->start() without going through x86_pmu_enable() -- specifically
> > the unthrottle path:
> >
> >   perf_adjust_freq_unthr_events()
> >     -> perf_event_unthrottle_group()
> >       -> perf_event_unthrottle()
> >         -> event->pmu->start(event, 0)
> >           -> x86_pmu_start()     // sets active_mask but not events[]
> >
> > The race sequence is:
> >
> >   1. A group of perf events overflows, triggering group throttle via
> >      perf_event_throttle_group(). All events are stopped: active_mask
> >      bits cleared, events[] preserved (x86_pmu_stop no longer clears
> >      events[] after commit 7e772a93eb61).
> >
> >   2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
> >      due to other scheduling activity. Stopped events that need to
> >      move counters get PERF_HES_ARCH set and events[old_idx] cleared.
> >      In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
> >      to be skipped -- events[new_idx] is never set.
> >
> >   3. The timer tick unthrottles the group via pmu->start(). Since
> >      commit 7e772a93eb61 removed the events[] assignment from
> >      x86_pmu_start(), active_mask[new_idx] is set but events[new_idx]
> >      remains NULL.
> >
> >   4. A PMC overflow NMI fires. The handler iterates active counters,
> >      finds active_mask[2] set, reads events[2] which is NULL, and
> >      crashes dereferencing it.
> >
> > Move the cpuc->events[hwc->idx] assignment in x86_pmu_enable() to
> > before the PERF_HES_ARCH check, so that events[] is populated even
> > for events that are not immediately started. This ensures the
> > unthrottle path via pmu->start() always finds a valid event pointer.
> >
> > Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes in v2:
> > - Move event pointer setup earlier in x86_pmu_enable() (peterz)
> > - Rewrote the patch title, given the new approach
> > - Link to v1: https://patch.msgid.link/20260309-perf-v1-1-601ffb531893@debian.org
> > ---
> >  arch/x86/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 03ce1bc7ef2ea..54b4c315d927f 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1372,6 +1372,8 @@ static void x86_pmu_enable(struct pmu *pmu)
> >  			else if (i < n_running)
> >  				continue;
> >  
> > +			cpuc->events[hwc->idx] = event;
> > +
> >  			if (hwc->state & PERF_HES_ARCH)
> >  				continue;
> >  
> > @@ -1379,7 +1381,6 @@ static void x86_pmu_enable(struct pmu *pmu)
> >  			 * if cpuc->enabled = 0, then no wrmsr as
> >  			 * per x86_pmu_enable_event()
> >  			 */
> > -			cpuc->events[hwc->idx] = event;
> >  			x86_pmu_start(event, PERF_EF_RELOAD);
> >  		}
> >  		cpuc->n_added = 0;
> 
> Just think twice, it seems the change could slightly break the logic of
> current PEBS counter snapshot logic. 
> 
> Currently the function intel_perf_event_update_pmc() needs to filter out
> these uninitialized counter by checking if the event is NULL as below
> comments and code show.
> 
> ```
> 
>      * - An event is stopped for some reason, e.g., throttled.
>      *   During this period, another event is added and takes the
>      *   counter of the stopped event. The stopped event is assigned
>      *   to another new and uninitialized counter, since the
>      *   x86_pmu_start(RELOAD) is not invoked for a stopped event.
>      *   The PEBS__DATA_CFG is updated regardless of the event state.
>      *   The uninitialized counter can be recorded in a PEBS record.
>      *   But the cpuc->events[uninitialized_counter] is always NULL,
>      *   because the event is stopped. The uninitialized value is
>      *   safely dropped.
>      */
>     if (!event)
>         return;
> 
> ```
> 
> Once we have this change, then the original index of a stopped event could
> be assigned to a new event. In these case, although the new event is still
> not activated, the cpuc->events[original_index] has been initialized and
> won't be NULL. So intel_perf_event_update_pmc() could update the cached
> count value to wrong event.
> 
> I suppose we have two ways to fix this issue.
> 
> 1. Move "cpuc->events[idx] = event" into x86_pmu_start(), just like what
> the v1 patch does.

That's not what v1 did; v1 did an additional setting.

> 2. Check cpuc->active_mask in intel_perf_event_update_pmc() as well, but
> the side effect is that the cached counter snapshots for the stopped events
> have to be dropped and it has no chance to update the count value for these
> stopped events even though the HW index of these stopped events are not
> occupied by other new events.
> 
> Peter, how's your idea on this? Thanks.

So you're saying that intel_perf_event_update_pmc() will be trying to
read the hardware counter; which hasn't been written with a sensible
value (and thus mis-behave) even though the event is STOPPED and the
active_mask bit is unset?

I'm thinking intel_perf_event_update_pmc() needs help either way around
:-)

