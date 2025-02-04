Return-Path: <stable+bounces-112201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA4A27875
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168593A39F8
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D782144AD;
	Tue,  4 Feb 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwXWorxu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4061865EE;
	Tue,  4 Feb 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690373; cv=none; b=jgQiiYZGyOIEaxR+67YhQl+Yko7jZFyJo7ofQw3XoVQpXiV1JYkr3rh1VtqpS3QKsU5bO9G1O0An302vMIem8E3P7NzsqLqSjsuzkoboSb6fCNBexTv4qntCSjXXk2tLiokT2VDkN0KwuAE8De7gFpVNE0RMElkJ3pr/CSAfktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690373; c=relaxed/simple;
	bh=0InDr5qCQp7QF5wBujLAZDOEanXIpHwX51yLZ4kI8iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqzeHc1TBgAfLrYPyt4ha9KpvujvxlB4zRD4Irkq5CDo0OMPmRH+XbHVIrBwaJVpUMOd348Rkfs9BaL4SaDLfx/93jiGgLjKK08oV7BUqpGkH13P8UFnNu4WfqSR5eKfShAJPXzejaqklv9rnNkrFdtQ97vj/VPFZmj1ejCGFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwXWorxu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738690372; x=1770226372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0InDr5qCQp7QF5wBujLAZDOEanXIpHwX51yLZ4kI8iM=;
  b=GwXWorxubY4EiVHezFHVBwQ0vsyv0mVuga5wC5yR17O9wiNrDJQljW1Z
   ln8O6z1NXIlPu9oHEL/KDQ1MfEWpIiFnLo4ryvklQgUUhu5rP5ddboQJv
   ebjE5aSoF3+BJvu97jqLr3Nq1rVWHwhjsWOYM5uhznCr7n055IU8EzmRk
   gaan0U6fZWgUxEWDOe5se/EehvwhzTcfz76u7VDsNNkJCeJD/+NGTPuqT
   N7EnxGq4/pRZr9e7WGSMLk9z3gsbyz6V2+hMPQQvtdbKap8AXHPoEV6jP
   jSaQ7WfX8wsGnKIOLYURqLmo4o09mPW8WdmV1muhG+HD465Lje9S4Njp2
   Q==;
X-CSE-ConnectionGUID: kwF2KzKTRhuJcoFY7ZHqJQ==
X-CSE-MsgGUID: 7UbTvYb1RfeyrNr1iPPfRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61702764"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="61702764"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:32:51 -0800
X-CSE-ConnectionGUID: KNd2x+GBQlqK05twHgHYCg==
X-CSE-MsgGUID: p+snzYmWTa6lPhIO739k4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110833675"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.55]) ([10.125.110.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:32:50 -0800
Message-ID: <054b7cab-4507-48f8-9c0a-d400779f226f@intel.com>
Date: Tue, 4 Feb 2025 09:32:52 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
To: Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com,
 ackerleytng@google.com, jxgao@google.com, sagis@google.com,
 oupton@google.com, pgonda@google.com, kirill@shutemov.name,
 dave.hansen@linux.intel.com, linux-coco@lists.linux.dev,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20250129232525.3519586-1-vannapurve@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250129232525.3519586-1-vannapurve@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I think this is the right fix for _now_. In practice, Vishal's problem
only occurs on CONFIG_PARAVIRT_XXL systems. His proposed fix here does
not make TDX depend on CONFIG_PARAVIRT_XXL, it just provides an extra
override when TDX and CONFIG_PARAVIRT_XXL collide.

This seems like a reasonable compromise that avoids entangling
PARAVIRT_XXL and TDX _too_ much and also avoids reinventing a hunk of
PARAVIRT_XXL just to fix this bug.

Long-term, I think it would be nice to move pv_ops.irq.safe_halt() away
from being a paravirt thing and move it over to a plain static_call().

Then, TDX can get rid of this hunk:

                pr_info("using TDX aware idle routine\n");
                static_call_update(x86_idle, tdx_safe_halt);

and move back to default_idle() which could look like this:

 void __cpuidle default_idle(void)
 {
-        raw_safe_halt();
+	 static_call(x86_safe_halt)();
         raw_local_irq_disable();
 }

