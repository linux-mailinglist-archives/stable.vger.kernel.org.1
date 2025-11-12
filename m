Return-Path: <stable+bounces-194628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB28C53470
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8326335405F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568C199230;
	Wed, 12 Nov 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oym3HxYM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhi4FiQB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5B338904;
	Wed, 12 Nov 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962627; cv=none; b=kIZGbxz8nYjDI9m7FhbNc6yYdeMT/dnEHcHJnTcA2I1TujMCtDrOZgxIg15vvPT85dBmo6wV8jFEg8RVe2qzFuoI63AwkNoNnlX3ln2bbvUhhKxd3n/lcQ5OHMcqpVZiAZgiYb7eWcx+k4DNjPi/aQyq14Ws4/9BdgZi5YpY17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962627; c=relaxed/simple;
	bh=tBqz5U+S4FJMVOt1fgMrckfUtXI/ikaWkctwPP1JJ2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7LZ4pmonwCRclg9YZyZerls3i3gzMJWWZJ4H4A58cQ+yb1PYTqHf3/w3JdW012VslS0hxlQdZFVbLcohzU/bVubk0cXAD4VcOWf3Nyc7X+C1xjw2NqyINmPJpMY0UI8Dtz8GnTr28RIRgzYmqdHEfqQQsCl/ahiIE+3UNTwFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oym3HxYM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhi4FiQB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762962623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWGMfk45SdLnD09q+h2yhcEoz1tTr3zQhx0NUvqG/Vg=;
	b=Oym3HxYMTqc2C/Vuim9P8HPxKYR97UFIgpHgk4RGD7fFn35fLd+EusM45YO10S+ZlrV+au
	0VLXtMxNtZ1MP8ntoTGuMQ6+JRXGmZo1oJVfwt0sZAkDBoVFhwHLjV75+h82kn0fte6E8D
	e9v2a3iDLw2fHMgEZDLmlZuFh1JDhiZcCChon7B8hoTLBjAzbH2ChO/Jee8yLfjwGaRATi
	RkToBzFBowY6m+N5uFVgCK+VWIfqJrBz/se2sAUDQJPJ3kjtPigKr3bZeSVhUfSTGUfxPP
	XJ4HKB6KHtuQ+1tu3RTN/9xwuYm3/C7Ms2o1sGqTtAwiYiFJtwmJMwv7H7ir5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762962623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWGMfk45SdLnD09q+h2yhcEoz1tTr3zQhx0NUvqG/Vg=;
	b=qhi4FiQBeyw7Zz1MGodX0gFCzTJmfWcGiafJDqb/vAOr1xeRxhq5VdrTHsoYy7WNr4HXR/
	7UMbHfOcfTYsnRDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sherry Sun <sherry.sun@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Derek Barbosa <debarbos@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on suspend
In-Reply-To: <aRNk8vLuvfOOlAjV@pathway>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
 <aRNk8vLuvfOOlAjV@pathway>
Date: Wed, 12 Nov 2025 16:56:22 +0106
Message-ID: <87ldkb9rnl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-11, Petr Mladek <pmladek@suse.com> wrote:
>> Introduce a new global variable @console_offload_blocked to flag
>
> s/console_offload_blocked/console_irqwork_blocked/

Ack.

>> when irq_work queueing is to be avoided. The flag is used by
>> printk_get_console_flush_type() to avoid allowing deferred printing
>> and switch NBCON consoles to atomic flushing. It is also used by
>> vprintk_emit() to avoid klogd waking.
>> 
>> --- a/kernel/printk/internal.h
>> +++ b/kernel/printk/internal.h
>> @@ -230,6 +230,8 @@ struct console_flush_type {
>>  	bool	legacy_offload;
>>  };
>>  
>> +extern bool console_irqwork_blocked;
>> +
>>  /*
>>   * Identify which console flushing methods should be used in the context of
>>   * the caller.
>> @@ -241,7 +243,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>>  	switch (nbcon_get_default_prio()) {
>>  	case NBCON_PRIO_NORMAL:
>>  		if (have_nbcon_console && !have_boot_console) {
>> -			if (printk_kthreads_running)
>> +			if (printk_kthreads_running && !console_irqwork_blocked)
>>  				ft->nbcon_offload = true;
>>  			else
>>  				ft->nbcon_atomic = true;
>> @@ -251,7 +253,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>>  		if (have_legacy_console || have_boot_console) {
>>  			if (!is_printk_legacy_deferred())
>>  				ft->legacy_direct = true;
>> -			else
>> +			else if (!console_irqwork_blocked)
>>  				ft->legacy_offload = true;
>>  		}
>>  		break;
>
> This is one possibility.
>
> Another possibility would be to block the irq work
> directly in defer_console_output() and wake_up_klogd().
> It would handle all situations, including printk_trigger_flush()
> or defer_console_output().
>
> Or is there any reason, why these two call paths are not handled?

My intention was to focus only on irq_work triggered directly by
printk() calls as well as transitioning NBCON from threaded to direct.

> I do not have strong opinion. This patch makes it more explicit
> when defer_console_output() or wake_up_klogd() is called.
>
> If we move the check into defer_console_output() or wake_up_klogd(),
> it would hide the behavior. But it will make the API more safe
> to use. And wake_up_klogd() is even exported via <linux/printk.h>.

Earlier test versions of this patch did exactly as you are suggesting
here. But I felt like "properly avoiding" deferred/offloaded printing
via printk_get_console_flush_type() (rather than just hacking
irq_work_queue() callers to abort) was a cleaner solution. Especially
since printk_get_console_flush_type() modifications were needed anyway
in order to transition NBCON from threaded to direct.

>> @@ -264,7 +266,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>>  		if (have_legacy_console || have_boot_console) {
>>  			if (!is_printk_legacy_deferred())
>>  				ft->legacy_direct = true;
>> -			else
>> +			else if (!console_irqwork_blocked)
>>  				ft->legacy_offload = true;
>
> This change won't be needed if we move the check into
> defer_console_output() and wake_up_klogd().
>
>>  		}
>>  		break;
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 5aee9ffb16b9a..94fc4a8662d4b 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  
>>  	if (ft.legacy_offload)
>>  		defer_console_output();
>> -	else
>> +	else if (!console_irqwork_blocked)
>>  		wake_up_klogd();
>
> Same here.
>
>>  
>>  	return printed_len;

I would prefer to keep all the printk_get_console_flush_type() changes
since it returns proper available flush type information. If you would
like to _additionally_ short-circuit __wake_up_klogd() and
nbcon_kthreads_wake() in order to avoid all possible irq_work queueing,
I would be OK with that.

John

