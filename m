Return-Path: <stable+bounces-205109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68ACF90E0
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFBD4300877B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608D341AD6;
	Tue,  6 Jan 2026 15:21:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975441684B4;
	Tue,  6 Jan 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712864; cv=none; b=gTrabMaASJMRW5L8O6s9pI0d7PPp2pXgu7keQqm90lO2lYAtHb4RbGV3V0GM7bRGYxPUgqZW6XqpgLlA8J0A+qe5xvufhfZ7Zlov86ZWZKD+JPRQJU9t0Fd1hNlN+y+K3EaPjzXAFRJOO68XaaRTiplT3mRKFzEnNMulVcIv++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712864; c=relaxed/simple;
	bh=KS1C9bAwlDhZvSLMwp9flwtHD0RxO1IUENqc9t4uHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L300JkI56f+J1YzSvX/JX1jYUDMgLu1rXeBO/+HzXm+ZOKWF29NQEKx+xOC2mAq0Nfix0DvymBEml+XmDyYpuaH07LF1OPpK/yWB9fFJM4cd+zHt0bbBaLz0fsXenHMi6TAKd8duQU+gEiQV0U/U6LUEmru0M1YsS8E8m9iFO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 384438ABED;
	Tue,  6 Jan 2026 15:20:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id ECE9C2000D;
	Tue,  6 Jan 2026 15:20:55 +0000 (UTC)
Date: Tue, 6 Jan 2026 10:21:20 -0500
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
Message-ID: <20260106102120.4272260e@gandalf.local.home>
In-Reply-To: <04624b16-40ea-42c6-b687-4013796e4779@suse.cz>
References: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
	<20260105164036.32a22c2e@gandalf.local.home>
	<04624b16-40ea-42c6-b687-4013796e4779@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kadyobb6jxgg53rrgr8pk5kiu7pjqpd4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: ECE9C2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Cnps0ORM9wOahzNOtx0DT319eAQmpInc=
X-HE-Tag: 1767712855-198917
X-HE-Meta: U2FsdGVkX18qn3xbopg0HXbkKioqQiII+KS+SESHqD4DmcTs87FqtTwlrJHklBpNtixlk38wVYTWl58BF19c+TgMm92szMg+VQcnCFJNRD4AHB5RYUf1fMNVhQROcMki6PZDC0Yr/gdYibD8NrC5wWG37/dIiBSLdagQmEYQCqe4JL5jxVSUPjcFfM05fbU3ts99MchYGe3AcRK+OZCbq7ODj7gIEfL2XaQLW0BDxwqvZlqdVSGAODffh/iEG18lJF8gLB7q7qfRDRhLXeXY2dl8zEBMD79afbk00Tj1xF5+SjEf+Sp0KISnnd++GCQG

On Tue, 6 Jan 2026 09:28:29 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> >> + */
> >> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
> >> +static inline void __flags_noop(unsigned long *flags) { }
> >> +#define spin_lock_maybe_irqsave(lock, flags)		\
> >> +({							\
> >> +	 __flags_noop(&(flags));			\
> >> +	 spin_lock(lock);				\
> >> +})
> >> +#define spin_unlock_maybe_irqrestore(lock, flags)	\
> >> +({							\
> >> +	 spin_unlock(lock);				\
> >> +	 __flags_noop(&(flags));			\
> >> +})
> >> +#else
> >> +#define spin_lock_maybe_irqsave(lock, flags)		spin_lock_irqsave(lock, flags)
> >> +#define spin_unlock_maybe_irqrestore(lock, flags)	spin_unlock_irqrestore(lock, flags)
> >> +#endif
> >> +  
> > 
> > These are very generic looking names for something specific for
> > page_alloc.c. Could you add a prefix of some kind to make it easy to see
> > that these are specific to the mm code?
> > 
> >  mm_spin_lock_maybe_irqsave() ?  
> OK, I think it's best like this:

Yeah, thanks.

-- Steve

> 
> ----8<----
> >From a6da5d9e3db005a2f44f3196814d7253dce21d3e Mon Sep 17 00:00:00 2001  
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 6 Jan 2026 09:23:37 +0100
> Subject: [PATCH] mm/page_alloc: prevent pcp corruption with SMP=n - fix
> 
> Add pcp_ prefix to the spin_lock_irqsave wrappers, per Steven.
> With that make them also take pcp pointer and reference the lock
> field themselves, to be like the existing pcp trylock wrappers.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_alloc.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ec3551d56cde..dd72ff39da8c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -177,19 +177,21 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
>   */
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
>  static inline void __flags_noop(unsigned long *flags) { }
> -#define spin_lock_maybe_irqsave(lock, flags)		\
> +#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
>  ({							\
>  	 __flags_noop(&(flags));			\
> -	 spin_lock(lock);				\
> +	 spin_lock(&(ptr)->lock);			\
>  })

