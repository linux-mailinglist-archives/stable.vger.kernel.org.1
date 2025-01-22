Return-Path: <stable+bounces-110216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2BA1981E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66A93A822A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDB21506C;
	Wed, 22 Jan 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bwr001e8"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8820FAAB;
	Wed, 22 Jan 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568637; cv=none; b=kkV2a0DTva1hD27fRhlq0BfcfDXPkayhLWQhVEWilwl2kI6xuLsmz1/2OKO+xlbHrcyWaidDC00+S6qFG6HDiBr0NAnAo2ru2RqPcIEP1pM7DGq6wPoNfVYraIrfvyaA6wZzN2r7NvkThFWOq+TCYAb1eaCsdhDXblNedaiw51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568637; c=relaxed/simple;
	bh=nd9P4tlvMQVFC/XPJnfoX6DriEXfQG1HhytdC+4qu1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsAjnwobWNwEKQ5A5gOJPpy4EBH/3kP7gk7tZEYlimfZmuHDdwC7CO+AUu0lbDib3obbZSRFtRr53c3fWzX9khr7GPufqCp6+zmunIIWHkTf6QA5ini6z7M4vAafOzBkJAfQnyiIGYJ/XLpKWBwIekX98Zr0DdGdqQQKL1msK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bwr001e8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pU6aV6WjrIb1qr6ZDVu0xD+ep8AT8mTNrCCro/Qbhqk=; b=bwr001e8vd0McI+hMdv3W6jK02
	HfBvYr12WYEAz3oSvGtIFutjljjADWWIfBNekwHU7TeUkX2erRCyiQqb7TP0CLKT7wBCsavgFrAXe
	qa02HRMQ5Y/eDNGDgwTL/dSHX7EBP08fzOcxVR1Qb8ZWODOR/pbwl8uarF1KDj2su4CQkyTOOYef0
	Xqxahv5XNwEq1IPfMA8/QDXI594IR0qN/BjDW468WQrJe/gs1zDPYIOehwMB56CKDyW2BzwXBi11j
	pWG3wlxdNuQ+0PBrLvVJ5zVWQ+3uR6hshIlR+JHtge82TgkyVCz2TE3cv46tioPbrwPL++KIPuqoH
	ey2TQh2A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taeyM-000000053eL-1cEL;
	Wed, 22 Jan 2025 17:57:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF852300599; Wed, 22 Jan 2025 18:57:01 +0100 (CET)
Date: Wed, 22 Jan 2025 18:57:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: Re: [for-next][PATCH 2/2] atomic64: Use arch_spin_locks instead of
 raw_spin_locks
Message-ID: <20250122175701.GA34562@noisy.programming.kicks-ass.net>
References: <20250121201942.978460684@goodmis.org>
 <20250121202123.224056304@goodmis.org>
 <20250122101457.GG7145@noisy.programming.kicks-ass.net>
 <20250122105517.4f80bf23@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122105517.4f80bf23@gandalf.local.home>

On Wed, Jan 22, 2025 at 10:55:17AM -0500, Steven Rostedt wrote:

> > >  s64 generic_atomic64_read(const atomic64_t *v)
> > >  {
> > >  	unsigned long flags;
> > > -	raw_spinlock_t *lock = lock_addr(v);
> > > +	arch_spinlock_t *lock = lock_addr(v);
> > >  	s64 val;
> > >  
> > > -	raw_spin_lock_irqsave(lock, flags);
> > > +	local_irq_save(flags);
> > > +	arch_spin_lock(lock);  
> > 
> > Note that this is not an equivalent change. It's probably sufficient,
> > but at the very least the Changelog should call out what went missing
> > and how that is okay.
> 
> What exactly is the difference here that you are talking about? I know that
> raw_spin_lock_irqsave() has lots of different variants depending on the
> config options, but I'm not sure which you are talking about? Is it the fact
> that you can't do the different variants with this?

If I followed the maze right, then I get something like:

raw_spin_lock_irqsave(lock, flags)
  local_irq_save(flags);
  preempt_disable();
  arch_spin_lock(lock);
  mmiowb_spin_lock();


And here you leave out that preempt_disable() and mmiowb stuff. The
former is fine because local_irq_save() already makes things
non-preemptible and there are no irq-state games. The mmiowb thing is
fine because nothing inside this critical section cares about mmio.


