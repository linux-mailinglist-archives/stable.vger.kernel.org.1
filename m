Return-Path: <stable+bounces-182937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00674BB0744
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EB12A1A54
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2552ED860;
	Wed,  1 Oct 2025 13:20:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DC1DA62E;
	Wed,  1 Oct 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324825; cv=none; b=u0onedwJOMT0xigUuP5J14/FPWV68PLtVTCuXO5XslnP4DJ6yUXgjHej/WgfYqJP9kxEL27eqqbQr80GqJB/Ii79UhjwjYPeksqNmWiWNtGYDxgf6HD5+OvpMJ7UwAy5p53oGgDck5giISkZP/Vpt6NYmrHvHXiE/EwfIFWqfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324825; c=relaxed/simple;
	bh=Uctcsfz4nNrfaQk5rKvvDsfcCV9RMgYtVLuLHqiRaLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjjEXakmwiyeDxSVhhJ1vnQf/HCvVvHX90NddnkrlJx2DUJuSUa/ELynAQz3so7kA4L1lGZ/PU3KXcDHyG93BgrvbZJ86b28Vc/Km5l3qCSYfQKIaIBqTvFRyeBZ6Mq0X/6hOSoJSZ0iuRFAkFU7KSPrngH+ts+hCQEOuGqRi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 621F82C0A2C6;
	Wed,  1 Oct 2025 15:10:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4BEE65F82FE; Wed,  1 Oct 2025 15:10:14 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:10:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert Wi??niewski <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] net: usb: asix: hold PM usage ref to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <aN0oNgEp08BaGeTJ@wunner.de>
References: <20251001130432.2444863-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001130432.2444863-1-o.rempel@pengutronix.de>

On Wed, Oct 01, 2025 at 03:04:32PM +0200, Oleksij Rempel wrote:
> @@ -1600,6 +1624,10 @@ static struct usb_driver asix_driver = {
>  	.resume =	asix_resume,
>  	.reset_resume =	asix_resume,
>  	.disconnect =	usbnet_disconnect,
> +	/* usbnet will force supports_autosuspend=1; we explicitly forbid RPM
> +	 * per-interface in bind to keep autosuspend disabled for this driver
> +	 * by using pm_runtime_forbid().
> +	 */

Looks like this code comment needs an update, now that you're no longer
using pm_runtime_forbid()?

Thanks,

Lukas

