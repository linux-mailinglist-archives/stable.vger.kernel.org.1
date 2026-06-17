Return-Path: <stable+bounces-266722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K2P7M9SGMmoO1gUAu9opvQ
	(envelope-from <stable+bounces-266722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:36:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29669925B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:36:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=Y1AXNBND;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266722-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266722-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D1753050FAE
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4E26E70E;
	Wed, 17 Jun 2026 11:15:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0B1A6803;
	Wed, 17 Jun 2026 11:15:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694921; cv=none; b=tBjLiS0nRg8hI/zx4MACZvVl1FCZ1kT3h/bAsfa5JcM3+SsUxqNZNZhS3l8jvSQtSeE5AcVe9TBdLke29hg/rpETIhAPaMuWBZwJOqVGRUGZ4nvwy6zvi7B6hFNtsqX4n6B/sj9/m17HEEC/jL6MN6dqzVsO2mxKrPLdc2zL8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694921; c=relaxed/simple;
	bh=nBVIaKSsHHnhzWNXbdCl+T5AZ8DzxyZFY7wkUDzN4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvwqTdWiSV4x/kSJ6BtiA6tLdFBJ/ECqqtL0vIkSCn6YWi1gZuR9XjJam97vwPASobirheYHh3n15cJqt4VJAv1sEYIgYhXQ7u/r/s6MpHT8zszbE621/nSqiv1w5N+sPvpgxsJXcBetOkHJLYaUEKKEa+gBFy2YZcL/vRzw+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y1AXNBND; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=meCnZyamFGP+bBE/4r/7JIL/zf4RCwFPKYvTk3wFM54=; b=Y1AXNBNDrx6/52jl+wRRaDAVnx
	aTeF1vWb594J4Qly4luv7i6USc7N9lF7HP104kQPtvBF2q+sNmKOmGoOkjp3SdH6eUHdpsXtWnetb
	I55g4s5NeqvPUf+OG98cAorUFy0zJ3BF+esnllmRtw43yKoWL781VNRBHiwWesZOQj2AqIH3At4RX
	0WVrzkBsDcCsEOvMJOwvc8U7bWjqCmwDebuXR6t2mGGvCB2hnq4ukXKGmTgJrHMF3ChpNi13TTRG4
	HxEH3h9UUv6gkg5mLat8LSdkAE6fSPPreMj+8y8aOJeitCriRkHRK86UodkAmHCo//JXx0j6coOkd
	bf+la3gA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoEa-0000000CW6M-2zW4;
	Wed, 17 Jun 2026 11:15:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 330BE30036F; Wed, 17 Jun 2026 13:15:04 +0200 (CEST)
Date: Wed, 17 Jun 2026 13:15:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260617111504.GK49951@noisy.programming.kicks-ass.net>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
 <ajJy92ES-Q8ro97A@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJy92ES-Q8ro97A@pathway.suse.cz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266722-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:bigeasy@linutronix.de,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,chromium.org,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,infradead.org:from_mime,vger.kernel.org:from_smtp,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF29669925B

On Wed, Jun 17, 2026 at 12:12:07PM +0200, Petr Mladek wrote:
> On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> > On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > > 
> > > > Adding sched and printk folks for opinions while eyeballing
> > > > WARN_ON_DEFERRED().
> > > 
> > > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > > WARN_DEFERRED would be just for stable? Or there's still some
> > > sensitivity even with nbcon?
> > 
> > We already have printk_deferred(). WARN_DEFERRED() would be new. I
> > *think* this is not limited netpoll/ netconsole but all console drivers
> > not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> > I don't remember all the details but printk_deferred() was introduced to
> > circumvent this until printk is fixed.
> 
> Just to make it clear. The problem with the legacy consoles is that
> they are called under console_lock() which is a semaphore. And it
> calls wake_up_process() in console_unlock() when there is another
> waiter on the lock.
> 
> > Once we get rid of those legacy drivers and NBCON is the default we can
> > get rid of printk_deferred() :)
> 
> Yup.

Can't we push all the legacy consoles into a single legacy kthread? I
mean, converting all consoles is of course awesome, but should we really
wait for that?

