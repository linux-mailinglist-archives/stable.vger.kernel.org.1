Return-Path: <stable+bounces-105250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CED9F719D
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 02:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086D5188C80D
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DAB3594B;
	Thu, 19 Dec 2024 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx6NQoqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1A64A8F;
	Thu, 19 Dec 2024 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571062; cv=none; b=Jdf6ID2ZXNfMz0LMsLM0mIOcvoDV+76WoOR/YbsBcwezSJ0sCNbIeRuwjmFZ3/4124vH6g54lhyu4xz9I9eYeLSUo/oIHO+KlR8gxtvNCfToeD2Ipxvx3KcLEMf2r6GZqAOOhxQRbKG1thzKfi15Ao1alg6zwoZR0uCDzhGkfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571062; c=relaxed/simple;
	bh=0NE9oPCfItxPii9OcgTm9DuGBcfrld1PP3bgzRwFNTs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=twz6wYCVXTVjlkcYnCIGlZyAXXEy0qe+GWufpaUI28/3pyrtS9W+mH+TYPZy0Fn3TpARFEOyTB2kt38DzRQ9K/BD6p/JNJn+RmGIj5sKxgYA6Ns+j1pCMVJx3lpQ+xRji4Q+nQRrq1oNAbmay6yUXwFk643juGSIIbFhbfQJo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx6NQoqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7D5C4CECD;
	Thu, 19 Dec 2024 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734571061;
	bh=0NE9oPCfItxPii9OcgTm9DuGBcfrld1PP3bgzRwFNTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hx6NQoqN39o0iwQ31ryvkwgwkCMmVJD//lwJX6EYzxIP/gBeRI95y1WNCnMQ3yweJ
	 MRgdq1tz8N11vtjdAjyQMb/xaaLyZxC8sE0tYPgnEiHOri7McYg/smky2pU8KLI/tW
	 Emu2ZhMnUSw5xaIWCf86yVspDJKCAqwcnIspRhmp2FOAkKEUYQQtI0eW5WtmQ2+lil
	 QqVwpV1EBeYle6Yq6YU9c9rxmuVHfbPpjrhl2JVAI4eFAKggsw5RL8e0uJIvgie5l0
	 zk9wNRp09OvNWH8lebRldb7BZQX0Z0GPGPIGYWwC6+YherancHp8R6u9piUdqnW5xz
	 5poiOvQMsN1og==
Date: Thu, 19 Dec 2024 10:17:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Francis Laniel <flaniel@linux.microsoft.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing/kprobes: Skip symbol counting logic for
 module symbols in create_local_trace_kprobe()
Message-Id: <20241219101737.83e3be23bd85c1f9810194c0@kernel.org>
In-Reply-To: <20241216161145.2584246-1-kniv@yandex-team.ru>
References: <20241216161145.2584246-1-kniv@yandex-team.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 19:11:45 +0300
Nikolay Kuratov <kniv@yandex-team.ru> wrote:

> commit b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> avoids checking number_of_same_symbols() for module symbol in
> __trace_kprobe_create(), but create_local_trace_kprobe() should avoid this
> check too. Doing this check leads to ENOENT for module_name:symbol_name
> constructions passed over perf_event_open.
> 
> No bug in mainline and 6.12 as those contain more general fix
> commit 9d8616034f16 ("tracing/kprobes: Add symbol counting check when module loads")

Thanks! It seems Greg already queued v2 for stable kernels, and
it seems no theoletical change in this version.

Thank you,

> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240705161030.b3ddb33a8167013b9b1da202@kernel.org
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
> v1 -> v2:
>  * Reword commit title and message
>  * Send for stable instead of mainline
> v2 -> v3:
>  * Specify first good LTS version in commit message
>  * Remove explicit versions from the subject since 6.1 and 5.10 need fix too
> 
>  kernel/trace/trace_kprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 12d997bb3e78..94cb09d44115 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1814,7 +1814,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	int ret;
>  	char *event;
>  
> -	if (func) {
> +	if (func && !strchr(func, ':')) {
>  		unsigned int count;
>  
>  		count = number_of_same_symbols(func);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

