Return-Path: <stable+bounces-116941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD93A3AE71
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7932F3B5D28
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091C1BBBDC;
	Wed, 19 Feb 2025 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMJg/nWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BA33991;
	Wed, 19 Feb 2025 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926640; cv=none; b=UZ+c98x2ogwhjKvL8W1HeBmxCziwVm2K6kl4Yt+ElkpUlg+pj+4TmIZV9FhSL0Z8Ag3klUlmS4Ys+hGemhGE7t8+7IW2ATlLP59QdpndnLOnj8Y7Y+nN9+rKp6HsZJMLTkZBe79VPW3EOBQayfplsaNoQpcJRIeeehOcNPRyYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926640; c=relaxed/simple;
	bh=O476KadsknrNOtGe0FYpBki4MawyLZYBAEC/CL/ml6s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QiMv+NKZAEHvhtrAJNMVKrWlRzhwL9yOgq4e9JmM6CDNNyUuZp761cdsPgeBqbPlvuyaiFnM7FGH5SocvMNJoEFnijSFl3RAtVfh05V7ge2P8mnlQ9Dc0yHk62tIFi/F8AA6C2VpT/lMpE2lRmbP0TW265hyfIW1oOBoL8pwjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMJg/nWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A100C4CEE2;
	Wed, 19 Feb 2025 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739926640;
	bh=O476KadsknrNOtGe0FYpBki4MawyLZYBAEC/CL/ml6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMJg/nWVU8MRPLWQYfQIUgjymhjVfibF7HurwZJG07cOBW5Vc4WYiP3zkDjYujn8d
	 vnWkS8QEg/C1K9j7UBpn46fGW9LHIAvbtpLMzyFD7N6z9BcDQMQvL67fhNNiOl0zX8
	 4VVUxk95RDViI9a+cxl6w/f3PkW42LX0Go8X9M4V6TIqnkrjzUC2IKUTQOX6fdqc3U
	 FUVBx2Qkfu2R0deh/+xmWKlnQMlarX5xqWotNW370glSXoNmTDwVxXpHwj4lefSVHz
	 /bGzkxdO/isTaI0znfnJoStb+UZjzsJAy5pdmoxaGH35tXpGswouhncNopexLBt2Dj
	 JDE9RwCcLMB7g==
Date: Wed, 19 Feb 2025 09:57:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] fprobe: Always unregister fgraph function from ops
Message-Id: <20250219095715.26c7b7811b05d3952c7bfa56@kernel.org>
In-Reply-To: <20250218193126.785837383@goodmis.org>
References: <20250218193033.338823920@goodmis.org>
	<20250218193126.785837383@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 14:30:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the last fprobe is removed, it calls unregister_ftrace_graph() to
> remove the graph_ops from function graph. The issue is when it does so, it
> calls return before removing the function from its graph ops via
> ftrace_set_filter_ips(). This leaves the last function lingering in the
> fprobe's fgraph ops and if a probe is added it also enables that last
> function (even though the callback will just drop it, it does add unneeded
> overhead to make that call).
> 
>   # echo "f:myevent1 kernel_clone" >> /sys/kernel/tracing/dynamic_events
>   # cat /sys/kernel/tracing/enabled_functions
> kernel_clone (1)           	tramp: 0xffffffffc02f3000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
> 
>   # echo "f:myevent2 schedule_timeout" >> /sys/kernel/tracing/dynamic_events
>   # cat /sys/kernel/tracing/enabled_functions
> kernel_clone (1)           	tramp: 0xffffffffc02f3000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
> schedule_timeout (1)           	tramp: 0xffffffffc02f3000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
> 
>   # > /sys/kernel/tracing/dynamic_events
>   # cat /sys/kernel/tracing/enabled_functions
> 
>   # echo "f:myevent3 kmem_cache_free" >> /sys/kernel/tracing/dynamic_events
>   # cat /sys/kernel/tracing/enabled_functions
> kmem_cache_free (1)           	tramp: 0xffffffffc0219000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
> schedule_timeout (1)           	tramp: 0xffffffffc0219000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
> 
> The above enabled a fprobe on kernel_clone, and then on schedule_timeout.
> The content of the enabled_functions shows the functions that have a
> callback attached to them. The fprobe attached to those functions
> properly. Then the fprobes were cleared, and enabled_functions was empty
> after that. But after adding a fprobe on kmem_cache_free, the
> enabled_functions shows that the schedule_timeout was attached again. This
> is because it was still left in the fprobe ops that is used to tell
> function graph what functions it wants callbacks from.
> 

Good catch! I forgot to remove the filter in this case.
Is there anyway to be sure the filter is empty or clear it if
fprobe_graph_active == 0?

Thank you,

> Cc: stable@vger.kernel.org
> Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fprobe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 90241091ca61..886090845b1a 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -403,11 +403,9 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
>  	lockdep_assert_held(&fprobe_mutex);
>  
>  	fprobe_graph_active--;
> -	if (!fprobe_graph_active) {
> -		/* Q: should we unregister it ? */
> +	/* Q: should we unregister it ? */
> +	if (!fprobe_graph_active)
>  		unregister_ftrace_graph(&fprobe_graph_ops);
> -		return;
> -	}
>  
>  	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
>  }
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

