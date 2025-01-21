Return-Path: <stable+bounces-109589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0EAA17905
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A077A3BD7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E581AF0B5;
	Tue, 21 Jan 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke0wFGMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC81B0F10;
	Tue, 21 Jan 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446702; cv=none; b=EJ8WhPX0zHwqM/YD4h/V2ccdTmx1foWk4OOY54F9jxA/l6Ts8nlJa7nLWR52LvUvMkLK65YAnOZoFEntRK3ZwqSkllqsEKIjyWly0wiVS4zMUsW77Q1JJGMhSLRzed1VgXlf3mFpHQ1DSB4jYQovxgx+G2Jbzt+LAyzE1/YeGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446702; c=relaxed/simple;
	bh=iuIpM3Q4ktQ1sfszFO4+hOk/QWq4tbhJZGW9CxpzYtk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P8O7xMZRfN9fMcjvv0wQvDDMZyxhq++5vV10XOJPNjE5yrweYm7UYR39cZeBnJFZQZqaZIHJ7HZyNcuYe0UkR2niY54g1r9sZ2n7CCFk7Z9Id/f39QzNrX123e2GFwLvvCnq1VuguVWhb0Ty6+LoK6sNuEoM+j9KRzFkSFufSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke0wFGMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED58C4CEE1;
	Tue, 21 Jan 2025 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737446702;
	bh=iuIpM3Q4ktQ1sfszFO4+hOk/QWq4tbhJZGW9CxpzYtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ke0wFGMQ8CigwZ1DW+o4kKHRJmqfEKueh5b4/c+eGgwlHjV/E6Qao57/RXLqK9N3t
	 KDLCuBM4PUX08z+hWZEwX/EhyiQa9g9dF1zXPLtoY1C4TMBwwvj9nAd4hMuj7xLLij
	 PaH+UEJLBsmt2f2bO0PNJsRiW2zoBSVO92rzRXmU8DXhKmyQ6tqvo/5/fZlCyAsUIg
	 PFBqmrkrB3Hnb+z5kkLhnQhLEtWOvzUDCqBq8DrYh89Q11cKUHXXsXFQrp4XO5wgP0
	 WZhgzO3aHGuTQlWlG6G9LiF99RhQ5Tf7aZReLRsOGIz/jW9GVmcc7gFwxbZBdn3ZNu
	 /6aiNGHnsQn2w==
Date: Tue, 21 Jan 2025 17:04:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ludwig Rydberg
 <ludwig.rydberg@gaisler.com>, Andreas Larsson <andreas@gaisler.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] atomic64: Use arch_spin_locks instead of
 raw_spin_locks
