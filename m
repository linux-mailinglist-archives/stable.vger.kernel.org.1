Return-Path: <stable+bounces-194671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600CC56B9D
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CF93BA294
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0D2DECA1;
	Thu, 13 Nov 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FuvO+I1k"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3F1F5EA
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027585; cv=none; b=jt7Ei9eVymi8c2nxBCq6MavQ8lKluTjGRkru8yjFxV/0UdYSTU1vlBirc9pJUQheiUIxQZg2X/mquWx8NvOZNvVo4zWWJAyHX/elgVdiqKpwxDls9caVjgL8sGJD+tXCrSIlJX5rZyrL51XqAmdUsf3ASVmv9P31SBieOrgQ0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027585; c=relaxed/simple;
	bh=6lCTspNXXG8TL9WsqkNOhLsjm8KE2uU5YJ523fQtSZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq2NHYO3dKg2TcJVtHkvnUxScU6HzVuKWJn8EzluKgFVqdGwNgFpl2kK6K/lX2yOEOa1+elxBoJ7rcygricb3kDY7BVC53rtbWdWxsv3v0Y9g6eM+X/SO7PQQJLV7YHBEDdDihfnqa2xW4tAEcTyeSaH49pR4TBwp11Op4vuD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FuvO+I1k; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7277324054so76625566b.0
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763027581; x=1763632381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoBKw49AlIbvYgXLE0sUru9NF+Zm0xipHAylnS2PSy0=;
        b=FuvO+I1kcewisBnUXic0UHumRtCCaWHzpQFMv16iYHxpM0gzlNYXRF6I1gJ8GmdE0K
         GY4J7m3FHYw5srLeQFDqK9uhouD7KyyrfbAizan7pa+2L5Kyk90s/FVvHKV95tcRYq16
         hHsND5i6V0VxgGxON1cOY+QrC8mDxCxStYLPOCdPCPMauZMzI2wmoLMyQSQTV9Hg7sVd
         YJ6ApWWqrahWKHYl8hUEubNEeXFYQCNi32gn6HhD3Sf7nnQyqZjBDeA8/5W5imIG6hlo
         4bUYhKuiCnmmk/j6vKgZzyOYHl9luQfa6GyC6Cklle7RHWvE1/h670Xp6wn58zGxwVAj
         NYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763027581; x=1763632381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoBKw49AlIbvYgXLE0sUru9NF+Zm0xipHAylnS2PSy0=;
        b=G97mMqNahKgXP2cvuvuYFqOr+EsuvHG0HJNSaKGqgjRyARqQkrVIevKUNyY+QmHADm
         0NPBrpApY6TMr6Ba4vQX0flVzoX5YSYXaSPce7VigcSmLMjixmwC6cZdw/kMDWPaY88M
         HHzkft9IcItfnzvwzG0ZVD+Epkz6TCgI0DrUcvDm1NaXl3BdRgqpdRt9QCwrpRbBR1BQ
         sHTi3sULS67NSE2Auth7vaXfXnjlUAiQ47cDxp25/QpklDgsAXlBjjVTy5cqaBQwSkK0
         zZ+HqdzHuX/zVEvE1fRnqOpc5GffEbMQfplnPI9Khd5UJXXFiNwOFCo0gAZBY859XA8C
         NuBA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQESsMOIVFHQjZZUIGA90I//zm+HiJDFeDolH9OxpJvcwoSJ9G3CbKwQcaWZbNy+rpo7FRFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYGmJW1eDDKZqjNeVPra5H/boj/hef8HcvBdGiBe48PZEJSWz
	lUZtqI6YSOBM+CRULuBvwOYqWDMXxqrnxcx5cR2WycIGg+blj5PtGZtzpELMqiTboPo=
