Return-Path: <stable+bounces-80723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D8E98FF66
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E271B21E15
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6B144D01;
	Fri,  4 Oct 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lisG9BNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0017758;
	Fri,  4 Oct 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033223; cv=none; b=kBio52ZNRs4JOly7nQo8fQhzblP/w2o/knXDBjQrAyRacXnoH14UiP46Fwg87solVZ061gvXX3V8DGgosRqRm2OHDf70DBhBg508XFmqzm0VXinZARjAQmHAhdXy5ot+XdLMlEUNbam0hLBAmOeZVxj91MudlPHuWyQI2RSghPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033223; c=relaxed/simple;
	bh=Z5bHITMaJBCz28koUc5htlEld8pCy/uM/+Bqca7buto=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owz6nA6Od1bcUS1f06xaFVj355eDe1CLrtXpTk5BubI8H0ZtfsEusJL/LGz7wmyNYdWFrsItk9ngZS3lOk84b1OmSCyYdeTH9XupIxReUgC+mqDva6by32JjaPGdp5XwWEzB60uptlr3t28N3KQJjNvY3Hv22oy0OCUKV2x+Ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lisG9BNX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so16232465e9.0;
        Fri, 04 Oct 2024 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728033220; x=1728638020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X15WC1ZWXuz5+wofBMUIwK10sZf4phCW4d2DHL2mVeQ=;
        b=lisG9BNX621iWVPwVt5AjEgQ1KXoJQGRfw9/I0dFytIrUypHV4CfFe3JdEMFNzeywj
         lLT25IjwdSY3x+hx4cW8XsoFcOmKPJ8VdRwxdplY/XSrnDqQBwP2XNN3hDRxGD9RyXzZ
         Q92E4X+RuGTlGKxXkhHY9t1HxsYfx5VY4kJonUbHgPiWZjD8CZU6qKGcV3ovt7eSH1K2
         tiSY9X/V2hb+PKOYyLQPMS8J4fvGhOmyWvDbRESLydlVMWIBUgJdK/q/Sgo1lpXWacbj
         gT+GQiTyKobJdP/sGtUYwE+QiCK7DC9aUZEQVY84Sa4fDg3X/UXjmk/Yh3S0hVCat+wa
         Q3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033220; x=1728638020;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X15WC1ZWXuz5+wofBMUIwK10sZf4phCW4d2DHL2mVeQ=;
        b=jX7ObyxtlmpKnBc+etf+Y4BwWH/qk4VRNwR7Lj4drY3zvX1P31rOwWuQF92Rmp/ctD
         SewvIO+k30g26ExScBCUMM7HiGK1Smkjg7XXJjJx6NZRlArmXydLxyLDEUH01D0fK0tM
         s7SOSxrFt+DNoclhOX01Ki2i1JG6XoPyjnbmmSGEptsNxENOsHqA+xw1rR1Yxlu8e3zS
         AxDdM/rMIOEAO7bnimQ7ltZnfgv4hS6SzHycFydZKF5GvZDUIGpCiN60flGFrWlL4J6w
         4mwV7/mGy5rYIJ/Aj4wwtzkCTr1ZgPkJf0ouWxymj/F/ri1TUCSOnk4RHokwnysaidFX
         nkUw==
X-Forwarded-Encrypted: i=1; AJvYcCUCaWFYMPLwZfq+ekQhIJ3scLB9sU82ULKIHlTkhr+c3WJilaexKWzhOFraSaQUbRbcCc54uVpc@vger.kernel.org, AJvYcCWvve/cCi/rtgIVLYOBpVsQp1QZH/dz0sd3+NcuHx7mhIaZ6blaWAoVim5kkAQIWve0BAUxIbyxFyM9sV0=@vger.kernel.org, AJvYcCX+MZ64/ZyZO8GBB89LZv9KE6CrdpdNUBAHh+gva2Icic2C+Q1skaM1d/VDyFRE8CUqjXGVtGQK@vger.kernel.org
X-Gm-Message-State: AOJu0YysJk8b3+8QggzDIaQmw7W3+cGqShYfL/WDuJwCIDdUTcfAxAsI
	+KRNAnYFOBTtumGu3YBrqQ/mSaXBIcxyfhcULlikwGph9yD0jGLN
X-Google-Smtp-Source: AGHT+IEd5QPZB1kQDUm9RuZ3CmJ84GZOC9yYfP5vZ1CPXSmaZBiiM7cib2MJO2OH5P38dW7HKytDeg==
X-Received: by 2002:a05:6000:1370:b0:37c:cf73:4bf7 with SMTP id ffacd0b85a97d-37d0e761138mr1402186f8f.34.1728033220106;
        Fri, 04 Oct 2024 02:13:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08247911sm2847582f8f.57.2024.10.04.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:13:38 -0700 (PDT)
Message-ID: <66ffb1c2.df0a0220.1b4c87.ce13@mx.google.com>
X-Google-Original-Message-ID: <Zv-xvFed138JItAj@Ansuel-XPS.>
Date: Fri, 4 Oct 2024 11:13:32 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [net PATCH 2/2] net: phy: Skip PHY LEDs OF registration for
 Generic PHY driver
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
 <20241003221006.4568-2-ansuelsmth@gmail.com>
 <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>

On Fri, Oct 04, 2024 at 12:50:39AM +0200, Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 12:10:05AM +0200, Christian Marangi wrote:
> > It might happen that a PHY driver fails to probe or is not present in
> > the system as it's a kmod. In such case the Device Tree might have LED
> > entry but the Generic PHY is probed instead.
> > 
> > In this scenario, PHY LEDs OF registration should be skipped as
> > controlling the PHY LEDs is not possible.
> > 
> > Tested-by: Daniel Golle <daniel@makrotopia.org>
> > Cc: stable@vger.kernel.org
> > Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/phy_device.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 499797646580..af088bf00bae 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -3411,6 +3411,11 @@ static int of_phy_leds(struct phy_device *phydev)
> >  	struct device_node *leds;
> >  	int err;
> >  
> > +	/* Skip LED registration if we are Generic PHY */
> > +	if (phy_driver_is_genphy(phydev) ||
> > +	    phy_driver_is_genphy_10g(phydev))
> > +		return 0;
> 
> Why fix it link this, when what you propose for net-next, that the drv
> ops must also exist, would fix it.
> 
> I don't see any need to special case genphy.
>

While the patch in net-next fix a broken condition (PHY driver exist but
doesn't have LEDs OPs), this account a much possible scenario.

It's totally ok if the PHY driver is not loaded and we fallback to the
Generic PHY and there are LEDs node.

This is the case with something like
ip link set eth0 down
rmmod air_en8811h
ip link set eth0 up

On this up, the Generic PHY is loaded and LEDs will wrongly be
registered. We should not add the LED to the phydev LEDs list.

Do you think this logic is wrong and we should print a warning also in
this case? Or should we bite it and just return 0 with no warning at
all? (again my concern is the additional LEDs entry in sysfs that won't
be actually usable as everything will be rejected)

-- 
	Ansuel

