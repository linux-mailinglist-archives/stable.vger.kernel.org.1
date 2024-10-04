Return-Path: <stable+bounces-80740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFE9904B2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC051F22476
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1FE212EE0;
	Fri,  4 Oct 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RdYf4yZF"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE521019A;
	Fri,  4 Oct 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049484; cv=none; b=khLBIuMgNaAjKinAsAt2OW8fXmx4Fm3BsBQPdWeb6vjLvA6JBVW7ITUm38m/0hb4rlbIYhYc5LxyIyuotqnqRgATcyR/cnOyWeoGF/r/ZOjQ83MZhniqMgTsM0rxx/x87IfSsRN4ANMDNWtZ46yWbOuPn9Bizb2kPnVlo31AD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049484; c=relaxed/simple;
	bh=nFkpUBaSkOjroiOgtmi/s2NOYwCeHe9+t0TpqsxGNP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW3TbVoGzfcsb+47EWNexoFG7HvU2NxbSDQOkzn45+LvQLY7N6fslqyzhERSuulIfA1YB9S1WtzJ0osNnvncNvYYbMPWsupaVaY/AHXryoB6Iawy22L4GZSRU7eLDAoiAcLXgAbM1ZevTK44Djr6meEBPCMM1JxvFaYQaXafdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RdYf4yZF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j4MR7MK6UIoUL6xo7ckBr43ZKx+btlvoJgILcC51T50=; b=RdYf4yZFwPCSEdhvCuQoBha7Wo
	4L876ajhLK0PqZvjEg3Skh0Fdo44uiLebbLdWVEVOmOGTJM8MgUID4vj07yzB2L06aCp6VqgNcnDG
	c5JEk9nWNKpRez3GxRRfUF29DaZmEVwJ/ClVQFvl5sQyjYSLbsNyhjr1GDFDu0Im5WOU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swibh-00938d-7f; Fri, 04 Oct 2024 15:44:33 +0200
Date: Fri, 4 Oct 2024 15:44:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <a463ca8c-ebd7-4fd4-98a9-bc869a92548c@lunn.ch>
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
 <20241003221006.4568-2-ansuelsmth@gmail.com>
 <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>
 <66ffb1c2.df0a0220.1b4c87.ce13@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ffb1c2.df0a0220.1b4c87.ce13@mx.google.com>

> While the patch in net-next fix a broken condition (PHY driver exist but
> doesn't have LEDs OPs), this account a much possible scenario.
> 
> It's totally ok if the PHY driver is not loaded and we fallback to the
> Generic PHY and there are LEDs node.
> 
> This is the case with something like
> ip link set eth0 down
> rmmod air_en8811h
> ip link set eth0 up
> 
> On this up, the Generic PHY is loaded and LEDs will wrongly be
> registered. We should not add the LED to the phydev LEDs list.
> 
> Do you think this logic is wrong and we should print a warning also in
> this case? Or should we bite it and just return 0 with no warning at
> all? (again my concern is the additional LEDs entry in sysfs that won't
> be actually usable as everything will be rejected)

We should not add LEDs which we cannot drive. That much is clear to
me.

I would also agree that LEDs in DT which we cannot drive is not
fatal. So the return value should be 0.

The only really open point is phydev_err(), phydev_warn() or
phydev_dbg(). Since it is not fatal, phydev_err() is wrong. I would
probably go with phydev_dbg(), to aid somebody debugging why the LEDs
don't appear in some conditions.

	Andrew

