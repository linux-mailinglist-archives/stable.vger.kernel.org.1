Return-Path: <stable+bounces-172390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E270AB31A18
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D941BC2729
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E83093BF;
	Fri, 22 Aug 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lFe2w2FZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7D3090CB;
	Fri, 22 Aug 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870072; cv=none; b=u/sLre31H39nt2ZpcgqJPoJUeyNyXTRixMpdAjMu7kPswDiXsMci/wnaGKWCbwB669mMrr+pP5+7jt1rTgXcSbDJyadSYLDAIvZIOTKtfPLAeNNPW1WJH2MQGAqlXaIWV4iDPMKdmeSEDy/z5Ja2l0UK3LH1hZdnzUmgw2VFGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870072; c=relaxed/simple;
	bh=D4vbN4SKyBF0Je6K3pwlXP5s7WA5gfWdo0pV7fYsdw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opW60Lt9Yb9lvRMy2lGP4ChEkZr9Yp0aOjYG9qhVEypsSx5+IYZre4jBxVJ6piOqr712bHkmFP8bfA6FZHyz3CWVHCIqfTnI1jJz/2aM0h/YgKtIl0jk0TYU9GUZrNNpkw7yEKqlsPy+y6lce8769TI1LCBuickShYuo1c7j7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lFe2w2FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66474C4CEED;
	Fri, 22 Aug 2025 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870071;
	bh=D4vbN4SKyBF0Je6K3pwlXP5s7WA5gfWdo0pV7fYsdw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFe2w2FZygApm5V7AL3SJlGFkkej19yZiH6/vMflKSsPybtBaMYuBtFKXHIZCjkv5
	 rZbnsZmc7mCRXNTQXiVS5e9xMQ13XkCmjpjEBxA86dkoWVrGjHy4W4tKx1I+ayFuFT
	 eTfi3KQFDPuYYR4SfbjalLjetOxRFWAN/sr/a97M=
Date: Fri, 22 Aug 2025 15:41:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, prarit@redhat.com,
	x86@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.15 RESEND 2/2] x86/irq: Plug vector setup race
Message-ID: <2025082252-uncaring-shock-ac5a@gregkh>
References: <20250822033608.1096607-1-ruanjinjie@huawei.com>
 <20250822033608.1096607-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822033608.1096607-3-ruanjinjie@huawei.com>

On Fri, Aug 22, 2025 at 03:36:08AM +0000, Jinjie Ruan wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> commit ce0b5eedcb753697d43f61dd2e27d68eb5d3150f upstream.
> 
> Hogan reported a vector setup race, which overwrites the interrupt
> descriptor in the per CPU vector array resulting in a disfunctional device.
> 
> CPU0				CPU1
> 				interrupt is raised in APIC IRR
> 				but not handled
>   free_irq()
>     per_cpu(vector_irq, CPU1)[vector] = VECTOR_SHUTDOWN;
> 
>   request_irq()			common_interrupt()
>   				  d = this_cpu_read(vector_irq[vector]);
> 
>     per_cpu(vector_irq, CPU1)[vector] = desc;
> 
>     				  if (d == VECTOR_SHUTDOWN)
> 				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
> 
> free_irq() cannot observe the pending vector in the CPU1 APIC as there is
> no way to query the remote CPUs APIC IRR.
> 
> This requires that request_irq() uses the same vector/CPU as the one which
> was freed, but this also can be triggered by a spurious interrupt.
> 
> Interestingly enough this problem managed to be hidden for more than a
> decade.
> 
> Prevent this by reevaluating vector_irq under the vector lock, which is
> held by the interrupt activation code when vector_irq is updated.
> 
> To avoid ifdeffery or IS_ENABLED() nonsense, move the
> [un]lock_vector_lock() declarations out under the
> CONFIG_IRQ_DOMAIN_HIERARCHY guard as it's only provided when
> CONFIG_X86_LOCAL_APIC=y.
> 
> The current CONFIG_IRQ_DOMAIN_HIERARCHY guard is selected by
> CONFIG_X86_LOCAL_APIC, but can also be selected by other parts of the
> Kconfig system, which makes 32-bit UP builds with CONFIG_X86_LOCAL_APIC=n
> fail.
> 
> Can we just get rid of this !APIC nonsense once and forever?
> 
> Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug retriggered irqs")
> Cc: stable@vger.kernel.org#5.15.x
> Cc: gregkh@linuxfoundation.org
> Reported-by: Hogan Wang <hogan.wang@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Hogan Wang <hogan.wang@huawei.com>
> Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
> [ Conflicts in arch/x86/kernel/irq.c because call_irq_handler() has been
>   refactored to do apic_eoi() according to the return value.
>   Conflicts in arch/x86/include/asm/hw_irq.h because (un)lock_vector_lock()
>   are already controlled by CONFIG_X86_LOCAL_APIC. ]
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/kernel/irq.c | 65 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 11d7233397df..065251fa3e40 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -235,24 +235,59 @@ static __always_inline void handle_irq(struct irq_desc *desc,
>  		__handle_irq(desc, regs);
>  }
>  
> -static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
> +static struct irq_desc *reevaluate_vector(int vector)
>  {
> -	struct irq_desc *desc;
> +	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
> +
> +	if (!IS_ERR_OR_NULL(desc))
> +		return desc;
> +
> +	if (desc == VECTOR_UNUSED)
> +		pr_emerg_ratelimited("No irq handler for %d.%u\n", smp_processor_id(), vector);
> +	else
> +		__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
> +	return NULL;
> +}
> +
> +static __always_inline bool call_irq_handler(int vector, struct pt_regs *regs)
> +{
> +	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
>  
> -	desc = __this_cpu_read(vector_irq[vector]);
>  	if (likely(!IS_ERR_OR_NULL(desc))) {
>  		handle_irq(desc, regs);
> -	} else {
> -		ack_APIC_irq();
> -
> -		if (desc == VECTOR_UNUSED) {
> -			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
> -					     __func__, smp_processor_id(),
> -					     vector);
> -		} else {
> -			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
> -		}
> +		return true;
>  	}
> +
> +	/*
> +	 * Reevaluate with vector_lock held to prevent a race against
> +	 * request_irq() setting up the vector:
> +	 *
> +	 * CPU0				CPU1
> +	 *				interrupt is raised in APIC IRR
> +	 *				but not handled
> +	 * free_irq()
> +	 *   per_cpu(vector_irq, CPU1)[vector] = VECTOR_SHUTDOWN;
> +	 *
> +	 * request_irq()		common_interrupt()
> +	 *				  d = this_cpu_read(vector_irq[vector]);
> +	 *
> +	 * per_cpu(vector_irq, CPU1)[vector] = desc;
> +	 *
> +	 *				  if (d == VECTOR_SHUTDOWN)
> +	 *				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
> +	 *
> +	 * This requires that the same vector on the same target CPU is
> +	 * handed out or that a spurious interrupt hits that CPU/vector.
> +	 */
> +	lock_vector_lock();
> +	desc = reevaluate_vector(vector);
> +	unlock_vector_lock();
> +
> +	if (!desc)
> +		return false;
> +
> +	handle_irq(desc, regs);
> +	return true;
>  }
>  
>  /*
> @@ -266,7 +301,9 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
>  	/* entry code tells RCU that we're not quiescent.  Check it. */
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
>  
> -	call_irq_handler(vector, regs);
> +	if (unlikely(!call_irq_handler(vector, regs)))
> +		ack_APIC_irq();
> +
>  	set_irq_regs(old_regs);
>  }

Same question here with this hunk, it seems like you are missing
something :(

thanks,

greg k-h

