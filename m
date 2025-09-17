Return-Path: <stable+bounces-180414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3377B80770
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A56E466147
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EA306D4A;
	Wed, 17 Sep 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="j1QTEBeP"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242222576E
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122253; cv=none; b=r20Vm4pFiPSAbT9GOeuTNr7aqhep5JMHKkrjrSWDwCzz0/QbgfNVC3V31KegRatULu7S48usV9xEV+jfPTvEIgUuXYvp5HvV82EkrWi9CqnPzO7f8lXlPgQ/qfFcIE95/uyujt9wzP+2CD5kcqpRvuY6Jx+W/HaFvHUY2IarNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122253; c=relaxed/simple;
	bh=8FM90E5mHWKPlyygNQKcdKsEFVD2MWieFx9SYo/Dxjg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=eZ/GGBxCqRLtjXhWhhAXyOYRZpmBR/T0kVKjt5sbAAVhBxZ6P5SOP3aGEa9Ru8mVubeIGbnCb4gFfFuW+CRAeI/DQ0Ji566RYb1gJh/NQI1tg3JDugHJilFEql86ty5NXGzmAk27QOaEH813poccFY5G9uiA19OvOg1A6mdjjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=j1QTEBeP; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=fTbHFPvES9r4Yoms6yx636I4RDiIqU0xlA9pZxQ18n0=; b=j1QTEBeP7riDEpShxyDuwUzaLm
	xUFZ+GkRBLSXRfPTM06zlWykbmga90YQYqVCeXHgV6SFKBKaLTyT29dJk+UN+T+AzrLdIlC2DLubR
	Zu0RVPth54cFJJU7hVH9c+e1zVv1KZ1Yho+B+acu6iDZrIP0BAej/yLwvBPM/JS0dVyE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:46896 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1uytuT-0004Ie-7Y; Wed, 17 Sep 2025 11:17:29 -0400
Date: Wed, 17 Sep 2025 11:17:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <20250917111728.d32f0b2cb1301dcd35e872b2@hugovil.com>
In-Reply-To: <20250917130319.535006-1-sashal@kernel.org>
References: <2025091722-chatter-dyslexia-7db3@gregkh>
	<20250917130319.535006-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -3.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 5.4.y] serial: sc16is7xx: fix bug in flow control levels
 init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 17 Sep 2025 09:03:19 -0400
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
> [ s->regmap renames + context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/tty/serial/sc16is7xx.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 8fb47f73cc7ad..cd767f3878df5 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1032,16 +1032,6 @@ static int sc16is7xx_startup(struct uart_port *port)
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
> @@ -1053,7 +1043,8 @@ static int sc16is7xx_startup(struct uart_port *port)
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

Hi Sasha,
this compiles ok but with a warning:

drivers/tty/serial/sc16is7xx.c: In function ‘sc16is7xx_startup’:
drivers/tty/serial/sc16is7xx.c:1023:32: warning: unused variable
‘s’ [-Wunused-variable] 1023 |         struct sc16is7xx_port *s =
dev_get_drvdata(port->dev);

Like for the other patches (5.10 and 5.15), you could remove this "s"
variable.

Hugo.

