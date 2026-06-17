Return-Path: <stable+bounces-266736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4x4mNDuPMmp22AUAu9opvQ
	(envelope-from <stable+bounces-266736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:12:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A55699925
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:12:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=pVWUvgXK;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=LQ4Z2Guy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266736-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266736-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEB8B300B450
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403111DF254;
	Wed, 17 Jun 2026 12:12:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B43EFD03;
	Wed, 17 Jun 2026 12:12:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698340; cv=none; b=TLaZEV537z0Dgv6+ydtauBhJmiyNxZf40053UPHFGrxA0Ef7kw+UgWtZ3z+is18e5h58HPmFHkHvmwCTRWiK5ipmoqZ6L0B6wA5S2qT/O9HysnobBfWPKww+5COusIDU5+5Sa3Wi4sVJx41+xn7r0tNdnMPozfJMYH/cC8dvauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698340; c=relaxed/simple;
	bh=IsqaLnjugtd3smeJmbHPULGQBZjkK9oUq6b+E8D5M98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fa9x+6m1zXuiHFzTDiERZOTfmDFCLfJ8ASWsO5ZdliQOvjGgpqR9IhuInr/jEsN37hezzjPj1m3mQHJUEpqlSEpVVq+q2MOeeoAy+fd3kcxzDHwlScDcQYf7x4rSX6JjveXW5rK+fLjlM0osKbbZBfiDslNyEGRLKoTu2xQTR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVWUvgXK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQ4Z2Guy; arc=none smtp.client-ip=193.142.43.55
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781698336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsqaLnjugtd3smeJmbHPULGQBZjkK9oUq6b+E8D5M98=;
	b=pVWUvgXKW5iucBs9vLdji2/haud+0IliNzfsVcRDFMXGPO72i6LJbquHjPNVGiqKMoD4Zj
	9Q/Ky6JiewXF4kS8lBcBIa5P41U6DbuKk6rGaPLiFeiNKT24d9CHp4oRPaSD9zcvoIDs2h
	K1kRUePCRK0IBrJX40vNdu5T8J5qzMb6OBBbOLvbajIhs4+2XXx3pvu+zD+jCMjjYkZcgx
	GQUN5lfsw8VAFCRshoyiCOIYk8BHnh+uWNjdsbJR6Fg/tlJZ7W8nua4QjpXJh6XTb2EV0W
	QJIuFfht/xYk/oynsdHI9we6eVnfJjn6J9G46bAPS2Iy0zJdcwUU6VK5FcOtQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781698336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsqaLnjugtd3smeJmbHPULGQBZjkK9oUq6b+E8D5M98=;
	b=LQ4Z2GuyjEYKyFohvTfS1YZqc3+q+cnn9BhhN7lLEAuSC3ZNLthtFH9ow/0WDHKDNfBpsC
	jVjKYqz+exefjrCw==
To: Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jakub Kicinski
 <kuba@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Vlad
 Poenaru <vlad.wing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
In-Reply-To: <ajKMH_LmiZhjNlOW@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de> <ajJy92ES-Q8ro97A@pathway.suse.cz>
 <20260617111504.GK49951@noisy.programming.kicks-ass.net>
 <ajKMH_LmiZhjNlOW@pathway.suse.cz>
Date: Wed, 17 Jun 2026 14:18:15 +0206
Message-ID: <87v7bh9xi8.fsf@jogness.linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266736-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:peterz@infradead.org,m:bigeasy@linutronix.de,m:kuba@kernel.org,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[john.ogness@linutronix.de,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,chromium.org,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57A55699925

On 2026-06-17, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2026-06-17 13:15:04, Peter Zijlstra wrote:
>> Can't we push all the legacy consoles into a single legacy kthread? I
>> mean, converting all consoles is of course awesome, but should we really
>> wait for that?
>
> I am afraid that converting the consoles one by one is the deal with
> Linus. I could imagine to moving last few sinners into the kthread
> when the majority is converted. But we are far from there :-/

Note that the proposed patch is only for older kernels. For mainline it
is moot because netconsole is already converted to nbcon.

John

