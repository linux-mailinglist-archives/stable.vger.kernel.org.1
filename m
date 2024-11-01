Return-Path: <stable+bounces-89543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19C9B9B28
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618CF1F21C46
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEEB1E2846;
	Fri,  1 Nov 2024 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGS27g0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F81D0F50;
	Fri,  1 Nov 2024 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730503724; cv=none; b=AsMLgqQyMH95AL874SSd0uyLhjrELi9zP8+1/fW368BKizCD1NgSzsMwK8LsktVEMpxxAvaGTAWysTCOVk4wd6mqU2dcfmO++mPmynpcapaxtd+a7IEmUZslr+ba+0AP5piSGLUwEZ+niao9NrHADjNWbkXcbZ0oyMjgGiOR8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730503724; c=relaxed/simple;
	bh=gtktdfx6scf2s9VlwUaTJU0dGd8MEhLXdkWGM07pt+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2CC06uQf7Ie0bJ7w9mB4CaedYq1X8e7dJJ/47yB6jJTq/Wu/2Z96HzWsmVPoZh9wc7adD7HcUJdTn9cOsqHEKbEeZnUTKaDQKAZ6eQ5dnPIUYVCj1G44nb0eAm41sTT4LEQCfoHfLjuavOKhs/l3KSnLbVjB4X97aE5jycjjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGS27g0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA032C4CECD;
	Fri,  1 Nov 2024 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730503723;
	bh=gtktdfx6scf2s9VlwUaTJU0dGd8MEhLXdkWGM07pt+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGS27g0TEaafhCtjyZVneGkeVpoyoUu0BSwJMo7l+PWMaNxcZjrUlYQCskqOXi0xO
	 k6W/SkiZ3Og0Q4f1JX4aM5rAwhdJw9XTRp45MXJF6E/M0cZSw3cbIZ+J3pwLZg1Hhx
	 LbaIZf0x14UDv7v+Gj7+o+En3lXy1P2bZFLO2MC78xnMiHCVOJZwTdh8OZy6GxMJnP
	 cPSh+wyOWBLj6W62ftN4V1Tvj3ptWti/wj+Wv4Lqf+ZERjH8YJI6x/zXw9rFqFqtL0
	 A7KUhycBBHxqm84oRuvVltGOYCMFz9aaAufIWSwaDhopa7cGPUsiMAxz0Q7D7Bcr8l
	 vMcxU85PDkrww==
Date: Sat, 2 Nov 2024 00:28:38 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZyVkJn2kOJzjPRyJ@example.org>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031200438.2951287-1-roman.gushchin@linux.dev>

On Thu, Oct 31, 2024 at 08:04:38PM +0000, Roman Gushchin wrote:
> Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
> ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
> of signals. However now it's enforced unconditionally, even if
> override_rlimit is set. This behavior change caused production issues.
> 
> For example, if the limit is reached and a process receives a SIGSEGV
> signal, sigqueue_alloc fails to allocate the necessary resources for the
> signal delivery, preventing the signal from being delivered with
> siginfo. This prevents the process from correctly identifying the fault
> address and handling the error. From the user-space perspective,
> applications are unaware that the limit has been reached and that the
> siginfo is effectively 'corrupted'. This can lead to unpredictable
> behavior and crashes, as we observed with java applications.
> 
> Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
> skip the comparison to max there if override_rlimit is set. This
> effectively restores the old behavior.
> 
> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Co-developed-by: Andrei Vagin <avagin@google.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Gladkov <legion@kernel.org>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/user_namespace.h | 3 ++-
>  kernel/signal.c                | 3 ++-
>  kernel/ucount.c                | 5 +++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 3625096d5f85..7183e5aca282 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -141,7 +141,8 @@ static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type ty
>  
>  long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
>  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> +			    bool override_rlimit);
>  void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
>  bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 4344860ffcac..cbabb2d05e0a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -419,7 +419,8 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
>  	 */
>  	rcu_read_lock();
>  	ucounts = task_ucounts(t);
> -	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
> +	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING,
> +					    override_rlimit);
>  	rcu_read_unlock();
>  	if (!sigpending)
>  		return NULL;
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 16c0ea1cb432..046b3d57ebb4 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -307,7 +307,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
>  }
>  
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> +			    bool override_rlimit)
>  {
>  	/* Caller must hold a reference to ucounts */
>  	struct ucounts *iter;
> @@ -316,7 +317,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  
>  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>  		long new = atomic_long_add_return(1, &iter->rlimit[type]);
> -		if (new < 0 || new > max)
> +		if (new < 0 || (!override_rlimit && (new > max)))
>  			goto unwind;
>  		if (iter == ucounts)
>  			ret = new;

It's a bad patch. If we do as you suggest, it will
do_dec_rlimit_put_ucounts() in case of overflow. This means you'll
break the counter and there will be an extra decrement in __sigqueue_free().
We can't just ignore the overflow here.

-- 
Rgrds, legion


