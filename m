Return-Path: <stable+bounces-225307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HjWIj4TtGlkgwAAu9opvQ
	(envelope-from <stable+bounces-225307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:38:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33329284063
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B94309CF05
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9723AEF53;
	Fri, 13 Mar 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mSKEJ6Xx"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA13AD533;
	Fri, 13 Mar 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408268; cv=none; b=ZaCvbbYjYxgW8pBMoG+86Ry4ungBn8XHWC313rnNehClL8e0noyD7omjyOC+ToVudrUy7O2ZyXgZxb3ZLnOW+fiYVeoytPDV18xVodeF6xQrJ+YXzrDayLJBb/TK0IcDcslKrpRE4OOhKLEpcUVZkxZtG/k35tixt4/snedUViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408268; c=relaxed/simple;
	bh=WdbifB+Lpy61GxOTmYIJ/0d0Q7fAs/e2+cEJDWNbeeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8J48bN7IrElqdN7hJo5kSB46nPhkk2450VEdPiTMlJ14XuLQgEIQpn1bFTiIJlem0/3/Ugaxuyml803+XY/wPuxFHj+I6A1t8sWIOP9s3A2c5/mVWdLwEM3ELObB1I5NgDRk1XkBX42KmtiP52Bbxpec4GJgkdnvC8+BMlaHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mSKEJ6Xx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X6CzG4WOOG89ao7WBG1kuZfV24i1xtrz3dwp1BQ647U=; b=mSKEJ6XxlogPw/552tbelWc2Zz
	PdiqU4/kgpDb0b2MGgMZh4POFgho9l/Cw574YBNjVwaSp7VSfLrprJRQ81CBRWIsLg1Df5bjoAJ7h
	OFEXI7Is0HnzJvVoPXbKCymHJJQYgyie3i3ufKEHUS7nWE1vugAjMSSeCoA+JFreB4IGG3F0/FxX4
	eI+njI1x9EdNVkprQDwi4vr+aQzk0I19myY+2vu5XsunIOOYhvbvvUB1RbHXmU5eueYOK7mDvbDeB
	bqIzi7DGBWj0tYteJAofvUwvUXkO+zr78gUc+Q8Ob3+WA6ljCl35gb5VNXyuPvwaIG1wdJLcTdRth
	gsivNQgg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w12UV-005LlJ-Qm; Fri, 13 Mar 2026 13:23:48 +0000
Date: Fri, 13 Mar 2026 06:23:41 -0700
From: Breno Leitao <leitao@debian.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
Message-ID: <abQPM7zKWBaNJufd@gmail.com>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
 <20260311173509.GR606826@noisy.programming.kicks-ass.net>
 <20260311204035.GX606826@noisy.programming.kicks-ass.net>
 <9e0e04e9-7421-4dfb-a017-c31741a8d500@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e0e04e9-7421-4dfb-a017-c31741a8d500@linux.intel.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225307-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,infradead.org:email]
X-Rspamd-Queue-Id: 33329284063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:53:59AM +0800, Mi, Dapeng wrote:
> On 3/12/2026 4:40 AM, Peter Zijlstra wrote:
> > Subject: x86/perf: Make sure to program the counter value for stopped events on migration
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Wed Mar 11 21:29:14 CET 2026
> >
> > Both Mi Dapeng and Ian Rogers noted that not everything that sets HES_STOPPED
> > is required to EF_UPDATE. Specifically the 'step 1' loop of rescheduling
> > explicitly does EF_UPDATE to ensure the counter value is read.
> >
> > However, then 'step 2' simply leaves the new counter uninitialized when
> > HES_STOPPED, even though, as noted above, the thing that stopped them might not
> > be aware it needs to EF_RELOAD -- since it didn't EF_UPDATE on stop.
> >
> > One such location that is affected is throttling, throttle does pmu->stop(, 0);
> > and unthrottle does pmu->start(, 0); possibly restarting an uninitialized counter.
> >
> > Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> > Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Reported-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/events/core.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1374,8 +1374,10 @@ static void x86_pmu_enable(struct pmu *p
> >
> >  			cpuc->events[hwc->idx] = event;
> >
> > -			if (hwc->state & PERF_HES_ARCH)
> > +			if (hwc->state & PERF_HES_ARCH) {
> > +				static_call(x86_pmu_set_period)(event);
> >  				continue;
> > +			}
> >
> >  			/*
> >  			 * if cpuc->enabled = 0, then no wrmsr as
>
> LGTM.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thank you for the patch and the discussion. To confirm my understanding:
this patch should be applied on top of my v2 series to fully resolve the
issue, correct?

If so, would you prefer that I include both patches together in a single
series, or are you fine with them as-is?

Thanks,
--breno

