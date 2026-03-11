Return-Path: <stable+bounces-224753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FSPGrTOsWmQFQAAu9opvQ
	(envelope-from <stable+bounces-224753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:21:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B8269EB1
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 965FC3016246
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D273331230;
	Wed, 11 Mar 2026 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BkQmcnXx"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA9310620;
	Wed, 11 Mar 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260333; cv=none; b=SVqTPt+oMi+C0p60G2X0C4qT2JXoPIblIoR3V6tOeHnQTlt47e/Oa/WcEyan8ANULqaiVBbiesOH80fGeWG7NXVvxCpSYYfOa8GVIUTSghh7kAtLaCDDj368xuNq+Mdr7SN9N6JutDYvkbZknTMY5VUiCM98/eVRuO36wa0PC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260333; c=relaxed/simple;
	bh=id27drD3i1tIKPtuJmasqTA+MRdOQ14tdZnRcyd2bKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7le1Q/fgLNNllknzyTDjqeh73fvG3P4MVp8LVza9CmbFg29WbCa5Hn2h3KUbLRMiIldJVzv20y4sSAbbpEVpyeoIu2xfW8qXawyxnynALCp1YyFHEQL9nZIzMzPzhIbkGd7nzLXu2tz/jdWPQjCpv13B6feu/7ROS8EQnSSZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BkQmcnXx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EcQTh7Kf3/pay1N8qJTn9d7r6CT2Jiy0Wg9T409UmbI=; b=BkQmcnXx4eh9Bq2DCZhjDpRbOZ
	SEyixXVLzKXEaYSaURgqq2hp0jduuL1rtfUf7Q8ZGgbxQIM5+gyCJEjwow6h3QRuOU7C/AD/RoNuc
	L9OBxIT/u7lWuTVOCTkcdcxUWkWNBAvMO/d/aDBWHkLUvWeDKT8CkyEihnEjzUbqTtUJYvjvw48fs
	rnFysI6BBxGSIX4NMiYlH8Nn+44/7LitWeBKLGAlDEIFGH3d6TwG5PuuzdQrde56fcRbG8cjiymW7
	osxdUo3GxEFc2pFyq2T94NucMwsc0Z9gpi8e5Vw/yZJ/FezUgwGbOffJWPglIuIbenj2XZPo8kXHL
	CVJkAiwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Pyk-000000003hl-0kPi;
	Wed, 11 Mar 2026 20:18:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 96D92302EC2; Wed, 11 Mar 2026 21:16:25 +0100 (CET)
Date: Wed, 11 Mar 2026 21:16:25 +0100
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
Subject: Re: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters
 constraint apply
Message-ID: <20260311201625.GW606826@noisy.programming.kicks-ass.net>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: D70B8269EB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Feb 28, 2026 at 01:33:20PM +0800, Dapeng Mi wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4768236c054b..4b042d71104f 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
>  		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
>  }
>  
> +static inline int intel_set_branch_counter_constr(struct perf_event *event,
> +						  int *num)
> +{
> +	if (branch_sample_call_stack(event))
> +		return -EINVAL;
> +	if (branch_sample_counters(event)) {
> +		(*num)++;
> +		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
> +	}
> +
> +	return 0;
> +}
> +
>  static int intel_pmu_hw_config(struct perf_event *event)
>  {
>  	int ret = x86_pmu_hw_config(event);
> @@ -4698,21 +4711,18 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		 * group, which requires the extra space to store the counters.
>  		 */
>  		leader = event->group_leader;
> +		if (intel_set_branch_counter_constr(leader, &num))
>  			return -EINVAL;
>  		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
>  
>  		for_each_sibling_event(sibling, leader) {
> +			if (intel_set_branch_counter_constr(sibling, &num))
> +				return -EINVAL;
> +		}
> +

Do the new bit is this, right?

> +		if (event != leader) {
> +			if (intel_set_branch_counter_constr(event, &num))
>  				return -EINVAL;
>  		}

The point being that for_each_sibling_event() will not have iterated the
event because its not on the list yet?

That wasn't really clear from the changelog and I think that deserves a
comment as well.

Let me go fix that.

