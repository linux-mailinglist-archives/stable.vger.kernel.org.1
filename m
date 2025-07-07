Return-Path: <stable+bounces-160373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086FDAFB5A9
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E447A3764
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C462D8379;
	Mon,  7 Jul 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="McipYCfc"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354372BE04A;
	Mon,  7 Jul 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897799; cv=pass; b=P+iuMJJHzK8F1t2k/+n30oR0uqC75BOWq/ForWnzs6lVZbFsF8K3wbSp+gsyFS0W/EUt9uKfIakNoaDLZj0UUeM84PJwJDPHFGVnyXkqtCNtWw8j5bXbLOh4vh90fAKTybZh3lR0BYXzc7KxFUYgsqJ7fxQyt5GM+qqg1C7KIcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897799; c=relaxed/simple;
	bh=HcEEtqzs0J9vcZHnd/EnWkrk4jMkCBGtgE6WuEhiDRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eq5PScUdfft5MBz8FYDzQLUDtCkqLzuf11UnEp3uc52Wf0yCuSdJLM0n+LjBIiQ6aUdj+2kPbnzgYu5rQn3jl2w+fQeiT9bznGxoUHNYVT19ReAc6rucCG1GAza1iuBU0t3wc3qDDDzfJ5oSke65tOwO+f+nQ4NJBuGGkvL0gTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=McipYCfc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751897762; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J2jG+zTdhJ8/5GEz+wjzqoR2q7qvi5wWHpZpDNhgtqx4dt1zSUcnJIadlWbinzGzxAkQkKzY2ASlxmYh6cUlE8MlcBNJRdzJmkstMxELUTAENjZRvpBZd7APRf4syRDSAdd8J+lyORg7JuQzrHEhl18VIJYbFsv8bQ7mb4PuyA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751897762; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dCDf+69VVJbWwI60MQY/tACqoX7jn/Ra0BXrlDPz350=; 
	b=LLp+sgF86fInUrVtQBoOSSwneLI9klvjyH7k36AqjWrwjpbKH4HC67sNhFUMnYobiuHVc/cWWH2UYmO+9yR+czKoeQlzZBN/LMXQ57TEf0SyEkZZM6teSlJT7hFnMatvc4KGKXIh7xbMx4LVxa4n8Kk4IEvhUDTmLV9x/IACzg8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751897762;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=dCDf+69VVJbWwI60MQY/tACqoX7jn/Ra0BXrlDPz350=;
	b=McipYCfcY5qa+hK0qeBb+BGseJ0429upHDFTaRQliWM1mfF7/sD2EsWap8yDCus9
	16y722EeboxrZhX7P1RX1hfgjZP+R/6+Y9OF1h7Qp0mkpcqL+/0w6OIq/OQHA2PcENX
	X4OI94CQ948+9bEBC2+pkAKx5J4z069oKe0fH6TM=
Received: by mx.zohomail.com with SMTPS id 1751897759190607.3834386194047;
	Mon, 7 Jul 2025 07:15:59 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH net] net: phy: realtek: Reset after clock enable
Date: Mon, 07 Jul 2025 10:15:57 -0400
Message-ID: <12698483.O9o76ZdvQC@earth>
In-Reply-To: <5xjp2k3b4rggbmjgchg6vlusotoqoqmxi54zzer3ioxv274vtx@22tzjjcs7s3z>
References:
 <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>
 <0310186d-dfc5-406f-8cd1-c393a7c620e8@gmail.com>
 <5xjp2k3b4rggbmjgchg6vlusotoqoqmxi54zzer3ioxv274vtx@22tzjjcs7s3z>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Sebastian,

On Friday, 4 July 2025 16:35:00 EDT Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jul 04, 2025 at 10:18:29PM +0200, Heiner Kallweit wrote:
> > On 04.07.2025 19:48, Sebastian Reichel wrote:
> > > On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> > > stability (e.g. link loss, or not capable of transceiving packages)
> > > after new board revisions switched from a dedicated crystal to providing
> > > the 25 MHz PHY input clock from the SoC instead.
> > > 
> > > This board is using a RTL8211F PHY, which is connected to an always-on
> > > regulator. Unfortunately the datasheet does not explicitly mention the
> > > power-up sequence regarding the clock, but it seems to assume that the
> > > clock is always-on (i.e. dedicated crystal).
> > > 
> > > By doing an explicit reset after enabling the clock, the issue on the
> > > boards could no longer be observed.
> > 
> > Is the SoC clock always on after boot? Or may it be disabled e.g.
> > during system suspend? Then you would have to do the PHY reset also
> > on resume from suspend.
> 
> Upstream kernel does not yet support suspend/resume on Rockchip RK3576
> (the SoC used by the ROCK 4D) and I missed, that the clock is disabled
> in the PHY's suspend routine.
> 
> Detlev: You added the initial clock support to the driver. If I add
> the reset in the resume routine, can you do regression testing on
> the board you originally added the clock handling for?

No regression for me on the pre-release board. I can't really give you a 
Tested-by as this is a fix for a board I don't have.

Regards,
Detlev

> > > Cc: stable@vger.kernel.org
> > > Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY
> > > clock")
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > > 
> > >  drivers/net/phy/realtek/realtek_main.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/realtek/realtek_main.c
> > > b/drivers/net/phy/realtek/realtek_main.c index
> > > c3dcb62574303374666b46a454cd4e10de455d24..3a783f0c3b4f2a4f6aa63a16ad309
> > > e3471b0932a 100644 --- a/drivers/net/phy/realtek/realtek_main.c
> > > +++ b/drivers/net/phy/realtek/realtek_main.c
> > > @@ -231,6 +231,10 @@ static int rtl821x_probe(struct phy_device *phydev)
> > > 
> > >  		return dev_err_probe(dev, PTR_ERR(priv->clk),
> > >  		
> > >  				     "failed to get phy clock\n");
> > > 
> > > +	/* enabling the clock might produce glitches, so hard-reset the PHY 
*/
> > > +	phy_device_reset(phydev, 1);
> > > +	phy_device_reset(phydev, 0);
> > > +
> > > 
> > >  	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
> > >  	if (ret < 0)
> > >  	
> > >  		return ret;
> > > 
> > > ---
> > > base-commit: 4c06e63b92038fadb566b652ec3ec04e228931e8
> > > change-id: 20250704-phy-realtek-clock-fix-6cd393e8cb2a
> > > 
> > > Best regards,





