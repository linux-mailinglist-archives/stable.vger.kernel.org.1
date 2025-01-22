Return-Path: <stable+bounces-110199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57075A195DB
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FC93A28BB
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704B2147E7;
	Wed, 22 Jan 2025 15:55:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7B214229;
	Wed, 22 Jan 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561315; cv=none; b=gCS67+NoJzRYVOQRZ9PgzRm1ohEVJhrq9QlU2+KO8RgnmULgGEa7JkVYn+HDb7iMPhkF7svt2LeRxwS4+SwplvyAFE/a/PtHsIB24IhyCtiuGJqnxqyhjah1KIRRLdGyh/L4c7dC0PmtBZZ03/V/HjrYElO7df+zwAjD0U/5kf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561315; c=relaxed/simple;
	bh=Nnnhw81yNHmwHCGQgmmobicTwnql+7+yZQ9YPTApWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekzMehC8MF6xmXu8b6dmxA0d3ymMRGSIMagYuyZ+PUihuaBp4TXWteqmkcwBVH1gR1UljxjJShBByqauL1lCBdSfGTzZuUASEYODeqaumaLukB3tcrKFvj/5SEHPmvzTA1wWlHjFMWQgGTIjV96KrByvuik12cfRccALIeoTSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E9C4CED3;
	Wed, 22 Jan 2025 15:55:13 +0000 (UTC)
Date: Wed, 22 Jan 2025 10:55:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andreas Larsson <andreas@gaisler.com>, Ludwig Rydberg
 <ludwig.rydberg@gaisler.com>
Subject: Re: [for-next][PATCH 2/2] atomic64: Use arch_spin_locks instead of
 raw_spin_locks
Message-ID: <20250122105517.4f80bf23@gandalf.local.home>
In-Reply-To: <20250122101457.GG7145@noisy.programming.kicks-ass.net>
References: <20250121201942.978460684@goodmis.org>
	<20250121202123.224056304@goodmis.org>
	<20250122101457.GG7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 11:14:57 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jan 21, 2025 at 03:19:44PM -0500, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > raw_spin_locks can be traced by lockdep or tracing itself. Atomic64
> > operations can be used in the tracing infrastructure. When an architecture
> > does not have true atomic64 operations it can use the generic version that
> > disables interrupts and uses spin_locks.
> > 
> > The tracing ring buffer code uses atomic64 operations for the time
> > keeping. But because some architectures use the default operations, the
> > locking inside the atomic operations can cause an infinite recursion.
> > 
> > As atomic64 is an architecture specific operation, it should not   
> 
> used in generic code :-)

Yes, but the atomic64 implementation is architecture specific. I could
change that to be:

  "As atomic64 implementation is architecture specific, it should not"

> 
> > be using
> > raw_spin_locks() but instead arch_spin_locks as that is the purpose of
> > arch_spin_locks. To be used in architecture specific implementations of
> > generic infrastructure like atomic64 operations.  
> 
> Urgh.. this is horrible. This is why you shouldn't be using atomic64 in
> generic code much :/
> 
> Why not just drop support for those cummy archs? Or drop whatever trace
> feature depends on this.

Can't that would be a regression. Here's the history. As the timestamps of
events are related to each other, as one event only has the delta from the
previous event (yeah, this causes issues, but it was recommended to do it
this way when it was created, and it can't change now). And as the ring
buffer is lockless, it can be preempted by interrupts and NMIs that can
inject their own timestamps, it use to be that an interrupted event would
just have a zero delta. If an interrupt came in while an event was being
written, and it created events, all its events would have the same
timestamp as the event it interrupted.

But this caused issues due to not being able to see timings of events from
interrupts that interrupted an event in progress.

I fixed this, but that required doing a 64 bit cmpxchg on the timestamp
when the race occurred. I originally did not use atomic64, and instead for
32bit architectures, it used a "special" timestamp that was broken into
multiple 32bit words, and there was special logic to try to keep them in
sync when this occurred. But that started becoming too complex with some
corner cases, so I decided to simply let these 32 bit architectures us
atomic64. That worked fine for architectures that have 64 bit atomics and
do not rely on spinlocks.

Then I started getting reports of the tracing system causing deadlocks.
That is, because raw_spin_lock() is traced. And it should be, as locks do
cause issues and tracing them can help debug those issues. Lockdep and
tracing both use arch_spin_lock() so that it doesn't recurse into itself.
Even RCU uses it. So I don't see why there would be any issue with the
atomic64 implementation using it as it is an even more basic operation than
RCU is.

> 
> 
> >  s64 generic_atomic64_read(const atomic64_t *v)
> >  {
> >  	unsigned long flags;
> > -	raw_spinlock_t *lock = lock_addr(v);
> > +	arch_spinlock_t *lock = lock_addr(v);
> >  	s64 val;
> >  
> > -	raw_spin_lock_irqsave(lock, flags);
> > +	local_irq_save(flags);
> > +	arch_spin_lock(lock);  
> 
> Note that this is not an equivalent change. It's probably sufficient,
> but at the very least the Changelog should call out what went missing
> and how that is okay.

What exactly is the difference here that you are talking about? I know that
raw_spin_lock_irqsave() has lots of different variants depending on the
config options, but I'm not sure which you are talking about? Is it the fact
that you can't do the different variants with this?

Or is it because it's not checked by lockdep? Hmm, I mentioned that in the
cover letter, but I failed to mention it here in this change log. I can
definitely add that, if that's what you are referring to.

-- Steve

