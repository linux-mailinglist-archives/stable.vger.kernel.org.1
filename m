Return-Path: <stable+bounces-272268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jxe8G/vGS2pgaAEAu9opvQ
	(envelope-from <stable+bounces-272268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:17:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3471276C
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272268-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272268-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 055F03024940
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3702F8E84;
	Mon,  6 Jul 2026 14:57:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3E2701DC;
	Mon,  6 Jul 2026 14:57:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349846; cv=none; b=jTXi4CIPY8m5sTlMwLvSqpLfhWQFnkzcpSCwF8UN/bB7KcgFuf1iGrXqIK6gBQ9any5lsjfEWBBcCPOhYgcp1UaNpSjTsuVuDbRmNNpdfqMH14sLuZJF9MLXrCMHlaPwyCLMBybe46Peh7VuUvobPDRwnO4f25KWPpGMT8Dq6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349846; c=relaxed/simple;
	bh=LAA4qWVnCC/SpR6bRRHW87rLHdrNT+nhJRGAscM+NiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urrkreTWy276Zzb6QOZGhFB8n08EcGvhnWx3586W/4Z0oltYABXQqgBJHzez0lGmAS4Et9g+o/9yBUYU4395/6u+nkNQShlK3Xh6EZ9dxl6Yn6oosXPiKdMwpbjzCVyZecitzl/qUIw4RPqJp0bvv4ocWCpbBYvxPHZRbQODNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 88F92160FBA;
	Mon,  6 Jul 2026 14:57:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id EF6E417;
	Mon,  6 Jul 2026 14:57:14 +0000 (UTC)
Date: Mon, 6 Jul 2026 10:57:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/stacktrace: Mark arch_stack_walk() and unwinder
 functions notrace
Message-ID: <20260706105715.769ba488@gandalf.local.home>
In-Reply-To: <20260706095445.1683434-1-xiangzao@linux.alibaba.com>
References: <20260706095445.1683434-1-xiangzao@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iitf39djh3mortxwxkq86eue6b3bpy57
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rqGyHfpsRGsVI+iAO+GsZU/8T+xxEMog=
X-HE-Tag: 1783349834-194698
X-HE-Meta: U2FsdGVkX197Tep2RR2qfA4PEZs0l1tULf6JEJzzHABGv3FNxddOIVtPOtoE//LPdUhpuYpqlNq05jowOd9RE3orplMiiyPW0oJq6pvn1mLh5bEgKywBCNeVl81IqsYklCos7InQyy7k0lt84Gqv0qhWf1pQ8IfAsYfGnQlZeYmi+be0ZNcgOHUnawLuCXWZuBZA5v6g7lDHVTol5g7VS7tcgsrHR2fIGYsLnmMGf8DCiN0kO9MawfkgdES8tn1L0OjM3Wr+DNFFXoLAbl+/Z5ZGca78Hf6I6pttmZEBYBpY0nET3ST3/3wl3/EBbqRJzAGXpY37F3JXa1mT9B1zf7ZKeE7bNZJfOLVHmH6+AQLS4R3BTmngZGj0iXDy/cBYyOEXMMXw+yJwxUxIx8poXQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272268-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xiangzao@linux.alibaba.com,m:jpoimboe@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alibaba.com:email,goodmis.org:from_mime,goodmis.org:email,gandalf.local.home:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EA3471276C

On Mon,  6 Jul 2026 17:54:45 +0800
Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:

> When the function tracer's func_stack_trace option and the function graph
> profiler (function_profile_enabled) are both active, a recursive ftrace
> reentrance can occur, leading to a hard lockup. This was observed during
> ftrace selftest (ftracetest-ktap) execution:
> 
>   watchdog: Watchdog detected hard LOCKUP on cpu 204
>   RIP: profile_graph_entry+0xa0/0x160
>   Call Trace:
>    function_graph_enter+0xc9/0x120
>    arch_ftrace_ops_list_func+0x112/0x230
>    ftrace_call+0x5/0x44
>    unwind_next_frame+0x5/0x870     <-- traced by ftrace
>    arch_stack_walk+0x88/0xf0
>    stack_trace_save+0x4b/0x70
>    __ftrace_trace_stack+0x12e/0x170
>    function_stack_trace_call+0x7c/0xa0
>    arch_ftrace_ops_list_func+0x112/0x230
>    ftrace_call+0x5/0x44
>    irqtime_account_irq+0x5/0xb0
>    __irq_exit_rcu+0x12/0xc0
>    ...
> 
> The root cause is a recursive ftrace reentrance:
> function_stack_trace_call() invokes __trace_stack() ->
> arch_stack_walk() -> unwind_next_frame() to capture a backtrace.
> Since the unwinder functions (__unwind_start(),
> unwind_next_frame(), unwind_get_return_address(),
> unwind_get_return_address_ptr()) are not marked notrace, the
> function graph tracer instruments them, re-entering the ftrace
> infrastructure from within an ftrace callback. This results in a
> hard lockup with interrupts disabled, detected by the watchdog NMI.

I'm fine with this change, but I'm wondering why the recursion protection
didn't catch this. There may be a missing check somewhere. I'll ack this
change, but I also want to add the check that would have prevented this
lockup.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


