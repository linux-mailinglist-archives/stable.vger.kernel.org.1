Return-Path: <stable+bounces-194509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A99C4F0AC
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED273AD8AD
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5803128D0;
	Tue, 11 Nov 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bpM/0HuS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90936C5B6
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878712; cv=none; b=ccuk0G0FHxd2LrrVs71YqIxUakVryL9K7QRrkmnBPSRPhAQ/4YJEo1Nn2jTHVhIgsxnOFSlR7jBdtp/pSQI3uwiJrIbk9d49rnJcde5wm7/W1W+/8xS/cxqqhWALGOwE5PJ9zzqCVz0dUj898JSfJzb+jMOBQurjTcDXPbFv588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878712; c=relaxed/simple;
	bh=/7JhdeqHU+pWuZo7BJYr/RwCCv41S/jJab+74+3hwpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1exomNJaHMLPaNehqjXSE/UOUs0vFvY1R/vB3rYmpV7EnZwht14hxRYlgtPSeOKGU+R2ElgMhMQPSJYBtf0eq5MLquizJuPUYwY2FGgvn17V+e9y1mi07II/QptbNPbT1T7xxoVLrZ9PjR6g2zWtWf7/BibQfR3y09ipZxrTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bpM/0HuS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso4223820a12.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762878709; x=1763483509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJEhmkdX/tZ6LlQiQX/bCOF/D5Lhd4PVnpUuCIOrAzo=;
        b=bpM/0HuSOo+MutJFeGQXYeeqH6ySa1JHquNYE35DJOb5b/oorzJdQDskdaHH/CJweE
         plltLQ2siyhCqffJ2X0A7BhdqhKJXMcqI5seSkos/Fdxt3uBeLmQRISRnvJM5VYXxOHM
         rSkAq6Wrv06FUBYV+k/Zjut9+jDe+6J4jz/0fP9nTgmSteQ4Qd0E3R5IU/Hd4w7OXeNI
         gSTK6uenuOJn8oWAXs2Rv51D0tJiLDn415SBzMCk3l8FpuqerI2nj9rPfV0tTlZzb3Z8
         HYPpK80uo0jM2am3I1GEbiSfDEWjndlj5v0KuH6mZzUnSZAbuAdykkitjcyDcAfFgQfO
         IP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878709; x=1763483509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJEhmkdX/tZ6LlQiQX/bCOF/D5Lhd4PVnpUuCIOrAzo=;
        b=XwXAVLsEVUj8g4QR332Gdb4MnqtawirHskaF64M/uc2d329YcaCtIr7ZckM++/f5zm
         41RWerB1jErfKJ6ULKP8MarrsALakAyYkQTJvD4jiz2QaSrmWFvaj+W2Ui5ud8r1vihP
         4XaGtRsSEx4sFIWQa6K8TZRmdYFTZhixQOeP6PZDF6mBdRo3Dpdw/+jfCKUwotT4WcnL
         ljdyw5uoCc99TkZi+Rg1hwN8CGhO7qoVOtLgS27IuKlrEJdqrND9ngPWo6/+rYp2iDuE
         oJojltZO/1FKYmQvwQIeUw4FYcIX1btfWt57D4p8QkWNIlxwiMnL7YvsLbF4ZYtFm42i
         42Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVsdPW69fvwqX6QKyzOwPUjXCQjDHggymr6T+dJFpgtMpV3WUNrRKOVeaT27mqh+miHLCPTBa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEt8Ebi6Q8Q3JxrQons9OsdL+xkRysLBLj8Gw0pvT8AP2ZYSeA
	78yQmWvfqn5pXbC1nbxAg2EJtDFTEOiUSDtqeiHf3z+Ifbytv5XHxWMi5TtkDd/3EFE=
X-Gm-Gg: ASbGncuKYsPbpOxQKS+UTKu11uPCqBzvqtMptXS04+0mxod91oZ32CHiIzG+lEsLWVv
	TtjvmX70Iux2taLUDthhC+eOoxx39HX2Y2exGE4mIn3AZbFsgS0Vi37jnxXU8nSsn0VYwPTMaWm
	VKQsCqp41hIPFS2QAiB+bXdmt88fQWQM7nJF1VVb6gnVbrRFSA0yk4etSLpd50TWCATLVmiz4TE
	QUqn/Jj5qK65IDLJqV5cdCgvOY+qsCI3OCq3fNFpVsnNztNqBrW8blc2oS3IP4vM5geLGkORFVV
	0pERVlVxngijQXM3jh+FRG9gnidv3oZIdofmgewQTQjuWNKvv5nbU3IkasRGYgAjhweYPj2Hjek
	oXkEhlndj1bOXrjJmuI1IrZ0O/gFUe+soFsvCZGAwPnRjzRNintX4A2BXLOZX9zAs93o2gxL/+j
	IbMNUsDCK+J217FdCJ8gTHwQE1DgCn
