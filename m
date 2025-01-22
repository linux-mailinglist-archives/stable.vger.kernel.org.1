Return-Path: <stable+bounces-110221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F5AA1992C
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 20:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18AD3A3F10
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF62153F3;
	Wed, 22 Jan 2025 19:31:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AB18FDAB;
	Wed, 22 Jan 2025 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574294; cv=none; b=BF+eabN7QOwNejH1XrKHyzrU1pMMsv27D7uxKG01tvgBlh6XQygFZMz9J8qUpgkTc0amBzjSSg6P36OmBIFTY4d5HeWaS2mlN69e1Pz1bWvl4w6KfovjylpeTXiySlRXPRsWuuGTcz244p/t2byVpUhKae2digRiEQLmK/U2Lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574294; c=relaxed/simple;
	bh=6QA8OxHuZG09CDIg9SnArXFjqSB/sN3uq4g+SbLI7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9cIdJa6NICkBnuba1Q9vAZOLL5P/DeZImtSb9q2xqutaPrfc7afcCTGLdgb4QrvuqGdoFS/dam5Y8cQ9uzzK+Fx5psMCkF04CAHc35+0Y2y3GaXIDTkFS3Upiwp2JsXCVQpSIG/nb4a4ICvd77hSy7SkuYlX7g3gMl/cjWFOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748C5C4CED2;
	Wed, 22 Jan 2025 19:31:32 +0000 (UTC)
Date: Wed, 22 Jan 2025 14:31:37 -0500
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
Message-ID: <20250122143137.2f613629@gandalf.local.home>
In-Reply-To: <20250122175701.GA34562@noisy.programming.kicks-ass.net>
References: <20250121201942.978460684@goodmis.org>
	<20250121202123.224056304@goodmis.org>
	<20250122101457.GG7145@noisy.programming.kicks-ass.net>
	<20250122105517.4f80bf23@gandalf.local.home>
	<20250122175701.GA34562@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 18:57:01 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> If I followed the maze right, then I get something like:
> 
> raw_spin_lock_irqsave(lock, flags)
>   local_irq_save(flags);
>   preempt_disable();
>   arch_spin_lock(lock);
>   mmiowb_spin_lock();
> 
> 
> And here you leave out that preempt_disable() and mmiowb stuff. The
> former is fine because local_irq_save() already makes things
> non-preemptible and there are no irq-state games. The mmiowb thing is
> fine because nothing inside this critical section cares about mmio.

Ah, yeah. OK, I don't plan on adding the preempt_disable() either as again,
this is really just an emulation of atomic64 for architectures that do not
support it.

I'll resend this with an updated change log.

Thanks for the review.

-- Steve

