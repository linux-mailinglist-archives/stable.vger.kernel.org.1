Return-Path: <stable+bounces-133190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4DA91F23
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D431897379
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33124EABC;
	Thu, 17 Apr 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OXELkmMb"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C1241CBA;
	Thu, 17 Apr 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898900; cv=none; b=Ncdn1J3cvE0wQUXCTOYdyGIfcSkhHgvJ/V5+olPhor2oV3NK9QkUKdKdy0uQnBrzxRUAg7rfr7BzI0qdqzmzOXQWXINsKJjtgxcrEbAQS9zh3TlSbaVrtx7InepZB9Ow3N3db7R+YMZHtYf339e2NU+bkZnQ4tIvWen8FAy+JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898900; c=relaxed/simple;
	bh=8HQ2ILyk1/v+DMbmi1jemdXFcmYahfo3ffBlDN37T0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCEGL2lETMutQHU/fqNu+2aIbwH9PJdmZyxDSPj8CflBhMKXKZEgUpyL1rFai2g4qqqV4H5ww7FkF8VBdGsmpu8LybSM9PL6hlsrSlBc5lpUMZgx44jNXteVMR2dN2sSsrPSImnI/7pUJTqaSOqB2f2x91WL98ET7kUIrKiI9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OXELkmMb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=RGSXHdvTRkZSD37t4oi9SPpteL7kOeLJUaL/e11tDgc=; b=OX
	ELkmMb7DstUMjddyzZpTLWIfGtWss8RYuAndOzwYLwOlwrl75083oPNe/XGTQf5y6cyiR6aSyA8rl
	M1FSy/fua8LE2lDW3xvyoBPDgv3CJFVKNcD5LOomruNLfrMxj1T6ZYJjcwd5NO42jYIVmaO8ys8Pu
	upYEtm81WZpCRCg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5PuS-009n7O-3S; Thu, 17 Apr 2025 16:08:08 +0200
Date: Thu, 17 Apr 2025 16:08:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
 <aAD-RDUdJaL_sIqQ@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAD-RDUdJaL_sIqQ@gmail.com>

On Thu, Apr 17, 2025 at 02:12:36PM +0100, Qasim Ijaz wrote:
> On Tue, Apr 15, 2025 at 08:56:48PM -0700, Jakub Kicinski wrote:
> > On Tue, 15 Apr 2025 20:52:30 -0700 Jakub Kicinski wrote:
> > > On Tue, 15 Apr 2025 03:35:07 +0200 Andrew Lunn wrote:
> > > > > @@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
> > > > >  		   __func__, phy_id, loc);
> > > > >  
> > > > >  	if (phy_id != 0)
> > > > > -		return -ENODEV;
> > > > > +		return 0;    
> > > > 
> > > > An actually MDIO bus would return 0xffff is asked to read from a PHY
> > > > which is not on the bus. But i've no idea how the ancient mii code
> > > > handles this.
> > > > 
> > > > If this code every gets updated to using phylib, many of the changes
> > > > you are making will need reverting because phylib actually wants to
> > > > see the errors. So i'm somewhat reluctant to make changes like this.  
> > > 
> > > Right.
> > > 
> > > I mean most of the patches seem to be adding error checking, unlike
> > > this one, but since Qasim doesn't have access to this HW they are
> > > more likely to break stuff than fix. I'm going to apply the first
> > > patch, Qasim if you'd like to clean up the rest I think it should
> > > be done separately without the Fixes tags, if at all.
> > 
> > Ah, no, patch 1 also does return 0. Hm. Maybe let's propagate the real
> > error to silence the syzbot error and if someone with access to the HW
> 
> Hi Andrew and Jakub
> 
> Since there is uncertainty on whether these patches would break things 
> how about I refactor the patches to instead return what the function 
> already returns, this way we include error handling but maintain consistency 
> with what the function already returns and does so there is no chance of 
> breaking stuff. I think including the error handling would be a good idea
> overall because we have already seen 1 bug where the root cause is insufficient 
> error handling right? Furthermore this driver has not been updated in 4 years, 
> so for the near‑term surely improving these aspects can only be a good thing.

It is not a simple thing to decided if we should make changes or not,
if we don't have the hardware. The test robot is saying things are
potentially wrong, but we don't have any users complaining it is
broken. If we make the test robot happy, without testing the changes,
we can make users unhappy by breaking it. And that is the opposite of
what we want.

We also need to think about "return on investment". Is anybody
actually using this device still? Would it be better to spend our time
on other devices we know are actually used?

If you can find a board which actually has this device, or can find
somebody to run tests, then great, we are likely to accept them. But
otherwise please focus on minimum low risk changes which are obviously
correct, or just leave the test robot unhappy.

	Andrew

