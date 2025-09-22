Return-Path: <stable+bounces-180890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229AB8F3A1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530523B24CC
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD02F1FC3;
	Mon, 22 Sep 2025 07:11:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDE221FCC
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525097; cv=none; b=auCFyZ8KgMR00Y/H/GDnAexsikA3lY/mZH0UyczBc6Vj0qILkue71a7K8Anrz3VTnAGeYJkAv4g9N6nCma48E7TLhsVLijhAi9+vJ1brY684VPEuvnCNKhwIj0nooDEDNtTdWHgy2VEVNteHKPMCoeqA0TK7WpPWmaRE4cDpbc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525097; c=relaxed/simple;
	bh=T7Z0FIstTb2WSj8YtIHnDt3lr50hwBNXU0a3XU0hZ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeaUDpgSnXCbaK9SBejv2OG/C7XQpmoK5WJiiA9v8gYa9qB7uQmoMk3c5X3ZAvPM6t6L8bue1nLdQxS6pKlKoK80eJKi/vMHYLjWDjR2JSihfytil1X4XnIXWjoIYhtkmZ5bw1S7Bhept60LLPw2vdKxkE3tD2KLGYbkqT8GqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v0ahc-0000Ae-EZ; Mon, 22 Sep 2025 09:11:12 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v0ahZ-002YKq-2Z;
	Mon, 22 Sep 2025 09:11:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v0ahZ-006mzY-25;
	Mon, 22 Sep 2025 09:11:09 +0200
Date: Mon, 22 Sep 2025 09:11:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert Wi??niewski <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <aND2jWYm8k5sD4nV@pengutronix.de>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <aMsEyXPMVWewOmQS@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMsEyXPMVWewOmQS@wunner.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Lukas,

On Wed, Sep 17, 2025 at 08:58:17PM +0200, Lukas Wunner wrote:
> On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
> > Forbid USB runtime PM (autosuspend) for AX88772* in bind.
> [...]
> > With autosuspend active, resume paths may require calling phylink/phylib
> > (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> > resume can deadlock (RTNL may already be held), and MDIO can attempt a
> > runtime-wake while the USB PM lock is held.
> 
> FWIW, for smsc95xx.c, the MDIO deadlock issue was resolved by commit
> 7b960c967f2a ("usbnet: smsc95xx: Fix deadlock on runtime resume").
> I would assume that something similar would be possible for
> asix_devices.c as well.

thanks for the recommendation.

Right now I’m juggling two goals:
- Stable: provide a simple and robust fix with minimal risk.
- net-next: design a clean and reliable solution that keeps autosuspend
  working.

For -stable, keeping autosuspend disabled per AX88772* seems to be the
most straightforward and low-risk way to avoid the problematic
autoresume path. Autosuspend isn’t on by default in most distros anyway,
so the behavioral impact is minimal.

If we keep autosuspend enabled, the driver has to be careful about
multiple contexts:
- Runtime PM callbacks: asix_{suspend,resume,reset_resume} running under
the USB PM lock.

- System sleep/resume: asix_resume() via dpm_run_callback() workqueues (no
pm_runtime involved).

- ndo_open() path (RTNL held): usbnet_open() -> usb_autopm_get_interface()
  -> synchronous autoresume into asix_resume().

- ethtool / netlink control paths: often under RTNL, may trigger
  autoresume and/or MDIO via phylib.

- phylink/MAC ops: may touch MDIO; caller is expected to hold RTNL.

- status URB / NAPI: atomic/BH context (no sleeping, no RTNL).

If maintainers prefer attempting the smsc95xx-style change right away, I
can draft it; my preference for -stable is still the minimal forbid to
limit churn.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

