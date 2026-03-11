Return-Path: <stable+bounces-224734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODDBJt6nsWn4EAAAu9opvQ
	(envelope-from <stable+bounces-224734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:35:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D629268115
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94FC9301B7BC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008E3074B1;
	Wed, 11 Mar 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOB/JLbf"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C820C029;
	Wed, 11 Mar 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250523; cv=none; b=Tm9xYTP8GVPEG7EjQoxZG5A2bMaOkyUe2+qRE+rUCUO/1qpeXxoI2/e17H80murpYiVsiVd4Lms7BZpQggwqgxfGIrfQ2Jo1doih/X4as1lIs9uH0pXFh6M1F5TIH0gkpsvXtA7owOBvlWaQ4QaQzJ5oYKIm1gHFRZWwXzmu/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250523; c=relaxed/simple;
	bh=nfzQpXc9eb878tgnSQAa64YWxspgp/2aqVk+zMIXxsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCm4qBEh9P0tWTA3BrE3gTRBnTJaCyM3CAejERD4VyKGkoQI9jp3UMuyl8bFUWzaAW5Xc4jVdmMacns59aXCHN7hqgRE6BKgPTPye7ZeP4TEYstBpke3BWEwM+qRDmu0wobDruu2QwDHotfQrCzByH4YTb0NxcOq5pB1MfdX5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NOB/JLbf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8fRju/0a1YBuwKFU39MW73CZPafQrWliwuiq5VPWm5s=; b=NOB/JLbfeMx/Vm/R4DmzX2hhXt
	7OoHWyGDl64JMAJYnsa9MG0NaEuzf2JKQ6CUIQheoX6RPFXzAUZW+WG+xFuGajHcp1bb8Y0wep4Fb
	RJ67scCk/apAi/JtLWMJL8Ix/L3t6eaeSbitzJ4VH6ZcBeoc1SgQQ3D9QUudy5qWxplW2989wubdy
	6HNKdedR8BW56AG9/53ndcwMy2kMV2SDBeErbweffqQ7kZH3HXJAgj6MyLLIDbQyd1duOfofsmxbB
	l8RiLTJNBWwMZySuTmIpnJOLcAlJi9ok5Gw+LG9/YQbgCKZ8xKD+DZja9R12VfwYuTk682vRCakR2
	kSh/l+2g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0NSg-0000000HQUd-29tc;
	Wed, 11 Mar 2026 17:35:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD9B730027B; Wed, 11 Mar 2026 18:35:09 +0100 (CET)
Date: Wed, 11 Mar 2026 18:35:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20260311173509.GR606826@noisy.programming.kicks-ass.net>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224734-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 2D629268115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:37:08AM -0700, Ian Rogers wrote:

> Fwiw, an AI review was saying something similar to me. 

How do you guys get this AI stuff to say anything sensible at all about
the code? Every time I try, it is telling me the most abject nonsense.
I've wasted hours of my life trying to guide it to known bugs, in vain.

> I wonder if the
> issue with NMI storms exists already via another path:
> 
> By populating cpuc->events[idx] here, even for events that skip
> x86_pmu_start() due to the PERF_HES_ARCH check, can this lead to PEBS
> data corruption?
> 
> For Intel PEBS, intel_pmu_pebs_late_setup() iterates over cpuc->event_list
> and enables PEBS_DATA_CFG for this counter index regardless of its stopped
> state. If the PMU hardware generates PEBS records for this uninitialized
> counter, or if there are leftover PEBS records from the counter's previous
> occupant (since x86_pmu_stop() does not drain the PEBS buffer),
> intel_perf_event_update_pmc() will now find a non-NULL event pointer.
> Will it incorrectly process these leftover records and attribute them
> to the stopped event?

Yes.

> Additionally, does this change leave the unthrottled event's hardware
> counter uninitialized?

Also yes.

> When x86_pmu_enable() moves a throttled event to a new counter, it sets
> PERF_HES_ARCH and skips calling x86_pmu_start(event, PERF_EF_RELOAD).
> Later, when the timer tick unthrottles the event, it calls
> perf_event_unthrottle(), which invokes event->pmu->start(event, 0).
> In x86_pmu_start(), because flags == 0 (lacking PERF_EF_RELOAD),
> x86_pmu_set_period() is skipped. Will the newly assigned hardware counter
> be enabled without being programmed with the event's period, potentially
> causing it to start from a garbage value and leading to incorrect sampling
> intervals or NMI storms?

Don't think you can get NMI storms this way. If the PMI trips, we'll do
set_period and that should fix it up.

So just wrong counting.

