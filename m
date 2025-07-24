Return-Path: <stable+bounces-164638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824BB10F5F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5CE7B8BB8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE52BE657;
	Thu, 24 Jul 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2P3e4G1L"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274091EA7CF;
	Thu, 24 Jul 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373029; cv=none; b=VqkEhpkwq1J6NkxUgRWuV6nG49N1YXr9X4+yxy8DUBKoON5zGsmgKGbYbnpukStWkZw2veVWKlrPhwsqjws4iAckjEc6ElUvwS9ImZui3ZrgSeDW0tCGwNYNyy6qd29jejv1KixiDayH4yL9tsGcK85r/3jorwgEa91W0LKGNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373029; c=relaxed/simple;
	bh=s98MWUopP2qJY4LWUlyVsvV8NWDPe4jQTDslu4DmNiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTVDWV3YUqcRbcm9ye2vwwX1URMCOE1E6yCbm4SKlEXRhteH9HsZ2JMnBz5WQqLbyTxpoltp69z/axYcJqVpR8P3ebJuhAyezLRd8SuA3JyigLYhvgnDsBlIPTYNE2US0ViXqkyit2kDOm4rr8RZMfbxjJh+kLn8gbV1AQavh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2P3e4G1L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ktBKmIi9zZrQKRQYUMNNsJi6dJ/WgfvOaCKCSheFKXg=; b=2P3e4G1L7+LMMQKl+cshpz+X5v
	qTdDWLFC7DIc6pxfutNwfZymFyFzACf5NI4LkcfRjgwHN71kkgqIvtzB1zMF3KB4HhughwfgiFaQn
	rnaC2YavechFx8kLqmj/hyAwTtoPZYhca3/28t+fVnzU7KNhIOvy9RgmwEH5bRVDhnrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueyPs-002mPx-Op; Thu, 24 Jul 2025 18:03:32 +0200
Date: Thu, 24 Jul 2025 18:03:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: realtek: Reset after clock enable
Message-ID: <0af6de2f-d8ca-4885-b0e9-0353fa50333c@lunn.ch>
References: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>

On Thu, Jul 24, 2025 at 04:39:42PM +0200, Sebastian Reichel wrote:
> On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> stability (e.g. link loss or not capable of transceiving packages) after
> new board revisions switched from a dedicated crystal to providing the
> 25 MHz PHY input clock from the SoC instead.
> 
> This board is using a RTL8211F PHY, which is connected to an always-on
> regulator. Unfortunately the datasheet does not explicitly mention the
> power-up sequence regarding the clock, but it seems to assume that the
> clock is always-on (i.e. dedicated crystal).
> 
> By doing an explicit reset after enabling the clock, the issue on the
> boards could no longer be observed.
> 
> Note, that the RK3576 SoC used by the ROCK 4D board does not yet
> support system level PM, so the resume path has not been tested.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

