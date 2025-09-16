Return-Path: <stable+bounces-179687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF0B58EF6
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A93BA9EC
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77201BD9CE;
	Tue, 16 Sep 2025 07:18:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FA5227
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007111; cv=none; b=TX437Gr6zM56APQHnoULCkg4mUiz1QLDraSoF+RvUxERX8T0hXNoSKZ0tySTZZQhwhUgxItyKpDEnhFXJTr3meUtJwVMVi6BBIsDnbfnn/MQd8+eIjUHW7zqtV2pSj6wLJFHQvzBa+/6jS/UbVUs/wDEZWbuoih3oi9h9WRM86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007111; c=relaxed/simple;
	bh=/n5L0zuim9T9324maodQZtpPeiOd0fceXfQP+n+Thx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ4KlGXeP7Bgk1m8HOiAjvAgDVPG4iEgxEzVwG++VDedyssr+biEsiBP0MFaZQNSvEr0UB+NtLVZrAZYMfoW7SEoTkymI2tx8aVYzXYeoJLjbHa6dbPGj8oJT1HSwkpkuWajRvqYU77+MXYEKil/sRpY64T/d5EUs+PqoKak8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyPx6-0007Fb-L3; Tue, 16 Sep 2025 09:18:12 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyPx4-001Y7t-0T;
	Tue, 16 Sep 2025 09:18:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyPx3-00BTqe-3A;
	Tue, 16 Sep 2025 09:18:10 +0200
Date: Tue, 16 Sep 2025 09:18:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
Message-ID: <aMkPMa650kfKfmF4@pengutronix.de>
References: <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
 <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
 <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
 <aMPawXCxlFmz6MaC@shell.armlinux.org.uk>
 <a25b24ec-67bd-42b7-ac7b-9b8d729faba4@rowland.harvard.edu>
 <aMQwQAaoSB0Y0-YD@shell.armlinux.org.uk>
 <aMUS8ZIUpZJ4HNNX@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMUS8ZIUpZJ4HNNX@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Sat, Sep 13, 2025 at 08:45:05AM +0200, Oleksij Rempel wrote:
> On Fri, Sep 12, 2025 at 03:37:52PM +0100, Russell King (Oracle) wrote:
> > On Fri, Sep 12, 2025 at 10:29:47AM -0400, Alan Stern wrote:
> > > On Fri, Sep 12, 2025 at 09:33:05AM +0100, Russell King (Oracle) wrote:
> > > > On Thu, Sep 11, 2025 at 10:30:09PM -0400, Alan Stern wrote:
> > > > > The USB subsystem uses only one pair of callbacks for suspend and resume 
> > > > > because USB hardware has only one suspend state.  However, the callbacks 
> > > > > do get an extra pm_message_t parameter which they can use to distinguish 
> > > > > between system sleep transitions and runtime PM transitions.
> > > > 
> > > > Unfortunately, this isn't the case. While a struct usb_device_driver's
> > > > suspend()/resume() methods get the pm_message_t, a struct usb_driver's
> > > > suspend()/resume() methods do not:
> > > > 
> > > > static int usb_resume_interface(struct usb_device *udev,
> > > >                 struct usb_interface *intf, pm_message_t msg, int reset_resume)
> > > > {
> > > >         struct usb_driver       *driver;
> > > > ...
> > > >         if (reset_resume) {
> > > >                 if (driver->reset_resume) {
> > > >                         status = driver->reset_resume(intf);
> > > > ...
> > > >         } else {
> > > >                 status = driver->resume(intf);
> > > > 
> > > > vs
> > > > 
> > > > static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
> > > > {
> > > >         struct usb_device_driver        *udriver;
> > > > ...
> > > >         if (status == 0 && udriver->resume)
> > > >                 status = udriver->resume(udev, msg);
> > > > 
> > > > and in drivers/net/usb/asix_devices.c:
> > > > 
> > > > static struct usb_driver asix_driver = {
> > > > ...
> > > >         .suspend =      asix_suspend,
> > > >         .resume =       asix_resume,
> > > >         .reset_resume = asix_resume,
> > > > 
> > > > where asix_resume() only takes one argument:
> > > > 
> > > > static int asix_resume(struct usb_interface *intf)
> > > > {
> > > 
> > > Your email made me go back and check the code more carefully, and it 
> > > turns out that we were both half-right.  :-)
> > > 
> > > The pm_message_t argument is passed to the usb_driver's ->suspend 
> > > callback in usb_suspend_interface(), but not to the ->resume callback in 
> > > usb_resume_interface().  Yes, it's inconsistent.
> > > 
> > > I suppose the API could be changed, at the cost of updating a lot of 
> > > drivers.  But it would be easier if this wasn't necessary, if there was 
> > > some way to work around the problem.  Unfortunately, I don't know 
> > > anything about how the network stack handles suspend and resume, or 
> > > what sort of locking it requires, so I can't offer any suggestions.
> > 
> > I, too, am unable to help further as I have no bandwidth available
> > to deal with this. Sorry.
> 
> Thanks for all the valuable input.
> 
> I’ll process the feedback and investigate possible ways to proceed. As a
> first step I’ll measure the actual power savings from USB auto-suspend
> on AX88772 to see if runtime PM is worth the added complexity.

I ran quick power measurements to check whether USB autosuspend is worth the
added complexity.

Meaning:
- "admin up/down" = ip link set dev <if> up/down.
- No link partner was attached, so the physical link was down in all tests.

Setups:
- Debian 5.10 (USB autosuspend present, no phylib).
- Debian 6.1 (phylib present, no regression).
- Power meter: Fnirsi FNB58.
- Env: QEMU 9.2.1 (USB passthrough)
       xHCI host Intel 100/C230
       device ASIX AX88772B (0b95:772b)

Legend:
- "RT: active" = runtime PM on;
- "RT: suspended" = runtime PM auto (device suspended).

Results:
- Kernel 5.10.237-1
  admin up (link down): 0.453 W (RT: active)
  admin down: 0.453 W (RT: active)
  admin down: 0.453 W (RT: suspended)

- Kernel 6.1.148-1
  admin up (link down): 0.453 W (RT: active)
  admin down: 0.248 W (RT: active)
  admin down: 0.248 W (RT: suspended)

Observations:
In this setup, USB autosuspend did not reduce power further (admin-down power
is identical with/without autosuspend).

The drop from ~0.453 W -> ~0.248 W on 6.1 appears to come from the phylib
migration (PHY powered down on admin-down), not from autosuspend.

Proposal:
Given autosuspend brings no measurable benefit here, and it hasn’t been
effectively functional for this device in earlier kernels, I suggest a minimal
-stable patch that disables USB autosuspend for ASIX driver to avoid the
PM/RTNL/MDIO issues. If someone needs autosuspend-based low-power later, they
can implement a proper device low-power sequence and re-enable it.

Would this minimal -stable patch be acceptable?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

