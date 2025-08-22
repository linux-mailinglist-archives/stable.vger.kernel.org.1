Return-Path: <stable+bounces-172387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8594BB318E8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F80189DFA6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241D2FC007;
	Fri, 22 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b1Vq6JAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE52E6114;
	Fri, 22 Aug 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868056; cv=none; b=ZG8k5HMA8lTFN0jniKAkJ0ZU5/2X2HuWSjRBdcOfHou6NxIr9wK7el6Xnq22YtpOFUhCCeTzrGDPO+52N0kH7ndDOUZmegdBFJvM9mkdL/llTYeCE9MYkbHBPhIRpBYSGqBpK3m0OlEz3D2iNjfunbYpegInxhbryKUDWjn2ITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868056; c=relaxed/simple;
	bh=I1vnQdWoQ3da9zwNugFK9yS/sak81xz7G7nlJDyiBeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJjykYA9oqpXgBG5ifcfLHnMVQ0t/JaJG+aUiQAKhbv6IORYWZZBYESnUsvpX2f4WAFrPG5+5QeA1yWX+r8VbUfvMlbt6SGQCRP/tLwGsuhBRgc5/Sc1twWD/tTNBAn+wvjij363L6bgCk7mOFMxb7U1Cqi+/LeAaGIAexOcLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b1Vq6JAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA726C4CEED;
	Fri, 22 Aug 2025 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755868055;
	bh=I1vnQdWoQ3da9zwNugFK9yS/sak81xz7G7nlJDyiBeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1Vq6JAQuvvYPjy3NLd+Zc0cKD6v4zj7BDiT3YiYnx/jPqw/ZNUOAM7c9XqhYd/LK
	 oqYOjigGO508K0nHIROPC7OtRhegzMoOM7xO454jJsMWtcO5yZviV2qONvrLqZMa/9
	 ZPxMiq1GmVKjz0q8fOrgsKvB/Ym0MSG5EEl4W+88=
Date: Fri, 22 Aug 2025 15:07:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, tglx@linutronix.de,
	jstultz@google.com, clingutla@codeaurora.org, mingo@kernel.org,
	sashal@kernel.org, boqun.feng@gmail.com, ryotkkr98@gmail.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "J . Avila" <elavila@google.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Message-ID: <2025082257-smirk-backside-6d93@gregkh>
References: <20250812161755.609600-1-sumanth.gavini.ref@yahoo.com>
 <20250812161755.609600-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812161755.609600-1-sumanth.gavini@yahoo.com>

On Tue, Aug 12, 2025 at 11:17:54AM -0500, Sumanth Gavini wrote:
> commit f4bf3ca2e5cba655824b6e0893a98dfb33ed24e5 upstream.
> 
> Tasklets are supposed to finish their work quickly and should not block the
> current running process, but it is not guaranteed that they do so.
> 
> Currently softirq_entry/exit can be used to analyse the total tasklets
> execution time, but that's not helpful to track individual tasklets
> execution time. That makes it hard to identify tasklet functions, which
> take more time than expected.
> 
> Add tasklet_entry/exit trace point support to track individual tasklet
> execution.
> 
> Trivial usage example:
>    # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_entry/enable
>    # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_exit/enable
>    # cat /sys/kernel/debug/tracing/trace
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 4/4   #P:4
>  #
>  #                                _-----=> irqs-off/BH-disabled
>  #                               / _----=> need-resched
>  #                              | / _---=> hardirq/softirq
>  #                              || / _--=> preempt-depth
>  #                              ||| / _-=> migrate-disable
>  #                              |||| /     delay
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>            <idle>-0       [003] ..s1.   314.011428: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
>            <idle>-0       [003] ..s1.   314.011432: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
>            <idle>-0       [003] ..s1.   314.017369: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
>            <idle>-0       [003] ..s1.   314.017371: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
> 
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> Signed-off-by: J. Avila <elavila@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Link: https://lore.kernel.org/r/20230407230526.1685443-1-jstultz@google.com
> 
> [elavila: Port to android-mainline]

This is not android-mainline, this is the normal stable tree.

And I'm with John, this makes no sense as to why you need/want these.  I
think that the syzbot report is bogus, sorry.  Please prove me wrong :)

thanks,

greg k-h