Message-Id: <20250121170458.20ae0ba33a493d3232e7fa04@kernel.org>
In-Reply-To: <20250120235721.574973242@goodmis.org>
References: <20250120235655.144537620@goodmis.org>
	<20250120235721.574973242@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 18:56:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

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
> As atomic64 is an architecture specific operation, it should not be using
> raw_spin_locks() but instead arch_spin_locks as that is the purpose of
> arch_spin_locks. To be used in architecture specific implementations of
> generic infrastructure like atomic64 operations.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: c84897c0ff592 ("ring-buffer: Remove 32bit timestamp logic")
> Closes: https://lore.kernel.org/all/86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com/
> Reported-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  lib/atomic64.c | 78 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 30 deletions(-)
> 
> diff --git a/lib/atomic64.c b/lib/atomic64.c
> index caf895789a1e..1a72bba36d24 100644
> --- a/lib/atomic64.c
> +++ b/lib/atomic64.c
> @@ -25,15 +25,15 @@
>   * Ensure each lock is in a separate cacheline.
>   */
>  static union {
> -	raw_spinlock_t lock;
> +	arch_spinlock_t lock;
>  	char pad[L1_CACHE_BYTES];
>  } atomic64_lock[NR_LOCKS] __cacheline_aligned_in_smp = {
>  	[0 ... (NR_LOCKS - 1)] = {
> -		.lock =  __RAW_SPIN_LOCK_UNLOCKED(atomic64_lock.lock),
> +		.lock =  __ARCH_SPIN_LOCK_UNLOCKED,
>  	},
>  };
>  
> -static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
> +static inline arch_spinlock_t *lock_addr(const atomic64_t *v)
>  {
>  	unsigned long addr = (unsigned long) v;
>  
> @@ -45,12 +45,14 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
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
>  	val = v->counter;
> -	raw_spin_unlock_irqrestore(lock, flags);
> +	arch_spin_unlock(lock);
> +	local_irq_restore(flags);
>  	return val;
>  }
>  EXPORT_SYMBOL(generic_atomic64_read);
> @@ -58,11 +60,13 @@ EXPORT_SYMBOL(generic_atomic64_read);
>  void generic_atomic64_set(atomic64_t *v, s64 i)
>  {
>  	unsigned long flags;
> -	raw_spinlock_t *lock = lock_addr(v);
> +	arch_spinlock_t *lock = lock_addr(v);
>  
> -	raw_spin_lock_irqsave(lock, flags);
> +	local_irq_save(flags);
> +	arch_spin_lock(lock);
>  	v->counter = i;
> -	raw_spin_unlock_irqrestore(lock, flags);
> +	arch_spin_unlock(lock);
> +	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL(generic_atomic64_set);
>  
> @@ -70,11 +74,13 @@ EXPORT_SYMBOL(generic_atomic64_set);
>  void generic_atomic64_##op(s64 a, atomic64_t *v)			\
>  {									\
>  	unsigned long flags;						\
> -	raw_spinlock_t *lock = lock_addr(v);				\
> +	arch_spinlock_t *lock = lock_addr(v);				\
>  									\
> -	raw_spin_lock_irqsave(lock, flags);				\
> +	local_irq_save(flags);						\
> +	arch_spin_lock(lock);						\
>  	v->counter c_op a;						\
> -	raw_spin_unlock_irqrestore(lock, flags);			\
> +	arch_spin_unlock(lock);						\
> +	local_irq_restore(flags);					\
>  }									\
>  EXPORT_SYMBOL(generic_atomic64_##op);
>  
> @@ -82,12 +88,14 @@ EXPORT_SYMBOL(generic_atomic64_##op);
>  s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v)		\
>  {									\
>  	unsigned long flags;						\
> -	raw_spinlock_t *lock = lock_addr(v);				\
> +	arch_spinlock_t *lock = lock_addr(v);				\
>  	s64 val;							\
>  									\
> -	raw_spin_lock_irqsave(lock, flags);				\
> +	local_irq_save(flags);						\
> +	arch_spin_lock(lock);						\
>  	val = (v->counter c_op a);					\
> -	raw_spin_unlock_irqrestore(lock, flags);			\
> +	arch_spin_unlock(lock);						\
> +	local_irq_restore(flags);					\
>  	return val;							\
>  }									\
>  EXPORT_SYMBOL(generic_atomic64_##op##_return);
> @@ -96,13 +104,15 @@ EXPORT_SYMBOL(generic_atomic64_##op##_return);
>  s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v)			\
>  {									\
>  	unsigned long flags;						\
> -	raw_spinlock_t *lock = lock_addr(v);				\
> +	arch_spinlock_t *lock = lock_addr(v);				\
>  	s64 val;							\
>  									\
> -	raw_spin_lock_irqsave(lock, flags);				\
> +	local_irq_save(flags);						\
> +	arch_spin_lock(lock);						\
>  	val = v->counter;						\
>  	v->counter c_op a;						\
> -	raw_spin_unlock_irqrestore(lock, flags);			\
> +	arch_spin_unlock(lock);						\
> +	local_irq_restore(flags);					\
>  	return val;							\
>  }									\
>  EXPORT_SYMBOL(generic_atomic64_fetch_##op);
> @@ -131,14 +141,16 @@ ATOMIC64_OPS(xor, ^=)
>  s64 generic_atomic64_dec_if_positive(atomic64_t *v)
>  {
>  	unsigned long flags;
> -	raw_spinlock_t *lock = lock_addr(v);
> +	arch_spinlock_t *lock = lock_addr(v);
>  	s64 val;
>  
> -	raw_spin_lock_irqsave(lock, flags);
> +	local_irq_save(flags);
> +	arch_spin_lock(lock);
>  	val = v->counter - 1;
>  	if (val >= 0)
>  		v->counter = val;
> -	raw_spin_unlock_irqrestore(lock, flags);
> +	arch_spin_unlock(lock);
> +	local_irq_restore(flags);
>  	return val;
>  }
>  EXPORT_SYMBOL(generic_atomic64_dec_if_positive);
> @@ -146,14 +158,16 @@ EXPORT_SYMBOL(generic_atomic64_dec_if_positive);
>  s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
>  {
>  	unsigned long flags;
> -	raw_spinlock_t *lock = lock_addr(v);
> +	arch_spinlock_t *lock = lock_addr(v);
>  	s64 val;
>  
> -	raw_spin_lock_irqsave(lock, flags);
> +	local_irq_save(flags);
> +	arch_spin_lock(lock);
>  	val = v->counter;
>  	if (val == o)
>  		v->counter = n;
> -	raw_spin_unlock_irqrestore(lock, flags);
> +	arch_spin_unlock(lock);
> +	local_irq_restore(flags);
>  	return val;
>  }
>  EXPORT_SYMBOL(generic_atomic64_cmpxchg);
> @@ -161,13 +175,15 @@ EXPORT_SYMBOL(generic_atomic64_cmpxchg);
>  s64 generic_atomic64_xchg(atomic64_t *v, s64 new)
>  {
>  	unsigned long flags;
> -	raw_spinlock_t *lock = lock_addr(v);
> +	arch_spinlock_t *lock = lock_addr(v);
>  	s64 val;
>  
> -	raw_spin_lock_irqsave(lock, flags);
> +	local_irq_save(flags);
> +	arch_spin_lock(lock);
>  	val = v->counter;
>  	v->counter = new;
> -	raw_spin_unlock_irqrestore(lock, flags);
> +	arch_spin_unlock(lock);
> +	local_irq_restore(flags);
>  	return val;
>  }
>  EXPORT_SYMBOL(generic_atomic64_xchg);
> @@ -175,14 +191,16 @@ EXPORT_SYMBOL(generic_atomic64_xchg);
>  s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>  {
>  	unsigned long flags;
> -	raw_spinlock_t *lock = lock_addr(v);
> +	arch_spinlock_t *lock = lock_addr(v);
>  	s64 val;
>  
> -	raw_spin_lock_irqsave(lock, flags);
> +	local_irq_save(flags);
> +	arch_spin_lock(lock);
>  	val = v->counter;
>  	if (val != u)
>  		v->counter += a;
> -	raw_spin_unlock_irqrestore(lock, flags);
> +	arch_spin_unlock(lock);
> +	local_irq_restore(flags);
>  
>  	return val;
>  }
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

