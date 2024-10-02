Return-Path: <stable+bounces-79494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4FD98D8C1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04ACBB23EAC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087761D0E30;
	Wed,  2 Oct 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMPKIGAq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaO7MgLB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA41CFEB3;
	Wed,  2 Oct 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877625; cv=none; b=aTqGnxiPpkv/uOifYvG3U8DZFPXO5MYufPUzFHGDjXaOYW1XNNBoXPrypazHbw4ZR5JEmtjiu7o0rlplIpt9xaZqUTItcVSqPDw8hISu28l6cpWwBxUOF5wJyNDn4ZWkOtELOWF2u0M7T5AX1mUZSg7hPQNkWoyb7EqKiibBk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877625; c=relaxed/simple;
	bh=LK3sIX6c8Vp5zH1p2Nl9RVDOvCjNChQGjpJ+XZwcNhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a3HYMQ5FgpuCK/bkKK71MLb5R0ZtyYcCR/FkutuN6BJjwiHxj7QwG6xHCDem5nsC0yesAaeYEzYMyqmKmdcndH2IhIfy93HGkUCg6nNFTilaIzkyVBJauDMtnm2iqu/Bu4LaY6cyEm6YRh8etEWwLbfeMDjkTlF1UCf027Dj55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMPKIGAq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaO7MgLB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727877621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRWdOmFvwEuoklANot4NPcQH4x73VoxrUIuRqMWDH3c=;
	b=DMPKIGAqsUTAW20USYZF3yfL7A3b9ZbzMIRj5R+loWuFbVexkhUIb2WkGexh8cppeFz5Vo
	7tPnOt3qsndBid6nKw+63o3CdSiocnNayBiC93xmG3rgYku9SvYIVb0AZ94PaAe74z1vLG
	C7Ms55qBeE96wKbqkRMsI3cGt5MSmGEOw8pBPeV2IEFJvGvZ6XQVQ3mg1ekkVniyCcret6
	YF7qOmU3XtKprpOt62mkXcTeJyiFf8HQXVB++GsA5y6bn1l0/hHcHfojOU26GSxDBZ5Ia+
	lqpRcJN1fXkCQ52lkpRAMi+5AxfcfH7dGFl2rbxUx2cuexywv5N4G0X5q3Qwtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727877621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRWdOmFvwEuoklANot4NPcQH4x73VoxrUIuRqMWDH3c=;
	b=JaO7MgLB3H615K0Pzsbh8rfsVoTA2xO2TsWkNm5mtJt6tUU+Gh3VB1ssGHUnCODTSBjmkE
	ru/i/N4t+YrgcnAg==
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley
 <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Nam Cao <namcao@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH] irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()
In-Reply-To: <20240926154315.1244200-1-namcao@linutronix.de>
References: <20240926154315.1244200-1-namcao@linutronix.de>
Date: Wed, 02 Oct 2024 16:00:21 +0200
Message-ID: <8734ley58q.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 26 2024 at 17:43, Nam Cao wrote:
> If another task disables the interrupt in the middle of the above steps,
> the interrupt will not get unmasked, and will remain masked when it is
> enabled in the future.
>
> The problem is occasionally observed when PREEMPT_RT is enabled, because
> PREEMPT_RT add the IRQS_ONESHOT flag. But PREEMPT_RT only makes the
> problem more likely to appear, the bug has been around since
> commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
> operations").

Correct. It's a general problem independent of RT.

> Fix it by unmasking interrupt in plic_irq_enable().
>
> Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations").
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/irqchip/irq-sifive-plic.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 2f6ef5c495bd..0efbf14ec9fa 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -128,6 +128,9 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>  
>  static void plic_irq_enable(struct irq_data *d)
>  {
> +	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
> +
> +	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
>  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);

Can you please move plic_irq_enable() below plic_irq_unmask() and invoke
the latter instead of duplicating the code?

Also usually unmask() is done after enable(), but the ordering probably
does not matter here.

Thanks,

        tglx

