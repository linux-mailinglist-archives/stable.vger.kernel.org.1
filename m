Return-Path: <stable+bounces-137000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB98AA03BB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 08:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB64188CCBF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF275274FF7;
	Tue, 29 Apr 2025 06:51:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D441FBE8C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909481; cv=none; b=o5wVAGvwsCkAPsfMAZOkQyak4kfaPiDl4fFO3GJmFZGPM+Ouv+N1LMHkyY+Pz2Ewq5WUvlFYj4C1RmuknsNVUILqZshA3KB7hh9cEJMwG7mEVrbwEW0TfkN9gDUP/5NaWJXCMo86/sF/uD33+qMV2ersgdoQnKmaq55yZHunM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909481; c=relaxed/simple;
	bh=ng4cdubXRoHSOfNaikV2yHk9smMLtTiFP7fxNeNmUIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEKo/cgE2y4UlUHXHdLAcDQjlIGl38ZVncjky90SWAxOvB4+C1qbd0ZxEH6eTRVna8KVOjki0d7g+Txv25B85Sa8fsnjaUXYk/J2+7q+QSI1SgUqHQNXhVe7iq2HDZqZCCnF3H6GZctqTefCE8NIN9lNSkpuWAp+dINJbHHwQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9eo6-0000oM-Lq; Tue, 29 Apr 2025 08:51:06 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9eo4-000DdC-2u;
	Tue, 29 Apr 2025 08:51:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9eo4-00An2G-2X;
	Tue, 29 Apr 2025 08:51:04 +0200
Date: Tue, 29 Apr 2025 08:51:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/2] net: dsa: microchip: let phylink manage PHY
 EEE configuration on KSZ switches
Message-ID: <aBB22NnNE4p6isiC@pengutronix.de>
References: <20250428125119.3414046-1-o.rempel@pengutronix.de>
 <20250428125119.3414046-2-o.rempel@pengutronix.de>
 <4d8a3e79-f454-4e2f-9362-c842354b123a@lunn.ch>
 <aA_DyKw8AVPdmu-Y@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aA_DyKw8AVPdmu-Y@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Mon, Apr 28, 2025 at 08:07:04PM +0200, Oleksij Rempel wrote:
> On Mon, Apr 28, 2025 at 06:51:19PM +0200, Andrew Lunn wrote:
> > > +/**
> > > + * ksz_phylink_mac_disable_tx_lpi() - Dummy handler to disable TX LPI
> > > + * @config: phylink config structure
> > > + *
> > > + * For ports with integrated PHYs, LPI is managed internally by hardware.
> > 
> > Could you expand that.
> > 
> > Does it mean the hardware will look at the results of the autoneg and
> > disable/enable LPI depending on those results?
> 
> Yes.
> 
> > I also assume this means it is not possible to force LPI on/off, independent
> > of autoneg?
> 
> Correct. set_eee call in this driver is filtering (tx_lpi == false) to
> reflect HW functionality.

I'll update this patch to include this information.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

