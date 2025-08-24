Return-Path: <stable+bounces-172700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28085B32E31
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC5F204F7F
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DE259C92;
	Sun, 24 Aug 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7wR3Bqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4E14F70;
	Sun, 24 Aug 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024674; cv=none; b=pxxVv8lTGGCPCcB4vMVr/aZ/ubF4mhnmCORWawI2jrCK9CUEGds1RaSa8gFKCsLN+Wf3KIwMwCG4PTTFNRYP48KBWAR9uDNe+5lUttb7+vhrxORA8PYCplDPoQohrNLHYwxI+KS+MqokwXbj2klgjGjWQeM5uhrEuPeVF/pgZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024674; c=relaxed/simple;
	bh=7C/furl0DcUT9W6mupFGCewd5k/8L8ZDOG7DtOWIJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8+8p7h3p5byCIPcFXveRUsUbNc2vVuw5NUdW0+GF3OMLG+XPatAfB75uvvYrpwyOo/0ouKz8xwQzXT3G0z/FrhRjkk7H1jPuHHNYMp4mjbNj8l69BLZkuQaE+/gqRY88Pz8gbbwqAfonz+3X3Ib2YpXzwn61puaGFTcIwldFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7wR3Bqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B958FC4CEEB;
	Sun, 24 Aug 2025 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756024674;
	bh=7C/furl0DcUT9W6mupFGCewd5k/8L8ZDOG7DtOWIJ9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y7wR3BqmSL5U+OcWqv8LejKLo41VvAQpbSsAHwcgdkZibIC3k3xyr5lC5QhV8Kct2
	 oXv9Or7+o8G0oDnZyiO0eky0mKqsHIPnVt7ClC9yHIYccShDV56pWavi7+ua/wuvXv
	 /3480p5NFKXqtYqBTyQ/GSa3KN3b4z0VvLftF2sU=
Date: Sun, 24 Aug 2025 10:37:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, prarit@redhat.com,
	x86@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.10 RESEND 0/2] x86/irq: Plug vector setup race
Message-ID: <2025082435-attribute-mounted-f09e@gregkh>
References: <20250822033304.1096496-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822033304.1096496-1-ruanjinjie@huawei.com>

On Fri, Aug 22, 2025 at 03:33:02AM +0000, Jinjie Ruan wrote:
> There is a vector setup race, which overwrites the interrupt
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
> The first patch provides context for subsequent real bugfix patch.
> 
> Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug retriggered irqs")
> Cc: stable@vger.kernel.org#5.10.x
> Cc: gregkh@linuxfoundation.org
> 
> v1 -> RESEND
> - Add upstream commit ID.
> 
> Jacob Pan (1):
>   x86/irq: Factor out handler invocation from common_interrupt()
> 
> Thomas Gleixner (1):
>   x86/irq: Plug vector setup race
> 
>  arch/x86/kernel/irq.c | 70 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 14 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Dropping as I didn't take the patches for later kernels either.

greg k-h

