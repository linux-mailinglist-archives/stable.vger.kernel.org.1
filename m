Return-Path: <stable+bounces-266737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +DruFWqQMmq92AUAu9opvQ
	(envelope-from <stable+bounces-266737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:17:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC940699A07
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:17:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=hDHsGGZu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266737-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266737-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44C073010259
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0F3E6DF5;
	Wed, 17 Jun 2026 12:13:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A953B4EAA
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:13:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698398; cv=none; b=aIQLwES4ex+5qN+bb7Fjm3kh2OjeU2nx3YMpLYdVwMqpYE6pFJ/ejKhMZRuiCJRKusiqCUl++CrJnlzo7Xd54NSqB2ErJ7Ef9oV4eHXf2gpUebhXbep2chcK5xGutuh7/FxXRFbxQodjEOTdi+1us52RYv7jHOP0+RDaG2BUnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698398; c=relaxed/simple;
	bh=drQjluxR83utrv7JFzAl3tgoSzQhMivNx3FdMfRDDGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxou+WQK11KwoBL5kf3kMAnfQN6uFxWA+beR23rryu1KBQ0sZcBnw4Z3AwTfanktl7FWhOiseT+iPM0A1KCDbt8/ZDva4jJhveidcIvtK/EOt/TSkkMYgwL9BUAHRXhNJb0tz2AvhKElhYBGY8WUbWh4GADa9VZ9OFpeegYBZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hDHsGGZu; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso8688935e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781698395; x=1782303195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Of6hY+HxCVg/UtNEg6WyP3LTybOpcyjydWiZNY5Yg=;
        b=hDHsGGZuSNOAw6+ZKjLAvTI6yvJYWjx7A7tMPmq9nk5aM/ntFWx9SRVdYg2QDb8UJ1
         /RvQEXfithO8SAVUYu/hSY+eXOJ6fw7WkA401q/DUQ2biAYQawZuJCq0uZ+TfqS/af+i
         txfYBozL5uVtBjXvUa4nOXqvWYciZI5kkhmpZeB2wnlKw52BGiGKS10ooENHaIdlX6w2
         KxoIFz3Sy5WHlni+SUDZL8nx7txBOwo+OJX6XDatSNo4369F8PezWSAl0qyyEo7J0h6U
         Xr43A/nwdneeBxP2mjHj9WtuQrklEtf8Y2G3X0x4UsvsAPE+9kj1hqA7QhuT+wXXjFr7
         fHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781698395; x=1782303195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3Of6hY+HxCVg/UtNEg6WyP3LTybOpcyjydWiZNY5Yg=;
        b=FdlvU1O2lwSq6vEj9bsQS4XfZZ4YpDzeIy/wiTiRDwwmLlr0bou3ayKmGmQWzNvV/O
         8zNMpus+tiQaILcHYNO2xHuieQkTpzePufhl6L8Fs7yLaEZ4TxHp7TMDwFROXJDJE54A
         ShOz80s9+k6R5CrJE/qSjgsYOOGKn9UIijHDmgQiFyrUOOayLIa83UXQ+v1yN8g05sEc
         mhDxy0dIKSpF+R/MM007qD07FjB9Wy7QYtGPJlk/vC+qtEn3YjFC75Ye8wHhmaRURsih
         1tNt8eiYlXcz4Vyrghr0hU/6/QHvw+nsI1Ua4HAR0W7LyT0dIz8McLSR2kY6OeuQ8tKe
         N7mg==
X-Forwarded-Encrypted: i=1; AFNElJ/UBiABtqRszaf/iWEc8wIjNGPQEa65/I+t6D6ymPHlKSNEHKWwXW/EWD/214zR2PwmDAzzBhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QeHjw1vFQkNnmbkfS3QUvm1SILd3LYDnYQinikzOYpRuGsaJ
	HQ/PMnr2lCwUimtcVhU2BhS9LEnTKHljggYxf7U65I+S96BicbatlfCs/jX1BjvaNcU=
X-Gm-Gg: Acq92OF5JJRuz5l1nu9saxRqtE9a7yxUjRPFqlJzmgnONab5H2VBU+++taH0eMmaMgu
	8irkPLvpDNDF1mU1r+wuQ8zDU+kVnwwT6Wx9G7GNQeQOywdFRX+rNTfPtPok5IOx+Q5e9qTl4+d
	MQiVPkStssItSad2Y2hYFkCqfSzLkc5GdMl+LEg0ri2VBsd8bAlwAoYWAXi3WKyurRWDxeFmaH0
	KxU5zg0InAJrs+aSrYsm4ZYHdq4LfCiYy2Y0OcpbgV+0YE47CVQ/MXrUSEy1+aywym/dAcqut/m
	FiEHTmtdFEYoFaMSGHih6Qn32ZQDX9Y4tJ/u+elaEkx6wdJtBljzNDRuGD4ZjzrBEf5F3sE3M7y
	wJNATwTyAnavL7yZM6YrOgzgmo8f6VNpZRu2eCUM9+/C5hJ60YxuBGIKWoko3yzO2N+yIIEZb65
	9lLRKWhtrEpybjLwQ=
X-Received: by 2002:a05:600c:46cf:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-492340e7632mr36603905e9.10.1781698395410;
        Wed, 17 Jun 2026 05:13:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47d1csm159343545e9.4.2026.06.17.05.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:13:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:13:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <ajKPWUtGfJj6tfPL@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
 <ajJ46o4fomfxY5CX@pathway.suse.cz>
 <20260617111958.GL49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617111958.GL49951@noisy.programming.kicks-ass.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266737-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:kuba@kernel.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,chromium.org,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,pathway.suse.cz:mid,suse.com:dkim,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC940699A07

On Wed 2026-06-17 13:19:58, Peter Zijlstra wrote:
> On Wed, Jun 17, 2026 at 12:37:30PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> > > On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > > > to NBCON console infrastructure"). Because from here now on writes are
> > > > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > > > 
> > > > Hmm, I thought netconsole had some reserved skbs and could to writes
> > > > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > > > netconsole.
> > > 
> > > Yes, that part is fine. The problem is that netconsole tries
> > > to reap Tx completions if the Tx queue is full. We can't call
> > > skb destructor in irq context so we put the completed skbs on
> > > a queue and try to arm softirq to get to them later.
> > > Arming softirq causes a ksoftirq wake up.
> > > 
> > > We already skip the completion polling if we detect getting called
> > > from the same networking driver. It's best effort, anyway.
> > > Networking-side fix would be to toss another OR condition into
> > > the skip. But we don't have one that'd work cleanly :S
> > 
> > Alternative solution might be to offload the ksoftirq wake up
> > to an irq_work. It might make this part safe for the
> > console->write_atomic() call.
> > 
> > Well, my understanding is that there are more problems.
> > AFAIK, some drivers do not use an IRQ safe locking, see
> > https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/
> 
> But anything using locking is not ->write_atomic() and should be driven
> from a kthread, no?

Right. I am not sure where my head was this morning.

Best Regards,
Petr

