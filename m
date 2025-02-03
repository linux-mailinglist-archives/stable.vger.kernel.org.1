Return-Path: <stable+bounces-112033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E838EA25E0F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0073AA678
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16EA208969;
	Mon,  3 Feb 2025 15:05:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC12080F2;
	Mon,  3 Feb 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595130; cv=none; b=FJxHqZG7vFNjatzCLyQfGwqYfAv5yFRa6CMAjuQ5ATW/qkt5ZvPpBWaLW1BJjHiuZm7LaZj/BmaFD8H1fcDsJZgsUd2f1wm7jHzK02r3M5xhDvaLLQMWVdJPtHuQzp+iyh+bArb0x+m6BgRZgKkjX8wpuQ0sXg518nAv+Uz/4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595130; c=relaxed/simple;
	bh=PJ6AuVOLEIGjuqdYnsyCxOl+tSLFzCB5bAbySdg5Abc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2c2roFoWG7SbVOjr3HOfr7hzmv2iMC1rfuy2GpZuYExacpM52VTz7VqBuKgbSD3l99OrCihxMXSD01OTSYWIbrZufEt0arQZfsyeKqmRYrWIykBdtPPi+jWnUaMg9d5PGlkQUemOROXnLvbSWBHTVEAlQQUqxOlKRYr+Q0wJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A32BC4CED2;
	Mon,  3 Feb 2025 15:05:29 +0000 (UTC)
Date: Mon, 3 Feb 2025 10:06:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Wen
 Yang <wenyang@linux.alibaba.com>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in
 function_stat_show()
Message-ID: <20250203100603.5c00df0f@gandalf.local.home>
In-Reply-To: <20250131155346.1313580-1-kniv@yandex-team.ru>
References: <20250131155346.1313580-1-kniv@yandex-team.ru>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 18:53:46 +0300
Nikolay Kuratov <kniv@yandex-team.ru> wrote:

> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -570,12 +570,12 @@ static int function_stat_show(struct seq_file *m, void *v)
>  		stddev = rec->counter * rec->time_squared -
>  			 rec->time * rec->time;
>  
> +		stddev = div64_ul(stddev, rec->counter * (rec->counter - 1));
>  		/*
>  		 * Divide only 1000 for ns^2 -> us^2 conversion.
>  		 * trace_print_graph_duration will divide 1000 again.
>  		 */
> -		stddev = div64_ul(stddev,
> -				  rec->counter * (rec->counter - 1) * 1000);
> +		stddev = div64_ul(stddev, 1000);
>  	}
>  

Why make it more complex than it needs to be? We can simply have:

	if (rec->counter <= 1) {
		stddev = 0;
	} else {
		unsigned long counter = rec->counter * (rec->counter - 1) * 1000;

		stddev = rec->counter * rec->time_squared -
			 rec->time * rec->time;

		/* Check for overflow */
		stddev = counter > rec->counter ? div64_ul(stddev, counter) : 0;
	}

And be done with it.

I'll make the change and give you a "Reported-by".

Thanks,

-- Steve


