Return-Path: <stable+bounces-232574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJcjEG80zGlRRQYAu9opvQ
	(envelope-from <stable+bounces-232574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:54:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE4371485
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCF33018BEB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658338A709;
	Tue, 31 Mar 2026 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umIoWgTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635233DEE5;
	Tue, 31 Mar 2026 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990274; cv=none; b=Fg92q7M/jZwKynpjk4G23OQUV0reIKjnGKDgtKi1Vpv5ROVYAxEpPV967iyswDezVMitrWFE7g2btgTjJdpT57yyRkL+XFo7crmLZIdOZJegXAhW5Dpe1JYlSsocuSYaLhgWLFd5oHH4rIU/0bUh+1tQwxr76d6Nxiyd2YdS6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990274; c=relaxed/simple;
	bh=R2SNtf8D9RTFGTcrXAVFU3cnZEn4csddMjgdX7pSwAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+DN4590cH8BOnnmTk+mrdycWG1eLfc4b8UJm8ADff3oLTbRVR7uFEmq4Q5ezkpHJVPn0EwTJcuTGBZrRJjlrPRsGX3J0XJcmOa2wt4bnNbYqtSvxtuMz8Or+XVQimWvh27BWeFyBHMMf+UV4F0uoF9WrjeyZJfxIyHrYIKZhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umIoWgTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE44FC19423;
	Tue, 31 Mar 2026 20:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774990273;
	bh=R2SNtf8D9RTFGTcrXAVFU3cnZEn4csddMjgdX7pSwAo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=umIoWgTcfhrBkTMgHFOTEX1PmSj7PIroh7pe4F2vc3cJojsur0HYjxdIAC/VsHteo
	 tpAPwQ/jrzHEIW1W+Ck9eqAlg3mmTxp3IpIHngCWCF6W7Sa+eRdRttyCQeFapqtuIg
	 bOwFL9MqIJat8ePbOGFIz2RyMooTApuhKJchsGHVXOXmTqdPZigcSQCbyvlxec+1vh
	 kZ+w1Jkln1E74pnaXMbfKQusFRrIn6DoWWWgjQ/dBhORvXoTw9pgZvu8V/q0gdMG4N
	 JvOwZNfDEoKsTIgmvC7CCQHvAvE1priJlIrt18/cEvJ6Hhq38VHZxAkRKf1i0Y/S/k
	 jlM0C7lI+mKMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8219BCE00EF; Tue, 31 Mar 2026 13:51:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:51:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sonam Sanju <sonam.sanju@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmitry Maluka <dmaluka@chromium.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
Message-ID: <2d080c02-9602-4b22-94ce-1f7a71cc19a4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260323053353.805336-1-sonam.sanju@intel.com>
 <20260323064248.1660757-1-sonam.sanju@intel.com>
 <acwPr_Aic9xd95_R@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acwPr_Aic9xd95_R@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232574-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,joshtriplett.org,redhat.com,bitbyteword.org,chromium.org,vger.kernel.org,goodmis.org,efficios.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5BE4371485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:17:19AM -0700, Sean Christopherson wrote:
> +srcu folks
> 
> Please don't post subsequent versions In-Reply-To previous versions, it tends to
> muck up tooling.
> 
> On Mon, Mar 23, 2026, Sonam Sanju wrote:
> > irqfd_resampler_shutdown() and kvm_irqfd_assign() both call
> > synchronize_srcu_expedited() while holding kvm->irqfds.resampler_lock.
> > This can deadlock when multiple irqfd workers run concurrently on the
> > kvm-irqfd-cleanup workqueue during VM teardown or when VMs are rapidly
> > created and destroyed:
> > 
> >   CPU A (mutex holder)               CPU B/C/D (mutex waiters)
> >   irqfd_shutdown()                   irqfd_shutdown() / kvm_irqfd_assign()
> >    irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
> >     mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock) //BLOCKED
> >     list_del_rcu(...)                     ...blocked...
> >     synchronize_srcu_expedited()      // Waiters block workqueue,
> >       // waits for SRCU grace            preventing SRCU grace
> >       // period which requires            period from completing
> >       // workqueue progress          --- DEADLOCK ---
> > 
> > In irqfd_resampler_shutdown(), the synchronize_srcu_expedited() in
> > the else branch is called directly within the mutex.  In the if-last
> > branch, kvm_unregister_irq_ack_notifier() also calls
> > synchronize_srcu_expedited() internally.  In kvm_irqfd_assign(),
> > synchronize_srcu_expedited() is called after list_add_rcu() but
> > before mutex_unlock().  All paths can block indefinitely because:
> > 
> >   1. synchronize_srcu_expedited() waits for an SRCU grace period
> >   2. SRCU grace period completion needs workqueue workers to run
> >   3. The blocked mutex waiters occupy workqueue slots preventing progress
> 
> Unless I'm misunderstanding the bug, "fixing" in this in KVM is papering over an
> underlying flaw.  Essentially, this would be establishing a rule that
> synchronize_srcu_expedited() can *never* be called while holding a mutex.  That's
> not viable.

First, it is OK to invoke synchronize_srcu_expedited() while holding
a mutex.  Second, the synchronize_srcu_expedited() function's use of
workqueues is the same as that of synchronize_srcu(), so in an alternate
universe where it was not OK to invoke synchronize_srcu_expedited() while
holding a mutex, it would also not be OK to invoke synchronize_srcu()
while holding that same mutex.  Third, it is also OK to acquire that
same mutex within a workqueue handler.  Fourth, SRCU and RCU use their
own workqueue, which no one else should be using (and that prohibition
most definitely includes the irqfd workers).

As a result, I do have to ask...  When you say "multiple irqfd workers",
exactly how many such workers are you running?

							Thanx, Paul

> >   4. The mutex holder never releases the lock -> deadlock

