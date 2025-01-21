Return-Path: <stable+bounces-109588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE4A178F1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 08:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544A618855CC
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17F1B414B;
	Tue, 21 Jan 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8M4HOfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E42913;
	Tue, 21 Jan 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446346; cv=none; b=B8Td2WD4VnFZBKbnSmHdiRaudzFM00FLGk8i+0hVSSaQ0+S0dzbvQV14BSm/9dff6McwPNajhRTHcMpRNjCKLPTKquFLuRxDq3QeQEeBVJSWedANLONNi5vpIMxg3WiWq5I8Hpg8gXfwL+ReIqgK7raVociS8yrlzLG5c0TjtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446346; c=relaxed/simple;
	bh=E2/bZ7VMntQ1oiUyzFadEi4P3H3GGSHYXxeM+aYMSFk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s0VWZg+vrNyevRZ5f2Y/lzIBCW8qjWPribUof0JCHED7N2myjkI630gK+nJObsCi9vK9jUnhGQvtrqG6yYC5kinjSkJQVV9cPiC3LXtzRJFrj8VStcVDxq692tj4i3JCbztbre+h/PkXkjV6kz8h524KK1z93G38PmAJ46D5VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8M4HOfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E529AC4CEDF;
	Tue, 21 Jan 2025 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737446345;
	bh=E2/bZ7VMntQ1oiUyzFadEi4P3H3GGSHYXxeM+aYMSFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s8M4HOfoa4j8aMOLgzQmVTHOFTHq8xFzpirSabMz+eflWcysGeZ0kdAinATR+Z0Nc
	 S0VnjKISaqNZIJH5A42LPyAG1ZV0WdV7QYN3Rz0+rE2vrbh49WGYe1rgmuzwcrNWw9
	 C1/pTDz/Q798nkWzEvbn6mh6oCDwu9Utx2laLnYpDpCnLD77fIn+xfWe0HKXw1aS7Z
	 0CYHsWeEupFF9i9QoOBuXTRJlYBeKfAM9qZRbLe0Qif6JWYy2tB38Z9NB8KIoSYRyh
	 st20hSgZ2HlPEEScVtHOQr6SF6U8FLSLttbkGKEIWPowts3JCYf3wqr115oVziArsf
	 TRv0QGYbfwcOQ==
Date: Tue, 21 Jan 2025 16:59:02 +0900
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
Subject: Re: [PATCH 1/2] ring-buffer: Do not allow events in NMI with
 generic atomic64 cmpxchg()
Message-Id: <20250121165902.c671d578a19c0980c826eabb@kernel.org>
In-Reply-To: <20250120235721.407068250@goodmis.org>
References: <20250120235655.144537620@goodmis.org>
	<20250120235721.407068250@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 18:56:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Some architectures can not safely do atomic64 operations in NMI context.
> Since the ring buffer relies on atomic64 operations to do its time
> keeping, if an event is requested in NMI context, reject it for these
> architectures.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Cc: stable@vger.kernel.org
> Fixes: c84897c0ff592 ("ring-buffer: Remove 32bit timestamp logic")
> Closes: https://lore.kernel.org/all/86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com/
> Reported-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 6d61ff78926b..b8e0ae15ca5b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4398,8 +4398,13 @@ rb_reserve_next_event(struct trace_buffer *buffer,
>  	int nr_loops = 0;
>  	int add_ts_default;
>  
> -	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
> -	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
> +	/*
> +	 * ring buffer does cmpxchg as well as atomic64 operations
> +	 * (which some archs use locking for atomic64), make sure this
> +	 * is safe in NMI context
> +	 */
> +	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
> +	     IS_ENABLED(CONFIG_GENERIC_ATOMIC64)) &&
>  	    (unlikely(in_nmi()))) {
>  		return NULL;
>  	}
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

