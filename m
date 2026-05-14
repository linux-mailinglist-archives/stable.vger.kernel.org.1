Return-Path: <stable+bounces-247298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEhfOh9eBmrijAIAu9opvQ
	(envelope-from <stable+bounces-247298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:43:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A3547D00
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85B8C300B2AA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491939E16B;
	Thu, 14 May 2026 23:43:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457A38D68F;
	Thu, 14 May 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802202; cv=none; b=kES7e/egr9p2s5EWPVekWfucbiRyRI9FFODB66vOCI68Cx3+7tH6H/+cPHKg/l7Ne5JRLW1YD1VnVf4yvnwsi0K+LjV8YAcmjZroQOb7btFI9ZhIUz7UgWVQcx8IDfkh+cf+1+yW8A82B3lOlV0xA+Vc6X55NNfRIW8oEfHwfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802202; c=relaxed/simple;
	bh=p6ctIFvWGNlH9lN/l6PNNGCRAq+meZ2OXsTIIxQcn1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9VFWYX8N7BiFMBvzJZSnJw05Q970IprQ+uVsI41h/Il2riytRoQl3d+boccexpF0WpmYVyJG02MtDoKR8Zc/JaBssZKjNqmietbmFiYT0ntEpmJRszMPhQPV+R1sRLhpF7p5qQuz6CuviHaPJknn39b3Tch7C5OjxI38YqAiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 37BCC40641;
	Thu, 14 May 2026 23:43:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id ED4D52001F;
	Thu, 14 May 2026 23:43:13 +0000 (UTC)
Date: Thu, 14 May 2026 19:43:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260514194312.1877c9e1@fedora>
In-Reply-To: <agY7c_uARe72fhwa@slm.duckdns.org>
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
	<agY7c_uARe72fhwa@slm.duckdns.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hqc44f6bs8szk6rx8gui3qhb8sh5gt81
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/H0npIT7mEPsaORhcoXGF2iKkqw8e/JEo=
X-HE-Tag: 1778802193-756747
X-HE-Meta: U2FsdGVkX1/5hrnnQPu2X0d1OkpXPBHKvnZmxmESV/S0WUKpmz6VPjDESkwY4nn6BRAIvHtow5BFgZ3SjOS4a9Dwgx2P3QgYng/M+xmVJrCGxRh6LecmfvyXOob9f4LBVlqVQJYJoucCVGpJ46QErCBjE5Wsre3XicgkcHQ42XCt2berb/JspN1W4VePCCD/Bv6EkjBxdFzRGOdbvCPS7dKIScZJ27P/pZkLo9DqpfNj//LbqVD//V5SsD+bUagSL9Vc/C7gS+Dq076MGOZzG4LGLKMgaDqdKHWlX0LhAcJJ9GCIXtawwIQR+qVleal1CA8rvgreHaiUGeI9vNHpDru2I6lISS3i
X-Rspamd-Queue-Id: EF3A3547D00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247298-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 11:15:31 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello, Steven.
> 
> On Thu, May 14, 2026 at 10:03:00AM -0400, Steven Rostedt wrote:
> > I was thinking about this more and does disabling the RT_PUSH_IPI cause any
> > problems for you?
> > 
> >   # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched/features  
> 
> Not at all. This is actually the mitigation that we deployed across the
> affected machines.
> 
> ...
> > -/* RT IPI pull logic requires IRQ_WORK */
> > -#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
> > +/*
> > + * RT IPI pull logic requires IRQ_WORK and doesn't make sense for uniprocessors.
> > + * If CONFIG_IRQ_FORCED_THREADING isn't set, then softirqs do not run as threads
> > + * and can cause latency larger than what RT_PUSH_IPI can save, killing the
> > + * effect of it.
> > + */
> > +#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP) &&	\
> > +	defined(CONFIG_IRQ_FORCED_THREADING)
> >  # define HAVE_RT_PUSH_IPI
> >  #endif  
> 
> Maybe it should trigger on force_irqthreads so that it's active only when
> irq threads are actully enabled.

Well, PREEMPT_RT doesn't need force_irqthreads for this to be enabled.
But I could keep this configured like the above, but have the feature to
be disabled on boot up if !PREEMPT_RT and force_irqthreads is not set.

> 
> Whichever way it's done tho, wouldn't this still leave machines in that
> config susceptible to IPI storms? It took a combination of factors to
> trigger - mpi3mr's threaded irq, psimon activated by systemd, and sustained
> network load - but those factors are not that exotic.

With softirqs as threads it is highly unlikely to be a problem. The
reason you saw this was because the break out to schedule happened in a
softirq that prevented scheduling from occurring right away. With irqs
as threads, so are softirqs, and they wouldn't be able to cause the
delay in scheduling that you were experiencing.

I'll write up a patch tomorrow or next week.

Thanks!

-- Steve

