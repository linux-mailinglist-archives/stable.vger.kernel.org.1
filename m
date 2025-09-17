Return-Path: <stable+bounces-180415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8424B807AC
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DD7525183
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B800333AB5;
	Wed, 17 Sep 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="rIR3dU3S"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359571C3314
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122364; cv=none; b=ifZZXSTbY7aWgUa17fZyKlb3p8gV46QCWPofQwVQ9apkABqAsfpktSkQOIaai9ucv11+FtLbefvOjZUkxgfT8oC90ELOQGPfKKF6l+oSjH9Y4/j21oSvK2HrrxaUg+LlMVF5fuN4bqJOYNfATx0I3nxhJe4+BuA9ylbk58OrSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122364; c=relaxed/simple;
	bh=c+qN09KBoyy2uLIlCQ59dshprkNFcWqZ397Ne8yAWUs=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=eAyFFJk4r7UBF44TT43YwCMVcIrYNSXZJYhQVgkdPCRGJ0do9reA17/Pk9dPZYLHCOrqI8oN9RqMmdZsquSTYjdh0wWzq1R5YAdpgFpZhUM/PSIiLbD0Bvch8jrUY7Fmds7fHkqmWVVyDeuOlN0QP5s5JKjA438J6MNv6i9RCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=rIR3dU3S; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=lOHcYRecEqu8jC94oVR4a7p/iArv5PODunbEknSvmok=; b=rIR3dU3SFPQDa3cZhQQpy+sTtg
	6OBTHUcNLlGmGFDzmm1xj+DmTxybmYv0n31DU7186pnVRUQFgcCUP2q3rpQPQbwvFFOnhAr/3P0hH
	R9XzbO/zp7C8lyyUeTo98ojXb6tpwoQycenzqWKwRx6fi3oFH6il0ytuLEVh1b2DI4FQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:40194 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1uytdo-0001ZO-M6; Wed, 17 Sep 2025 11:00:17 -0400
Date: Wed, 17 Sep 2025 11:00:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <20250917110015.1fe9b6d91da419d44cd9315a@hugovil.com>
In-Reply-To: <20250917123957.515161-1-sashal@kernel.org>
References: <2025091721-moonwalk-barrack-423e@gregkh>
	<20250917123957.515161-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -3.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 5.15.y] serial: sc16is7xx: fix bug in flow control
 levels init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 17 Sep 2025 08:39:57 -0400
Sasha Levin <sashal@kernel.org> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> [ Upstream commit 535fd4c98452c87537a40610abba45daf5761ec6 ]
> 
> When trying to set MCR[2], XON1 is incorrectly accessed instead. And when
> writing to the TCR register to configure flow control levels, we are
> incorrectly writing to the MSR register. The default value of $00 is then
> used for TCR, which means that selectable trigger levels in FCR are used
> in place of TCR.
> 
> TCR/TLR access requires EFR[4] (enable enhanced functions) and MCR[2]
> to be set. EFR[4] is already set in probe().
> 
> MCR access requires LCR[7] to be zero.
> 
> Since LCR is set to $BF when trying to set MCR[2], XON1 is incorrectly
> accessed instead because MCR shares the same address space as XON1.
> 
> Since MCR[2] is unmodified and still zero, when writing to TCR we are in
> fact writing to MSR because TCR/TLR registers share the same address space
> as MSR/SPR.
> 
> Fix by first removing useless reconfiguration of EFR[4] (enable enhanced
> functions), as it is already enabled in sc16is7xx_probe() since commit
> 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed").
> Now LCR is $00, which means that MCR access is enabled.
> 
> Also remove regcache_cache_bypass() calls since we no longer access the
> enhanced registers set, and TCR is already declared as volatile (in fact
> by declaring MSR as volatile, which shares the same address).
> 
> Finally disable access to TCR/TLR registers after modifying them by
> clearing MCR[2].
> 
> Note: the comment about "... and internal clock div" is wrong and can be
>       ignored/removed as access to internal clock div registers (DLL/DLH)
>       is permitted only when LCR[7] is logic 1, not when enhanced features
>       is enabled. And DLL/DLH access is not needed in sc16is7xx_startup().
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Link: https://lore.kernel.org/r/20250731124451.1108864-1-hugo@hugovil.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ changed regmap variable from one->regmap to s->regmap ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> ---
>  drivers/tty/serial/sc16is7xx.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index d274a847c6ab3..3623d3167950d 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1018,7 +1018,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
>  static int sc16is7xx_startup(struct uart_port *port)
>  {
>  	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> -	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
>  	unsigned int val;
>  
>  	sc16is7xx_power(port, 1);
> @@ -1030,16 +1029,6 @@ static int sc16is7xx_startup(struct uart_port *port)
>  	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG,
>  			     SC16IS7XX_FCR_FIFO_BIT);
>  
> -	/* Enable EFR */
> -	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
> -			     SC16IS7XX_LCR_CONF_MODE_B);
> -
> -	regcache_cache_bypass(s->regmap, true);
> -
> -	/* Enable write access to enhanced features and internal clock div */
> -	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
> -			     SC16IS7XX_EFR_ENABLE_BIT);
> -
>  	/* Enable TCR/TLR */
>  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
>  			      SC16IS7XX_MCR_TCRTLR_BIT,
> @@ -1051,7 +1040,8 @@ static int sc16is7xx_startup(struct uart_port *port)
>  			     SC16IS7XX_TCR_RX_RESUME(24) |
>  			     SC16IS7XX_TCR_RX_HALT(48));
>  
> -	regcache_cache_bypass(s->regmap, false);
> +	/* Disable TCR/TLR access */
> +	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
>  
>  	/* Now, initialize the UART */
>  	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
> -- 
> 2.51.0
> 


-- 
Hugo Villeneuve

