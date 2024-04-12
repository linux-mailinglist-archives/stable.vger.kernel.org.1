Return-Path: <stable+bounces-39313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0898A2FAC
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD44F1C23E28
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A065A83CD6;
	Fri, 12 Apr 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu2xCDhA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F17FBB4
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929099; cv=none; b=AXrYe+qHj6oL1wgNHcHrNjwVKrGLicllTARscWFgMa6uy2HRIvr1rrFxMyVLydSy85xQ/x4KEBuLxSRHQJu+1tkvlBpgGTiOngC0EsMkuIQhaodLEzu2TwkuxWWkFtchY/+pLGCiDOC1lMBigo0f2BTllqgNmOmhxSytwZJON10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929099; c=relaxed/simple;
	bh=2/po26POLFPB6mWm0a1MOS0hf6IkPZ4juYnl99tZN+g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hvzB8c6Ot3kgr+QJEPRMapfcTEizu9Yb+MZEumpTAf+Oaix3SLCQkHmrb5qa16XyUNmzTC5DwmV4hPxiY3wMZu4zqu850bDVbKIkRQzrMmwZ3WivThWkuFcL4DBOQA5VZ0VywibEG4gE06bGWKtt4TenE6jf/4j3hb2gU3azTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu2xCDhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91221C2BD10;
	Fri, 12 Apr 2024 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929099;
	bh=2/po26POLFPB6mWm0a1MOS0hf6IkPZ4juYnl99tZN+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gu2xCDhApD8sXocd1/21N0DkJrgUjPUs4uWPu1kl5tShh1iUvxTdlcCfHxkYdYsOv
	 ZDYemjC1RvVtz2hhREzcSI+q+nihtnHgbOc5UNlq56r+wQJIAicMO8wHObHU4bAOtE
	 txW95XLQRgompQ8oFnHuIgc6qRC86iNood7qrfts3h1d76M/O2OKWZxux+mNUdg42U
	 7U3AtCP4/vrbtkwsfvvsKGiD7McReA9fC9Zu8KKEKQ4+NiroAEMH2l06YkZrv9o4Pf
	 ntebW9nyD0XOSIfXG1GU+X08PQMHgDYvzCaCiadynbP9pH44IO6kPGk2t9Z5aphiTU
	 dNfaLFsQ5KOoA==
Date: Fri, 12 Apr 2024 22:38:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Maxime MERE <maxime.mere@foss.st.com>, Maxime MERE <maxime.mere@st.com>,
 Maxime <mere.maxime@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Francis Laniel <flaniel@linux.microsoft.com>, <stable@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/3] tracing/kprobes: Fix symbol counting logic by
 looking at modules as well
Message-Id: <20240412223814.2182add2c769ef9cbf016935@kernel.org>
In-Reply-To: <20240412222920.c65c9e176c692529166d5aa8@kernel.org>
References: <20240412115422.2693663-1-maxime.mere@foss.st.com>
	<20240412222920.c65c9e176c692529166d5aa8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 22:29:20 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Fri, 12 Apr 2024 13:54:20 +0200
> Maxime MERE <maxime.mere@foss.st.com> wrote:
> 
> > From: Andrii Nakryiko <andrii@kernel.org>
> > 
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> > 
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> > 
> > Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/
> > 
> 
> I forgot to push this to probes/for-next. Thanks for finding.
> Let me pick.

Nevermind, I confused similar different patch[1]. This fix has been merged as
commit 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at
modules as well").

Thank you,

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/169854904604.132316.12500381416261460174.stgit@devnote2/


> 
> Thank you,
> 
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 95c5b0668cb7..e834f149695b 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
> >  	return 0;
> >  }
> >  
> > +struct sym_count_ctx {
> > +	unsigned int count;
> > +	const char *name;
> > +};
> > +
> > +static int count_mod_symbols(void *data, const char *name, unsigned long unused)
> > +{
> > +	struct sym_count_ctx *ctx = data;
> > +
> > +	if (strcmp(name, ctx->name) == 0)
> > +		ctx->count++;
> > +
> > +	return 0;
> > +}
> > +
> >  static unsigned int number_of_same_symbols(char *func_name)
> >  {
> > -	unsigned int count;
> > +	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> > +
> > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> >  
> > -	count = 0;
> > -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> >  
> > -	return count;
> > +	return ctx.count;
> >  }
> >  
> >  static int __trace_kprobe_create(int argc, const char *argv[])
> > -- 
> > 2.25.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

