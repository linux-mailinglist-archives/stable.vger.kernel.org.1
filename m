Return-Path: <stable+bounces-136912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB9A9F638
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA543B8A6B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B8E27FD7E;
	Mon, 28 Apr 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BqdlwEzT"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D741262FCE;
	Mon, 28 Apr 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859098; cv=none; b=m0PonB+72TkJC7wvX8bkiQOroZW+tXL3VWHnvDNjcV60B06FF0/jC4Soj/tcQUQU0vyIh1ByhH2yjbnExiB/rEXq9ECq2zhmLjc9CtS63G3JLKM5v1fqQlzbWTgYuP4mEaU0E6aux44WR0SDJnzRwixCA+MF3anJHc4dAE1wRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859098; c=relaxed/simple;
	bh=oEmUhIZbZAiYMOXn+vdBkUJvA4KYj2yAlYhV5SRxVNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+H6q+lF60pEeJ1Cg8lyago5lFkHwidK9fZWTjVsbTM41JWet3knWt72CDLJRItcw+sqUEFW2ugV5EjtkkvEYyl/9Vff1bSMXpGJIAH6zrXNCoQtYpI7dawLquGrITtwfbJj/aR48geF48vq7WKgC8IlhRM7czguGMkNcbihoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BqdlwEzT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CJS+qSb/Irxv/rV6XyY0hXCjZ08w1k6CYeop3aogqes=; b=BqdlwEzTD2qxPrV8XyBSf510EI
	H6+ZmHFaMJNLkJnpgpZ3mA00kK3Y8ob+ge9ZTgdkHPGS16Fw5UOx5O1fYeu7mA/SsHzLcZAAWea5W
	zomDoyTf7Sp2FvqiDc2/3ITWP6FywZrDC+FTd6fmzJF2w7UJLG/BQ6FsEph8pt7TM2DI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9RhP-00ArGQ-9B; Mon, 28 Apr 2025 18:51:19 +0200
Date: Mon, 28 Apr 2025 18:51:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
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
Message-ID: <4d8a3e79-f454-4e2f-9362-c842354b123a@lunn.ch>
References: <20250428125119.3414046-1-o.rempel@pengutronix.de>
 <20250428125119.3414046-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428125119.3414046-2-o.rempel@pengutronix.de>

> +/**
> + * ksz_phylink_mac_disable_tx_lpi() - Dummy handler to disable TX LPI
> + * @config: phylink config structure
> + *
> + * For ports with integrated PHYs, LPI is managed internally by hardware.

Could you expand that.

Does it mean the hardware will look at the results of the autoneg and
disable/enable LPI depending on those results? I also assume this
means it is not possible to force LPI on/off, independent of autoneg?

	Andrew

