Return-Path: <stable+bounces-224722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFkrHJ2asWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:38:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B836B267757
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6732030378B3
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0A3DDDC0;
	Wed, 11 Mar 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StTXfS0d"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498E31F98D
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247043; cv=pass; b=Lw07ZlpQ8HPI9RkzsWOnsZ7FR9czY7W49f1YF/nmvlJkZAkkXCMNH7WrpFDMtkahpS1YLN962sAtCwI8Kcd3evAgFuvIh4TrchZ98dgJVciGdM32g03OEUisYJyt9Alco4Ulu65gWZNjfA+w6aCFd+KwDW8ezuwCBqtLS6/+/Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247043; c=relaxed/simple;
	bh=RlZtAcOHvn6iVXytHsYQcRdB5CnLSzmJ0LmW71rJClM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMrX04V5euTlSzZZid+0QE4SL01kKU3ao4AtE4CNrLpTtktJK+AhYwANzmcauLf37Y4m5tnMwnWVecirMMxV3+S6By5vzoUQvUadIEu0chfLtn9B1lsvYli/sk0JB4EXiLJBzF/udNUNKGdz0UNQzVJFgv1saViBkGJ9t/NyxYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StTXfS0d; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9697so10311c88.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773247041; cv=none;
        d=google.com; s=arc-20240605;
        b=TLjefPs8IC1eN9By1WVCFHyZjm4xe0rJdwEZ9vjHiGWUZkFvWy1ahl3eEveLpNkoZX
         OfHeq9Si2sj4Uh1DyW/RtQi6GfrozRzczX5DRqNYUU0QCZ5cSwdwCkK6SFZKfbFVOz9h
         ykKRLKGOpr+YF3AOBiOYAdz7OyGnl5Rv0nxDU1XBCwecm1ysq/zx1YcY/HjKB+ya2tij
         F62nfd3CAt6I8C1p08YtrWXVl3pj/jTojQ4d2i99nhFHmyFBYpy7SQICOfhaQ+0pZYpw
         hk5odY2Ut2UoFCfBAx6xIlfsoNL8PyvlKl/ARzRYTc9i79s7APwbPmC1V5fusxPqoCmb
         Khaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQ1RUAYmZNd/ngoTZfJcP2qTw/1JJE3aRmrbR1xxSBU=;
        fh=3moCDvFBBO6oq1psIPEkWmPrX+KISK/eyy4AeFXaVmU=;
        b=EccN9/djFcL/ntP2lrjK1P+SKto3kFfZ60hMjYiJZdnhfWJT+7NQ8OoYbtmK/0AxTA
         pDuwrvlatsZfN0gt8uist1Om/I0qrW8UOn63lRPpyDill8hPyWrOy6IvhOCeuC68wHV7
         MSqaSDc1A5rk3Ym5leeBMLln5h/uj41VC3r/Q3t6nYLMhhJ/on/1D66SGLpSGlmrYYo+
         pz1vq1UVaTLa73j6gyTqgXXJm00GSb2ARbEL+d3gWIJ1AIuyQJRVkIWly+NGiptclI8i
         P0BOLwbwENwpiV1xv8csxWesJofXeBj5RGvAo6hZlWiRltZY1V38yn0BIkLduJw0QEhQ
         w3+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773247041; x=1773851841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ1RUAYmZNd/ngoTZfJcP2qTw/1JJE3aRmrbR1xxSBU=;
        b=StTXfS0ded77R74IpXMr3Ng2ShsSzNdfe+rPls8ww4sM8ihS61JatCJSvn1l2msfW7
         DKQinlLsEIZVM31NKHqD3wQklKCr4NqtH/K03e9yZYS9l91rP8crTVYhNKxTYdtDVfZG
         x9oEzeQbglwmS64On/+Qr9/0ItpOqvytKbzCc6gNSd8cZZSWh2lxceDGOR8LMRFbE3s2
         fj2FGWya8CIIYr28Tszvdp81KpAlH9NAXPhX24/RsvhFevEqTGwN7Gb11xyzgTIIYG/r
         dOiH3nI4R5Y48KN/zzTvaTJaGjoo9Xu1cWHkxJNZxD1Yjk5321ZzUbpzSYgrYtZREFXG
         KYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247041; x=1773851841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQ1RUAYmZNd/ngoTZfJcP2qTw/1JJE3aRmrbR1xxSBU=;
        b=GSEgvSgB+6092mdyvLGrLSReyAVJks4Mui6Cw3aWiSDhZ3ambQYuLDL51dBzpXspu8
         c6M11Rq++oLaKRncH7qTvN2xcQMy6MfKjZH/DjaNmn9venSRqZdqGkEdOUrDPS7h2aW3
         lEfNf/kDm695NFTAeKt1P5lX4iJsZxMkWMcfLjh2HbUbu7mxBpLczWbbIdW4Au4UT42G
         rx+vn/do8nN8BvoEk94GQQa6hFl91tHk1Q1cNXsM2s3L6Qv0rhOslQ73jkaBpNUMHQYk
         h0/f8mhJypvdJH8bPnqpNuOAr8evEsL4bZLbrhOZSGYB0qlmELfpiNZW33bBZXqL8R6W
         TWtg==
