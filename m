Return-Path: <stable+bounces-9017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22186820725
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 17:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D056F281E03
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E49479;
	Sat, 30 Dec 2023 16:21:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E3DDA9;
	Sat, 30 Dec 2023 16:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7701DC433C9;
	Sat, 30 Dec 2023 16:21:53 +0000 (UTC)
Date: Sat, 30 Dec 2023 11:22:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, stable
 <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "ring-buffer: Force absolute timestamp on discard of
 event" has been added to the 6.1-stable tree
Message-ID: <20231230112246.72c8b2cd@gandalf.local.home>
In-Reply-To: <20231210194035.164923-1-sashal@kernel.org>
References: <20231210194035.164923-1-sashal@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Sasha,

Was this automated or did you do this manually?

I'm asking because I was walking through my INBOX to see what FAILED
backports I could clean up, and I started on this one:

  https://lore.kernel.org/all/2023120938-unclamped-fleshy-688e@gregkh/

I did the cherry pick, fixed up the conflict, but when I tried to commit
it, it failed because there was nothing to commit.

This confused me for a bit, and then when I did a git blame, I saw that you
had done the fix already.

When you fix a FAILED patch, can you do a reply to the FAILED message that
Greg sends out, so that I don't waste my time on trying to fix something
that was already fixed?

Thanks!

-- Steve


On Sun, 10 Dec 2023 14:40:35 -0500
Sasha Levin <sashal@kernel.org> wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     ring-buffer: Force absolute timestamp on discard of event
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ring-buffer-force-absolute-timestamp-on-discard-of-e.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 1249c67fa9a9b3ae207b53fcbefa8dac3acbc308
> Author: Steven Rostedt (Google) <rostedt@goodmis.org>
> Date:   Wed Dec 6 10:02:44 2023 -0500
> 
>     ring-buffer: Force absolute timestamp on discard of event
>     
>     [ Upstream commit b2dd797543cfa6580eac8408dd67fa02164d9e56 ]
>     
>     There's a race where if an event is discarded from the ring buffer and an
>     interrupt were to happen at that time and insert an event, the time stamp
>     is still used from the discarded event as an offset. This can screw up the
>     timings.
>     
>     If the event is going to be discarded, set the "before_stamp" to zero.
>     When a new event comes in, it compares the "before_stamp" with the
>     "write_stamp" and if they are not equal, it will insert an absolute
>     timestamp. This will prevent the timings from getting out of sync due to
>     the discarded event.
>     
>     Link: https://lore.kernel.org/linux-trace-kernel/20231206100244.5130f9b3@gandalf.local.home
>     
>     Cc: stable@vger.kernel.org
>     Cc: Masami Hiramatsu <mhiramat@kernel.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Fixes: 6f6be606e763f ("ring-buffer: Force before_stamp and write_stamp to be different on discard")
>     Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f3c4bb54a0485..c02a4cb879913 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3025,22 +3025,19 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>  			local_read(&bpage->write) & ~RB_WRITE_MASK;
>  		unsigned long event_length = rb_event_length(event);
>  
> +		/*
> +		 * For the before_stamp to be different than the write_stamp
> +		 * to make sure that the next event adds an absolute
> +		 * value and does not rely on the saved write stamp, which
> +		 * is now going to be bogus.
> +		 */
> +		rb_time_set(&cpu_buffer->before_stamp, 0);
> +
>  		/* Something came in, can't discard */
>  		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
>  				       write_stamp, write_stamp - delta))
>  			return 0;
>  
> -		/*
> -		 * It's possible that the event time delta is zero
> -		 * (has the same time stamp as the previous event)
> -		 * in which case write_stamp and before_stamp could
> -		 * be the same. In such a case, force before_stamp
> -		 * to be different than write_stamp. It doesn't
> -		 * matter what it is, as long as its different.
> -		 */
> -		if (!delta)
> -			rb_time_set(&cpu_buffer->before_stamp, 0);
> -
>  		/*
>  		 * If an event were to come in now, it would see that the
>  		 * write_stamp and the before_stamp are different, and assume