X-Google-Smtp-Source: AGHT+IHeMXFBK2R94y0xAavt77FqJhtG78dDnrH6Srnh9imuOjXwMgWyuYOPJ4SCpRj8L5bEITGGSg==
X-Received: by 2002:a17:907:960a:b0:b6d:519f:2389 with SMTP id a640c23a62f3a-b72e04ad8b5mr1360986366b.52.1762878708718;
        Tue, 11 Nov 2025 08:31:48 -0800 (PST)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312e51sm1366249866b.17.2025.11.11.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:31:48 -0800 (PST)
Date: Tue, 11 Nov 2025 17:31:46 +0100
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
Message-ID: <aRNk8vLuvfOOlAjV@pathway>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111144328.887159-2-john.ogness@linutronix.de>

On Tue 2025-11-11 15:49:22, John Ogness wrote:
> Allowing irq_work to be scheduled while trying to suspend has shown
> to cause problems as some architectures interpret the pending
> interrupts as a reason to not suspend. This became a problem for
> printk() with the introduction of NBCON consoles. With every
> printk() call, NBCON console printing kthreads are woken by queueing
> irq_work. This means that irq_work continues to be queued due to
> printk() calls late in the suspend procedure.
> 
> Avoid this problem by preventing printk() from queueing irq_work
> once console suspending has begun. This applies to triggering NBCON
> and legacy deferred printing as well as klogd waiters.
> 
> Since triggering of NBCON threaded printing relies on irq_work, the
> pr_flush() within console_suspend_all() is used to perform the final
> flushing before suspending consoles and blocking irq_work queueing.
> NBCON consoles that are not suspended (due to the usage of the
> "no_console_suspend" boot argument) transition to atomic flushing.
> 
> Introduce a new global variable @console_offload_blocked to flag

s/console_offload_blocked/console_irqwork_blocked/

> when irq_work queueing is to be avoided. The flag is used by
> printk_get_console_flush_type() to avoid allowing deferred printing
> and switch NBCON consoles to atomic flushing. It is also used by
> vprintk_emit() to avoid klogd waking.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -230,6 +230,8 @@ struct console_flush_type {
>  	bool	legacy_offload;
>  };
>  
> +extern bool console_irqwork_blocked;
> +
>  /*
>   * Identify which console flushing methods should be used in the context of
>   * the caller.
> @@ -241,7 +243,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>  	switch (nbcon_get_default_prio()) {
>  	case NBCON_PRIO_NORMAL:
>  		if (have_nbcon_console && !have_boot_console) {
> -			if (printk_kthreads_running)
> +			if (printk_kthreads_running && !console_irqwork_blocked)
>  				ft->nbcon_offload = true;
>  			else
>  				ft->nbcon_atomic = true;
> @@ -251,7 +253,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>  		if (have_legacy_console || have_boot_console) {
>  			if (!is_printk_legacy_deferred())
>  				ft->legacy_direct = true;
> -			else
> +			else if (!console_irqwork_blocked)
>  				ft->legacy_offload = true;
>  		}
>  		break;

This is one possibility.

Another possibility would be to block the irq work
directly in defer_console_output() and wake_up_klogd().
It would handle all situations, including printk_trigger_flush()
or defer_console_output().

Or is there any reason, why these two call paths are not handled?

I do not have strong opinion. This patch makes it more explicit
when defer_console_output() or wake_up_klogd() is called.

If we move the check into defer_console_output() or wake_up_klogd(),
it would hide the behavior. But it will make the API more safe
to use. And wake_up_klogd() is even exported via <linux/printk.h>.


> @@ -264,7 +266,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>  		if (have_legacy_console || have_boot_console) {
>  			if (!is_printk_legacy_deferred())
>  				ft->legacy_direct = true;
> -			else
> +			else if (!console_irqwork_blocked)
>  				ft->legacy_offload = true;

This change won't be needed if we move the check into
defer_console_output() and wake_up_klogd().

>  		}
>  		break;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5aee9ffb16b9a..94fc4a8662d4b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	if (ft.legacy_offload)
>  		defer_console_output();
> -	else
> +	else if (!console_irqwork_blocked)
>  		wake_up_klogd();

Same here.

>  
>  	return printed_len;


The rest of the patch looks good to me.

Best Regards,
Petr