X-Forwarded-Encrypted: i=1; AJvYcCUdVNtkF0x3TWzCQUSRpXTQsQhXiDnsP9jNeUOobWOXd30fmZC1rS5+sf06BOMirGFC4sIjoUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8BbKp4Ob2xKYQ/cTJqZXbHCeIrCMGN+8AaeHpjrjwStng/FX
	aRteg+Nrl4XV90YfqFUxZYSrsWuiFcC9dwSn3S2XjLrhlsoDWwYklSjSRUA1gD71qcyi0lsZJKZ
	ogC45xvA0RxFr11Yz9LLtk63eFlxTkPiDp6w1Hu/N
X-Gm-Gg: ATEYQzye5J+80+HC2iwqLNnts/FM5otJCUV49eEoCX98DV5Rr6VNBkIJ73aYxhiEp+6
	36Wtj0sKTjMGj/x7FrS44zk/CpcxYJq6U+Oo4w0mFR1ek1Jy1ZSalbiAbh+Q5a2jCWpD/U1tRav
	KLSknhzWMa08ScxQyviFJombzqvA2EPzhxVItZVljbjPoGTEbzG7IP0XXob5J28mSTnXdY4sNxa
	t9GKZc6zssbAuaaq2cCDElb9CVFKdq/MAdBUg3XuLfA3N1CMItrJ4p6LnjEy+4+VsDqYwyoYi8U
	LJPKKH7M7Rm/mnWja5ccFrYzGFLo/LU+wfJj
X-Received: by 2002:a05:7022:b042:20b0:119:e55a:808a with SMTP id
 a92af1059eb24-128e77a3b92mr116800c88.7.1773247040555; Wed, 11 Mar 2026
 09:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-perf-v2-1-4a3156fce43c@debian.org> <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
