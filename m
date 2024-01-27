Return-Path: <stable+bounces-16039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C483E87A
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DB228A7D0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F35EA8;
	Sat, 27 Jan 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FSVi0rTF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3539E
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315494; cv=none; b=hNWliy+xvHyWQosOInI/LxNxr4UX0I+jcJAc/RxGdhzSl1uhLFMpu+y1k44JU7CKtQRcClfjfw4nmjRd7E8ZSzf1A5jfcsyxjJXXFjJ3AOpiQ007LGu7VyLu1EDeNyFad/MNxR2sUAtS+G0f6Ji9vJyCX2MLDEm1AkoCcMcJDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315494; c=relaxed/simple;
	bh=SK4HyjVhdINn4BqUDpamulPq20k/lzRnVcRRWR81V2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBpm5iKBS1Usnhei3R1l0QbSyImhf20blPS3q7IZlH9TpHCkuRZV3bYjSL92ywge8OsPEjkAXFe1JktSb1OfrbCgX3b5UKg/OEpt1AUwdoPt6CLJchRI14W213ww4DzUBMq6smVQCoI0buTuVfSCAKybfYvhwoRT/ddaU0m85R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FSVi0rTF; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a75ec56dcso9047481cf.0
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 16:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706315491; x=1706920291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EE1ASbxE2gS1DHjjB75FAGFf+9sqnnv3UERtEA/9BEs=;
        b=FSVi0rTFWHFoFFycMUXqnQoT2jQuU9PsQZIAIjQ92vB5rsmYVycpORiSr0zxxUsj0I
         juVJJfadieG920l/sv1mHQU1dtpxFO9670H+ZddJLZ4NEEm3JCAHKbm24SJovnlpeDV2
         cYxAu/C6Erj0Dbbc1H44bWFW60e87QtkInc9eLBt6xXi1jX1kmOaG5I7os5Aj5bK83lG
         hJ3WeoXx+REiPRPc94/VZxrfAWlcWktr+Riyop6NWrfMlRXdwl2imNrHpQ9oXZ+uM9d7
         IvOEbQNC9vS3cXMVgadg9JK+VI7CXWpVBf2NcRrL1DbFESOQdiKHVnKVNMkm8GAf+VRT
         xDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706315491; x=1706920291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EE1ASbxE2gS1DHjjB75FAGFf+9sqnnv3UERtEA/9BEs=;
        b=GRURFnzyGhv3siBg1wYn+vpXYZwvf3VSrN2dofJ9BdWMGA5Vqa+HeaCaWWTQ/rqSFJ
         wtBO61VwRq5ws1e1OmztEdo2bdtALr3qT/8cjyP7WDKGHeZYjToAmyyqAlMFHcNrnDWb
         sdf3h+QCYKlAKmmTx5zH+JqFDDQclxG6KGcUK7fzCdNWvduKbLJzdVNa4yDgEBDHUeP2
         0MBq1YuaO9Jop+j0mKy2uQfFXR+0e37X3FEhewNFDqDNAWa93v4ogA0XqYPAZQK/ooj1
         qGscq5HWLEc5tCDmKH/G700PoTZWbsJR/YhpUJEsFQLp8W7LKozj1Xwap6CZt3BxS2rC
         1YmQ==
X-Gm-Message-State: AOJu0YzHQ8m5/7r3whVawJcqD3NyIS+OuA6KD/QskCBwikTQvRJ2+7G2
	lOUdIVBys9Q7XujB0Q6HIKbMT7ZnK201a07bpMOCBz3arXY9biOAH+fFc491DEY=
X-Google-Smtp-Source: AGHT+IHYBkYFYpz0r2W2w1iGtXElTSkPAKJefOG+eq74ZWSy/gVQVZ5V3xMjVE6TCOcBqwZTNSl3Ew==
X-Received: by 2002:a05:622a:307:b0:42a:6cc2:20c4 with SMTP id q7-20020a05622a030700b0042a6cc220c4mr882478qtw.60.1706315490927;
        Fri, 26 Jan 2024 16:31:30 -0800 (PST)
Received: from [100.64.0.1] ([136.226.108.192])
        by smtp.gmail.com with ESMTPSA id v26-20020ac873da000000b00427f1fa87e6sm994412qtp.56.2024.01.26.16.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 16:31:30 -0800 (PST)
Message-ID: <071142d9-3644-4c62-a99d-40b55bf64406@sifive.com>
Date: Fri, 26 Jan 2024 18:31:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/sifive-plic: enable interrupt if needed before
 EOI
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Samuel Holland <samuel@sholland.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc: stable@vger.kernel.org
References: <20240126223836.202321-1-namcao@linutronix.de>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240126223836.202321-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-01-26 4:38 PM, Nam Cao wrote:
> RISC-V PLIC cannot EOI disabled interrupts, as explained in the
> description of Interrupt Completion in the PLIC spec:
> 
> "The PLIC signals it has completed executing an interrupt handler by
> writing the interrupt ID it received from the claim to the claim/complete
> register. The PLIC does not check whether the completion ID is the same
> as the last claim ID for that target. If the completion ID does not match
> an interrupt source that *is currently enabled* for the target, the
> completion is silently ignored."
> 
> Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
> ensured that by enabling the interrupt if needed before EOI.
> 
> Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
> operations") removed the interrupt enabling code from the previous
> commit, because it assumes that interrupt should be enabled at the point
> of EOI. However, this is incorrect: there is a small window after a hart
> claiming an interrupt and before irq_desc->lock getting acquired,
> interrupt can be disabled during this window. Thus, EOI can be invoked
> while the interrupt is disabled, effectively nullify this EOI.
> 
> Make sure that interrupt is really enabled before EOI.

Could you please try the patch I previously sent for this issue[1]? It
should fix the bug without complicating the IRQ hot path.

Thanks,
Samuel

[1]: https://lore.kernel.org/lkml/20230717185841.1294425-1-samuel.holland@sifive.com/

> Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 5b7bc4fd9517..0857a516c35b 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>  
> -	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +	if (irqd_irq_disabled(d)) {
> +		plic_toggle(handler, d->hwirq, 1);
> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +		plic_toggle(handler, d->hwirq, 0);
> +	} else {
> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +	}
>  }
>  
>  #ifdef CONFIG_SMP


