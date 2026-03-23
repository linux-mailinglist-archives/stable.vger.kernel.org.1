Return-Path: <stable+bounces-227963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKOPNdoswWmbRAQAu9opvQ
	(envelope-from <stable+bounces-227963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:06:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 735752F1A5C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF63A300CA08
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83483396B66;
	Mon, 23 Mar 2026 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAGvZ4oK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577937F721;
	Mon, 23 Mar 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267608; cv=none; b=VuUgE5+gOk5aQlqdESCQhZYbLJEITqe2g0hZo1fb7jwJNuagcs+AQTGcvxqqHyHm541xsyeHoDs4i6X0Yhi5BxiUPUDwit5vSs3MiLE9jfjG68oVbi9t1awy2Ke11na6gMkD+SEjeEtv9YTh8xJpGERpjYxjfUWeeiElWykjTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267608; c=relaxed/simple;
	bh=G9WmYiLeswQv6Ve1LoG1uvOvj989vX1oUK2ETCU2J9o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tpGJj2kZTGGR78D2zKaVH8tvsBiYOMIXskg7G32MeOKIJxnD2S+S3JO4W2Lud1Hsd+rDC8Hdz5AKl7GoDfhHRJj2SzdIu8nb42mGJpsmeINsntBBRQdPtP7jZncJXKz1jFwP7Iu3iEp+09Dld493UIoO+W3tC8G1G1wR+Ee1W7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAGvZ4oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A87C2BCB6;
	Mon, 23 Mar 2026 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267607;
	bh=G9WmYiLeswQv6Ve1LoG1uvOvj989vX1oUK2ETCU2J9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAGvZ4oKAXzn89bVfmJwx36J+WLBB9JqLS26s5DZ3196PgmbMyv0qN8iyM0GgRXVD
	 AvuBq40yjlJH5KHLVncQtPIl87b4fG8A5Jzx9/gPZlwvd9EbFCkvE8xExW70b7h136
	 QOZKqXpmfeZ+u98/8ougbVxTh++6xKcTz9mfASbth5NBeCDntYRYVPTqXv2qeRtQ1D
	 f6oa8yDVW8Sc0l0lFmETFJqCxGesqYKi+72T58hHA7jGJJ8dfzAE608KtKTMKA6y8K
	 xy7eKpTBD9TpjVA0CzieNU6dF1ivluUXeAZPHyh9HodET+i+14/gRkt4eVyFLHWU4j
	 Gbp1My3/gkliw==
Date: Mon, 23 Mar 2026 21:06:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Message-Id: <20260323210643.2b43b307f0348623d680b098@kernel.org>
In-Reply-To: <20260323102020.239567-1-martin@kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227963-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kaiser.cx:email]
X-Rspamd-Queue-Id: 735752F1A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 11:19:36 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

> If fprobe_entry does not fill the allocated fgraph_data completely, the
> unused part is zeroed with memset.
> 
> Fix the length for this memset call. Both reserved_words and used are in
> units of return stack words, but memset needs the number of bytes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Good catch!

Thanks,

> ---
>  kernel/trace/fprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a..6a1192515afd 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		}
>  	}
>  	if (used < reserved_words)
> -		memset(fgraph_data + used, 0, reserved_words - used);
> +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
>  
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

