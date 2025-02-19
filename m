Return-Path: <stable+bounces-118290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B047A3C268
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C457A579F
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D4716F858;
	Wed, 19 Feb 2025 14:45:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993C450F2;
	Wed, 19 Feb 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976327; cv=none; b=KFGj4Q0b+2nbeJMJvt82GAfZcSIkYGOrymfZKNa3k9f0+feia9vtRq+DRHDa7M69m6i87nx5q0WsoNYEYXHypUrmLnY5+yapUcVifuymSlzDwB0vCuOfNnOo5GSc2fMIa1UfbCBgH16o2GR3kxTvIJZ/VzRdB4iIv9xAGP58ATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976327; c=relaxed/simple;
	bh=s0LycvToQG/6zkbDwJzQGNvC70N+j8gBHmFOolfYVhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiWXw9qBJN6nV60LrL7WFfEmcf4Pyp1tlWrnNIS/m2naXQaYLHzcx5QxPLGb+ovxeUy16D+PAQu7/kVNSBO/jldC6XQ9GnXdZWkMmp5prQ248HPWQZ+8quFq21kyn6XwEsaIb0ZfCxDSlm09bigyZ8g4ng1pOSxPMu9NvpzBTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746B8C4CED1;
	Wed, 19 Feb 2025 14:45:26 +0000 (UTC)
Date: Wed, 19 Feb 2025 09:45:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/5] fprobe: Fix accounting of when to unregister from
 function graph
Message-ID: <20250219094549.4d0899cc@gandalf.local.home>
In-Reply-To: <20250219095332.f9667fe4f414ec9945093b73@kernel.org>
References: <20250218193033.338823920@goodmis.org>
	<20250218193126.619197190@goodmis.org>
	<20250219095332.f9667fe4f414ec9945093b73@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 09:53:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Can you use this version?
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 2560b312ad57..7d282c08549e 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -409,7 +409,8 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
>  		return;
>  	}
>  
> -	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
> +	if (num)
> +		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
>  }
>  
>  static int symbols_cmp(const void *a, const void *b)
> @@ -679,8 +680,7 @@ int unregister_fprobe(struct fprobe *fp)
>  	}
>  	del_fprobe_hash(fp);
>  
> -	if (count)
> -		fprobe_graph_remove_ips(addrs, count);
> +	fprobe_graph_remove_ips(addrs, count);
>  
>  	kfree_rcu(hlist_array, rcu);
>  	fp->hlist_array = NULL;

Yes, that looks better. I'll add that to v2.

-- Steve