X-Gm-Gg: ASbGncvMALjvy2gusfdqtzOlNzQFjG1I6iqZ03wL1HKEwAKt/QsmoX22yqGGvZZQ9zt
	tRYVMSLEgTyfELs8HLFvjzThpGIHc7cWurC4sN/PdCSsBdJM3xCsh7u+kgW3f1LCIyYtevIXhnB
	lYh+/UnWEUoitJnynpdCJfJO0zO3PCu8lIT/Xy+xxtdOMQMaavh0gGxur2nkT15FMzUn6oZE0D2
	jyXi1jAwJcSGszcuQ+kZ1DopxvcgkQjWQ5RhKTpPbHLZiwCWtbdJWhkX4wIzw3aV/n8kS7Hi247
	tBDWZ6W+oSH/B3BXZ0TLySA796aZyZBjz/2R5gtCaOGWYWFMAHw7Jn+88TymgSs1Qx4jBKfyU9s
	P4xgnew2cFvJxoon1N2iVupFDtWwhsBjiNKMI8BkwUVJXU+HF3EGZ6ougxdOXpclIpDMr9gsaqj
	ONHH0=
X-Google-Smtp-Source: AGHT+IFOOZDoUn3QUugRM7g5tlD93FfiRjUJwHjHjA6lHKsrk39VhVq0NmVwV5vw4rnJjMFTmaZSDQ==
X-Received: by 2002:a17:906:dc89:b0:b40:6e13:1a82 with SMTP id a640c23a62f3a-b7331a71aa5mr618089466b.26.1763027580379;
        Thu, 13 Nov 2025 01:53:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fb12d55sm128460466b.33.2025.11.13.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:52:59 -0800 (PST)
Date: Thu, 13 Nov 2025 10:52:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <aRWqei9jA8gcM-sD@pathway.suse.cz>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
 <aRNk8vLuvfOOlAjV@pathway>
 <87ldkb9rnl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldkb9rnl.fsf@jogness.linutronix.de>

