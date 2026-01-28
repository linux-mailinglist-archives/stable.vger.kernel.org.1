Return-Path: <stable+bounces-212685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJUoNNSNemls7wEAu9opvQ
	(envelope-from <stable+bounces-212685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:29:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35955A98FE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 600FD3025D3C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96464344046;
	Wed, 28 Jan 2026 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJyx5ETe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55447284689;
	Wed, 28 Jan 2026 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639372; cv=none; b=srvNUv60M6nUe9lSb6MyKLqgavjDy+48VAbvhrpHI4Ej5cInlCbaQjBLQJyXtkZ/K57cMdXtrxRpWy9iguyRfajIwk1bVeHEekDZusQvUcbe8Tqj/0Dyan1yHpKUNtOKwPYodrU6On2iaVv+vWyt4jmlDOKyN8d9uDYr7KGM2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639372; c=relaxed/simple;
	bh=a0Ddc1sM8tlaUXYOPYAnFNHQc1jvPGEdsW9X+42V578=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EUAVWmgOBKM8sFxkPNYahzWSgutv0PZn/FFwRciPfNQGI4etKwtSMW+gphcQe3BA1o/c69TYQsF+IFLhdIHQuhUM+sA6zuAK1izmGfhN6GfbV7AQCts4n5Zzfi53s5PnAgXFwbbEekY+JDuwvs7IFotEDpQTwLjzJmoqSeDmW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJyx5ETe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE12CC4CEF1;
	Wed, 28 Jan 2026 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769639372;
	bh=a0Ddc1sM8tlaUXYOPYAnFNHQc1jvPGEdsW9X+42V578=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJyx5ETeeFXIxljN9Qea1B15cBU8SVVXXIgRbVrSN8RYjlmz3AsJtHksRpsq2/l/9
	 wXETTKIpwrHDCDTMLmcAHuNPj2ai/z0XUZFCurH8/aMUwhPj+jeK1nd/iteefYsNnP
	 NKKxn3lw7S06muMLmmBnMTzWEI5We/FZXnhDKpz8D+UyQlWYinllyxSGH6wb1hTS0D
	 S7LOiZL++0aRDRJ/4EXK4GXEfzHw5IfW2urOGVxWoI5kAOFcWWYh2XcKDyxcpGE39Z
	 fZOyZwQlXEhalzhJA+5k+7dJZdk9WhK8Pl9ini9Vu3vahXYAvRK1jC0gsG/Qo1AF3N
	 oUVSIpSiYDGHA==
Date: Thu, 29 Jan 2026 07:29:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Andrii
 Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: fix incorrect lockdep condition in
 filter_chain()
Message-Id: <20260129072928.da41ab0a2e71da86dd4cd4b8@kernel.org>
In-Reply-To: <20260128-uprobe_rcu-v2-1-994ea6d32730@debian.org>
References: <20260128-uprobe_rcu-v2-1-994ea6d32730@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 35955A98FE
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 10:16:11 -0800
Breno Leitao <leitao@debian.org> wrote:

> The list_for_each_entry_rcu() in filter_chain() uses
> rcu_read_lock_trace_held() as the lockdep condition, but the function
> holds consumer_rwsem, not the RCU trace lock.
> 
> This gives me the following output when running with some locking debug
> option enabled:
> 
>   kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section!!
>     filter_chain
>     register_for_each_vma
>     uprobe_unregister_nosync
>     __probe_event_disable
> 
> Remove the incorrect lockdep condition since the rwsem provides
> sufficient protection for the list traversal.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - updated the "fixes" tag (Oleg)
> - Link to v1: https://patch.msgid.link/20260128-uprobe_rcu-v1-1-d41316763799@debian.org
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index d546d32390a81..726d13b375f3d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1138,7 +1138,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
>  	bool ret = false;
>  
>  	down_read(&uprobe->consumer_rwsem);
> -	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
> +	list_for_each_entry(uc, &uprobe->consumers, cons_node) {
>  		ret = consumer_filter(uc, mm);
>  		if (ret)
>  			break;
> 
> ---
> base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
> change-id: 20260128-uprobe_rcu-e21867ab4c1b
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

