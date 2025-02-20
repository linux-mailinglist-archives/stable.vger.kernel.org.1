Return-Path: <stable+bounces-118372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B3A3D084
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 05:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD6160C5A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 04:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D31E0E16;
	Thu, 20 Feb 2025 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOnZUKAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45F3FD1;
	Thu, 20 Feb 2025 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026578; cv=none; b=OQJ4whBY9J2U8j9EV8WeB8Lo3lOdwKi8CmXdKpsH1lohdrCAt5+nxc5tIVewAjqB+At87sADcqe0W8oNSKmENc45OzIG9LTtyk/n0JfkFtFySg28QD/CPt548cESmcyHBDCGf8fB3/1aWTAAeIgu/SjJyHDA3fqWA1/cuWnIAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026578; c=relaxed/simple;
	bh=3athwsnaPokOQlzvDMLGksr4cwXubq3IMFHwaP+zaaA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uT+gHsjFvyPAkLNj0wfshSymsIi06e59VJUiLTHZav8+LIx7eDIeF7vS0vJNURKd7DWC9xZHwGTCtgkYvDNcQwA/wOrvbDrsTuD0MxsBno4qqSWQiKVVZWnU0yyzHe6yf9PTeKympWpiR9+UEnGC0XM6Z59oTfKrllUyRwJ/wK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOnZUKAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F66C4CED1;
	Thu, 20 Feb 2025 04:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740026577;
	bh=3athwsnaPokOQlzvDMLGksr4cwXubq3IMFHwaP+zaaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kOnZUKAp3747EExuK9rJJRU7RC1Rtj6ZTXJDVjSOGu3Ko7XnaN7IWILvxfoAeVqyk
	 qnInbIVFfxKdABUDJNLr2wXy1CDzkgOiGpfDsyTWEAyvwyS5LFVpvFfHEfAnyUx1Vu
	 FW7rTdGhrp28EOJRa0Oi0E7MA8DKbKUof8y+3kyhxhB3Gkeuo11jk7yrGiMMxKY/Vv
	 snTpwhGmgxlCI8vdKAnJvcHRYKLc+pMB0BY9s5pdfjOYZRkCUzRS9098LEjmohfQEZ
	 CduehJYc9n0SZa/pNB8Q7ByCXc+09EazYMVDn14dlNpE/2Ase+/AMnEShY+0sYWmia
	 uADC4C5TPE3KA==
Date: Thu, 20 Feb 2025 13:42:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] fprobe: Fix accounting of when to unregister
 from function graph
Message-Id: <20250220134254.9b4edb4353e137bf1bbc5713@kernel.org>
In-Reply-To: <20250219220511.392563510@goodmis.org>
References: <20250219220436.498041541@goodmis.org>
	<20250219220511.392563510@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:04:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When adding a new fprobe, it will update the function hash to the
> functions the fprobe is attached to and register with function graph to
> have it call the registered functions. The fprobe_graph_active variable
> keeps track of the number of fprobes that are using function graph.
> 
> If two fprobes attach to the same function, it increments the
> fprobe_graph_active for each of them. But when they are removed, the first
> fprobe to be removed will see that the function it is attached to is also
> used by another fprobe and it will not remove that function from
> function_graph. The logic will skip decrementing the fprobe_graph_active
> variable.
> 
> This causes the fprobe_graph_active variable to not go to zero when all
> fprobes are removed, and in doing so it does not unregister from
> function graph. As the fgraph ops hash will now be empty, and an empty
> filter hash means all functions are enabled, this triggers function graph
> to add a callback to the fprobe infrastructure for every function!
> 
>  # echo "f:myevent1 kernel_clone" >> /sys/kernel/tracing/dynamic_events
>  # echo "f:myevent2 kernel_clone%return" >> /sys/kernel/tracing/dynamic_events
>  # cat /sys/kernel/tracing/enabled_functions
> kernel_clone (1)           	tramp: 0xffffffffc0024000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
> 
>  # > /sys/kernel/tracing/dynamic_events
>  # cat /sys/kernel/tracing/enabled_functions
> trace_initcall_start_cb (1)             tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> run_init_process (1)            tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> try_to_run_init_process (1)             tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> x86_pmu_show_pmu_cap (1)                tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> cleanup_rapl_pmus (1)                   tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> uncore_free_pcibus_map (1)              tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> uncore_types_exit (1)                   tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> uncore_pci_exit.part.0 (1)              tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> kvm_shutdown (1)                tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> vmx_dump_msrs (1)               tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
> [..]
> 
>  # cat /sys/kernel/tracing/enabled_functions | wc -l
> 54702
> 
> If a fprobe is being removed and all its functions are also traced by
> other fprobes, still decrement the fprobe_graph_active counter.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And please push this series via your branch because the selftest
updates should cover the series.

Thanks!

> Cc: stable@vger.kernel.org
> Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
> Closes: https://lore.kernel.org/all/20250217114918.10397-A-hca@linux.ibm.com/
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250218193126.619197190@goodmis.org
> 
> - Move the check into fprobe_graph_remove_ips() to keep it matching
>   with fprobe_graph_add_ips() (Masami Hiramatsu)
> 
>  kernel/trace/fprobe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 62e8f7d56602..33082c4e8154 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -407,7 +407,8 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
>  	if (!fprobe_graph_active)
>  		unregister_ftrace_graph(&fprobe_graph_ops);
>  
> -	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
> +	if (num)
> +		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
>  }
>  
>  static int symbols_cmp(const void *a, const void *b)
> @@ -677,8 +678,7 @@ int unregister_fprobe(struct fprobe *fp)
>  	}
>  	del_fprobe_hash(fp);
>  
> -	if (count)
> -		fprobe_graph_remove_ips(addrs, count);
> +	fprobe_graph_remove_ips(addrs, count);
>  
>  	kfree_rcu(hlist_array, rcu);
>  	fp->hlist_array = NULL;
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

