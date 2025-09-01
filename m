Return-Path: <stable+bounces-176818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D05FB3DEDB
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E10F3BBC30
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79030C35D;
	Mon,  1 Sep 2025 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTXxQ0o3"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC72E11D2;
	Mon,  1 Sep 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719637; cv=none; b=dk5J9RzEhnYR9Ibax6y8isuLDRYSzFBD+/gbZ3gGVnbvwGurKiYlup7tvrbY2AbA+KqKBQbE5WzyFIYmQrWAQqeKigVoW4J/sjRvNuT4D83Uaa5chhA+Vgmq9EshFNC7B+94RAyFPu4ggF3EWMkfbCz8c4haSTDV2k0jK9rqXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719637; c=relaxed/simple;
	bh=pu3t3HYGdb/3qe4rsC99h/rS48sKgLSi6n82WhD0Lpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT/adhwdohU06ytxPahK/DcUItdnPwGnlgX6fjuSKW82J3u2Ve8xpI2FOiL9ETO/4MeaMTyjEveDot7lynqA/kypL8LOAkKmFS1aa+sEen297UhRij3wAch+Nh18RzWdNDRqkW9XXiD6nURrb8dXFVxC8HCuQmYSfXsUMzPTQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JTXxQ0o3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GbQGpwo86rox1IbkeX8SIdLYLI+/9jeAqCH7E/j4364=; b=JTXxQ0o3CLHzqXeSg/2WDOkLGm
	YCM8iFfHAridw1myzdVtzpKiBroJzzk56j50KbXWPa91Hci3zHMeMiQaJEc2zI27FPkpxGGLQ8S11
	QXkivOgtnBRBfBs8FYGxgHHgyk/oGJtTkA0hS/2LPeD/53ELsmov0oCAd+NzKIc4MIZ6FAR/zH72j
	NR1hZQ6jvXuodaEwB782XCTvId+RACmmfFRwslbxQpqeKDD3PGitNenbgbLKGRUSEQHHoOD1oLs6r
	9QIKiMJIgJCjwdFKykKdnL7koXQoioISjGuI/+7HPbz6S/zOJc0c96NL4sD6RYMJUrC762n5IaCVm
	Fln47s+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut11c-000000067T2-0WDD;
	Mon, 01 Sep 2025 09:40:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 561D6300342; Mon, 01 Sep 2025 11:40:32 +0200 (CEST)
Date: Mon, 1 Sep 2025 11:40:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Eero Tamminen <oak@helsinkinet.fi>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250901094032.GL4068168@noisy.programming.kicks-ass.net>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
 <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>
 <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
 <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org>
 <20250827115447.GR3289052@noisy.programming.kicks-ass.net>
 <10b5aaae-5947-53a9-88bb-802daafd83d4@linux-m68k.org>
 <20250901093600.GF4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901093600.GF4067720@noisy.programming.kicks-ass.net>

On Mon, Sep 01, 2025 at 11:36:00AM +0200, Peter Zijlstra wrote:

> Something like the completely untested below should do I suppose.
> 
> ---
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 711a1f0d1a73..e39cdfe5a59e 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -67,6 +67,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
>  {
>  	kasan_check_read(v, size);
>  	kcsan_check_atomic_read(v, size);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
>  }
>  
>  /**
> @@ -81,6 +82,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_atomic_write(v, size);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
>  }
>  
>  /**
> @@ -95,6 +97,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_atomic_read_write(v, size);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
>  }
>  
>  /**

Arguably, that should've been something like:

	((unsigned long)v & (size-1))

I suppose.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index dc0e0c6ed075..1c7e30cdfe04 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1363,6 +1363,16 @@ config DEBUG_PREEMPT
>  	  depending on workload as it triggers debugging routines for each
>  	  this_cpu operation. It should only be used for debugging purposes.
>  
> +config DEBUG_ATOMIC
> +	bool "Debug atomic variables"
> +	depends on DEBUG_KERNEL
> +	help
> +	  If you say Y here then the kernel will add a runtime alignment check
> +	  to atomic accesses. Useful for architectures that do not have trap on
> +	  mis-aligned access.
> +
> +	  This option has potentially significant overhead.
> +
>  menu "Lock Debugging (spinlocks, mutexes, etc...)"
>  
>  config LOCK_DEBUGGING_SUPPORT

