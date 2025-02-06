Return-Path: <stable+bounces-114106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B6A2AB53
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED011632A0
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C961E5B86;
	Thu,  6 Feb 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5YsVwZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C21E5B75
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852118; cv=none; b=UxpBvW9exrzMzKYOOFeUjHIhLZXRLrf12dH1Z46YzrYl7tIyBexwD8kiKWB7e2psLmPF4rUP1bzx+M4di+5AePcnpv1+vwcX5U+tLE/RACqYm84OFtspcEKaOTUgqbk7av7+P8EsR5EBLidAS5NTb+T2c2Ev4Dl3GIZOTPGI3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852118; c=relaxed/simple;
	bh=ZGMh4NBIlI/VAItS+IF6XAUKNT0gBk2JR1Y97NCSDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBKgA4juuNRZb9Uz1/BKFqAXS00ltTWfX6UhrsFSlKFAfYGNqt/H78OrWmI+NHKBO2jSRpht3fEWzZqiLdnYqAiba/DI5bkpGCguHwCVg8cgTbdFaeYXx9ltu0rdrcCQlIngS+FY/LNlJfHfjbHhGl6i/fA/BHe/Fov18kDe0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5YsVwZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E89C4CEDF;
	Thu,  6 Feb 2025 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852118;
	bh=ZGMh4NBIlI/VAItS+IF6XAUKNT0gBk2JR1Y97NCSDqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5YsVwZTj+hJ4yJC+l0Ga919aTyQ/y4+SiS05Ty4c6aTUI9EliJi0vomUAOzzDdUz
	 dVrAV/7nCYDPvkF7jT6YEsVeVznVEg7fnN59i9I75W6ZH7DP6/wcQYOoq/SpG7mmXj
	 FkyXkDhRBKj1WtRxmBBUmoGhEBKXQZncOQqlv0IM=
Date: Thu, 6 Feb 2025 09:15:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xingrui Yi <yixingrui@linux.alibaba.com>
Cc: tglx@linutronix.de, rostedt@goodmis.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] profile: Fix use after free in profile_tick()
Message-ID: <2025020603-slighting-playful-1623@gregkh>
References: <20250206072406.975315-1-yixingrui@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206072406.975315-1-yixingrui@linux.alibaba.com>

On Thu, Feb 06, 2025 at 03:24:06PM +0800, Xingrui Yi wrote:
> [free]
> profiling_store()
>   --> profile_init()
>     --> free_cpumask_var(prof_cpu_mask)                           <-- freed
> 
> [use]
> tick_sched_timer()
>   --> profile_tick()
>     --> cpumask_available(prof_cpu_mask)                          <-- prof_cpu_mask is not NULL
>                                                                       if cpumask offstack
>       --> cpumask_test_cpu(smp_processor_id(), prof_cpu_mask)     <-- use after free
> 
> When profile_init() failed if prof_buffer is not allocated,
> prof_cpu_mask will be kfreed by free_cpumask_var() but not set
> to NULL when CONFIG_CPUMASK_OFFSTACK=y, thus profile_tick() will
> use prof_cpu_mask after free.
> 
> Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
> ---
>  kernel/profile.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/profile.c b/kernel/profile.c
> index 0db1122855c0..b5e85193cb02 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -137,6 +137,9 @@ int __ref profile_init(void)
>  		return 0;
>  
>  	free_cpumask_var(prof_cpu_mask);
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +	prof_cpu_mask = NULL;
> +#endif
>  	return -ENOMEM;
>  }
>  
> -- 
> 2.43.5
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

