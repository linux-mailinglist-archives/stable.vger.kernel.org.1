Return-Path: <stable+bounces-203162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4083CD402F
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD5583005270
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF70299947;
	Sun, 21 Dec 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fXyN8uZc"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4062F8BCA;
	Sun, 21 Dec 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766320488; cv=none; b=GQMJdBk1b/Tb3e+1MpBphCh7K7yE8JDjdYl2dgtbjolVDLPhLmI/0VBw8k2jlUvcvIaGHe3yukWdzV7zzWM1hyfpSQs/qoB+BDElIcXVLb+6ev+JZDzC5GOzmNPjxOweN0fsGTA42wyQ4Z7ABOPJUmzUavHy/j/zxPXny3hUdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766320488; c=relaxed/simple;
	bh=obY40gWwQl2DIwxk6CF1/T/Xpqzv0Pyrip73ZSZn7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKYg35HXxikP14IzrxXWn7btMC/na+DNYdQfynqYVRPBFPPb2mtEFa5vqLs6iE+uKa2TXEbD8RIzdLwZuxjHWuTLaTmsPJWezFVH0lSLTsz6teZlr93Lkv5hfs9Fwq+YtIXVZVzI2OVOhBgdUFL74oDL/XmTPBK1PAGR+Xu1J9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fXyN8uZc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yj8b4wc2kO8O3h5rkpVBnAqWpely2jUEjwXeapDzC5E=; b=fXyN8uZc5KCDJL79JEokJSKs7J
	n81OQ/mjxB9anrDXD7/iidJ0P/nkzW2neJoERkc+qKLo8N1/lOFMUZ0Lpz41ecYdlSdFYXslHoHl/
	8GI6cU/Xwk0QugpSdlxjzDfiCqEgu+YiBdcKYpd19O80Ha2MLuLRKJnB2aOs+Bb3dR9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXIdx-0004A7-20; Sun, 21 Dec 2025 13:34:37 +0100
Date: Sun, 21 Dec 2025 13:34:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: sr9700: fix incorrect command used to write
 single register
Message-ID: <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch>
References: <20251221082400.50688-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221082400.50688-1-enelsonmoore@gmail.com>

On Sun, Dec 21, 2025 at 12:24:00AM -0800, Ethan Nelson-Moore wrote:
> This fixes the device failing to initialize with "error reading MAC
> address" for me, probably because the incorrect write of NCR_RST to
> SR_NCR is not actually resetting the device.
> 
> Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/usb/sr9700.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> index 091bc2aca7e8..5d97e95a17b0 100644
> --- a/drivers/net/usb/sr9700.c
> +++ b/drivers/net/usb/sr9700.c
> @@ -52,7 +52,7 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8 *value)
>  
>  static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
>  {
> -	return usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG,
> +	return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
>  				value, reg, NULL, 0);
>  }
>  
> @@ -65,7 +65,7 @@ static void sr_write_async(struct usbnet *dev, u8 reg, u16 length,
>  
>  static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
>  {
> -	usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
> +	usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
>  			       value, reg, NULL, 0);
>  }

I don't know anything about this hardware, but there are four calls using SR_WR_REG:

https://elixir.bootlin.com/linux/v6.18.2/source/drivers/net/usb/sr9700.h#L157

You only change two here? Are the other two correct?

It might be worth while also changing the name of one of these:

#define	SR_WR_REGS		0x01
#define	SR_WR_REG		0x03

to make it clearer what each is actually used for, so they don't get
used wrongly again.

	Andrew

