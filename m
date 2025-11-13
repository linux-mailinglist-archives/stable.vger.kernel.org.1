Return-Path: <stable+bounces-194676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EAFC56C6F
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D387C4E3B24
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127E2DFA46;
	Thu, 13 Nov 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nR96jifA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onMmSOGu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680D35CBD6;
	Thu, 13 Nov 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028707; cv=none; b=J+QsDLOY7lekmfKv6J3hX6YIbqqzQetXS2n8NNRLVjJRK6YLCkgIuXPO+8Xjb1Zr/Ex+w39eIfcdxpd0S9wyWmd01TatMnWS0yh2K8+2fLgZGEQwd19hCN5l9ai+JWkcLFOeGgEy9nm0qJEUDy2U95Qtz60zVd+Um9Y7OsQqkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028707; c=relaxed/simple;
	bh=DCgraUxnIHCdSYO/82thIrC3AFENsm6IeTrXsxUe6qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/iYe2yDw7P2sDfxx6gS+wsh3L6OMXnDjl1lAe2TY3w0wDy7UwyOzVpHyeorD1lIW/nTwJUv8SGlHiax55Jq+G3bbsWivRin5WAglXTO6uCjmPCCFyUEGbaRmNgTCPq6KJicEmSi+iTdg34ogmaIEldoDD8WkAGd32agaN+AYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nR96jifA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onMmSOGu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763028703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7rQ1Ku+Lcb1YDFKTkaU7P1bhMj4USysrirqKAlROBQ=;
	b=nR96jifA84HMHu8GyG1kTBdHHa5dKOk5A/UDAPumiYBiqRKuTqOBsGyLKLDRWpApUBoBTp
	zJ0OSM7ZbW5t3+pWly7gfpr551GodtyhacCq6G/MsDIH102GBVks38no2IWhOPKeJRC8tK
	gAO61ZsOZ/ckcCdLg0DUmpiSBTgwbA4xfpIh5C5AOEw2Fkxj+Eie3DQ+EGspNcK+ewYgki
	pCH7CdtbdsMtlGPEVTN/EMlhl/3m83O5BQnSO47Hr4QoWDOKxPE9dwAts4wgfWPvQuxzN7
	dm4LZ8M674ur8RabHy8D4wWuOm1JmF67X1Jdmb+EDXJkwE3LCegAMyTsgJ5/RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763028703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7rQ1Ku+Lcb1YDFKTkaU7P1bhMj4USysrirqKAlROBQ=;
	b=onMmSOGuepJ9C/XpFXLKShpQQTgDfO1Y2dhsGtd0jv9fVN5Brvx04oVDOF9ZtIPhMO8m5V
	6h/w2D9JumzXgiDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sherry Sun <sherry.sun@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Derek Barbosa <debarbos@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on suspend
In-Reply-To: <aRWqei9jA8gcM-sD@pathway.suse.cz>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
 <aRNk8vLuvfOOlAjV@pathway> <87ldkb9rnl.fsf@jogness.linutronix.de>
 <aRWqei9jA8gcM-sD@pathway.suse.cz>
