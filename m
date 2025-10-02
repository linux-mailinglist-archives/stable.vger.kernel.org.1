Return-Path: <stable+bounces-183105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C5BB4624
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E872619E3E0B
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005D225788;
	Thu,  2 Oct 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyR6lfly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239A21348;
	Thu,  2 Oct 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419836; cv=none; b=eli+OvuHBNlrVjJNAIc8QAHL3eJ7JLmWWQSlIF9h/VS56bYHixlyqTGY/P91k4sheTOKU0UmdaLEjWqIq+pvxZHKUWB5g7fjFSivGTJ+3pPDNYQaiBVKcGZv3B9ANExn6K3+0cUTUcUqj9ZP2WVlPBvylKkHmEtZTOZNYg/UM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419836; c=relaxed/simple;
	bh=Ygig/gwXFfTw25IMNCToOkgFqzdwvG3H+SO9QZbFmBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKl9DQaW51WaCxyatVIvCtwYpnnQl/l8V8wXzOp0SW8tScCk752ctO+j58e9qpX5OCMrG7S/Hp08BKwSQgcIPcfu60gYQ9yqqgED9jrA5rpAbS9pCkQCs53ZbtCW209TlHp9c9ApAf+k6r89HvHFbM9mmmEmKgooObwNYfVOMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyR6lfly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DEAC4CEF4;
	Thu,  2 Oct 2025 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759419835;
	bh=Ygig/gwXFfTw25IMNCToOkgFqzdwvG3H+SO9QZbFmBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyR6lflyFXF85n+nvxEyp/s4vpX8Ud1Qwm/CtGn2KmGAcj3vSDvLpW8HJOwJcxAGy
	 tJN7KoCYFDacc7Ub/8m+Qs1bWEvF7HKdKIbTb6Y5aZat2BKQfnUPP1k1GjVJMq49kN
	 yRUdezcYvHpNbhlbR9wMxXIgaZbnsExUFzVo04nw=
Date: Thu, 2 Oct 2025 17:43:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: jirislaby@kernel.org, fvallee@eukrea.fr, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/15] serial: sc16is7xx: remove useless enable of
 enhanced features
Message-ID: <2025100219-neon-litter-24c0@gregkh>
References: <20251002145738.3250272-1-hugo@hugovil.com>
 <20251002145738.3250272-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002145738.3250272-2-hugo@hugovil.com>

On Thu, Oct 02, 2025 at 10:57:24AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 43c51bb573aa ("sc16is7xx: make sure device is in suspend once
> probed") permanently enabled access to the enhanced features in
> sc16is7xx_probe(), and it is never disabled after that.
> 
> Therefore, remove useless re-enable of enhanced features in
> sc16is7xx_set_baud().
> 
> Fixes: 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 1a2c4c14f6aac..c7435595dce13 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -588,13 +588,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>  		div /= prescaler;
>  	}
>  
> -	/* Enable enhanced features */
> -	sc16is7xx_efr_lock(port);
> -	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> -			      SC16IS7XX_EFR_ENABLE_BIT,
> -			      SC16IS7XX_EFR_ENABLE_BIT);
> -	sc16is7xx_efr_unlock(port);
> -
>  	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
>  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
>  			      SC16IS7XX_MCR_CLKSEL_BIT,
> -- 
> 2.39.5
> 
> 

Why is this needed for stable kernels?  It's useless, what is it
harming?

If so, please send it separately, not as a part of a larger series.

thanks,

greg k-h

