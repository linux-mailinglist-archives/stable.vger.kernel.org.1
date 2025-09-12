Return-Path: <stable+bounces-179373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD6B551FC
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A9C5A1A20
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3E30214B;
	Fri, 12 Sep 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aFT/2EW8"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9DD3128AF;
	Fri, 12 Sep 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687894; cv=none; b=a5h4SVXsZ9G7bBP+LT3P/GkPAOwfnaryd/sOS7RpCMdggF6FeWnhEYcOC6Kzj+s+gcrDfmf/o/7cyAku5OFPgieRyrF9St7YIzDi+kQmh23tWyHrgwPPCYzYjgVrrzlX35hXbJgGEnyF/toNlibO+iALbvtaZJ+V3Re0xbZW2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687894; c=relaxed/simple;
	bh=+W9RkNkmmT1IiTtBnRQIf0vW4aRt3gzcijwo74OaTUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxD9ITJzvsmsQl6kzHhOHc/8XNBPsB/r3UFXneOaHgD/aVyGgiJzpjsOQW3hl2kR2+7GlGPXtnIKs2HQNdCebAnf2tY28IEofK4BsXvl8rBkuae+MFgcpo4nnqF/UOm77/ZRDI4DocYCtyxGT3OBbgpz4Yb2GTWWYZ7bYMgbegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aFT/2EW8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KqBKUZlM/P2XIZmldzfqFf87P0LiDauesCM5frm4wHM=; b=aFT/2EW8+DdbUF9V9Qseem00aq
	TKs/hvQR3QWDTBkaq6UvjrdPvBvBTAu1IbZOng6qIKS58tCRLOhFgdsMyztFvTGf/rtswHIbWnGCL
	BZ7l4RDv+5NK2eDycPi+DVEuTxHcYKAjNU6kJ02nGhu93bMTq6j1rz3jWpz83Lw6AI8N/dUA2JzFt
	j+OQEJdOEIMaaEa8pOOhvIPwGc5PDjjUiDfjg2KABjPJxrsJqApXFvWjH29BDxTA3E60fe755FaPg
	C/3FkTHnZwWYk8tnDcI9tfNsAdfKbM9o0dxnXeA0BuFGhpPMAi/1Okcl5Beu7wFDw9ZDCdhSPecfq
	4XopNUTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38276)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ux4uT-000000004j2-1wjo;
	Fri, 12 Sep 2025 15:37:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ux4uO-000000003Za-2uZp;
	Fri, 12 Sep 2025 15:37:52 +0100
Date: Fri, 12 Sep 2025 15:37:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
Message-ID: <aMQwQAaoSB0Y0-YD@shell.armlinux.org.uk>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
 <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
 <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
 <aMPawXCxlFmz6MaC@shell.armlinux.org.uk>
 <a25b24ec-67bd-42b7-ac7b-9b8d729faba4@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25b24ec-67bd-42b7-ac7b-9b8d729faba4@rowland.harvard.edu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 12, 2025 at 10:29:47AM -0400, Alan Stern wrote:
> On Fri, Sep 12, 2025 at 09:33:05AM +0100, Russell King (Oracle) wrote:
> > On Thu, Sep 11, 2025 at 10:30:09PM -0400, Alan Stern wrote:
> > > The USB subsystem uses only one pair of callbacks for suspend and resume 
> > > because USB hardware has only one suspend state.  However, the callbacks 
> > > do get an extra pm_message_t parameter which they can use to distinguish 
> > > between system sleep transitions and runtime PM transitions.
> > 
> > Unfortunately, this isn't the case. While a struct usb_device_driver's
> > suspend()/resume() methods get the pm_message_t, a struct usb_driver's
> > suspend()/resume() methods do not:
> > 
> > static int usb_resume_interface(struct usb_device *udev,
> >                 struct usb_interface *intf, pm_message_t msg, int reset_resume)
> > {
> >         struct usb_driver       *driver;
> > ...
> >         if (reset_resume) {
> >                 if (driver->reset_resume) {
> >                         status = driver->reset_resume(intf);
> > ...
> >         } else {
> >                 status = driver->resume(intf);
> > 
> > vs
> > 
> > static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
> > {
> >         struct usb_device_driver        *udriver;
> > ...
> >         if (status == 0 && udriver->resume)
> >                 status = udriver->resume(udev, msg);
> > 
> > and in drivers/net/usb/asix_devices.c:
> > 
> > static struct usb_driver asix_driver = {
> > ...
> >         .suspend =      asix_suspend,
> >         .resume =       asix_resume,
> >         .reset_resume = asix_resume,
> > 
> > where asix_resume() only takes one argument:
> > 
> > static int asix_resume(struct usb_interface *intf)
> > {
> 
> Your email made me go back and check the code more carefully, and it 
> turns out that we were both half-right.  :-)
> 
> The pm_message_t argument is passed to the usb_driver's ->suspend 
> callback in usb_suspend_interface(), but not to the ->resume callback in 
> usb_resume_interface().  Yes, it's inconsistent.
> 
> I suppose the API could be changed, at the cost of updating a lot of 
> drivers.  But it would be easier if this wasn't necessary, if there was 
> some way to work around the problem.  Unfortunately, I don't know 
> anything about how the network stack handles suspend and resume, or 
> what sort of locking it requires, so I can't offer any suggestions.

I, too, am unable to help further as I have no bandwidth available
to deal with this. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

