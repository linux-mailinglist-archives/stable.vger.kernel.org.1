Return-Path: <stable+bounces-110139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40646A18F7F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2975F3A126D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B91C3C0D;
	Wed, 22 Jan 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOcQ7Xqv"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4494211470;
	Wed, 22 Jan 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540905; cv=none; b=YvCWAJXwN4OewkB9wBN/76mSN49waQqh6LL2xqEgsoeEwJZtFoFEFUq1/5SnshTkw0IVB8MLUst8DdR6iK3OTa+XeAqYxm+NhqzcpM9bEb962AIqzFG7AYDAEDtejG1uNykFKbo59AmGzgZ5Z0TaJ95SgKWAUyRi5U7o1Rvt7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540905; c=relaxed/simple;
	bh=f6wsCtNzHDC8y2BCl81fnjQJCAzBTdDU0pnEYVzRb94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMd4QPHNnJhO51sInH49Xs5v9il4+jCUgAYxQQdSx33yYYOZVdKT3gwd+kijOkfP5PuSDexAQyqKUcxLNBt/Zz+uM9ISVXD/BoWoAh2dTcRfUSYBUkCRMS7z6D5VfdJfFoHOpxz70P6MAfvtk90pymZIB1kPGyrQUIfqSqu63xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KOcQ7Xqv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M9EUCbiwY94dzh5bMpO+AdPgKmnqtflEaTrPXuorKYA=; b=KOcQ7Xqvtjok4IN5IE01NFqJKg
	TZaB2zygnKbNHpJsrmskWGAv5DStxtpiBL8p5d7x1pBPKuLnX5ACoRmAxq/PfuPBK6+aINqj9THae
	kK52eWpYPiL1Zd42fQSsNJACO7bEBg9WQpTkJmmJbBu8kSVOyA9LeR61bjL5p9yC0wkSJnvNult10
	ov5PGIjCslXKPvcsaM7fhgQmydga1n569pi9n0ZX8Fzhxk0SjPO+gwsR3EIghdJAvWfkpp9HwgtJo
	fVhroeogi3ZUoh84YUdqJ7w4+y9J6PYnk/Mxu/cqdlFeSCYrXX3Z3bYB8ikIgWqcB4T5eBCtYDPQa
	GRgw74WQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taXlC-00000001315-1DAh;
	Wed, 22 Jan 2025 10:14:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5235300599; Wed, 22 Jan 2025 11:14:57 +0100 (CET)
Date: Wed, 22 Jan 2025 11:14:57 +0100
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
Message-ID: <20250122101457.GG7145@noisy.programming.kicks-ass.net>
References: <20250121201942.978460684@goodmis.org>
 <20250121202123.224056304@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121202123.224056304@goodmis.org>

On Tue, Jan 21, 2025 at 03:19:44PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> raw_spin_locks can be traced by lockdep or tracing itself. Atomic64
> operations can be used in the tracing infrastructure. When an architecture
> does not have true atomic64 operations it can use the generic version that
> disables interrupts and uses spin_locks.
> 
> The tracing ring buffer code uses atomic64 operations for the time
> keeping. But because some architectures use the default operations, the
> locking inside the atomic operations can cause an infinite recursion.
> 
> As atomic64 is an architecture specific operation, it should not 

used in generic code :-)

> be using
> raw_spin_locks() but instead arch_spin_locks as that is the purpose of
> arch_spin_locks. To be used in architecture specific implementations of
> generic infrastructure like atomic64 operations.

Urgh.. this is horrible. This is why you shouldn't be using atomic64 in
generic code much :/

Why not just drop support for those cummy archs? Or drop whatever trace
feature depends on this.


>  s64 generic_atomic64_read(const atomic64_t *v)
>  {
>  	unsigned long flags;
> -	raw_spinlock_t *lock = lock_addr(v);
> +	arch_spinlock_t *lock = lock_addr(v);
>  	s64 val;
>  
> -	raw_spin_lock_irqsave(lock, flags);
> +	local_irq_save(flags);
> +	arch_spin_lock(lock);

Note that this is not an equivalent change. It's probably sufficient,
but at the very least the Changelog should call out what went missing
and how that is okay.