In-Reply-To: <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 09:37:08 -0700
X-Gm-Features: AaiRm53fw3sDFWpIBogA8_eyq0TFS7uy1Q85OPZ7cibdyxOYGImWoI-uFyMCu5I
Message-ID: <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in x86_pmu_enable()
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224722-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B836B267757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 7:04=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
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
> > The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=3D0,
> > corresponding to the `if (unlikely(!hwc->event_base))` check in
> > x86_perf_event_update() where hwc =3D &event->hw and event is NULL.
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
> > with hw.idx=3D2 and hw.state=3D0x0, confirming x86_pmu_start() had run
> > (which clears hw.state and sets active_mask) but events[2] was
> > never populated.
> >
> > Another event (event_list[0]) had hw.state=3D0x7 (STOPPED|UPTODATE|ARCH=
),
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
> > Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEB=
S record loss")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes in v2:
> > - Move event pointer setup earlier in x86_pmu_enable() (peterz)
> > - Rewrote the patch title, given the new approach
> > - Link to v1: https://patch.msgid.link/20260309-perf-v1-1-601ffb531893@=
debian.org
> > ---
> >  arch/x86/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 03ce1bc7ef2ea..54b4c315d927f 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1372,6 +1372,8 @@ static void x86_pmu_enable(struct pmu *pmu)
> >                       else if (i < n_running)
> >                               continue;
> >
> > +                     cpuc->events[hwc->idx] =3D event;
> > +
> >                       if (hwc->state & PERF_HES_ARCH)
> >                               continue;
> >
> > @@ -1379,7 +1381,6 @@ static void x86_pmu_enable(struct pmu *pmu)
> >                        * if cpuc->enabled =3D 0, then no wrmsr as
> >                        * per x86_pmu_enable_event()
> >                        */
> > -                     cpuc->events[hwc->idx] =3D event;
> >                       x86_pmu_start(event, PERF_EF_RELOAD);
> >               }
> >               cpuc->n_added =3D 0;
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
>      * - An event is stopped for some reason, e.g., throttled.
>      *   During this period, another event is added and takes the
>      *   counter of the stopped event. The stopped event is assigned
>      *   to another new and uninitialized counter, since the
>      *   x86_pmu_start(RELOAD) is not invoked for a stopped event.
>      *   The PEBS__DATA_CFG is updated regardless of the event state.
>      *   The uninitialized counter can be recorded in a PEBS record.
>      *   But the cpuc->events[uninitialized_counter] is always NULL,
>      *   because the event is stopped. The uninitialized value is
>      *   safely dropped.
>      */
>     if (!event)
>         return;
>
> ```
>
> Once we have this change, then the original index of a stopped event coul=
d
> be assigned to a new event. In these case, although the new event is stil=
l
> not activated, the cpuc->events[original_index] has been initialized and
> won't be NULL. So intel_perf_event_update_pmc() could update the cached
> count value to wrong event.
>
> I suppose we have two ways to fix this issue.
>
> 1. Move "cpuc->events[idx] =3D event" into x86_pmu_start(), just like wha=
t
> the v1 patch does.
>
> 2. Check cpuc->active_mask in intel_perf_event_update_pmc() as well, but
> the side effect is that the cached counter snapshots for the stopped even=
ts
> have to be dropped and it has no chance to update the count value for the=
se
> stopped events even though the HW index of these stopped events are not
> occupied by other new events.
>
> Peter, how's your idea on this? Thanks.

Fwiw, an AI review was saying something similar to me. I wonder if the
issue with NMI storms exists already via another path:

By populating cpuc->events[idx] here, even for events that skip
x86_pmu_start() due to the PERF_HES_ARCH check, can this lead to PEBS
data corruption?

For Intel PEBS, intel_pmu_pebs_late_setup() iterates over cpuc->event_list
and enables PEBS_DATA_CFG for this counter index regardless of its stopped
state. If the PMU hardware generates PEBS records for this uninitialized
counter, or if there are leftover PEBS records from the counter's previous
occupant (since x86_pmu_stop() does not drain the PEBS buffer),
intel_perf_event_update_pmc() will now find a non-NULL event pointer.
Will it incorrectly process these leftover records and attribute them
to the stopped event?

Additionally, does this change leave the unthrottled event's hardware
counter uninitialized?

When x86_pmu_enable() moves a throttled event to a new counter, it sets
PERF_HES_ARCH and skips calling x86_pmu_start(event, PERF_EF_RELOAD).
Later, when the timer tick unthrottles the event, it calls
perf_event_unthrottle(), which invokes event->pmu->start(event, 0).
In x86_pmu_start(), because flags =3D=3D 0 (lacking PERF_EF_RELOAD),
x86_pmu_set_period() is skipped. Will the newly assigned hardware counter
be enabled without being programmed with the event's period, potentially
causing it to start from a garbage value and leading to incorrect sampling
intervals or NMI storms?

Thanks,
Ian


> >
> > ---
> > base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
> > change-id: 20260309-perf-fd32da0317a8
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
> >

