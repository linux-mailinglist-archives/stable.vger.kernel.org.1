Return-Path: <stable+bounces-179155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9400B50CB4
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 06:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A1A4479FA
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C6C26C3AA;
	Wed, 10 Sep 2025 04:11:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D0199BC
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477484; cv=none; b=tBsq9K45rrDidct5KN6jv4rYc977Y+HWlvi3lRa4/LsRAUIcxyqzPuSSth+rLAoF/+fi6m5RXOpqn4Pa7TKVFaVefxdgVRTvirDzeNnhrczQCSnonfsn6XHQFpUjGXzO3PA58KrU1hpFVa3GDx/83nylWScmmN0r9XZr9Ewklbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477484; c=relaxed/simple;
	bh=wRUWATM/WMZT06XdJ8eJgyBbBSLZQwQeTuNuKYdkiOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs8iqMya9Gz2EVJKi4IbTwuX+IbRoDjgTF13UFNzuYbRrhTven7uKihnmvmpR7xYGg2XCCwmEaXwf5sRYYM9awqPZPas8InxgomOGarwhftRNtCCWycZTJ24FdfkDXHwF1sxvXgl0PYog0A+XouzHbL2HA5NM+k0HmPCh8JOanQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uwCAo-0003K5-22; Wed, 10 Sep 2025 06:11:10 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uwCAm-000X4H-0c;
	Wed, 10 Sep 2025 06:11:08 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uwCAm-00G731-06;
	Wed, 10 Sep 2025 06:11:08 +0200
Date: Wed, 10 Sep 2025 06:11:07 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <aMD6W80KfjcSz4In@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <20250909165803.656d3442@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909165803.656d3442@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Tue, Sep 09, 2025 at 04:58:03PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 13:26:19 +0200 Oleksij Rempel wrote:
> > No extra phylink PM handling is required for this driver:
> > - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
> 
> Meaning the interface is never suspended when open?

Ack.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

