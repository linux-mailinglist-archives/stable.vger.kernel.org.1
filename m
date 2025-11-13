Return-Path: <stable+bounces-194684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5DC57236
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 12:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9837F3A53D7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCAA33BBDA;
	Thu, 13 Nov 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HMuZoRh+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED433B96C
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032554; cv=none; b=WoBP7uVX20FGDyKXCPaC0GgtdgfOwdVFIcwCMgG5gNnsM7pHbk9zc6mR8UR9wPoxz75KU7YjytHcxrKx0+Ql5A/pjD8cakY75dp1val4ZBnrZarzj+CJQTQq2uceGFF41356/WW5YjY+tP8iwMfS5FUyvaiIIsVAWZsEckDobsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032554; c=relaxed/simple;
	bh=7Dty1bsVrl3mflWypqdumDcsm+eUd6kxdLgav7xBytY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmK31DHtSJFbHGxaQcBbuastSqX0lFEg3ZATk7tn4i0AZOKVxtEw6junQTeamsg9Im6t6iFZJvlBJEsTlVig0HXvJzP0pjEesyclUHKpOZqXMhgjcipmn0zcCRYMzW9HJu+bdBh6iHjBiZI4WxFCaA3wfITT4+HF09Ld92w9JVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HMuZoRh+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7355f6ef12so68519266b.3
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 03:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763032550; x=1763637350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5AzzFRZPbAyw/0U2l3vo4T8Z0AKAvwU0ttCnBP9wco=;
        b=HMuZoRh+Jngf1OkERsVdMUw/sJ5vTIDiLbUXMxOds4Lk8Kx7L10xHWE3y/QRXqHl1W
         dIccO+egfpUCaszzY8usa+j9cCR9W6sLDgEDXroUNfNR4Kg/ZBvkBMJ8LwC8O6hWHIiN
         bCzii8vJ0CYVxt0hiZ2F5uzT9THnf2GsNwSFTaO/20AHT1UO5JqFGDUQFELAbujAYM+v
         bnh1tUnXXdCfe942oOh+qY4Ig4t8bYBjNXusMzIU4/lB3F+I/iI1tJmgkiMZnQnskhsa
         hGjojOdUCoM+cK23aJqTwGnn5FWDGwHyZ7GfcMLfcMfFtSzdJqiHtJthW8GaVAgyfcNa
         cFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032550; x=1763637350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5AzzFRZPbAyw/0U2l3vo4T8Z0AKAvwU0ttCnBP9wco=;
        b=htET31R3k5CRDRry1AQVsL2AFkyhomgk1DuS1+wTJN0iJUOUu8TI5FvQ6TEVRWX796
         g7anaCia8K2dFy0vFknCE7g1UGe+GQqvX+2nhqzrJotaM1/4x3s9/O1r5kEHcHAWdE6u
         9L62KPghipDtG8/MyHtVXWNeg1wa9GgsOVU73l9P+V30jFbPhaV/fdl0fCAT1B+LXLOd
         kzMrEvIVHT0yZeyngb2CdN+sEj/Na94FyK/KaQO4J5jK/WjEJGEdGlJ+r1j2ysV/Q8Tx
         UlggJYv4tqkBYiNJ6NFpZn0JE51vMS+MAr5cDT+VFEFb5OPA5jHiLo9V3WXz7CkaSW5q
         b+4A==
X-Forwarded-Encrypted: i=1; AJvYcCWROJoEtwb4ycAVkajqK1JMxfZ1Y5VbbxytoD5+ru2XBpgFrvXIGunVRB7HquAt+fdsRg/5xBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCMjNLkyxTC4udMfi36oWvudhENv0PjuLiONo7fU0nxDuftCl
	ufijMcY5D1DELkYb/en7KJp7ZX5A/Svnba2a6C8f3Z4dLbmTMp//9/6vdmLIOSkR460=
X-Gm-Gg: ASbGnctSoafMYnjGpetT55jH8Qwrz/wCS22tyQtu9ULwGqV6wrXQOn5K4YDlyYh4pLr
	4ci8gZTRxDhIsad1Ae6inK49wzSwTksSg83Z3CjclIZb7a+FsXXLAER3KQ/b7/nteHpI3vt60/U
	i+0PRrC28dwWR7win0e63+sHyx1MgYaQnzbQuqG24Nt27K43n4nCFH2QDzOcAp5qhLMvQcMIdU8
	ooV/pssSrI4UxWQ2rWdFoTQ13DHfNy3pWlW1Xi+3W8R1z4g7Bbfrfjk8deToxYfcHuMtQmlNOB9
	iTascfxpxbl7qzjXvlaJWOi+SYSP+1+w3dd+29qaGXHaO5abi+NASkJ26avBDf58P00PD0RjpUt
	K4Nr2g4+3eDeyzkQKnKiuS4zOg6+l9G0t62Yun1aqjfNxP3lRs0Wxnaaxey+FKruq2stTjBnbFk
	5aTuU=
