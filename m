Return-Path: <stable+bounces-247287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDkHGng7BmqdggIAu9opvQ
	(envelope-from <stable+bounces-247287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:15:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B191546F46
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A0AC3016B76
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC47397323;
	Thu, 14 May 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or8IOM16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF631E852;
	Thu, 14 May 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793333; cv=none; b=T96rkNo4ou3lTYMODRF9jkkXs2K9Y+njZeSDfqF0qB1jfT6Zj9aWQu1baPUfuF4t4LNKK74480I+0KjbH4w8TIeekcx2NfwON7UbiJHSG4C7UhwaA8JxWZAajuiAe6w95O1fnfmswg17z6rEcD09VmQiZiiF5yJ7cCWPf/KzVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793333; c=relaxed/simple;
	bh=zn5jP5uribMvXcgpJ0rp7zvAd2mUNvr/nvoMbhIOkfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWX1rWB2NsYr5uWcSJ8XOW5AKMe8vzWx6bBPNwWscHZb3JHSCYpa5Hmf/tAIgUfiYvThLgQwG1aFlutqxeN3gO6qMDnSqwAq9L3UUMOnbZU1QnjdHND4VACXoXscdfLHpZKGSPWp1rpjPxqS5O3s7GOtW+paZjDv97Qfky9vc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or8IOM16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B3C2BCB3;
	Thu, 14 May 2026 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778793332;
	bh=zn5jP5uribMvXcgpJ0rp7zvAd2mUNvr/nvoMbhIOkfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=or8IOM16rev9cFQwpI4jVqNDZ0q7GVW/e0EcNWlKzYjXyFvzub2zbIGW0G86qE1Ue
	 +ApV+i2W9qfuPfuDnJN7qTwGz4SGodhJnuNUR6R8CqNd2igNcTBFCQg1EIqIjYxPEW
	 DLAUnzrQuogcEl+oYZfSE1aGPttEr4bE7dDe+IxFTTslZqT8AcD3RZw1wIK5nCJNtw
	 /TCIXQ+tr1cmGoNMelfW/bcJFQ33GXrC/S+lAhUNW0zKmNg+Lb4cSg6fh4/u9+3jwa
	 FmloQsEmx5m+Amv6sFhdn3wM8bMcdOL967THrwGmBYsGI+uxd2kXUiN723V//eJ5u0
	 BMo0ZQ0HyBtpA==
Date: Thu, 14 May 2026 11:15:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linux RT Development <linux-rt-devel@lists.linux.dev>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <agY7c_uARe72fhwa@slm.duckdns.org>
References: <056f95bc5805f7e161458984fff4b3cb@kernel.org>
 <20260512172847.5024e5e8@gandalf.local.home>
 <20260513193914.1593369-1-tj@kernel.org>
 <20260513202432.18dd7b9f@gandalf.local.home>
 <agUdAatmlqQc1NS_@slm.duckdns.org>
 <20260513213108.2870a1e7@fedora>
 <agUodtxEi24HQ1Oo@slm.duckdns.org>
 <20260513220136.5a11c740@fedora>
 <agVUH-L503DwAiSW@slm.duckdns.org>
 <20260514100300.1d594c7a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514100300.1d594c7a@gandalf.local.home>
X-Rspamd-Queue-Id: 0B191546F46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247287-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

Hello, Steven.

On Thu, May 14, 2026 at 10:03:00AM -0400, Steven Rostedt wrote:
> I was thinking about this more and does disabling the RT_PUSH_IPI cause any
> problems for you?
> 
>   # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched/features

Not at all. This is actually the mitigation that we deployed across the
affected machines.

...
> -/* RT IPI pull logic requires IRQ_WORK */
> -#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
> +/*
> + * RT IPI pull logic requires IRQ_WORK and doesn't make sense for uniprocessors.
> + * If CONFIG_IRQ_FORCED_THREADING isn't set, then softirqs do not run as threads
> + * and can cause latency larger than what RT_PUSH_IPI can save, killing the
> + * effect of it.
> + */
> +#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP) &&	\
> +	defined(CONFIG_IRQ_FORCED_THREADING)
>  # define HAVE_RT_PUSH_IPI
>  #endif

Maybe it should trigger on force_irqthreads so that it's active only when
irq threads are actully enabled.

Whichever way it's done tho, wouldn't this still leave machines in that
config susceptible to IPI storms? It took a combination of factors to
trigger - mpi3mr's threaded irq, psimon activated by systemd, and sustained
network load - but those factors are not that exotic.

Thanks.

-- 
tejun

