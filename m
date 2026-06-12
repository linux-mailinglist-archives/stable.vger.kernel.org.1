Return-Path: <stable+bounces-262903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U/s2MOnVK2oQGAQAu9opvQ
	(envelope-from <stable+bounces-262903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:48:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526B6786C2
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=VNA323Dr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262903-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262903-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5ABF308B99E
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131AB386576;
	Fri, 12 Jun 2026 09:46:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7434CFD3;
	Fri, 12 Jun 2026 09:46:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257616; cv=none; b=WwV4ztho/iVTNXyO6v1aye+uzzU0oJfnLNgVkbT0M4spVOowrxW6ImwBZW5Ad5cHkBlnvlPfweH4lvAUYI9PiGfqVRKaSGqAsLTuDyqRlV7CDfzLswt/jZ1v0f5ZJq0cCJlHDsfeMTZJF59CTOF07TPFFZ/cbw0Rhz6VzeAhDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257616; c=relaxed/simple;
	bh=CmjqGI0s0vnqCK5JH597mmLCQGFSpnabTIVdkKXBQ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNDzn8cbnhIf6u6UfCo9k5IV+vwUG+aNLPZRitXyfzx97BihGQ3P9fArCeiyJkilo/+hh22l/p2qJPqQj/z1VBaxOOCp3Mfke72WZj6QS6XIvxW4zQ5Fg1q2U3iXdQ+Eq1JHk820saA9b8/z02rI1A/957UI2N1uaAFjrH7Ekng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VNA323Dr; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMS1rHvde0qOXS7Wu2x8UE9Q5Ye6ybC0ttjK2rfWB6Q=; b=VNA323DrX5BNk+JJOWyjsWhp3k
	KPj5g5zLfSAQIow4hDlCntjhnbabObBxW8UOZtzL2wXIXTvqeF/7jEUjfw/Ud3Wp5q9ZvMTGb81iB
	v27eu5sR/BcKatXQzYxNq5Yv0Sy/4YPaAcSlr3p/f/yKH/UvwfgQ+rkDExA11Ofac8m4Iw6wB2xxx
	gEJWdpOTl/1z1um/xIETExZlQnjjbZkhVFf0dm9cDLafES15o59uvv4nCN5YUhLn5DdAK3yR7UG8R
	2LdMBx1GMhnqwKb+JGeVtDJCOU1qQNTE/3OcPDbNkhQDS90gPksnH0E7Zx1qIMJPWuNGxzZsuITSN
	ahHKxomQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXyTR-00000006G7b-35qA;
	Fri, 12 Jun 2026 09:46:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C62ED300312; Fri, 12 Jun 2026 11:46:48 +0200 (CEST)
Date: Fri, 12 Jun 2026 11:46:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
Message-ID: <20260612094648.GB42921@noisy.programming.kicks-ass.net>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262903-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dapeng1.mi@linux.intel.com,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:ak@linux.intel.com,m:eranian@google.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:dapeng1.mi@intel.com,m:zide.chen@intel.com,m:thomas.falcon@intel.com,m:xudong.hao@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:from_mime,noisy.programming.kicks-ass.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2526B6786C2

On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
> represent "anythread deprecation" in perf_capabilities. It leads to the
> anythread_deprecated bit could be overwritten by the real value of
> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
> 
> ```
> if (!intel_pmu_broken_perf_cap()) {
> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
> }
> ```
> 
> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
> these support Perfmon v6 platforms, like Clearwater Forest.
> 
> ```
> $grep . /sys/devices/cpu/format/*
> /sys/devices/cpu/format/acr_mask:config2:0-63
> /sys/devices/cpu/format/any:config:21
> /sys/devices/cpu/format/cmask:config:24-31
> ```
> 
> So remove the anythread_deprecated bit from perf_capabilities structure
> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
> deprecated.

Again, no markdown please. I've stripped it from these patches.

