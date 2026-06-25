Return-Path: <stable+bounces-268286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jSOlBErWPGpgtAgAu9opvQ
	(envelope-from <stable+bounces-268286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:18:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B916C34D5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268286-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268286-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B204C302BCED
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 07:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A135F16F;
	Thu, 25 Jun 2026 07:18:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9767212564;
	Thu, 25 Jun 2026 07:18:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371906; cv=none; b=F3zUQqvSIrdkmK8T8+RO38al2zGCDmcYdgLflWCHyJ9waXub2/Hkvewl8qlrUDZxr+OBZEJJp36P3FUJnTawl3q4NWX04Dtxiyf6dTLd3xA1Ee702SgXzQQci0RixRfSMfqbV1j6jZ0HD23szsHsgks9Q98EOjVX+94cnZG4CSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371906; c=relaxed/simple;
	bh=sJ+CCPF0CYyGnCSQxtoQ9+ZKYBlQ0GV4hzUB+BKi3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQLfjMJ3MiF5KLRQd/BZ3DIZhWlc3m6OoYtiRKJpV77hxIlHLLgpQrkd3oFSHn1rmsbaIVYkX0M1/PQ4GryBDJ5vFys3s4Cauxi4GaloQSSn5TT0dkSKDxX9XxQd/ZbWUmlUtakPH/KKCq0yDfJHjb8NTjxR3d4maZSON8cxC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2961520066B;
	Thu, 25 Jun 2026 09:18:23 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wceLv-004YMz-0G;
	Thu, 25 Jun 2026 09:18:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wceLu-0000000DGBy-42LG;
	Thu, 25 Jun 2026 09:18:22 +0200
Date: Thu, 25 Jun 2026 09:18:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vincent Jardin <vjardin@free.fr>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <ajzWPi3L8MjyrKfo@pengutronix.de>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-268286-lists,stable=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:vjardin@free.fr,m:kernel@pengutronix.de,m:andi.shyti@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:wsa@kernel.org,m:kaushalkernelmailinglist@gmail.com,m:shawn.guo@freescale.com,m:stefan.eichenberger@toradex.com,m:linux-i2c@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[free.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66B916C34D5

On Mon, May 25, 2026 at 06:43:14PM +0200, Vincent Jardin wrote:
> i2c-imx rejects a SMBus Block Read byte count of 0 (valid per SMBus 3.1
> 6.5.7) and it returns without a NACK+STOP, leaving the target
> holding SDA so the bus is stuck until a power cycle occur.
> 
> The same bug is occuring with two independently introduced spots, so the
> fix is two patches with their respective Fixes: tags and backport ranges:
> 
>   1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
>   2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

