Return-Path: <stable+bounces-179311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A5B53D43
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 22:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFFC1C8049A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA42D248D;
	Thu, 11 Sep 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nDousAk5"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2532DC775;
	Thu, 11 Sep 2025 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623614; cv=none; b=F2LckAbINULk8prR9l/veNvnOZAl6HtF+PAY8otMW0ftfX3LvQzkKqe1TuLRK4KUnaDYps5NspmoypUKyadPFWi/Cgffc11I8IT9j8KO0PXZxl/m0OECSDummh2jz/zBnu/ocbV2h1IKfrAXuKCVboA+2ehRf/k9/4yPl5WkSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623614; c=relaxed/simple;
	bh=1isUSRl5kbt6ekppmtJi/xrvSMndt1O8ZLVTprW8rA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgsGxhx3lO2CcVh+8eC/4zfzXT+3Vqsty1WnCsoG4Xefk1/BpGrAPN22YOCT91wPrflbFlx3f6e+P6b9oprvQRnkLftaTspU4fqJ5yVJ91Y1RkMknHy0NQWNVAcT5erBdeRcfcH0mTdfws17vP6EPX1sX9UDf2Gl0jZVo3SDfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nDousAk5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0YBafjYQdiIF2lXwZ2cx5VVofHoYSwzD6di7O2ITSYc=; b=nDousAk5HazAghqDWfgpvEpO5x
	RLwZkEqcCOA+PvSA5gFNirWB3ViumIJgXrbbfEmzi7/SPhW0MmMX7bTy+Y0WTB4D00j+1KNl51XeQ
	C4H0o/Le39tpc23S1YG9PhU5IQ7vi98pTtkOTYXFmpTsFaw+J4nKv+y6CBAFwbMMwq1JMZy62opvI
	qNpTUR48Dzy0Zl8nL0Q7F4UB8VakYvcJDX4S6IT81bsjPS/qUtitEo2biOXLweEQln2OOJsy23ZHw
	9fSMsh4+i4FM6Rj9PjI7vCk2RQI1eRiYZ0h8Bg+CyassYU5IFYVToE4cbeGnjTTO7S3D48JmyBT10
	L1ZGQ4dw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32794)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwoBl-000000003aE-3osZ;
	Thu, 11 Sep 2025 21:46:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwoBg-000000002g5-04Xg;
	Thu, 11 Sep 2025 21:46:36 +0100
Date: Thu, 11 Sep 2025 21:46:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911075513.1d90f8b0@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 07:55:13AM -0700, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 15:39:20 +0100 Russell King (Oracle) wrote:
> > I'm not surprised. I'm guessing phylib is using polled mode, and
> > removing the suspend/resume handling likely means that it's at the
> > mercy of the timings of the phylib state machine running (which is
> > what is complaining here) vs the MDIO bus being available for use.
> > 
> > Given that this happens, I'm convinced that the original patch is
> > the wrong approach. The driver needs the phylink suspend/resume
> > calls to shutdown and restart phylib polling, and the resume call
> > needs to be placed in such a location that the MDIO bus is already
> > accessible.
> 
> We keep having issues with rtnl_lock taken from resume.
> Honestly, I'm not sure anyone has found a good solution, yet.
> Mostly people just don't implement runtime PM.
> 
> If we were able to pass optional context to suspend/resume
> we could implement conditional locking. We'd lose a lot of
> self-respect but it'd make fixing such bugs easier..

Normal drivers have the option of separate callbacks for runtime PM
vs system suspend/resume states. It seems USB doesn't, just munging
everything into one pair of suspend and resume ops without any way
of telling them apart. I suggest that is part of the problem here.

However, I'm not a USB expert, so...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