On Wed 2025-11-12 16:56:22, John Ogness wrote:
> On 2025-11-11, Petr Mladek <pmladek@suse.com> wrote:
> >> Introduce a new global variable @console_offload_blocked to flag
> >> when irq_work queueing is to be avoided. The flag is used by
> >> printk_get_console_flush_type() to avoid allowing deferred printing
> >> and switch NBCON consoles to atomic flushing. It is also used by
> >> vprintk_emit() to avoid klogd waking.
> >> 
> >> --- a/kernel/printk/internal.h
> >> +++ b/kernel/printk/internal.h
> >> @@ -230,6 +230,8 @@ struct console_flush_type {
> >>  	bool	legacy_offload;
> >>  };
> >>  
> >> +extern bool console_irqwork_blocked;
> >> +
> >>  /*
> >>   * Identify which console flushing methods should be used in the context of
> >>   * the caller.
> >> @@ -241,7 +243,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> >>  	switch (nbcon_get_default_prio()) {
> >>  	case NBCON_PRIO_NORMAL:
> >>  		if (have_nbcon_console && !have_boot_console) {
> >> -			if (printk_kthreads_running)
> >> +			if (printk_kthreads_running && !console_irqwork_blocked)
> >>  				ft->nbcon_offload = true;
> >>  			else
> >>  				ft->nbcon_atomic = true;
> >> @@ -251,7 +253,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> >>  		if (have_legacy_console || have_boot_console) {
> >>  			if (!is_printk_legacy_deferred())
> >>  				ft->legacy_direct = true;
> >> -			else
> >> +			else if (!console_irqwork_blocked)
> >>  				ft->legacy_offload = true;
> >>  		}
> >>  		break;
> >
> > This is one possibility.
> >
> > Another possibility would be to block the irq work
> > directly in defer_console_output() and wake_up_klogd().
> > It would handle all situations, including printk_trigger_flush()
> > or defer_console_output().
> >
> > Or is there any reason, why these two call paths are not handled?
> 
> My intention was to focus only on irq_work triggered directly by
> printk() calls as well as transitioning NBCON from threaded to direct.
> 
> > I do not have strong opinion. This patch makes it more explicit
> > when defer_console_output() or wake_up_klogd() is called.
> >
> > If we move the check into defer_console_output() or wake_up_klogd(),
> > it would hide the behavior. But it will make the API more safe
> > to use. And wake_up_klogd() is even exported via <linux/printk.h>.
> 
> Earlier test versions of this patch did exactly as you are suggesting
> here. But I felt like "properly avoiding" deferred/offloaded printing
> via printk_get_console_flush_type() (rather than just hacking
> irq_work_queue() callers to abort) was a cleaner solution. Especially
> since printk_get_console_flush_type() modifications were needed anyway
> in order to transition NBCON from threaded to direct.

I see.

> >> @@ -264,7 +266,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> >>  		if (have_legacy_console || have_boot_console) {
> >>  			if (!is_printk_legacy_deferred())
> >>  				ft->legacy_direct = true;
> >> -			else
> >> +			else if (!console_irqwork_blocked)
> >>  				ft->legacy_offload = true;
> >
> > This change won't be needed if we move the check into
> > defer_console_output() and wake_up_klogd().
> >
> >>  		}
> >>  		break;
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 5aee9ffb16b9a..94fc4a8662d4b 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >>  
> >>  	if (ft.legacy_offload)
> >>  		defer_console_output();
> >> -	else
> >> +	else if (!console_irqwork_blocked)
> >>  		wake_up_klogd();
> >
> > Same here.
> >
> >>  
> >>  	return printed_len;
> 
> I would prefer to keep all the printk_get_console_flush_type() changes
> since it returns proper available flush type information. If you would
> like to _additionally_ short-circuit __wake_up_klogd() and
> nbcon_kthreads_wake() in order to avoid all possible irq_work queueing,
> I would be OK with that.

Combining both approaches might be a bit messy. Some code paths might
work correctly because of the explicit check and some just by chance.

But I got an idea. We could add a warning into __wake_up_klogd()
and nbcon_kthreads_wake() to report when they are called unexpectedly.

And we should also prevent calling it from lib/nmi_backtrace.c.

I played with it and came up with the following changes on
top of this patch:

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 45c663124c9b..71e31b908ad1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -203,6 +203,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
+void printk_try_flush(void);
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
@@ -299,6 +300,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
 static inline void dump_stack(void)
 {
 }
+static inline void printk_try_flush(void)
+{
+}
 static inline void printk_trigger_flush(void)
 {
 }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ffd5a2593306..a09b8502e507 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1302,6 +1302,13 @@ void nbcon_kthreads_wake(void)
 	if (!printk_kthreads_running)
 		return;
 
+	/*
+	 * Nobody is allowed to call this function when console irq_work
+	 * is blocked.
+	 */
+	if (WARN_ON_ONCE(console_irqwork_blocked))
+		return;
+
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		if (!(console_srcu_read_flags(con) & CON_NBCON))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 334b4edff08c..e9290c418d12 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4581,6 +4581,13 @@ static void __wake_up_klogd(int val)
 	if (!printk_percpu_data_ready())
 		return;
 
+	/*
+	 * Nobody is allowed to call this function when console irq_work
+	 * is blocked.
+	 */
+	if (WARN_ON_ONCE(console_irqwork_blocked))
+		return;
+
 	preempt_disable();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
@@ -4637,6 +4644,21 @@ void defer_console_output(void)
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
 }
 
+void printk_try_flush(void)
+{
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
+	if (ft.legacy_direct) {
+		if (console_trylock())
+			console_unlock();
+	}
+	if (ft.legacy_offload)
+		defer_console_output();
+}
+
 void printk_trigger_flush(void)
 {
 	defer_console_output();
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 33c154264bfe..632bbc28cb79 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -78,10 +78,10 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	nmi_backtrace_stall_check(to_cpumask(backtrace_mask));
 
 	/*
-	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * Try flushing messages added CPUs which might be stuck in IRQ context
 	 * and therefore could not run their irq_work.
 	 */
-	printk_trigger_flush();
+	printk_try_flush();
 
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();

How does it look, please?

Best Regards,
Petr

