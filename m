Return-Path: <stable+bounces-118381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF575A3D199
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCAA3BBD08
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E281E4110;
	Thu, 20 Feb 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKZouwLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8F1DEFF7;
	Thu, 20 Feb 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034788; cv=none; b=Yaw0R9qbG/8h7jLV8c7tfdqOdKWotJF3V/X4/3BRxJ9/nLvl/YOb3nQH3H377T04+SiUiGmFmaovzZ+PUh1sxTepYSdgcSLcO2WKQRmTV3ynR8NoHtch0h+z62rxxK+IJcFlx3BEZmhI6V9fdb4UekJU4AwKAVA6degQKlag1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034788; c=relaxed/simple;
	bh=H/yMB8RtQkvn72FexcC+tGE6YCZ9EmaqgGYEZeoF8eg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IYJPULXoffW4cY611YbeUSxlZ8UAI44ZWcfE0vD+incRX41h9Fhzr99dm+8PDVXzKu6KUYT/1FjeOw/xVVLlvAl6T8zUn921UOz2GdRslXLIbwB1tWSbH7J3jhA8uhPoQaqRr3j3mlCK6AbCvKwgYdOZWxwcrrXqEKE4d0kKoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKZouwLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B2AC4CED1;
	Thu, 20 Feb 2025 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740034787;
	bh=H/yMB8RtQkvn72FexcC+tGE6YCZ9EmaqgGYEZeoF8eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YKZouwLolbtiGDjWlDK9GDbyGZfTAcUxh9VwCfUDnSXmQ565GHrqrndpZOrucjH1Z
	 jUpoLx/4YMc0EIuabtmSj3pMqLnLplIWF/+lM2Yuu1t+19J1AYxAS1w7rM+Z8ilhoc
	 Vo2pHSFWFNYmbTbCdQvNrsLDsQpGTqno1BFQuamPa0wtH/wdP5khXWvoF2wR20g4Sy
	 mHR2BzF6jR2m44YKUbJI8NDOvSjalPfkfDLHXO2DIgRWwgJSV4WhBowoQtkAjeMGqR
	 sVS3LQYwUrOrfOqvOWecaH1Bj3OTRU2+h0fh8GjfX64IPMhEuGv7JVSdFXfLL2wbLg
	 hV1f1Nhik//nA==
Date: Thu, 20 Feb 2025 15:59:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ftrace: Do not add duplicate entries in subops
 manager ops
Message-Id: <20250220155944.821ccc0cd98594b924c2752e@kernel.org>
In-Reply-To: <20250219220511.054985490@goodmis.org>
References: <20250219220436.498041541@goodmis.org>
	<20250219220511.054985490@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:04:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Check if a function is already in the manager ops of a subops. A manager
> ops contains multiple subops, and if two or more subops are tracing the
> same function, the manager ops only needs a single entry in its hash.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4f554e955614f ("ftrace: Add ftrace_set_filter_ips function")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  kernel/trace/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 03b35a05808c..189eb0a12f4b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5717,6 +5717,9 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
>  			return -ENOENT;
>  		free_hash_entry(hash, entry);
>  		return 0;
> +	} else if (__ftrace_lookup_ip(hash, ip) != NULL) {
> +		/* Already exists */
> +		return 0;
>  	}
>  
>  	entry = add_hash_entry(hash, ip);
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

