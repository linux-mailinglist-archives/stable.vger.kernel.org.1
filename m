Return-Path: <stable+bounces-163061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A3B06C8F
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 06:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57A117E9F9
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0027587D;
	Wed, 16 Jul 2025 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFTS/5dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E722628C;
	Wed, 16 Jul 2025 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752639418; cv=none; b=IzzHELrtRKTOgU2rqGrPfx6upTPZKbW0USyRoHey3V7yKp0sCMUt2Oc1N43AdpZhScJEqgsO0m3h/5CxB5r3RLpmooRTD3Eoi2UKo+lv0lFXZrViDO2jN63sIsF1X/s2YFF5JYI/sfJ9XpkM6UuJApOVtY6wScqxSKLnb1DivoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752639418; c=relaxed/simple;
	bh=5mUglmWt+DtfiWzS7JbWNY3rOgVqbEQ28VtYDouYkBs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ka6EnczAz+sBOpHzAWJpdhhZTI4n2BMNxne0qlCXptdNN80ZKwZ9InxxNNJNel+FXz7zjbFe6neZmiMSJyeaQ667xhfcaU9fWlnMsgS61KQSG0xdfi05eBhm0GHxM2oIkO3jGkViNQyU4RXgXNEImnmdLqbREMi615SkN0bYC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFTS/5dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D09C4CEF0;
	Wed, 16 Jul 2025 04:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752639417;
	bh=5mUglmWt+DtfiWzS7JbWNY3rOgVqbEQ28VtYDouYkBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFTS/5dvr7V2c3NMRqT+e+4xcsNVwPIiT1ektGIZa5EaHUtpA0Wimmp1AEuTnpHLz
	 usJgTTUcM/R7HLgC6g++WuFmWeOqW9BL+OYAtTdJMpEbrbB+vlyf1pacQaWLnwkzRV
	 oR3dIxTtu4dh7S6x9XgYS0uBuI4Ww3V0DrfBSkXJlE0gzOB9HiEJED4YLFyBSf6LN/
	 LQzqzgzlWnH+LId1juHSIM58l126KiLtw1uKOIXmZ+n4fQ4rKvdXtHrSAiVyGaRRvm
	 qvp4mFoPZFhEVl51BWry8WOlAKB8AmfzFJ7QvkX2E9jQnuU248RIyTmfujmyAThFhV
	 rzfqGsl8SoYPA==
Date: Wed, 16 Jul 2025 13:16:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Avoid using params uninitialized in
 parse_btf_arg()
Message-Id: <20250716131654.93b969d6eab59b0cd292a3f3@kernel.org>
In-Reply-To: <20250715-trace_probe-fix-const-uninit-warning-v1-1-98960f91dd04@kernel.org>
References: <20250715-trace_probe-fix-const-uninit-warning-v1-1-98960f91dd04@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 20:19:44 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> After a recent change in clang to strengthen uninitialized warnings [1],
> it points out that in one of the error paths in parse_btf_arg(), params
> is used uninitialized:
> 
>   kernel/trace/trace_probe.c:660:19: warning: variable 'params' is uninitialized when used here [-Wuninitialized]
>     660 |                         return PTR_ERR(params);
>         |                                        ^~~~~~
> 
> Match many other NO_BTF_ENTRY error cases and return -ENOENT, clearing
> up the warning.

Good catch! let me pick this up.

Thank you,


> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2110
> Fixes: d157d7694460 ("tracing/probes: Support BTF field access from $retval")
> Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 424751cdf31f..40830a3ecd96 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -657,7 +657,7 @@ static int parse_btf_arg(char *varname,
>  		ret = query_btf_context(ctx);
>  		if (ret < 0 || ctx->nr_params == 0) {
>  			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
> -			return PTR_ERR(params);
> +			return -ENOENT;
>  		}
>  	}
>  	params = ctx->params;
> 
> ---
> base-commit: 6921d1e07cb5eddec830801087b419194fde0803
> change-id: 20250715-trace_probe-fix-const-uninit-warning-7dc3accce903
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

