Return-Path: <stable+bounces-160247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FFAF9F11
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 10:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BBC541FF7
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC12797AE;
	Sat,  5 Jul 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SKoAtiMv"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB41F418F;
	Sat,  5 Jul 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751703057; cv=none; b=N+kS0T7nR3OdudUWtGv8glwYewCcYBsa0F1X7+OGzoMfdxgwEyS8ITdcRk8dlV1RVwJIzwQQbkUOaOoBZt154XzPMut4jZM2lZtXDKimFVDKWOgHhEt0s1B7wDakJwfwBrfFWwztOMWMhUasQYzQNU3IKvSQfmBRRIrzizpy3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751703057; c=relaxed/simple;
	bh=NLwY+RObuoSFbPTe2+ZYsRiQiNlgFC+2GTkUWFIu9VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvETy2LRYp5n0GdEXqwgaidLmNcf03ZW8m2uUw3MyLzdGA1N8ep/exKdpUkgNfxilimZa439wUqazgQN21CePeCP0eanqXwi/tRGzJL68nhShjvSPm2Po75MYsCil3DgNH0bEFalwBwvWYF+H00+nJrOdW7ZvNr00+3V5DMu3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SKoAtiMv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8tu7+Zp0YatuDllTNOUx72knnGe1yKc8lR7+17d3cGs=; b=SKoAtiMvmDvoXagIUq978ZXq7n
	V+87ytVvr2CX5jIb744RJJc6RjaB+ZmJVMb3sJLjWqo/7cZuwubUNG7INUKIN6KZNFoEc0M6mYnFm
	y/ARtbS+aPk3uFkviTs/zQtasG8wwNv7iGmM9khUGv8GA5SIOzqW6PBPFn2SGQWMrJFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXxyq-000NMe-Pq; Sat, 05 Jul 2025 10:10:40 +0200
Date: Sat, 5 Jul 2025 10:10:40 +0200
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
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: Reset after clock enable
Message-ID: <e1df8097-dd48-4570-8f8e-c6c25a3683a4@lunn.ch>
References: <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>

On Fri, Jul 04, 2025 at 07:48:44PM +0200, Sebastian Reichel wrote:
> On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> stability (e.g. link loss, or not capable of transceiving packages)
> after new board revisions switched from a dedicated crystal to providing
> the 25 MHz PHY input clock from the SoC instead.
> 
> This board is using a RTL8211F PHY, which is connected to an always-on
> regulator. Unfortunately the datasheet does not explicitly mention the
> power-up sequence regarding the clock, but it seems to assume that the
> clock is always-on (i.e. dedicated crystal).
> 
> By doing an explicit reset after enabling the clock, the issue on the
> boards could no longer be observed.

I don't know if it helps in this situation, but look at
PHY_RST_AFTER_CLK_EN.

If it does not actually help, it might be worth mentioning it in the
commit message to stop reviewers saying you should see if it is
useful.

	Andrew

