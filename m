Return-Path: <stable+bounces-204946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD1CF5B17
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13E49300D577
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB23101D2;
	Mon,  5 Jan 2026 21:40:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAC2D63F6;
	Mon,  5 Jan 2026 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649221; cv=none; b=kigABlKscCWjKmHMbdezVAZ67IQoJAw2CwLIxhly9ivGTDlWJQakBQvdF6cwgggfk/gSe2cDGlLEzgCqb03opshxhobCO2LAXKofaPW4BtTK20lXxMjGdvo+ZcSILc8aWzr+0Lzes+l6UQ/4GD1YNOAz7kX1VRFGf4gMrCrGh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649221; c=relaxed/simple;
	bh=OEnaVrS9NCvNISNrMcGe9dvl6dlXMtmhgGoftwocHxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvZmF8Uc02rovEebUOkAENQJH7bkHkYggs4FhbREnkk/BswHP6GWCbWdVebFcJDrG2gCNhl/9fBVhtyjeb7Bt9cq2tVYClWv2gEmFdgeFN01G8fyID1ovNdbGvZ2s26F59rZrVtm2qdcacx34E8HimpLsLzC9HVueXazCjr9opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 2DBF31AE85;
	Mon,  5 Jan 2026 21:40:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id E27946000B;
	Mon,  5 Jan 2026 21:40:13 +0000 (UTC)
Date: Mon, 5 Jan 2026 16:40:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, kernel test robot
 <oliver.sang@intel.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH mm-hotfixes] mm/page_alloc: prevent pcp corruption with
 SMP=n
Message-ID: <20260105164036.32a22c2e@gandalf.local.home>
In-Reply-To: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
References: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E27946000B
X-Stat-Signature: q3rc73ahsu5xyypthgfwoq69wzw3c14m
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uqG90fClQgYqM+gD7rF9u4JBB5PDylXs=
X-HE-Tag: 1767649213-413291
X-HE-Meta: U2FsdGVkX18D8vhglud99GU7CXmQ3Vimslye/1+TjZjBXISc1kIieVs/XQKSr4g6+QlVr7/o2HccNhzJQETTMl/B3o7ZZ56IUoHf+eDzwZQpMU3U7Kxey0/E/eyNuopzOc9dYfGhezalTsrvwlIiLoSX4GAONhfUChSXPxSdcw1SQnIxlwxuhU2ylSOQB12csT3H+njuA4KavBrP7AnFflX+0Wzx3ckM6TQLMNk/Hg8irAcqYims6mxoijVg+8zN6RVMSh0T96rx17VrqsQCPD8gXu9HHDiVQaVi4wdFyYT8UtwbpxS2cd+aIawIEQ8o

On Mon, 05 Jan 2026 16:08:56 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> +++ b/mm/page_alloc.c
> @@ -167,6 +167,31 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
>  	pcp_trylock_finish(UP_flags);					\
>  })
>  
> +/*
> + * With the UP spinlock implementation, when we spin_lock(&pcp->lock) (for i.e.
> + * a potentially remote cpu drain) and get interrupted by an operation that
> + * attempts pcp_spin_trylock(), we can't rely on the trylock failure due to UP
> + * spinlock assumptions making the trylock a no-op. So we have to turn that
> + * spin_lock() to a spin_lock_irqsave(). This works because on UP there are no
> + * remote cpu's so we can only be locking the only existing local one.
> + */
> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
> +static inline void __flags_noop(unsigned long *flags) { }
> +#define spin_lock_maybe_irqsave(lock, flags)		\
> +({							\
> +	 __flags_noop(&(flags));			\
> +	 spin_lock(lock);				\
> +})
> +#define spin_unlock_maybe_irqrestore(lock, flags)	\
> +({							\
> +	 spin_unlock(lock);				\
> +	 __flags_noop(&(flags));			\
> +})
> +#else
> +#define spin_lock_maybe_irqsave(lock, flags)		spin_lock_irqsave(lock, flags)
> +#define spin_unlock_maybe_irqrestore(lock, flags)	spin_unlock_irqrestore(lock, flags)
> +#endif
> +

These are very generic looking names for something specific for
page_alloc.c. Could you add a prefix of some kind to make it easy to see
that these are specific to the mm code?

 mm_spin_lock_maybe_irqsave() ?

Thanks,

-- Steve

