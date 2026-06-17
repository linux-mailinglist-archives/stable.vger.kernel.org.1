Return-Path: <stable+bounces-266652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NwjKCNpPMmroyQUAu9opvQ
	(envelope-from <stable+bounces-266652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:42:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A72556973DC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=4sW21Ypg;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=MbFlUpVf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266652-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266652-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337AB30115B1
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B493BB123;
	Wed, 17 Jun 2026 07:42:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7743BB120;
	Wed, 17 Jun 2026 07:42:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682131; cv=none; b=tQHHZdIZhIn0owxtHxIX8tdMIS0dKaLPS3VjWdTdHFDzQ6C+pimq6yMA1V8msaoqaBu5HDw8IlnGo9e5gPyo0nA5K23XSoUA2anni2MQERMx11EF8xtHRn0pxhXDtBBME9tqUAtiMj6QAbWdCR9azCo8ddz8w+TtwXoMOBgkxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682131; c=relaxed/simple;
	bh=UYnPxb1Rl/unG8AVIs6+c36t87t9Pw4qOIB524d8GNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wc/ONT9KiziwJaxBHvE94gmFlLMIqMCg3nGB+ycZb7kBfFhkygNZUvwgICrzS+9KtJxw7WQ16+J9Gf3y+VbuKv7/2SgI8H1FFGF+ZwtPkn5X92D2fV0DwCpfgHSFqQwV4Uj4uxE3BmGn0QrTm3x1RuYxylWzVhbboo3oDOuIaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4sW21Ypg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbFlUpVf; arc=none smtp.client-ip=193.142.43.55
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781682128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnPxb1Rl/unG8AVIs6+c36t87t9Pw4qOIB524d8GNs=;
	b=4sW21YpgR3GAzE4SyMd8vyQ9/Cb0EJz4EJnc0UdmP6HbYmWBglbAq37akwe1SlIZOH4kr6
	+QiMgt436te6oOI+lmAu12sXggSA8cORImUvh09dMPn2DAqtt9W3CaSXbCKrbXMpbujb8y
	7hjlSxh5jtJf2H5wVpVnbKwrnBcB5NgKVRoe9s1usN8XMswu84YAoHuP0eBPbAdVExURku
	aOngiFO27/nVGbCat9KTiTSlWcZ1xc3h9VyTgoJ4LNFwlJ0jXUkyPGk2GmBuMRD3vq6hVn
	FvLiigQYy9isVxvIRYfOAe4trfrUo6sZI4ewhcNg39LCgR0g0wNhuZZ9BmH+wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781682128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnPxb1Rl/unG8AVIs6+c36t87t9Pw4qOIB524d8GNs=;
	b=MbFlUpVfCCdPPCPFztBOHVzgXUqWNTd2yX6XgxBEb2+MroUmYBfg82eFym9PLbfdRDbPrt
	m+VdNMVvE0uzkWBA==
To: Breno Leitao <leitao@debian.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, pmladek@suse.com
Cc: Jakub Kicinski <kuba@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Peter Zijlstra
 <peterz@infradead.org>, Vlad Poenaru <vlad.wing@gmail.com>, Thomas
 Gleixner <tglx@kernel.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
In-Reply-To: <ajF5S0uY-8F0jzoh@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de> <ajF5S0uY-8F0jzoh@gmail.com>
Date: Wed, 17 Jun 2026 09:48:07 +0206
Message-ID: <877bnxfwa8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266652-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:bigeasy@linutronix.de,m:pmladek@suse.com,m:kuba@kernel.org,m:senozhatsky@chromium.org,m:peterz@infradead.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[john.ogness@linutronix.de,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,chromium.org,infradead.org,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jogness.linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A72556973DC

On 2026-06-16, Breno Leitao <leitao@debian.org> wrote:
>> So this is not an issue since commit 7eab73b18630e ("netconsole: convert
>> to NBCON console infrastructure"). Because from here now on writes are
>> deferred to the nbcon thread. So this purely about -stable in this case.
>
> Does the nbcon thread handle defer even for consoles that support atomic
> operations?

The all "printk deferred" variants have zero effect on nbcon
drivers. The "printk deferred" variants exist purely as duct tape for
legacy console drivers.

If nbcon drivers provide a safe write_atomic(), they will _always_ write
synchronously when the CPU is in an emergency state. Otherwise nbcon
drivers _always_ defer to their dedicated console printing kthread and
there they use the write_thread() callback.

> netconsole is marked with CON_NBCON_ATOMIC_UNSAFE, which means it rarely
> performs inline/direct printk and instead pushes to the thread, which
> flushes in a safe context.

CON_NBCON_ATOMIC_UNSAFE means it _never_ performs inline/direct printk
console writing. That flags means that in panic, at the _very_ end, just
before going into an infinite nop loop, the CON_NBCON_ATOMIC_UNSAFE
consoles will be flushed directly from the panic context.

> For drivers that behave correctly, I'd like to be able to drop
> CON_NBCON_ATOMIC_UNSAFE, potentially setting it at runtime based on the
> underlying driver capabilities. If netconsole is backed by a well-behaving
> network driver, we could eventually remove the flag (!?)
>
> Would that approach cause any issues?

Removing the flag means the driver can safely write from _any_ context
(including scheduler and NMI), regardless what locks that context may be
holding.

Note that the nbcon framework allows console drivers to mark unsafe
regions in themselves, where atomic writing would not be possible. In
such scenarios, it defers to the dedicated printing kthread (except
during panic, where more agressive tactics are used).

John Ogness