Date: Thu, 13 Nov 2025 11:17:42 +0106
Message-ID: <877bvukzs1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-13, Petr Mladek <pmladek@suse.com> wrote:
>> I would prefer to keep all the printk_get_console_flush_type() changes
>> since it returns proper available flush type information. If you would
>> like to _additionally_ short-circuit __wake_up_klogd() and
>> nbcon_kthreads_wake() in order to avoid all possible irq_work queueing,
>> I would be OK with that.
>
> Combining both approaches might be a bit messy. Some code paths might
> work correctly because of the explicit check and some just by chance.
>
> But I got an idea. We could add a warning into __wake_up_klogd()
> and nbcon_kthreads_wake() to report when they are called unexpectedly.
>
> And we should also prevent calling it from lib/nmi_backtrace.c.
>
> I played with it and came up with the following changes on
> top of this patch:
>
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 45c663124c9b..71e31b908ad1 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -203,6 +203,7 @@ void dump_stack_print_info(const char *log_lvl);
>  void show_regs_print_info(const char *log_lvl);
>  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>  extern asmlinkage void dump_stack(void) __cold;
> +void printk_try_flush(void);
>  void printk_trigger_flush(void);
>  void console_try_replay_all(void);
>  void printk_legacy_allow_panic_sync(void);
> @@ -299,6 +300,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
>  static inline void dump_stack(void)
>  {
>  }
> +static inline void printk_try_flush(void)
> +{
> +}
>  static inline void printk_trigger_flush(void)
>  {
>  }
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index ffd5a2593306..a09b8502e507 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1302,6 +1302,13 @@ void nbcon_kthreads_wake(void)
>  	if (!printk_kthreads_running)
>  		return;
>  
> +	/*
> +	 * Nobody is allowed to call this function when console irq_work
> +	 * is blocked.
> +	 */
> +	if (WARN_ON_ONCE(console_irqwork_blocked))
> +		return;
> +
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(con) {
>  		if (!(console_srcu_read_flags(con) & CON_NBCON))
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 334b4edff08c..e9290c418d12 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4581,6 +4581,13 @@ static void __wake_up_klogd(int val)
>  	if (!printk_percpu_data_ready())
>  		return;
>  
> +	/*
> +	 * Nobody is allowed to call this function when console irq_work
> +	 * is blocked.
> +	 */
> +	if (WARN_ON_ONCE(console_irqwork_blocked))
> +		return;
> +
>  	preempt_disable();
>  	/*
>  	 * Guarantee any new records can be seen by tasks preparing to wait
> @@ -4637,6 +4644,21 @@ void defer_console_output(void)
>  	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
>  }
>  
> +void printk_try_flush(void)
> +{
> +	struct console_flush_type ft;
> +
> +	printk_get_console_flush_type(&ft);
> +	if (ft.nbcon_atomic)
> +		nbcon_atomic_flush_pending();

For completeness, we should probably also have here:

	if (ft.nbcon_offload)
		nbcon_kthreads_wake();

> +	if (ft.legacy_direct) {
> +		if (console_trylock())
> +			console_unlock();
> +	}
> +	if (ft.legacy_offload)
> +		defer_console_output();
> +}
> +
>  void printk_trigger_flush(void)
>  {
>  	defer_console_output();
> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> index 33c154264bfe..632bbc28cb79 100644
> --- a/lib/nmi_backtrace.c
> +++ b/lib/nmi_backtrace.c
> @@ -78,10 +78,10 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>  	nmi_backtrace_stall_check(to_cpumask(backtrace_mask));
>  
>  	/*
> -	 * Force flush any remote buffers that might be stuck in IRQ context
> +	 * Try flushing messages added CPUs which might be stuck in IRQ context
>  	 * and therefore could not run their irq_work.
>  	 */
> -	printk_trigger_flush();
> +	printk_try_flush();
>  
>  	clear_bit_unlock(0, &backtrace_flag);
>  	put_cpu();
>
> How does it look, please?

I like this. But I think the printk_try_flush() implementation should
simply replace the implementation of printk_trigger_flush().

For the arch/powerpc/kernel/watchdog.c:watchdog_timer_interrupt() and
lib/nmi_backtrace.c:nmi_trigger_cpumask_backtrace() sites I think it is
appropriate.

For the kernel/printk/nbcon.c:nbcon_device_release() site I think the
call should be changed to defer_console_output():

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 558ef31779760..73f315fd97a3e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1849,7 +1849,7 @@ void nbcon_device_release(struct console *con)
 			if (console_trylock())
 				console_unlock();
 		} else if (ft.legacy_offload) {
-			printk_trigger_flush();
+			defer_console_output();
 		}
 	}
 	console_srcu_read_unlock(cookie);

Can I fold all that into a new patch?

John