If 'x86_safe_halt' was the only route in the kernel to call 'sti;hlt'
then we can know with pretty high confidence if TDX or Xen code sets
their own 'x86_safe_halt' that they won't run into more bugs like this one.

On to the patch itself...

On 1/29/25 15:25, Vishal Annapurve wrote:
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via tdvmcall. This process renders HLT instruction
> execution inatomic, so any preceding instructions like STI/MOV SS will
> end up enabling interrupts before the HLT instruction is routed to the
> hypervisor. This creates scenarios where interrupts could land during
> HLT instruction emulation without aborting halt operation leading to
> idefinite halt wait times.

Vishal! I'm noticing spelling issues right up front and center here,
just like in v1. I think I asked nicely last time if you could start
spell checking your changelogs before posting v2. Any chance you could
actually put some spell checking in place before v3?

So, the x86 STI-shadow mechanism has left a trail of tears. We don't
want to explain the whole sordid tale here, but I don't feel like
talking about the "what" (atomic vs. inatomic execution) without
explaining "why" is really sufficient to explain the problem at hand.

Sean had a pretty concise description in here that I liked:

	https://lore.kernel.org/all/Z5l6L3Hen9_Y3SGC@google.com/

But the net result is that it is currently unsafe for TDX guests to use
the "sti;hlt" sequence. It's really important to say *that* somewhere.

> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests") already
> upgraded x86_idle() to invoke tdvmcall to avoid such scenarios, but
> it didn't cover pv_native_safe_halt() which can be invoked using
> raw_safe_halt() from call sites like acpi_safe_halt().

Does this convey the same thing?

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from using "sti;hlt". But it missed the
paravirt routine. That can be reached like this, for example:

	acpi_safe_halt() =>
	raw_safe_halt()  =>
	arch_safe_halt() =>
	irq.safe_halt()  =>
	pv_native_safe_halt()

I also dislike the "upgrade" nomenclature. It's not really an "upgrade".

...
> @@ -380,13 +381,18 @@ static int handle_halt(struct ve_info *ve)
>  {
>  	const bool irq_disabled = irqs_disabled();
>  
> +	if (!irq_disabled) {
> +		WARN_ONCE(1, "HLT instruction emulation unsafe with irqs enabled\n");
> +		return -EIO;
> +	}

The warning is fine, but I do think it should be separated from the bug fix.

>  
> -void __cpuidle tdx_safe_halt(void)
> +void __cpuidle tdx_idle(void)
>  {
>  	const bool irq_disabled = false;
>  
> @@ -397,6 +403,12 @@ void __cpuidle tdx_safe_halt(void)
>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
>  }
>  
> +static void __cpuidle tdx_safe_halt(void)
> +{
> +	tdx_idle();
> +	raw_local_irq_enable();
> +}

The naming here is a bit wonky. Think of how the call chain will look:

	irq.safe_halt() =>
	tdx_safe_halt() =>
	tdx_idle()	=>
	__halt()

See how it's doing a more and more TDX-specific halt operation? Isn't
the "idle" call right in the middle confusing?

>  static int read_msr(struct pt_regs *regs, struct ve_info *ve)
>  {
>  	struct tdx_module_args args = {
> @@ -1083,6 +1095,15 @@ void __init tdx_early_init(void)
>  	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
>  	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
>  
> +#ifdef CONFIG_PARAVIRT_XXL
> +	/*
> +	 * halt instruction execution is not atomic for TDX VMs as it generates
> +	 * #VEs, so otherwise "safe" halt invocations which cause interrupts to
> +	 * get enabled right after halt instruction don't work for TDX VMs.
> +	 */
> +	pv_ops.irq.safe_halt = tdx_safe_halt;
> +#endif

Just like the changelog, it's hard to write a good comment without going
into the horrors of the STI-shadow. But I think this is a bit more to
the point:

	/*
	 * Avoid the literal hlt instruction in TDX guests. hlt will
	 * induce a #VE in the STI-shadow which will enable interrupts
	 * in a place where they are not wanted.
	 */



