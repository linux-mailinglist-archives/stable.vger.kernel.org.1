Return-Path: <stable+bounces-55068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527CF9154A9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A5EB24DE1
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1319E81B;
	Mon, 24 Jun 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZB2jBe1"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5242F24;
	Mon, 24 Jun 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247608; cv=none; b=MsWimIeHNgLauxYKZUj+gyRv0Za059jUFkrYmnEqLUj0/bwkZBL1N5teWJQaXmFu7iWbwuT1gZ2mSDDSwiyTHo45jZUWlCY4AheQgcaC1+Y+4yuVtPB29Bb6kMUnQ0EVrzX8mNt0Llxj+eex88N7vxrZVOLxKxwuZ+CY1T79l6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247608; c=relaxed/simple;
	bh=Z0KOoAgihY9+2olzC1EakZj1hVSDqO9ADCzWhcqulHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oPruGRN1FyqVklvuTcsJQ+z8yYEDxsldPbua+zR5uEHEcl4XjASJ8lNjv+3aWWsCLPgNdNTYaf4QvCHTKXu+cXtp/1Eps0WywBxNMcxJF4bsO9eErB0mkJHWGRhaJxyOAKnVceoF/y/fbGA7IufpupdQfK6yM8sMNCuTC5v9sYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZB2jBe1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45OGkIgZ099626;
	Mon, 24 Jun 2024 11:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719247578;
	bh=ftKRQUamjpJWDefpfpwbKp7EZqAIxw/kXhR8Z/Mx5zs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fZB2jBe1GUWTGU75xB7pLY7UhFEn3HYvewkq5kyAi+/eEvYDBMponWXnJxO/O5NID
	 Go4QUK0V6VnoC9bUYlmqUncnOtuqIQ9c6zT4e/3TtUbiA7xykxUhK/XcpjTikJibDk
	 Gv8OdQKX2Uno445OwA1TIGcD5DpXTey4CgQLBSlk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45OGkInC079934
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 11:46:18 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 11:46:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 11:46:18 -0500
Received: from [10.249.142.56] ([10.249.142.56])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45OGkEin083808;
	Mon, 24 Jun 2024 11:46:15 -0500
Message-ID: <e96d0c55-0b12-4cbf-9d23-48963543de49@ti.com>
Date: Mon, 24 Jun 2024 22:16:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3] serial: 8250_omap: Implementation of Errata i2310
To: Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <stable@vger.kernel.org>
References: <20240619105903.165434-1-u-kumar1@ti.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240619105903.165434-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/19/2024 4:29 PM, Udit Kumar wrote:
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
> Change logs
> Changes in v3:
> - CC stable in commit message
> Link to v2:
> https://lore.kernel.org/all/20240617052253.2188140-1-u-kumar1@ti.com/
> 
> Changes in v2:
> - Added Fixes Tag and typo correction in commit message
> - Corrected bit position to UART_OMAP_EFR2_TIMEOUT_BEHAVE
> Link to v1
> https://lore.kernel.org/all/20240614061314.290840-1-u-kumar1@ti.com/
> 
>  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 170639d12b2a..ddac0a13cf84 100644
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
> @@ -663,13 +667,24 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
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
> -	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
> -	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
> -		serial_port_in(port, UART_RX);
> +		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {

This still doesn't match the errata workaround described in the above
doc. Need a check for RX FIFO LVL to be empty (like before). Else we end
up applying workaround on every timeout (including those that are not
spurious) which is undesirable in the IRQ hotpath.

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

