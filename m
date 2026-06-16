Return-Path: <stable+bounces-263660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3pCIhInMWpMcwUAu9opvQ
	(envelope-from <stable+bounces-263660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:36:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3F68E5D8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:36:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=NUfoDcXo;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=wb2Bc7wj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263660-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263660-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14371303B19F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452342EEAB;
	Tue, 16 Jun 2026 10:35:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09342EEA1;
	Tue, 16 Jun 2026 10:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606136; cv=none; b=NZZb0GUb3n7yz2FIXFvh8twxdM7AgbR/RFwdxhUmBNlchgkGNyUPMDpBFJ8hgsvG4rlhj/B5xDghr6qzKxB3I4LdJYdwk0/njhaCCoUeZOLt0iXf6Xnh0hrbmlT4lT5LSV8OYQ3vaQ1uIpPv5SXp/O6bf04+Ue9IejNM5tlVuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606136; c=relaxed/simple;
	bh=RNLsRJqIsMcq5s1FV+cMEbdmzYKOwcmHfY4//2Qa9YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnH3bj4jbqWfDh9RQtvTqb4D2YMO+RatCBCW8eHLJ41C/daBLh0vkCdQip4FulyVL747yQLvBy/F0AUz3vEPhld1IirrKS+wR0gAatP1P8uHIt3VvHshQZvrNi2Gnms5uEsbySdgS2IcBw/FCjeQh9aI0KfLIlTLhjnukt9SPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NUfoDcXo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wb2Bc7wj; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 16 Jun 2026 12:35:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781606131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOdqUcYnCHWecakifkfeakQfsbtnd8983iT9Id9elR8=;
	b=NUfoDcXol+nCASxi0OGksSZDm2F5xru195qAuBmwWxzETiJ2pILP+m6Wlj+qsrl34gy9M2
	5ed/dACqZ8hCaqjtFXrzVM/3mPMiQAJ0nJ9doirqBrEt1ILagRz/8/J9aHx4GboyKjmTE3
	qXcTxAkSo7sYlt9zd0nzuQEVT8stcRES1Mdbo9sJTR2yuaQ2+Kv5Ty62Xaf9OghUu7FVrq
	ox8mcmS142bJl+xy3bVrjnkDdCMYF30GiBAgSm78tW0bgOobkCqF+LmA/a4ryKJTBzllFe
	ZYVvT90Scy7u0Ewiw21YhC2eoOcLvEyXEcki46jnXt90dZEubEreP7ITXUIjxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781606131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOdqUcYnCHWecakifkfeakQfsbtnd8983iT9Id9elR8=;
	b=wb2Bc7wjsy8vkfCE5HxWdCYFR1KTdlLWFTCeO63DyWIOz21yUr6KDUWEp4x2pn+DMQ5GoX
	O+7GpqAGvexxjEDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Vlad Poenaru <vlad.wing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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
Message-ID: <20260616103529.Yh9Dxsjp@linutronix.de>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260611191114.5bc43a59@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263660-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pmladek@suse.com,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:peterz@infradead.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2E3F68E5D8

On 2026-06-11 19:11:14 [-0700], Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 11:36:21 -0700 Vlad Poenaru wrote:
> > @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
> > +	local_bh_disable();
> > + 	poll_napi(dev);
> > +	_local_bh_enable();
>=20
> tglx, Sebastian, are you okay with using _local_bh_enable() to trick
> softirq into not waking ksoftirqd? The problematic path is:
>=20
>   scheduler -> printk -> netconsole -> raise softirq -> scheduler (deadlo=
ck)
>=20
> so the softirq may never get serviced.
>=20
> In netcons we try to avoid touching the network driver if the Tx path
> locks are already held. Ideally we'd do something similar with the
> scheduler. Try to do bare minimum if we may be in the scheduler.
> Failing that - don't poll the driver if we were called with irqs
> already disabled.
>=20
> Or maybe we only poll from console->write_thread ?

So this is not an issue since commit 7eab73b18630e ("netconsole: convert
to NBCON console infrastructure"). Because from here now on writes are
deferred to the nbcon thread. So this purely about -stable in this case.

Looking at the patch and the amount of comments vs code changes look
somehow hackish. That ifdef for PREEMPT_RT is not needed because on
PREEMPT_RT we have either nbcon or the legacy console (including
netconsole before the mentioned commit) wrapped in a dedicated thread
(via force_legacy_kthread()).
That means in both cases the flow never ends there and the problem is
limited to !PREEMPT_RT.

Now. The scheduler usually does printk_deferred() because of the rq lock
so it does not deadlock for various reasons. It is kind of a pity that
the various WARN macros don't do that.
I don't think that patch is enough. It works around the problem in this
scenario but should the NIC driver invoke schedule_work() then we are
back here again.
Should the network driver acquire a lock then lockdep might observe
rq -> driver-lock and then driver-lock -> rq and yell dead lock (CPU1
doing AB and CPU2 doing BA). This includes also other console driver so
it is not limited to netconsole.

Point being made is that we should avoid the callchain:

|  console_unlock
|  vprintk_emit
|  __warn
|  __enqueue_entity                // WARN_ON_ONCE() here -- rq->lock held
|  put_prev_entity
|  put_prev_task_fair
|  __schedule

basically a printk under the rq lock.

We could add printk_deferred_enter/exit() to all the rq_lock() variants.
I think PeterZ loves this the most. And Greg will appreciate it too
while backporting because of all the context changes.

We could also introduce WARN_ON_DEFERRED +variants which do the
printk_deferred_enter/exit() thingy should around the printk and replace
all the WARNs in kernel/sched/.
I *think* the tty/console layer has also a deadlock problem where it
holds locks and then the WARN(), that never triggers, asks for the same
locks again so we might have a second user=E2=80=A6

Adding sched and printk folks for opinions while eyeballing
WARN_ON_DEFERRED().

Sebastian

