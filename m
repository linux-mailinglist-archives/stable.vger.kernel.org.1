Return-Path: <stable+bounces-224757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FlJN2DUsWk2FgAAu9opvQ
	(envelope-from <stable+bounces-224757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:45:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0626A211
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDEC23024A4F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254E355F43;
	Wed, 11 Mar 2026 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSdd5UAF"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DF375AA1;
	Wed, 11 Mar 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261659; cv=none; b=R0zwoPr/XD9kaE/Uatw0FVckyZGPd6WnOBeKAGJR1aKzNcc2upKtzJU4tGqcCH1K03QNhIq+DfgoLOAns6RF6YPzJ3SxlDPjlNxV8gQmYkkZw3XheS44yyeC9LkrilWNKphulk6EUQjbvwUUftASOupZ8vLNaLbQGB4JYDZyBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261659; c=relaxed/simple;
	bh=pibyIUqXwyf04y7bytC1Pi+7ZXiisHRo3t/sg2L8l9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufCQZuuuKzuHgJRM0vJSBY+v4fPwO4S53Qw/FbJT+XLNXN78Jpi3ukvMsexRaoKyxv4YTEkUmc/CIREBJVsULTKh+09kD7KKPJLPZOz8NBNFeu8r4TKd69TInJRCuIIb+xV0gX+Y9QLGdZ3ZYACqMiX1+h9F+VrtAcnNwmgtd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pSdd5UAF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x5bZPYzyMxtK9zdY/OlIuLaRt8T0wYJhjNW2h89DXJk=; b=pSdd5UAFYIm3vy9aNEHKdNVDDg
	KgXvupNasYG22s1DxfXV3BT3IwTAOYxGnVNxVM4cOctg07VLc7nRWSjd8TbbaLFgvaGqL64TdrIhs
	DynEpIHIj/lKEQmZcEl4hfytZIaf5FGjn0V8qHGhOx8r+p2x9HGIkczAxQxr7TovP9/ByHXDOI6Ju
	J0CIWcW3Cxpx5+NVv/CVpT/bWV28IwLtzaAX3srt1F3jURC6L2YMWVvkvptDdJlEXLSbPrRdNjeJQ
	jAqz+SiepF+F0IgFbZ9a8OfbCr68/RzFReBtTLqRj984YUyELg+8irfhtTpJ35UhQegXa186LmeEx
	B/infNqQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0QME-0000000AHEF-0N6V;
	Wed, 11 Mar 2026 20:40:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A7CA302EC2; Wed, 11 Mar 2026 21:40:35 +0100 (CET)
Date: Wed, 11 Mar 2026 21:40:35 +0100
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
Message-ID: <20260311204035.GX606826@noisy.programming.kicks-ass.net>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
 <20260311173509.GR606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311173509.GR606826@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224757-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,noisy.programming.kicks-ass.net:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63E0626A211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 06:35:09PM +0100, Peter Zijlstra wrote:
> > Additionally, does this change leave the unthrottled event's hardware
> > counter uninitialized?
> 
> Also yes.

Something like so on top of things I suppose.

---
Subject: x86/perf: Make sure to program the counter value for stopped events on migration
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 11 21:29:14 CET 2026

Both Mi Dapeng and Ian Rogers noted that not everything that sets HES_STOPPED
is required to EF_UPDATE. Specifically the 'step 1' loop of rescheduling
explicitly does EF_UPDATE to ensure the counter value is read.

However, then 'step 2' simply leaves the new counter uninitialized when
HES_STOPPED, even though, as noted above, the thing that stopped them might not
be aware it needs to EF_RELOAD -- since it didn't EF_UPDATE on stop.

One such location that is affected is throttling, throttle does pmu->stop(, 0);
and unthrottle does pmu->start(, 0); possibly restarting an uninitialized counter.

Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1374,8 +1374,10 @@ static void x86_pmu_enable(struct pmu *p
 
 			cpuc->events[hwc->idx] = event;
 
-			if (hwc->state & PERF_HES_ARCH)
+			if (hwc->state & PERF_HES_ARCH) {
+				static_call(x86_pmu_set_period)(event);
 				continue;
+			}
 
 			/*
 			 * if cpuc->enabled = 0, then no wrmsr as

