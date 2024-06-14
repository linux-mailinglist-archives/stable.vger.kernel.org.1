Return-Path: <stable+bounces-52148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F5908420
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42F71C20DBC
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3236136E09;
	Fri, 14 Jun 2024 07:01:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579717C72
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348494; cv=none; b=IskHnHmTB+FmFJa9pw0NC+TqNr1Piu+c0d6FYZtxn4RS9kCwQEkE8IbiURH1yqWSWH/FGJucOwBG+AN9HGLRJ4UUCIzLQjIbyMlbGjnf30PYZgn9GSi7gL/Mjqmz495Pkn/WvpDkw/xcHhWk/Ci9XiAcVF2I24M6TBY5q96vZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348494; c=relaxed/simple;
	bh=f+47wVGcuysOXwCj/07vA1XG0M+Mix+78gdu2z03d+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjNHU4y3hkl0YhJJoIGNzyECJEgCG1WNcDeojt9W0Zn+ZcoJk9L7ucXVUHgIaNIUEmOp5yegnUNCIQ3seRKf4iOL5zGQ3lBBBqmGRWwHdoUncl6irsOjPDANinG61YBb09PauS1BGwLgfQPS4borOQ8xOxFTpAtVzfV5at4LDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sI0w9-0004Jv-JE; Fri, 14 Jun 2024 09:01:25 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sI0w7-002Cwf-Q0; Fri, 14 Jun 2024 09:01:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sI0w7-00ALq4-2I;
	Fri, 14 Jun 2024 09:01:23 +0200
Date: Fri, 14 Jun 2024 09:01:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 2/2] net: phy: dp83tg720: get initial master/slave
 configuration
Message-ID: <Zmvqw-GtKsSNFQsr@pengutronix.de>
References: <20240613183034.2407798-1-o.rempel@pengutronix.de>
 <20240613183034.2407798-2-o.rempel@pengutronix.de>
 <f88abfe3-a66c-4e65-b627-7adf7f04580f@lunn.ch>
 <ZmvTS9YI8LACJOND@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmvTS9YI8LACJOND@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Fri, Jun 14, 2024 at 07:21:15AM +0200, Oleksij Rempel wrote:
> On Thu, Jun 13, 2024 at 09:33:01PM +0200, Andrew Lunn wrote:
> > On Thu, Jun 13, 2024 at 08:30:34PM +0200, Oleksij Rempel wrote:
> > > Get initial master/slave configuration, otherwise ethtool
> > > wont be able to provide this information until link is
> > > established. This makes troubleshooting harder, since wrong
> > > role configuration would prevent the link start.
> > 
> > I looked at how genphy_c45_read_status() works. If we have
> > phydev->autoneg == AUTONEG_ENABLE then genphy_c45_baset1_read_status()
> > is called which sets phydev->master_slave_get. If not AUTONEG_ENABLE
> > it calls genphy_c45_read_pma() which ends up calling
> > genphy_c45_pma_baset1_read_master_slave().
> > 
> > So it seems like the .read_status op should be setting master/slave
> > each time it is called, and not one time during .config_init.
> > 
> > What do you think?
> 
> Yes, you are right. I verified it:
> In case of this driver, .config_init will be executed every time no link
> is detected over phy_init_hw() call. If link is detected
> genphy_c45_pma_baset1_read_master_slave() is called directly.
> It is not directly visible but read_master_slave() will be executed on
> every  .read_status.

Hm.. on other hand. Since the configuration state is readed only on
init and reset, we will see on user space side only default state not updated
after config_aneg().

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

