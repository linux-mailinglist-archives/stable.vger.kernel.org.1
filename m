Return-Path: <stable+bounces-179330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB8B54585
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8B2173079
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD29274B39;
	Fri, 12 Sep 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IMcAcadQ"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F9221FA8;
	Fri, 12 Sep 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666002; cv=none; b=fY6QEtr/v3xgF5Tu7wYlOagWn1i0sknsaqM1edxjaK4jPE39xQo/lXhUfsRKSRxdSU7bsq0asKLqhEPPfsuiQqDkiE7dEgdh8mYzs9Nf23YbAj/+tpUUzfpe4hu+nClSFS/tDGwhjppZkaKaNGyn8lQzr6uZ3jOgIR3orcpjWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666002; c=relaxed/simple;
	bh=Mxr62HmVtfbP4jbUBdHvnIYP+nC/oO9ivF+eEK18zmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKnPf+/9XGA0g0OHuK0UXFT1CCf63aLqtobaYLJduDjZSJXjYPuclqIVytzPhyiiZWvf0LjKXrUQRWiT9D16LNHyaaqZm6dV2sRMs/v9RFxFnfpr38H8nmZDUH8YQkGKagYSugOhxEhNOSu1RM5wX//LbrAeZKyOtozshP+SANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IMcAcadQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q2YkID527W7lqOrFnU+Vj4fmcAikRXDTUil4ImrM08E=; b=IMcAcadQP51YLAcZorEteZBCmA
	kHyIwUIejCR7dqhdjIASnNPssJcKRtuhf4SADoBZxqMzdh/7ToTfXtHTaaPOTmXFfym56ush1FBpJ
	J3+/oxD3+I4CJh3Eao7/oApSfPGhWbuY1zg7DQAkC2nf9N1BHvwCOkt5bIy8gDCgQUKorJdAwbBp7
	KMkcZrGZr6ekvAqrDC7d4OJOON2/b12yqXXz8EN+5UXla65O81da5qCqHxdlPUja2hIxO+N2qSYit
	zaaHMFzGGzb+4rD4mCRKKW5/hf+BIva2+eca3tYmQ0QsTWcJuliso1abBiaCBphTFeFm8vX0IqI2F
	KrJF13xA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52752)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwzDQ-000000004AH-2Pau;
	Fri, 12 Sep 2025 09:33:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwzDN-000000003N7-0zes;
	Fri, 12 Sep 2025 09:33:05 +0100
Date: Fri, 12 Sep 2025 09:33:05 +0100
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
Message-ID: <aMPawXCxlFmz6MaC@shell.armlinux.org.uk>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
 <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
 <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 10:30:09PM -0400, Alan Stern wrote:
> On Thu, Sep 11, 2025 at 09:46:35PM +0100, Russell King (Oracle) wrote:
> > On Thu, Sep 11, 2025 at 07:55:13AM -0700, Jakub Kicinski wrote:
> > > We keep having issues with rtnl_lock taken from resume.
> > > Honestly, I'm not sure anyone has found a good solution, yet.
> > > Mostly people just don't implement runtime PM.
> > > 
> > > If we were able to pass optional context to suspend/resume
> > > we could implement conditional locking. We'd lose a lot of
> > > self-respect but it'd make fixing such bugs easier..
> > 
> > Normal drivers have the option of separate callbacks for runtime PM
> > vs system suspend/resume states. It seems USB doesn't, just munging
> > everything into one pair of suspend and resume ops without any way
> > of telling them apart. I suggest that is part of the problem here.
> > 
> > However, I'm not a USB expert, so...
> 
> The USB subsystem uses only one pair of callbacks for suspend and resume 
> because USB hardware has only one suspend state.  However, the callbacks 
> do get an extra pm_message_t parameter which they can use to distinguish 
> between system sleep transitions and runtime PM transitions.

Unfortunately, this isn't the case. While a struct usb_device_driver's
suspend()/resume() methods get the pm_message_t, a struct usb_driver's
suspend()/resume() methods do not:

static int usb_resume_interface(struct usb_device *udev,
                struct usb_interface *intf, pm_message_t msg, int reset_resume)
{
        struct usb_driver       *driver;
...
        if (reset_resume) {
                if (driver->reset_resume) {
                        status = driver->reset_resume(intf);
...
        } else {
                status = driver->resume(intf);

vs

static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
{
        struct usb_device_driver        *udriver;
...
        if (status == 0 && udriver->resume)
                status = udriver->resume(udev, msg);

and in drivers/net/usb/asix_devices.c:

static struct usb_driver asix_driver = {
...
        .suspend =      asix_suspend,
        .resume =       asix_resume,
        .reset_resume = asix_resume,

where asix_resume() only takes one argument:

static int asix_resume(struct usb_interface *intf)
{

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

