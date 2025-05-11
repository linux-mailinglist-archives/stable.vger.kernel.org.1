Return-Path: <stable+bounces-143089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175DAAB278D
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E7A17574F
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBE21A317E;
	Sun, 11 May 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lNQdupnS"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D513BAF1;
	Sun, 11 May 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746957452; cv=none; b=C5ivnMxvP9OpYmlaFfRvMket3Dhd14RfMXw5MYB0wHcA5IJebAxOiOZEfcnsYauS6ZrU6+YhBayeFpPmt3GfN24AAc6sIDOnrA1eE4cgn8c7pPK1kxNzCsuJmBZMLMlj1l+0rzL1qmk5+8ljNxVeqmwI+L3FyvsxDJw8965Pw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746957452; c=relaxed/simple;
	bh=DPJG4PvkAyLVxlGdfS4q/kBq/bWu/WF2ntWz4PAzrw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcX6feQJC49dICJyQCWtGbG7gi9nw2PTPlbdglx+TB7HHpuPRZMBznmJZTJUgOGfYVIpJJ2gh0DAMLjInWlSXPvelaKsBfRxVRWa0T1RK7J5wuSDrReMHMJQNEdrc+lDDHqL8OsudknSzWVDmKw0/Pj2ifeZV+VgG8R81KZrRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lNQdupnS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+HkXY9uD0IJgliLTge+1QCfl90UxdVOyJJ6tTfPwFkw=; b=lNQdupnS2kvfwZbuZTFh4QZWxn
	v9xyxWJqe/r0AUDDCUpQyFlyJSxdYV3zRKlatBQztgqNaGXtAV1oNqCAnEL+ihEEqUCI2UATZyHxB
	E+LCD9A0UQFkGVvDkeLtm/ydm0k27fQrsKs+5uIdROO2+C7/OqUfTpeMNW2o2ASQEGHr1w8OQUYxM
	0InHvXcW5ruIAwU5ay8YHxBKGk38YWZpsfbvdM3TMKGD5vbl0+Vm+SNG5oYnJPJnRKFPy0l3FPSLv
	BXE3O1ugQ/Aq4Cty/4d7hOJ18LqVxy+47Bq/ORjCwCmZF9pqBZKB8In7/Xuf/asP06aeB9pHys3rq
	c5wJQTfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41920)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uE3Qp-0003ox-20;
	Sun, 11 May 2025 10:57:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uE3Qk-0001DM-38;
	Sun, 11 May 2025 10:57:10 +0100
Date: Sun, 11 May 2025 10:57:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: aquantia: fix wrong GENMASK define for
 LED_PROV_ACT_STRETCH
Message-ID: <aCB0dkhiO49NJhyX@shell.armlinux.org.uk>
References: <20250511090619.3453606-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511090619.3453606-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, May 11, 2025 at 11:06:17AM +0200, Christian Marangi wrote:
> In defining VEND1_GLOBAL_LED_PROV_ACT_STRETCH there was a typo where the
> GENMASK definition was swapped.
> 
> Fix it to prevent any kind of misconfiguration if ever this define will
> be used in the future.

I thought GENMASK() was supposed to warn about this kind of thing. I've
questioned in the past whether GENMASK() is better than defining fields
with hex numbers, and each time I see another repeat of this exact case,
I re-question whether GENMASK() actually gives much benefit over hex
numbers because it's just too easy to get the two arguments to
GENMASK() swapped and it's never obvious that's happened.

I don't remember there being a dribble of patches in the past
correcting bitfields defined using hex numbers, but that seems common
with GENMASK().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

