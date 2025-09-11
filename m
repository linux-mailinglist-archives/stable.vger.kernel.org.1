Return-Path: <stable+bounces-179274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E5B535F4
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336481888F28
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB091342C9B;
	Thu, 11 Sep 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r769PxGr"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86865338F4E;
	Thu, 11 Sep 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601576; cv=none; b=XUwv8XhzSY5n0HpFgVHAb0ioeP76xvXhFRgDG8+wcwEUU/eXRRfoKrLLEA/lK31cq6btypbTBb9kLAMAlZMcQ3ANiivAID79hjUmHl9P7c4dRevcbL0O1EZSNYpImIEupUBkY1eamisHn34oeHQm+omPDeTadhYfQCrOk88k/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601576; c=relaxed/simple;
	bh=mPhRSz02axb+92Rdqq5SC3Csl0OIf9zO1JftDdB061w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkGSlMZLOtvijB+G//aDrUSikX1YOvwDkC6Fst/Mlyzv7UN4xNIIqrdnA1+Pzx/vpFu0hOwUSSAElj/yPTLVEsqqg5D9MbSJide/dXJXXwsxOGtNzXUr+AD5Su7PRJ+sDjnuPv5PmSsnpgr3WF14/TcF6DN3xZ/hfn3V83yaKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r769PxGr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VeF93NLQYati3cJU4QRm7yhxeHlkMwFBcqHspj8dzm8=; b=r769PxGraMr7edBlBl3w5COYwA
	PgRQDWnmRPr6Rc/G9jnT0MqljaRIo4oiEVXWAnq5xce8kTKUu01qlJkKIElfQWRK8kL2LQpNltRZv
	WHSfXSUDk4liMET5ouUHb935XWjHX1b7Dd+jcF+W0o/kIHx9Bv/X/h3a7SLCrVieDy1p/fcrz8JrG
	PBD8RWUG6yunwi9moF6PZyJqtw9CZafMEmEKo8t79S0DSrG6IhfgLfE6IxQIVzVylMTlqcPpUaOw4
	dAMI1l0zwKh+xOYTRW3gJbcVOJjV9gzaVc+G97ADOQ2uBErKFpXt8XJHoDB/D1Rtps70N6TGl9Q+p
	Z+hTrM2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwiSK-000000003Cw-3C4A;
	Thu, 11 Sep 2025 15:39:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwiSG-000000002QC-2K8T;
	Thu, 11 Sep 2025 15:39:20 +0100
Date: Thu, 11 Sep 2025 15:39:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 03:58:50PM +0200, Marek Szyprowski wrote:
> On 08.09.2025 13:26, Oleksij Rempel wrote:
> > Drop phylink_{suspend,resume}() from ax88772 PM callbacks.
> >
> > MDIO bus accesses have their own runtime-PM handling and will try to
> > wake the device if it is suspended. Such wake attempts must not happen
> > from PM callbacks while the device PM lock is held. Since phylink
> > {sus|re}sume may trigger MDIO, it must not be called in PM context.
> >
> > No extra phylink PM handling is required for this driver:
> > - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
> > - ethtool/phylib entry points run in process context, not PM.
> > - phylink MAC ops program the MAC on link changes after resume.
> >
> > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> > Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> 
> This patch landed in today's linux-next as commit 5537a4679403 ("net: 
> usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM 
> wakeups"). In my tests I found that it breaks operation of asix ethernet 
> usb dongle after system suspend-resume cycle. The ethernet device is 
> still present in the system, but it is completely dysfunctional. Here is 
> the log:
> 
> root@target:~# time rtcwake -s10 -mmem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Sep 11 13:02:23 2025
> PM: suspend entry (deep)
> Filesystems sync: 0.002 seconds
> Freezing user space processes
> Freezing user space processes completed (elapsed 0.003 seconds)
> OOM killer disabled.
> Freezing remaining freezable tasks
> Freezing remaining freezable tasks completed (elapsed 0.024 seconds)
> ...
> usb usb1: root hub lost power or was reset
> ...
> usb usb2: root hub lost power or was reset
> xhci-hcd xhci-hcd.7.auto: xHC error in resume, USBSTS 0x401, Reinit
> usb usb3: root hub lost power or was reset
> usb usb4: root hub lost power or was reset
> asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
> asix 2-1:1.0 eth0: Failed to enable software MII access
> asix 2-1:1.0 eth0: Failed to read reg index 0x0000: -113
> asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
> asix 2-1:1.0 eth0: Failed to enable software MII access
> ... (the above error repeated many times)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9 at drivers/net/phy/phy.c:1346 
> _phy_state_machine+0x158/0x2d0
> phy_check_link_status+0x0/0x140: returned: -110

I'm not surprised. I'm guessing phylib is using polled mode, and
removing the suspend/resume handling likely means that it's at the
mercy of the timings of the phylib state machine running (which is
what is complaining here) vs the MDIO bus being available for use.

Given that this happens, I'm convinced that the original patch is
the wrong approach. The driver needs the phylink suspend/resume
calls to shutdown and restart phylib polling, and the resume call
needs to be placed in such a location that the MDIO bus is already
accessible.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

