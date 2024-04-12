Return-Path: <stable+bounces-39311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7EC8A2F64
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF588282D22
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030D824A7;
	Fri, 12 Apr 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY18LgI6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B76824A3
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928565; cv=none; b=MWJ54zS6uTWemwpTsHzdNmVD+kDNII/5CWTKxszuX1eokEiM7g41Lfcrp/ZljXdjYYBcFDlqCBYPdLvX0WNL248dhXw+CMM6qswhvqhTF8tOzyJySQY8vdUBJtekUMQHpwNu8smRlB7QAsQ3MqmZdH8WNNjmtM4nUZRVtTxl5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928565; c=relaxed/simple;
	bh=hRyoN1LZ8uUNr/s3ClJX2HJYgp0UozjbXCjLota3Vtw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FSDPkRQcF+g+OG3ET30zCtjWKxtKgbFk2AVx06Ke3csISTn1miNKGsz+S1lMe5JsyYjsc9/hrwvir7Tq9ayJGliUj1m1IRpaV2MAN2+u4VqhuimkDQu4/ADq/9VW0iwTaUlErUCFuguNEywo9AYxzsHJepoPxohWH1K7rfcN3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY18LgI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548AAC113CC;
	Fri, 12 Apr 2024 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928564;
	bh=hRyoN1LZ8uUNr/s3ClJX2HJYgp0UozjbXCjLota3Vtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nY18LgI6tPFTI7l4Gom6jkctFyrRNNHn2rP+1Gn5WfMBoLLxtrmMX/RgCEhBIho6Z
	 SQNZEIM1x8LbE8+32XMRZ3vi7WBeP3OWLdz1ehP11grkbZGmQh9a01nXueNCgVjqfl
	 eyRgvYbC9+hfNLbIwU78f8NE/E9CG7vd+4hFc7jkGYzquJLswvmMVLpW9QD9Lohky/
	 s54vZDb5pQ1uOCqXA9ftu5tydVG2lSIJn+T7oPuicMqXkxEAKA/xKCxRXvvwxZLV79
	 WEOEuyzk+V0QOA8RLc6KvYyVGT0EWOgonEW/0Q++MvnOd36c132SNPzGTxCZyEbaJV
	 ySZZEQkkp8CFQ==
Date: Fri, 12 Apr 2024 22:29:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Maxime MERE <maxime.mere@foss.st.com>
Cc: Maxime MERE <maxime.mere@st.com>, Maxime <mere.maxime@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Francis Laniel <flaniel@linux.microsoft.com>,
 <stable@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/3] tracing/kprobes: Fix symbol counting logic by
 looking at modules as well
Message-Id: <20240412222920.c65c9e176c692529166d5aa8@kernel.org>
In-Reply-To: <20240412115422.2693663-1-maxime.mere@foss.st.com>
References: <20240412115422.2693663-1-maxime.mere@foss.st.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 12 Apr 2024 13:54:20 +0200
Maxime MERE <maxime.mere@foss.st.com> wrote:

> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.
> 
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
> 
> Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/
> 

I forgot to push this to probes/for-next. Thanks for finding.
Let me pick.

Thank you,

> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 95c5b0668cb7..e834f149695b 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
>  	return 0;
>  }
>  
> +struct sym_count_ctx {
> +	unsigned int count;
> +	const char *name;
> +};
> +
> +static int count_mod_symbols(void *data, const char *name, unsigned long unused)
> +{
> +	struct sym_count_ctx *ctx = data;
> +
> +	if (strcmp(name, ctx->name) == 0)
> +		ctx->count++;
> +
> +	return 0;
> +}
> +
>  static unsigned int number_of_same_symbols(char *func_name)
>  {
> -	unsigned int count;
> +	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> +
> +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> -	count = 0;
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
>  
> -	return count;
> +	return ctx.count;
>  }
>  
>  static int __trace_kprobe_create(int argc, const char *argv[])
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

