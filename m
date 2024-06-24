Return-Path: <stable+bounces-55094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2157D915519
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0318281134
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39519EEB6;
	Mon, 24 Jun 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hau3DsbR"
X-Original-To: stable@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8A1EA87;
	Mon, 24 Jun 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248959; cv=none; b=TDffEnUUdLYn7KYP1yFbzRE061j6UrILbWqLFwkk+kf29l8FOD3dieesFYy6Ccu97udkJoVdz9vzm56gHV3wTeMhIqPvVvVZFJ8aFyn9YC0dzHK1DTs4Zus+ZpHFhhXTR7QMKyFlpt2Iowqz0e/Rj2eHJT4Dy03toFBBhEW65d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248959; c=relaxed/simple;
	bh=dwEPjDc/BlYER6gzVye1cYTBbiMlwD39qUuDxRhvp3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VtRpZ9dNsSOUhbUHHM0sLPX81tFPXehi0eORLqYIgRroCBPHB/n0J/btyKLna8oArrAOQaV/wCojotPGp+WsnOH5bbVnXXWwlbpZqJMkGG7lFN4jrCL6/NeWk0zVi58UmKhhZWEEPDu9DLjIaxr9Iky55jgjTWngucX2tog0PEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Hau3DsbR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45OH8sUs131022;
	Mon, 24 Jun 2024 12:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719248934;
	bh=GAL79usfS5BXcnKgQIqFLVN5w19xXDo6oQmCqfMOimM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Hau3DsbR+OoDtcYVWY1O6vB947vzPQ460bV1HzJfcd+DmIMtE6G+KUPGqqRpsChW6
	 UbJl0fpbQXnhLP54YbYZtihoebiZS6Uj6QgaPqsjYUJ2r10wQPwdlrN66Nkp2jjfCZ
	 GVWXUk8Z1Jh54P/QwBpGBU8fMPkmKyB1xoZ18Mtc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45OH8s0e093596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 12:08:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 12:08:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 12:08:54 -0500
Received: from [10.249.142.56] ([10.249.142.56])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45OH8oAe119122;
	Mon, 24 Jun 2024 12:08:50 -0500
Message-ID: <d59c67e3-1445-4005-8b2c-92cb7c898770@ti.com>
Date: Mon, 24 Jun 2024 22:38:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] serial: 8250_omap: Implementation of Errata i2310
To: Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <stable@vger.kernel.org>
References: <20240624165656.2634658-1-u-kumar1@ti.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240624165656.2634658-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/24/2024 10:26 PM, Udit Kumar wrote:
> As per Errata i2310[0], Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to storm of interrupts, therefore apply Errata i2310 solution.
> 
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
> 
> Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---

[...]

> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 170639d12b2a..1af9aed99c65 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -115,6 +115,10 @@
>  /* RX FIFO occupancy indicator */
>  #define UART_OMAP_RX_LVL		0x19
>  
> +/* Timeout low and High */
> +#define UART_OMAP_TO_L                 0x26
> +#define UART_OMAP_TO_H                 0x27
> +
>  /*
>   * Copy of the genpd flags for the console.
>   * Only used if console suspend is disabled
> @@ -663,13 +667,25 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
>  
>  	/*
>  	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
> -	 * FIFO has been drained, in which case a dummy read of RX FIFO
> -	 * is required to clear RX TIMEOUT condition.
> +	 * FIFO has been drained or erroneously.
> +	 * So apply solution of Errata i2310 as mentioned in
> +	 * https://www.ti.com/lit/pdf/sprz536
>  	 */
>  	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
>  	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
>  	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
> -		serial_port_in(port, UART_RX);
> +		unsigned char efr2, timeout_h, timeout_l;
> +
> +		efr2 = serial_in(up, UART_OMAP_EFR2);
> +		timeout_h = serial_in(up, UART_OMAP_TO_H);
> +		timeout_l = serial_in(up, UART_OMAP_TO_L);
> +		serial_out(up, UART_OMAP_TO_H, 0xFF);
> +		serial_out(up, UART_OMAP_TO_L, 0xFF);
> +		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
> +		serial_in(up, UART_IIR);
> +		serial_out(up, UART_OMAP_EFR2, efr2);
> +		serial_out(up, UART_OMAP_TO_H, timeout_h);
> +		serial_out(up, UART_OMAP_TO_L, timeout_l);
>  	}
>  
>  	/* Stop processing interrupts on input overrun */

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

