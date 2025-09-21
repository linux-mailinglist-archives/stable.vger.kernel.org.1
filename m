Return-Path: <stable+bounces-180742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70528B8D760
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 10:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C20D3BF6F8
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 08:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C323D7E8;
	Sun, 21 Sep 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GsrVTsOx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Vt982O9"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FD184;
	Sun, 21 Sep 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758443285; cv=none; b=HCuCjXVJJe8UQaz0OoIM8SoK3GUKp0zoDSv8viUibYQNldGk8TofBOqLFzwwM8LfF8f1LPnuuZP0u7/EqJoMm4Yu5KOCF4QN7hagorAZWTx/jy/eT+6RMIbcc3+qHAeS3Ozz1PYj3OSIqoSOZt/byUtrFZEkf2u8JUBzlEqfxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758443285; c=relaxed/simple;
	bh=a2ozcfRvL1LNCpQJLw3UNVFJr5AW/8/JVOwIRszxAWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iP6CgFJfebvPqX9Ji3+3ITazOkTkrW3cws2hV9Bh1QDWv0gtFlgClr8rlmpm6IZj2fgAQljDsqoG5XmvJ4iN1H6HfZgX2SbcvaVeZDJk/kygjgW3K850ltGEQVr05QvqgQmGoNKig18bls0FrmOBp/qJFmBUTAfG5+V7fcxACqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GsrVTsOx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Vt982O9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758443281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Zd+C1azbDEt3Vz0ImeQyxblM1ChpI5F+d3T0ZRmmlY=;
	b=GsrVTsOxqKIg/ZCp3pN45SNUYSErdZ0EAY747oORQ2U7LzGsfw5uvTIi0jiCI7NAOCKL54
	RIHBqJYdv/bvoSRKFhNnscwonRjNHokJ440D0GhWFbsXdfeVYyK3AjOTawROhsM6kvBUg4
	yiE23i0txfBEim2aXazFWBtqn8xN/8T1WHebLcy6PTEkJXCJP+hnvjIRXxxMrN22m8njnW
	tDHtlxv+8dnp6KSQM7B9zfcImg8UTofoG8iOsTZaNLs2EXzt6jBIzbVm9XGZ7t49Slrkva
	+b/Glj7TJjRCv0UYdORckiCkNNQgLhI565BSK+RaDeaeZIjXy4/rmln5swsMng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758443281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Zd+C1azbDEt3Vz0ImeQyxblM1ChpI5F+d3T0ZRmmlY=;
	b=1Vt982O9XL6grD/TgQTBMrDh1K0kOl0pnLICT4p5yqtFxB1xxU9uQ9uER0HWNGToyNWAFl
	zUz66DO3CeeZpfBw==
To: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>,
 stable@vger.kernel.org, linux-riscv@lists.infradead.org, Jia Wang
 <wangjia@ultrarisc.com>
Subject: Re: [PATCH] irqchip/sifive-plic: avoid interrupt ID 0 handling
 during suspend/resume
In-Reply-To: <20250915162847.103445-1-lzampier@redhat.com>
References: <20250915162847.103445-1-lzampier@redhat.com>
Date: Sun, 21 Sep 2025 10:27:59 +0200
Message-ID: <87ikhc5hww.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 15 2025 at 17:28, Lucas Zampieri wrote:

> To: linux-kernel@vger.kernel.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Samuel Holland <samuel.holland@sifive.com>
> Cc: stable@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>

How is this Cc list relevant in explaining the changes here?

> According to the PLIC specification[1], global interrupt sources are
> assigned small unsigned integer identifiers beginning at the value 1.
> An interrupt ID of 0 is reserved to mean "no interrupt".
>
> The current plic_irq_resume() and plic_irq_suspend() functions incorrectly
> starts the loop from index 0, which could access the reserved interrupt ID
> 0 register space.
> This fix changes the loop to start from index 1, skipping the reserved
> interrupt ID 0 as per the PLIC specification.

s/This fix changes/Change/

And please separate this from the explanation above.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

> This prevents potential undefined behavior when accessing the reserved
> register space during suspend/resume cycles.
>
> Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
> Co-developed-by: Jia Wang <wangjia@ultrarisc.com>
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>
> [1] https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0

Link: .....

This [1] stuff is just annoying.

> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf69a4802b71..1c2b4d2575ac 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -252,7 +252,7 @@ static int plic_irq_suspend(void)
>  
>  	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
>  
> -	for (i = 0; i < priv->nr_irqs; i++) {
> +	for (i = 1; i < priv->nr_irqs; i++) {

This lacks a comment explaining this non-obvious 'i = 1'.

Thanks,

        tglx

