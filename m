Return-Path: <stable+bounces-267290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vKo9OpuDNGpYaAYAu9opvQ
	(envelope-from <stable+bounces-267290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:47:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC086A31E8
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:47:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AjInI95v;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267290-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267290-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9DC63039F79
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1C32FA2E;
	Thu, 18 Jun 2026 23:47:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB2258CE7;
	Thu, 18 Jun 2026 23:47:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826456; cv=none; b=eGLlaj20SPUib3QBPRFhi0LH9Rez6iXD0s4G6rPLmDwMRLVAZ9z96exL15pIOOb9+y5TmjlMRf6uWf5jte5Rsf7T8wp6GlgxomKV3kU7gftFTtg61eFW0Ia33lD9ffYnIghdu3XFp1D+hPOE8gyRkPyzZK63vQGXzXZuG0iqZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826456; c=relaxed/simple;
	bh=Hgx7gS5P2EbYXi9kGfoDRRrX8TYw8Lnz+LamjNGgOoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgNBFTvVR0mZQ6qJ0VoHuECaKaFdwcL5ennPUfcCwxEVTVNGVJQNrF0HBxjbkHLIfTSmAhuDRCp4Ibcmbng5uDlK7i+1nHlxk7B0+p2L2Yaiqsd1JtiEhNmsc3ZGRiwqG5m5KXoB9BQqmZRGQTkSTdfV/OdoJ3F1QUZgE38jTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjInI95v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28A21F000E9;
	Thu, 18 Jun 2026 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826454;
	bh=Hgx7gS5P2EbYXi9kGfoDRRrX8TYw8Lnz+LamjNGgOoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AjInI95vFpdMaqcgDoeFdM4ksjmtX6M58qi2GHmnlsVhG5sHo7viooQ6xF4znuu0c
	 i0GQzla3wtAIqThFkOFURGfVUyDJlHHqeqK+0p1WJjwWiW8gLb+LbZp9UHNjbaacoT
	 P02fy5a3Q+wjdqNoTbCBQDwFNSMMtEqIH57A98KxhLxhFKYuO77mhtcN48WFPt0zDB
	 zLRy7IF/vnjNaiQ68QEzegRSgUSIfjTpeUJ+Kvb7C12zQAmpWhEMtc0rPlBogJuBu+
	 gODyHVyXB/TNMvELRqQYPgx3YEcrfZEVNtiqXaQbVAFpv3J8qNhWKgYNR48aor2KFg
	 kqGR6ISo7tQjQ==
Date: Thu, 18 Jun 2026 16:47:33 -0700
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
Message-ID: <20260618164733.49539468@kernel.org>
In-Reply-To: <ajQFMS4ucT-mybhi@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
	<20260611191114.5bc43a59@kernel.org>
	<20260616103529.Yh9Dxsjp@linutronix.de>
	<20260616170257.GH49951@noisy.programming.kicks-ass.net>
	<20260616141719.67684bf0@kernel.org>
	<ajJ46o4fomfxY5CX@pathway.suse.cz>
	<20260617111958.GL49951@noisy.programming.kicks-ass.net>
	<ajKi4wtA8U1iZkMD@gmail.com>
	<20260617132127.645534d1@kernel.org>
	<ajQFMS4ucT-mybhi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267290-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:peterz@infradead.org,m:pmladek@suse.com,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,suse.com,linutronix.de,chromium.org,gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EC086A31E8

On Thu, 18 Jun 2026 07:57:33 -0700 Breno Leitao wrote:
> Let me verify my understanding: if we switched to __raise_softirq_irqoff()
> in dev_kfree_skb_irq_reason(), the issue would be resolved since we'd
> avoid waking ksoftirqd and therefore wouldn't touch the runqueue lock in this
> code path.

That's the same as Vlad's patch. It risks leaving the softirq raised
but never invoked.

