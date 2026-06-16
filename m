Return-Path: <stable+bounces-266572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZacLMGe9MWqYpgUAu9opvQ
	(envelope-from <stable+bounces-266572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 23:17:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ECA69564D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 23:17:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DrPAWzPo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266572-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266572-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D88F318DB75
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1738C427;
	Tue, 16 Jun 2026 21:17:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322037EFE6;
	Tue, 16 Jun 2026 21:17:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781644642; cv=none; b=oOQhzP4nLhRjZKQod00ftn0oBXd6JbgPbTmREF7KADFCxsWM23+wQlh5p6vQ/Qj20UREqIsdLrrwvZ8kRJUN648WbpcJis7LhkwdSn8fY/NMHdEqEXBX0zSceOLX8TIHmQY1HB15i+A0F74LqM0bByh9HU6/OkBd+O5HfAbzKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781644642; c=relaxed/simple;
	bh=QTMau5ie2GGEAKVBGPZRNG3hRy6adIvv5lbrYw+yI7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9pbAcRSK1N2BqEcLwrGL/bGZn44WRNLG56blWun7cu9a4w7lvgrbcHzzzgq7Fm0MOVypF1balYdWPl9+U8wNI6SfYgTcYIfWf1gzKakzBtxMKpwQIFfHaB5G52QRXnTseoqJPxyMrbxNvbmRQLqqcMfYs5RhM+S6mztbC6PM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrPAWzPo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8411F00A3A;
	Tue, 16 Jun 2026 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781644641;
	bh=NmootHN4igiCQs8RopCQPxrV4Rp0tI0uYhX2d5/vyBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DrPAWzPozIAd8z0OeZ+cn5GcnA0lYsXw9qioSOB3wnNF/Gisatr1GakVW+8Dj+TbP
	 WaJbfdg46Jwhx0sMo1uTfI2YHyQ0iSb2SldhS5PDDSLWj3yYzyvL7bN4p2U65MTAUv
	 PzrOYNrhWG7s0b6PXS5nl1vCTXDry6bAIOPsPThUHM2M4/bTxENJCJsCDMGhBvCzd1
	 +/rJTSQIqdBDBsNufBqonhIwBIKUH0u7Hc/TXozvP03HeXsvjpsd9ABZ+8CU1L53e1
	 SPZ4vOzs0pURzmN1s0QufSkCufmL96dLt006EM54nUIIBFIwZZlWipICYdeJqexZlJ
	 kBPtdv6u4ORiw==
Date: Tue, 16 Jun 2026 14:17:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek
 <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Vlad Poenaru <vlad.wing@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Breno Leitao
 <leitao@debian.org>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260616141719.67684bf0@kernel.org>
In-Reply-To: <20260616170257.GH49951@noisy.programming.kicks-ass.net>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
	<20260611191114.5bc43a59@kernel.org>
	<20260616103529.Yh9Dxsjp@linutronix.de>
	<20260616170257.GH49951@noisy.programming.kicks-ass.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266572-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:bigeasy@linutronix.de,m:pmladek@suse.com,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,suse.com,chromium.org,gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59ECA69564D

On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > to NBCON console infrastructure"). Because from here now on writes are
> > deferred to the nbcon thread. So this purely about -stable in this case.  
> 
> Hmm, I thought netconsole had some reserved skbs and could to writes
> 'atomic' like? That said, it was 2.6 era the last time I looked at
> netconsole.

Yes, that part is fine. The problem is that netconsole tries
to reap Tx completions if the Tx queue is full. We can't call
skb destructor in irq context so we put the completed skbs on
a queue and try to arm softirq to get to them later.
Arming softirq causes a ksoftirq wake up.

We already skip the completion polling if we detect getting called
from the same networking driver. It's best effort, anyway.
Networking-side fix would be to toss another OR condition into
the skip. But we don't have one that'd work cleanly :S

