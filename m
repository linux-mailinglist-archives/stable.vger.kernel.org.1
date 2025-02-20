Return-Path: <stable+bounces-118371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E893A3D083
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 05:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913807A89AD
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757A1E0E16;
	Thu, 20 Feb 2025 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkeJK9BJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB043FD1;
	Thu, 20 Feb 2025 04:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026493; cv=none; b=NmDX83yrPTfPIFLZmuzaK4dM77xIv7HUV6PRRLGhcKEAyG3JvBbs8ScMxPxuXnV7goRmmwDw+/JMAOqJf9YqYCUFAYQaQl/mZBkONR4aKsYyvDUVYjpqXAFxrrjs2ZnIJGUovLfu6+J2TjL1JDRv5inqvJ9rUmJPznbl4DJ9U7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026493; c=relaxed/simple;
	bh=U//WCjz/OhSm6S+aKb2vckRzIxF+ipPyMBGHe+o6hVE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SVTt3hFFhI5oaEe9zUUIdKTToGqiC1ZYShBsMwN7t0EchTt32QNbNx27Buj8UNVLYFbt9PYMk5iwpqmX+P1EIPlYdiftNahL2iYOO0YxT7Jozy9uB1Ziuwms3ro7HOo30TdjZPkwgd54s/5tSEeq1mCF47FtD9QN/G8Vc6kmPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkeJK9BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A17C4CED1;
	Thu, 20 Feb 2025 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740026492;
	bh=U//WCjz/OhSm6S+aKb2vckRzIxF+ipPyMBGHe+o6hVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkeJK9BJsX/SCnE2GQ1B40tC9noS025JefFPIt4mkqs1xFVbK0ihnDftRXqC9XEiM
	 wzncXHuO+BKbqMjmAW79vzP1EwZmzTUikp/nBiik/0NYg2MeqNUntValx0O9bFpkz5
	 2B1KLv1aW2m3PjMJG/aXosD0MwMLSuXiP6UJDJbSw9zsTZHuhGDvcjHtZtq21hJXom
	 oHSnBJZsfdxyvuEMLKY5CKN3UZunu8de4xD0vJVJgnz89nkpYRsiaKEaA67xq3p9uU
	 3cvQjhc1AdKx5R4OU+uOF5U8FwKLhRMnxEBh7B5GBNk72yvktnVRCdQ75YmfyrLmo9
	 EfbXISW+qHxBA==
Date: Thu, 20 Feb 2025 13:41:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/5] fprobe: Always unregister fgraph function from
 ops
Message-Id: <20250220134129.e0e1520b6b99499047b9120b@kernel.org>
In-Reply-To: <20250219220511.227410168@goodmis.org>
References: <20250219220436.498041541@goodmis.org>
	<20250219220511.227410168@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:04:39 -0500
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

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!


> Cc: stable@vger.kernel.org
> Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fprobe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 2560b312ad57..62e8f7d56602 100644
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

