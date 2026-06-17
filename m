Return-Path: <stable+bounces-266906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d35MKM4BM2oZ8gUAu9opvQ
	(envelope-from <stable+bounces-266906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:21:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE469C568
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:21:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W2ABGdit;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266906-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266906-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15CEA3030D0A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29EA3B9610;
	Wed, 17 Jun 2026 20:21:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C83B38BE;
	Wed, 17 Jun 2026 20:21:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727691; cv=none; b=D/ISaUR0r9FdmZ4dDO+NuZ5GOJySJWHlzhSvtPYozrvRJTo/YZOeyGvvt/EWla+E+WBzMPEpKvKNTbvPHFF5+y4awpGGCdGl+wUFuM0+PFwFP/v9aITe7Q0th8XtfgLoMZUkbQ1RU/mhVaAaf3kHUl/LNzO92Wz60MenQHaBjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727691; c=relaxed/simple;
	bh=FY+MvB5dX5KNRcj4ELtvVmk3nMdZ9TN9cd59trOnxas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITgMUzuFk38ru4VgiZkT5t/Vz4E1ak//akRAMyKSzg/bR2n8jJORjbKAucI4Y1rxKjHotqBnYUnEAFUDvHCUHIjDdnN43Eq4TpPrui9JazOM8Rp+aZUsaCACG7lQ7stjgBK0zsThySjfSHzbd/6VGABNtA3t+Ui+dxDAuRnbxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2ABGdit; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C71F000E9;
	Wed, 17 Jun 2026 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781727690;
	bh=X9Yvy7sIhh446JwNO7Npv+/riipmJ9y2cxgC0NQAmSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W2ABGdithDpTLvE6i47F7YQ8wJlFQLUyqzIxLKwODn2rf8do3B5YavOYdZgPitSbi
	 w9aEmAoJRH1YV01a89UcIVHdk2uc9w6huzrUALFd8XgRh+tn5b6fTynVw/q5EG7pBr
	 nZSIQKt4jMCtNNBV3n2k3o1yBf/ay704y59YdvMOHS5BF1mj5PjsY9mFe0QBwJl/ja
	 SJ4eMs3/noRwsONxaQi+U7mmTpSAxeOqOgpDT7zova73Ui0lIA03ZLy53NPJZxVJRX
	 Kzj/l1G9jnAsGcwAG7CMskureGaeweTxe22yxJRcOdUL9h8C6XvRCNPFVHFuJ5ttA5
	 VyO5x+GE6QpZg==
Date: Wed, 17 Jun 2026 13:21:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vlad Poenaru <vlad.wing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260617132127.645534d1@kernel.org>
In-Reply-To: <ajKi4wtA8U1iZkMD@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
	<20260611191114.5bc43a59@kernel.org>
	<20260616103529.Yh9Dxsjp@linutronix.de>
	<20260616170257.GH49951@noisy.programming.kicks-ass.net>
	<20260616141719.67684bf0@kernel.org>
	<ajJ46o4fomfxY5CX@pathway.suse.cz>
	<20260617111958.GL49951@noisy.programming.kicks-ass.net>
	<ajKi4wtA8U1iZkMD@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266906-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:peterz@infradead.org,m:pmladek@suse.com,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,suse.com,linutronix.de,chromium.org,gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14AE469C568

On Wed, 17 Jun 2026 07:56:50 -0700 Breno Leitao wrote:
> As far as I can tell, there isn't a network driver today whose transmit
> path is completely lockless, so, even if we make netpoll lockless.
> 
> It's unlikely any NIC will ever achieve this, given that NIC TX
> fundamentally relies on a shared DMA ring and doorbell register, which
> inherently cannot be made lockless.

The lock which protects the queue is maintained by the stack,
and we trylock it. Maybe I lost the thread but if you're saying
that writes to netconsole are impossible from arbitrary context,
that is _not_ true, AFAIU. We can queue a packet and kick off 
the transfer on well-behaved drivers.

Main problem is the opportunistic freeing up of the queue space.
If we could avoid that in atomic context I think we'd be good.