X-Google-Smtp-Source: AGHT+IExcpEGzB16h+OORPfiSc3U/Q+WA4IUJ/PrcE+hSGqVvU7uaWsum+i+r5qrKs9tVBN7TJ03IQ==
X-Received: by 2002:a17:907:3f11:b0:b73:1baa:6424 with SMTP id a640c23a62f3a-b7331af1e06mr647068066b.55.1763032550071;
        Thu, 13 Nov 2025 03:15:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd809fasm142355066b.45.2025.11.13.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:15:49 -0800 (PST)
Date: Thu, 13 Nov 2025 12:15:47 +0100
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
Message-ID: <aRW9439ee0NdXuyo@pathway.suse.cz>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
 <aRNk8vLuvfOOlAjV@pathway>
 <87ldkb9rnl.fsf@jogness.linutronix.de>
 <aRWqei9jA8gcM-sD@pathway.suse.cz>
 <877bvukzs1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bvukzs1.fsf@jogness.linutronix.de>

On Thu 2025-11-13 11:17:42, John Ogness wrote:
> On 2025-11-13, Petr Mladek <pmladek@suse.com> wrote:
> >> I would prefer to keep all the printk_get_console_flush_type() changes
> >> since it returns proper available flush type information. If you would
> >> like to _additionally_ short-circuit __wake_up_klogd() and
> >> nbcon_kthreads_wake() in order to avoid all possible irq_work queueing,
> >> I would be OK with that.
> >
> > Combining both approaches might be a bit messy. Some code paths might
> > work correctly because of the explicit check and some just by chance.
> >
> > But I got an idea. We could add a warning into __wake_up_klogd()
> > and nbcon_kthreads_wake() to report when they are called unexpectedly.
> >
> > And we should also prevent calling it from lib/nmi_backtrace.c.
> >
> > I played with it and came up with the following changes on
> > top of this patch:
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 334b4edff08c..e9290c418d12 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -4637,6 +4644,21 @@ void defer_console_output(void)
> >  	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
> >  }
> >  
> > +void printk_try_flush(void)
> > +{
> > +	struct console_flush_type ft;
> > +
> > +	printk_get_console_flush_type(&ft);
> > +	if (ft.nbcon_atomic)
> > +		nbcon_atomic_flush_pending();
> 
> For completeness, we should probably also have here:
> 
> 	if (ft.nbcon_offload)
> 		nbcon_kthreads_wake();

Makes sense. I think that did not add it because I got scared by
the _wake suffix. I forgot that it just queued the irq_work.


> > +	if (ft.legacy_direct) {
> > +		if (console_trylock())
> > +			console_unlock();
> > +	}
> > +	if (ft.legacy_offload)
> > +		defer_console_output();
> > +}
> > +
> >  void printk_trigger_flush(void)
> >  {
> >  	defer_console_output();
> > diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> > index 33c154264bfe..632bbc28cb79 100644
> > --- a/lib/nmi_backtrace.c
> > +++ b/lib/nmi_backtrace.c
> > @@ -78,10 +78,10 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> >  	nmi_backtrace_stall_check(to_cpumask(backtrace_mask));
> >  
> >  	/*
> > -	 * Force flush any remote buffers that might be stuck in IRQ context
> > +	 * Try flushing messages added CPUs which might be stuck in IRQ context
> >  	 * and therefore could not run their irq_work.
> >  	 */
> > -	printk_trigger_flush();
> > +	printk_try_flush();
> >  
> >  	clear_bit_unlock(0, &backtrace_flag);
> >  	put_cpu();
> >
> > How does it look, please?
> 
> I like this. But I think the printk_try_flush() implementation should
> simply replace the implementation of printk_trigger_flush().

Make sense.

> For the arch/powerpc/kernel/watchdog.c:watchdog_timer_interrupt() and
> lib/nmi_backtrace.c:nmi_trigger_cpumask_backtrace() sites I think it is
> appropriate.

Yup.

> For the kernel/printk/nbcon.c:nbcon_device_release() site I think the
> call should be changed to defer_console_output():
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 558ef31779760..73f315fd97a3e 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1849,7 +1849,7 @@ void nbcon_device_release(struct console *con)
>  			if (console_trylock())
>  				console_unlock();
>  		} else if (ft.legacy_offload) {
> -			printk_trigger_flush();
> +			defer_console_output();
>  		}
>  	}
>  	console_srcu_read_unlock(cookie);

Looks good.

> Can I fold all that into a new patch?

Go ahead.

Best Regards,
Petr

