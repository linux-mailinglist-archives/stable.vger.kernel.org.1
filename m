Return-Path: <stable+bounces-89760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D39BC04A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 22:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FF9B216B9
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09951925B0;
	Mon,  4 Nov 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrGuTvCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9218EB1;
	Mon,  4 Nov 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756884; cv=none; b=casjG3ec2mzcme8RwYOXm7T76/JmOcxNnYRBfnwZ6Sqtg5qvtFbJ3SyH1Yd3nnkkvMR741+h5ddpOvBiyrSw09iUqmq6xl6iQ5G2vEAMadxMTlsReE7hnEE8edrzbJGb7nmh1bKs9sIb8HERdD/cC4sb26+pzLjkNuATnJb2XKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756884; c=relaxed/simple;
	bh=z0z+VhjQxXwDo/BAhp8d3UQo5IF5+NwMLHi6UsNUgSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQurbh37gaWjHCL5Lk7Ee2B+i4a2t2Ce91lGhMST3mNsaqX5M3xTbn60L3v2UeIXADsMZobda2SkbjbYxs3VCdS07WS7SgNRFEjPz/eRNKMYEdlwgkjHndUaovAlqLTrdWGSmwYjjclVPYZoK3CvIMGE7lkfJscTB0ZWt+51qOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrGuTvCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68635C4CED1;
	Mon,  4 Nov 2024 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730756883;
	bh=z0z+VhjQxXwDo/BAhp8d3UQo5IF5+NwMLHi6UsNUgSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrGuTvCTYJuIo1Jo7ImUNBx+XSuw3Zhr35UL3sC2CG6HK/VzEM8eBLkJfKO3JEWmN
	 CJis85i9X7/cPd3y24nLsPPMtIOKevF+ilfLw3+7AyW9LhCt/TBAMfzKUQ9MqeT5Mu
	 ZP0vplu6Q5/7JoCz94rGfSfa++XCtVANIjM0PCL0ShIyP86aVfdDs2tiv/n1JSv8yr
	 hVR8Gl5WwCcl5msN568wXE2jmRtvqcp1P3EOzDsfGjmVmbe/NDx7MEPwk0fpAO35qF
	 20000jsaqG1EtnV7EL6m8SnQwkLtSffLfKeD/yz6Kc06GTGF0TXH6xX79XyzNlXL48
	 yAffCyEKFy1nw==
Date: Mon, 4 Nov 2024 22:47:56 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] signal: restore the override_rlimit logic
Message-ID: <ZylBDEjygL7meU4r@example.org>
References: <20241104195419.3962584-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104195419.3962584-1-roman.gushchin@linux.dev>

On Mon, Nov 04, 2024 at 07:54:19PM +0000, Roman Gushchin wrote:
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
> v2: refactor to make the logic simpler (Eric, Oleg, Alexey)
> 
> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Co-developed-by: Andrei Vagin <avagin@google.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Gladkov <legion@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  include/linux/user_namespace.h | 3 ++-
>  kernel/signal.c                | 3 ++-
>  kernel/ucount.c                | 6 ++++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
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
> index 16c0ea1cb432..49fcec41e5b4 100644
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
> @@ -320,7 +321,8 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  			goto unwind;
>  		if (iter == ucounts)
>  			ret = new;
> -		max = get_userns_rlimit_max(iter->ns, type);
> +		if (!override_rlimit)
> +			max = get_userns_rlimit_max(iter->ns, type);
>  		/*
>  		 * Grab an extra ucount reference for the caller when
>  		 * the rlimit count was previously 0.
> -- 
> 2.47.0.199.ga7371fff76-goog
> 

-- 
Rgrds, legion


