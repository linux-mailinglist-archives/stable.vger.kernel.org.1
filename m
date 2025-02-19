Return-Path: <stable+bounces-116940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DDA3AE47
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E479188A7BE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222871A8419;
	Wed, 19 Feb 2025 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKsPac5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F19D8A7;
	Wed, 19 Feb 2025 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926416; cv=none; b=NNFIqFHzLHVr0Wv92MsofwwBQntn+Q2LhbPyqNYLxKjda4QRnNJAtCyuUARDlmBm+53Q/fvCAmZcAZ4ky2hDzBr98wfCCUIJzHxf93YBGGTkIFuSS2m2MW7vxjHHkm2l5nlHep9TyDznJsOIxSJDUlqCggVrG/7ll0uprHvAcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926416; c=relaxed/simple;
	bh=l8wDuRqJ/CejzfL8HrHYbXhxxF4iBq5obOtIyGJ7yDI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pMHlOfj46TWpgeMm5BCbwdx9SF0dtHLf/NpWfymx1mt74TSnNesfAlpBkoeabPyLfoR7jOWIg5zQq/KImbOuWWRzugZWmEfdW/hlqBzWYAqe4xa86hNDxylaCCsiisUWNdKVv3x694Q94xSgOa5lkXcwIZqCT3UDAKe/AsQS5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKsPac5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4FCC4CEE2;
	Wed, 19 Feb 2025 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739926416;
	bh=l8wDuRqJ/CejzfL8HrHYbXhxxF4iBq5obOtIyGJ7yDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FKsPac5qFYVOu/eypD1DMagX/ta6fHybw+efTDnTqM1WWXUsZwRzuN4RNTI3H9I+O
	 zagN4+q654nuN65pE0Uvwiek1r9Z2vXIkMT8Cf4w1i/3cu2VpfUL/toI7RcgFhb05T
	 +p7z0TwTDAsls14C15wJ2lxLQS4gxHEGqkUQxTIF49FQc4jCwPU1MXpRe2wX0vmDqb
	 4THOOVs0gUSFc5p6HrwBmjMOkbShm1C2gxop6nMieL8cFY6nN+bBDVVkmSGnS8deJR
	 1A9D3P4yAMUPCnfT6T5KVH03v+hzR0GueaPIvlkCmfOrs3vwDbkauF0OSDoN1B0aft
	 Jd41HG7LyQ5dw==
Date: Wed, 19 Feb 2025 09:53:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/5] fprobe: Fix accounting of when to unregister from
 function graph
Message-Id: <20250219095332.f9667fe4f414ec9945093b73@kernel.org>
In-Reply-To: <20250218193126.619197190@goodmis.org>
References: <20250218193033.338823920@goodmis.org>
	<20250218193126.619197190@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 14:30:36 -0500
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


Ah, thanks! But I would like to change the fix a bit since
fprobe_graph_remove_ips() must be paired with fprobe_graph_add_ips()
to hide fprobe_graph_active counting.

Can you use this version?

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 2560b312ad57..7d282c08549e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -409,7 +409,8 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 		return;
 	}
 
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
+	if (num)
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
 static int symbols_cmp(const void *a, const void *b)
@@ -679,8 +680,7 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	if (count)
-		fprobe_graph_remove_ips(addrs, count);
+	fprobe_graph_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;


> Cc: stable@vger.kernel.org
> Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
> Closes: https://lore.kernel.org/all/20250217114918.10397-A-hca@linux.ibm.com/
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 2560b312ad57..90241091ca61 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -681,6 +681,8 @@ int unregister_fprobe(struct fprobe *fp)
>  
>  	if (count)
>  		fprobe_graph_remove_ips(addrs, count);
> +	else
> +		fprobe_graph_active--;
>  
>  	kfree_rcu(hlist_array, rcu);
>  	fp->hlist_array = NULL;
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

