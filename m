Return-Path: <stable+bounces-179046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F372FB4A34A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 09:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46A33A44FF
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A001F63CD;
	Tue,  9 Sep 2025 07:17:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B4238C29
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402261; cv=none; b=FdQffXF1Lnm5z4HR5hgIar6AG7U1R8tXcVVXinYnqpWrphtAQo2sNzJbyOSUHihx7yXLg7JTPtBpya6RpICSBsuqn33Mf4b/Y18usCbCNiJlP1gRF8DJh5/wKBouqINgA1Zz0r2IE89MpQ3ZWhf6tyqBm1L6mwol1KSrWl96+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402261; c=relaxed/simple;
	bh=xcbuBAIcV7PYG4iVvgt6Hx4JudC8RwH/H+Q+eNBFY44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfmfBwIzSWytLzvLO7NDCFeyu9OfVn2eeNStY2FWzYg2kc1kqOZNF1CfJFavcpQwqn2ip4DWFj1iWxkEoz/1h4ZksmWBaYGqN76tJhMm761Fc63SlS27IIKX3fqQyM4ZOBzS0jd8Hku6mEcnkNxMkVRQB4IsF1cdKrAyzS900Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsbO-0003x4-SX; Tue, 09 Sep 2025 09:17:18 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsbN-000Nkg-0l;
	Tue, 09 Sep 2025 09:17:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsbN-00DwzJ-0J;
	Tue, 09 Sep 2025 09:17:17 +0200
Date: Tue, 9 Sep 2025 09:17:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <aL_UfST0Q3HrSEtM@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Mon, Sep 08, 2025 at 07:00:09PM +0200, Hubert Wiśniewski wrote:
> On Mon Sep 8, 2025 at 1:26 PM CEST, Oleksij Rempel wrote:
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
> 
> Thanks for the patch! Applied to v6.17-rc5, it fixes the problem for me.
> 
> Tested-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>

Thank you for testing!

> > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> 
> It does, but v5.15 (including v5.15.191 LTS) is affected as well, from
> 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC"). I think
> it could also use a patch, but I won't insist.

Ack, I'll try do address it later.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

