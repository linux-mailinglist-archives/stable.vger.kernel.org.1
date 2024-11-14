Return-Path: <stable+bounces-92995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6019C8889
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 12:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E81A281736
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358351DB52A;
	Thu, 14 Nov 2024 11:13:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E0376E0
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582793; cv=none; b=V1jifgG4ir47X+Wk4I3JfO0h66DHg+ZTK3jprJeRa1Yinc56awdp9lsOj8B9aga/fu2fQQMxVRuBv7dzz7uBiblqV6Q35iV67mEfjRXoHOqaGTcizqA4PbDItbqFJUmgIpStmz00Uy8t61oXA+2I0N8L3FVUtpQY1ArGXICQmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582793; c=relaxed/simple;
	bh=+pJyM4myEdcEmUAWQdaVGE69hM9JdGfjrGd2jPw4V0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxSqjD+E/HeaVfmDDQnI8DIz48BD2UOQcvz0l7l9TETzatxJzBsrp9oBDzdvY1sKeeH7mOqCdG9L2ztVtn2IHHUo5YyB6YtOgGTjmpeskR92iTNfemDcdFV4z+0CwneHt1ksFwUEMi0J1ex7kHpyq9xapTtl31BGg+ubOtHYl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DCB91480;
	Thu, 14 Nov 2024 03:13:40 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B6A3F6A8;
	Thu, 14 Nov 2024 03:13:09 -0800 (PST)
Date: Thu, 14 Nov 2024 11:12:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: tls: Fix context-switching of tpidrro_el0 when
 kpti is enabled
Message-ID: <ZzXbMXd5K5RmITJX@J2N7QTR9R3>
References: <20241114095332.23391-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114095332.23391-1-will@kernel.org>

On Thu, Nov 14, 2024 at 09:53:32AM +0000, Will Deacon wrote:
> Commit 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of
> tpidrro_el0 for native tasks") tried to optimise the context switching
> of tpidrro_el0 by eliding the clearing of the register when switching
> to a native task with kpti enabled, on the erroneous assumption that
> the kpti trampoline entry code would already have taken care of the
> write.
> 
> Although the kpti trampoline does zero the register on entry from a
> native task, the check in tls_thread_switch() is on the *next* task and
> so we can end up leaving a stale, non-zero value in the register if the
> previous task was 32-bit.
> 
> Drop the broken optimisation and zero tpidrro_el0 unconditionally when
> switching to a native 64-bit task.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks")
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> You fix one side-channel and introduce another... :(
> 
>  arch/arm64/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 3e7c8c8195c3..2bbcbb11d844 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -442,7 +442,7 @@ static void tls_thread_switch(struct task_struct *next)
>  
>  	if (is_compat_thread(task_thread_info(next)))
>  		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
> -	else if (!arm64_kernel_unmapped_at_el0())
> +	else
>  		write_sysreg(0, tpidrro_el0);
>  
>  	write_sysreg(*task_user_tls(next), tpidr_el0);
> -- 
> 2.47.0.277.g8800431eea-goog
> 

