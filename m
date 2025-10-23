Return-Path: <stable+bounces-189152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB01DC02AAC
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B09425806AE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45F33F8AB;
	Thu, 23 Oct 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M9pUntZf"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48B257427;
	Thu, 23 Oct 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238909; cv=none; b=QQ7hf26gUOEOpd+GB4BmPf91mkqkC1i3cryV6mzzzDkRXnKGTSLVo0OWnjC3I1zTzuTzsuZIYJ7J6zs2KKTtsjyVBGvGUQ2vQw3pYe4qKBPshl0X/2Z8vMVJCRuEYYVbbQepfgXozbfyTAQpiCHwDgtLz6bbquIV5li5QherYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238909; c=relaxed/simple;
	bh=hdmq/sRayl6/auhTmgwlv9zfI+n+5rqdaNCPOPrk0aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH3DQxxfGbQ9gFSqJqUqJKwngWvR+ZZVz73tLULnAhULQh3E41KKHX6OnwOUZOALFhSKzu1Y2xp3Nb7Y3X9sCInAYjCvRRnOH1Pp/kcnfGI/DS32pLXa8PzBUFqgJosIcOyLDANsG61I6gtRBhqctNHO8Cn7ne5G8vowdvnhY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M9pUntZf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p7rBIGumlMcci27kMgSWW94FUPYeAc7w0OEyP+alJhY=; b=M9pUntZf8dbZP5qLisc0QF2O0j
	ZMr+j8SvzUpGicdgVvORE6WYSt53H7MmZkEN5VK5DTnJlay0kGDcwTVSH1XplHzQNrWGcpNJ7cHpd
	geo1lK/PR3CM2gcbBWC4OMcQYGk3teTSwOLYvzdrDbADNK1RofquGDWYGgKLOoR8z554=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBygw-00Bu7J-CS; Thu, 23 Oct 2025 19:01:34 +0200
Date: Thu, 23 Oct 2025 19:01:34 +0200
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
Message-ID: <0b61689c-ac4a-402c-bbc8-2c1207e19c76@lunn.ch>
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

On Thu, Oct 23, 2025 at 04:48:53PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> While the DP83867 PHYs report EEE capability through their feature
> registers, the actual hardware does not support EEE (see Links).
> When the connected MAC enables EEE, it causes link instability and
> communication failures.
> 
> The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
> Since the introduction of phylink-managed EEE support in the stmmac driver,
> EEE is now enabled by default, leading to issues on systems using the
> DP83867 PHY.
> 
> Call phy_disable_eee during phy initialization to prevent EEE from being
> enabled on DP83867 PHYs.
> 
> Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1445244/dp83867ir-dp83867-disable-eee-lpi
> Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet

Interesting statement this last one. "None of our gigabit PHYs
support EEE operation today."

I wounder if any of the other TI PHY drivers need this fix?

> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

