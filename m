Return-Path: <stable+bounces-225331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCgcA+YvtGmuigAAu9opvQ
	(envelope-from <stable+bounces-225331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:40:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58E286313
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44AC2300B444
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E83B3C14;
	Fri, 13 Mar 2026 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="exzRCStB"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921D3B2FF0;
	Fri, 13 Mar 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416136; cv=none; b=DY15rrATjzUT7Tmu2nrxwjDMnqdrn8lWQmcmgkztBKle0pYtiqcPt3E6Rg5Ln+JUKaNn/+w1TpR3kPnxrHpzAFoe4+ezCT01YD0CNsBD5u0o2Dt8+7oKBccr7nrqVdAvMWf2kDYlVO0Q2cQ1t1IEWcfNdGxgJKswNJhBoTQ33dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416136; c=relaxed/simple;
	bh=LiVpjZyWcLgaZBso4RHPZwM346VQfW2lwVDPOvwOGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqdcxxWasiPueWQJKN9GS4ncRYKDoJ7rQ2K1IfnBYlYdytkUfcl3FVcqK5N8FLlnoAYYwvTOdHOOpYbOoJfLa38o1o/k5W10g0YO3Hwi92sJ5EJ+1ThofI0T74/dKWIrK0loEBbdwIrUyyNbnEqjjDnrE8vOWlJ/eFOivMvprXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=exzRCStB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dWMRU5JVS/t7/tdyfkDrfyI+p1lveBJHbU8Nl4HN8OU=; b=exzRCStBODRJ0dm7D5emwmIuQA
	Z5StnHDK/A8VRC+ZT9kadzJgmY06ey8oeYuWuaN7BEUZXbBOM64ScuVVZrq9UcS3xHSuGZDW3BB2u
	9A4jNjZmr/Ep8fcsKalhjUec18gYWofupd/Aqb1rg6qmEEP4TaZuGSUUBAU53kcF54Lg8RJsT/MSs
	PIGKz8g2sIZM8RxrPDOO0gTaE1PEJAG/4+tR1n+ETl4F0ISCFGSa5gDNnyKD6EBrLpkKTVQUxfav/
	9wJWVhoEXep7HOjkpNpaUd62jkE+GaYtgOYYefv3cZ8n5sknkt4S2c2JcFeHLClbcoDVI4iiUu4vY
	eKOBby4g==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w14Xk-00000003iKj-3mNu;
	Fri, 13 Mar 2026 15:35:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B790A303377; Fri, 13 Mar 2026 16:35:15 +0100 (CET)
Date: Fri, 13 Mar 2026 16:35:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
Message-ID: <20260313153515.GC2872@noisy.programming.kicks-ass.net>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
 <20260311173509.GR606826@noisy.programming.kicks-ass.net>
 <20260311204035.GX606826@noisy.programming.kicks-ass.net>
 <9e0e04e9-7421-4dfb-a017-c31741a8d500@linux.intel.com>
 <abQPM7zKWBaNJufd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abQPM7zKWBaNJufd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225331-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E58E286313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 06:23:41AM -0700, Breno Leitao wrote:
> On Thu, Mar 12, 2026 at 10:53:59AM +0800, Mi, Dapeng wrote:
> > On 3/12/2026 4:40 AM, Peter Zijlstra wrote:
> > > Subject: x86/perf: Make sure to program the counter value for stopped events on migration
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Wed Mar 11 21:29:14 CET 2026
> > >
> > > Both Mi Dapeng and Ian Rogers noted that not everything that sets HES_STOPPED
> > > is required to EF_UPDATE. Specifically the 'step 1' loop of rescheduling
> > > explicitly does EF_UPDATE to ensure the counter value is read.
> > >
> > > However, then 'step 2' simply leaves the new counter uninitialized when
> > > HES_STOPPED, even though, as noted above, the thing that stopped them might not
> > > be aware it needs to EF_RELOAD -- since it didn't EF_UPDATE on stop.
> > >
> > > One such location that is affected is throttling, throttle does pmu->stop(, 0);
> > > and unthrottle does pmu->start(, 0); possibly restarting an uninitialized counter.
> > >
> > > Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> > > Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > Reported-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/events/core.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -1374,8 +1374,10 @@ static void x86_pmu_enable(struct pmu *p
> > >
> > >  			cpuc->events[hwc->idx] = event;
> > >
> > > -			if (hwc->state & PERF_HES_ARCH)
> > > +			if (hwc->state & PERF_HES_ARCH) {
> > > +				static_call(x86_pmu_set_period)(event);
> > >  				continue;
> > > +			}
> > >
> > >  			/*
> > >  			 * if cpuc->enabled = 0, then no wrmsr as
> >
> > LGTM.
> >
> > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Thank you for the patch and the discussion. To confirm my understanding:
> this patch should be applied on top of my v2 series to fully resolve the
> issue, correct?
> 
> If so, would you prefer that I include both patches together in a single
> series, or are you fine with them as-is?

Yeah, I've got then in queue/perf/urgent and once the robot is done
chewing on them, I'll push them out into tip.

Thanks!

