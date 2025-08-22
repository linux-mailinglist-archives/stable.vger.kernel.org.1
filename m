Return-Path: <stable+bounces-172334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBD9B31257
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7C21729EC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1C2475C7;
	Fri, 22 Aug 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hlSrC9Xq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5413A3F7;
	Fri, 22 Aug 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852749; cv=none; b=N2uAI4lOzVbg+FMK9Nta+jPBBy0tb3/0tmj96W/XK+Y4w2t9Yk3Lrt9rViMqzSp8Oowa269Jn8TTTxfN9L3SN8+RJL3Jop6TT0mizH7A/Ykt+nAZdtiKoXKLYpaxfRyKycF+NnTfk/8L3jMUHQrXBnUAz66HNsTWdBIpRN5XmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852749; c=relaxed/simple;
	bh=4aya1wTVDtUII+mYsjx1rpaa1qpUSpw6w3Rn6vJRYAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDk4FrGwh5cwXKFywu7dPdau3BJSbiqcTVImDkd6Us4wWtjX65BtbUxjrLTiKMk6f0LDRpoZabQgHwGFVcM/ZNsSxkf1/Fx9m8eQIdxTlgDCV1YYT1QOY3Ty7rWwnD0pAjlrtNimaSso/iHjzwZuHftAUVLbaNBWwXPEJw9Z8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hlSrC9Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8949C4CEF1;
	Fri, 22 Aug 2025 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755852749;
	bh=4aya1wTVDtUII+mYsjx1rpaa1qpUSpw6w3Rn6vJRYAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlSrC9XqDakqYo1ey4Vu2QEDpP+2Y2HzXuY/x3PL1w7WgcW7f85mQGjGHyMKtdhjD
	 DLc1VOXpIrh6klWX5V2iv5qgsx44nuPA3RizOrDlGGV4/jZYr1KGDu+qZkhpx/HRr/
	 NRwhxujwBp+wP/FNxdFq81adVAKVUK8LJ6rwLDec=
Date: Fri, 22 Aug 2025 10:52:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, prarit@redhat.com,
	rui.y.wang@intel.com, x86@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.6 2/2] x86/irq: Plug vector setup race
Message-ID: <2025082218-faceted-striving-b595@gregkh>
References: <20250821131228.1094633-1-ruanjinjie@huawei.com>
 <20250821131228.1094633-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821131228.1094633-3-ruanjinjie@huawei.com>

On Thu, Aug 21, 2025 at 01:12:28PM +0000, Jinjie Ruan wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
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
> Cc: stable@vger.kernel.org#6.6.x
> Cc: gregkh@linuxfoundation.org
> Reported-by: Hogan Wang <hogan.wang@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Hogan Wang <hogan.wang@huawei.com>
> Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
> [ Conflicts in arch/x86/kernel/irq.c because call_irq_handler() has been
>   refactored to do apic_eoi() according to the return value.
>   Conflincts in arch/x86/include/asm/hw_irq.h because (un)lock_vector_lock()
>   are already controlled by CONFIG_X86_LOCAL_APIC. ]
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/kernel/irq.c | 65 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 14 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

