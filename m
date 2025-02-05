Return-Path: <stable+bounces-113954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F81A297DF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3046D16A5FA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271EF1FDE07;
	Wed,  5 Feb 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YFke/Ib8"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D161FDA96;
	Wed,  5 Feb 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777517; cv=none; b=vAs5P6PeG5Hd3h4Limjxy642saz0g1zeG3AyV9LH3lY997v7V3BYSZLkaexnL97GWtkGjmIiZAuBERFVo30F6UaPb2WoLHPtuBDhk0hFqAyhUvU6jdmKp/OsQNNJpcEVjZ9KF2EyLkUpF5+RG0RygQzg2T/l8rNdpYYXhW7dwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777517; c=relaxed/simple;
	bh=Y8aAjOf3AT4BufOpk3zqdSx3kA3F965v0KtHpTlTJW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkKibm6opgz9160uQqZkLUPlu5fvPZQjQiTxZllnRrolvGTAr5fgu4HE6tmDTizhmGMdpCNCiKovTMkD/c5bltxkPMr2VxFXsjrGHKZVeE49SFicLy313SQNH5Ngz5xJxCS+riAZNtDgZ2yg63QNCs+aOLiF4Df1EjrDGt8JKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YFke/Ib8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a51LPLjOt3wwZB6mg+Y3S9/fHKpsOrF0RHXl8dP5K9o=; b=YFke/Ib8EU5hGyNz5OI18D/jXb
	LgKzeb6g4CeABgLgLmj3yzRSwdQnFVfTrNyBnLB5+V6yIz8fDaBI2KMVhjMYTVO2Tc92tOL4IFXtM
	myCRnncf5o8lh85f8iYKOTArbHfFqFTA3wgxnkFM9Ws3L2Zxg8WwpPPZ66uOiIhNTkwou8AEj0yQG
	Xx7m1YTkkBfv+9n80iYQ3U+/s9B9mBadOs6h5bTqCmNqY8QA+fk9zw6p2xOkO6U0a4ctamQHzFlOM
	KxyMPIqjLiaq9/7m6gfVLlVIU/wQ3V6JLsRlheTDy89eWAL5MsvXtiHAIwcbkIpv++7MN0a7plBaA
	3XSQWG0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52386)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfjSR-0007tq-0B;
	Wed, 05 Feb 2025 17:45:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfjSN-0002bu-08;
	Wed, 05 Feb 2025 17:44:59 +0000
Date: Wed, 5 Feb 2025 17:44:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Steven Price <steven.price@arm.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
Message-ID: <Z6OjmtiZ4A8BzvsP@shell.armlinux.org.uk>
References: <20250204161359.3335241-1-wens@kernel.org>
 <20250204134331.270d5c4e@kernel.org>
 <CAGb2v641vvtVKv8QbiEfHnMWngcKYTJZAgfH5k+G_nOvZcbC9g@mail.gmail.com>
 <20250205173824.GJ554665@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205173824.GJ554665@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 05, 2025 at 05:38:24PM +0000, Simon Horman wrote:
> On Wed, Feb 05, 2025 at 11:45:17AM +0800, Chen-Yu Tsai wrote:
> > On Wed, Feb 5, 2025 at 5:43 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Wed,  5 Feb 2025 00:13:59 +0800 Chen-Yu Tsai wrote:
> > > > Since a fix for stmmac in general has already been sent [1] and a revert
> > > > was also proposed [2], I'll refrain from sending mine.
> > >
> > > No, no, please do. You need to _submit_ the revert like a normal patch.
> > > With all the usual details in the commit message.
> > 
> > Mine isn't a revert, but simply downgrading the error to a warning.
> > So... yet another workaround approach.
> 
> I think the point is that someone needs to formally
> submit the revert. And I assume it should target the net tree.

For what I think is the third time today (fourth if you include the
actual patch...)

https://lore.kernel.org/r/E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

