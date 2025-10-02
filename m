Return-Path: <stable+bounces-183106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FCBB467B
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074A8189489A
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDEF235072;
	Thu,  2 Oct 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ybBQ8P+x"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5819D880;
	Thu,  2 Oct 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420419; cv=none; b=AMy3C2WGRSwXW5KAyegC65kRaTzjRI70iHvcxr71zTLHSdIbykgfefuYflY9tOtcVJJXF8Xr0NFEbeiFCQq7qOCqm7HmdFTVgLxQFQ0mavaKazpsI4R9Hvh3Iap6q3if6iisPonQvnLcbnoQQt9fOiqOvKmg0zfWSwWExhd44sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420419; c=relaxed/simple;
	bh=vjLYvJOecYDB9EUrqeUhF/MZYNg6CB+C6RGu0rMKSnk=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=GJFVur9UXVe24lIDQYS2Sr1XDQ2AGdBIb2I7J/dxsXuKPDSNmPo8nvTRdstzKvcqrlfAfCa7sknm87G5VfKQcKZEAo0XUh3TCXz4oxKAoJ0nvsSHJViaCRlEbuJWEyK4dTqDyk4hmUYp1JJH2/B7FGVq7jzv4qyWQVAutA8+L7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ybBQ8P+x; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=/lko4rz8t3SWehKKGl/EDP80xAecOhLMpeuZOcoe7Sk=; b=ybBQ8P+x1CADQ2k11zWWq4Rz69
	t2nd17i/RrMoot4xHJ4Fbywgy2k1W5SsOO/P/7WXo6CA6kgb8Gcp8c97gqgUMchA1TaQ1tnv4RnYd
	LmGoVmXhPjGy2t/xhSSsu9OTSKh4DkLHx9T6v4fDd/uzfZsFVT3f+XW7Q8CQJDWLCfoY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34770 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4Lcb-0001e7-GD; Thu, 02 Oct 2025 11:53:33 -0400
Date: Thu, 2 Oct 2025 11:53:33 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, fvallee@eukrea.fr, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 stable@vger.kernel.org
Message-Id: <20251002115333.23f1c4a535a4a6f64cdca8a2@hugovil.com>
In-Reply-To: <2025100219-neon-litter-24c0@gregkh>
References: <20251002145738.3250272-1-hugo@hugovil.com>
	<20251002145738.3250272-2-hugo@hugovil.com>
	<2025100219-neon-litter-24c0@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.2 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 01/15] serial: sc16is7xx: remove useless enable of
 enhanced features
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Greg,

On Thu, 2 Oct 2025 17:43:52 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Oct 02, 2025 at 10:57:24AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit 43c51bb573aa ("sc16is7xx: make sure device is in suspend once
> > probed") permanently enabled access to the enhanced features in
> > sc16is7xx_probe(), and it is never disabled after that.
> > 
> > Therefore, remove useless re-enable of enhanced features in
> > sc16is7xx_set_baud().
> > 
> > Fixes: 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 1a2c4c14f6aac..c7435595dce13 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -588,13 +588,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> >  		div /= prescaler;
> >  	}
> >  
> > -	/* Enable enhanced features */
> > -	sc16is7xx_efr_lock(port);
> > -	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> > -			      SC16IS7XX_EFR_ENABLE_BIT,
> > -			      SC16IS7XX_EFR_ENABLE_BIT);
> > -	sc16is7xx_efr_unlock(port);
> > -
> >  	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
> >  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
> >  			      SC16IS7XX_MCR_CLKSEL_BIT,
> > -- 
> > 2.39.5
> > 
> > 
> 
> Why is this needed for stable kernels?  It's useless, what is it
> harming?

It is useless, and doing no "harm", but since the device is on a SPI
or I2C bus, this is inefficient as it takes precious cycles on these
busses.

> If so, please send it separately, not as a part of a larger series.

That is why this patch is the first in the series, so that it could be
easily backported. But I can send it separately, sure.

Hugo.

