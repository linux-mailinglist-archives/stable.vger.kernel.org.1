Return-Path: <stable+bounces-189895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA2C0B798
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 00:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2D18A1AA1
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 23:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991C3019DA;
	Sun, 26 Oct 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dHB6KI1b"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF729C33D;
	Sun, 26 Oct 2025 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522338; cv=none; b=TPmnvFZaYuLGheaTqhNPdqr4Bdjtv84YxEJgKhZ8+uY3jJ1tcpC1E8de/9Ah/INNZbfPVc5/jtvCwMMq2DWS1cHwaYX5hpBQGg5pa0ktCsDulbtjJOFHTvx/xc25eDg4GX3toef+W3IFuBGR/VezKxvv4f4ZxMWz6Tsq3FwAjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522338; c=relaxed/simple;
	bh=MKUJpePeI/vtRd7eFD066XMq9RN4z0wlVKNuiMPgvvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfS+HA+NE4ZbhfaA5Ad67zlyCqj1/gcWPhFvDbiqBSer5J3TgJtIYAMoOeLaW9Q6wQ9dh9hwFohipV5W0zrFXNfTtIX2/K3Rug2YlePIo3wIXUTBvK/8oOGmQYPrK5iag+wOSKuZP2wOutppDz+dgfhcay2GArtBsfLKHNy6o90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dHB6KI1b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YaOEzrYe7KzWArBLHgosFV2IzuOoDe3pQTN6GaTMAoo=; b=dHB6KI1bRwMYBVJ+J8qHo1TWHD
	+66h+GtG6dLRDOkUtFnS+E0coZlmhAzlUiHyE8GFFDLkMCX80RMPXms/pnmFYwufMzuphpq6yD0Fo
	MFYol03n4yNEJKFfoBUIBXHl3FFIh9DWloqnIa0r2qaLRfu309+EfW8MQfYWiYRt/OAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDAQB-00C8jB-Sr; Mon, 27 Oct 2025 00:45:11 +0100
Date: Mon, 27 Oct 2025 00:45:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023144857.529566-1-ghidoliemanuele@gmail.com>

> Since the introduction of phylink-managed EEE support in the stmmac driver,
> EEE is now enabled by default, leading to issues on systems using the
> DP83867 PHY.

Did you do a bisect to prove this?

> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")

What has this Fixes: tag got to do with phylink?

I hope you have seen Russell is not so happy you claim phylink is to
blame here...

	Andrew
 

