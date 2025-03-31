Return-Path: <stable+bounces-127272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08197A76F57
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 22:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5D6164452
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84A1D5174;
	Mon, 31 Mar 2025 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Up4u0ZtG"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F51D86F7;
	Mon, 31 Mar 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453056; cv=none; b=AwzxPwRtMClObwcYb/5Et3GiZNReJyYa9O9GUplCe/QrQSt9pxNsSLNiKb/20o69tVthPBtJTlEIZqcjrYq3+W6qpgYX98PvCbJEP+KTik1qBpMbvA2Lm9keFp9gUd+DBZ8e9Z2LmW2p/LD3YGNo3ddeQqLq4NgoAQFFJlBoOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453056; c=relaxed/simple;
	bh=oSgO4eBDnIoUqaBokqlhEpgWsqEDw8Ac1dYf3mCoSAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjrIaFQkW56KT1jAyBg8/qilnemyvVL3UVNQF7VerddIZjcBcHlwuJaZiVlkazXqX2G5z3FWnz0ieMG7mc/iOwoT47oHtPYHx0YrkU2Rn+JwbZjMfhuViOHCs5Kty9WEzuKZqEUQ2iUK8nHdv4l94ZIaLLYhVvXJtejHsPD/w1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Up4u0ZtG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bwgUmQ/Ln+vl6Ggzqf2YmSZ7HB+LoNBmRfI1Y27KDkA=; b=Up4u0ZtG1+H47e4FsrNKSaV3o8
	3eDeJC82AW9n1sRD92fm7KDWTFxTlKyVYZkALIOZ8v3lqVlbgS4tKxO6tohdct1W0suaUXUPBw/vy
	nK+4MK+9EMi1TY9eDu0nvxRN4EbMm1sLlZQ3F3an+fF2Unme7J1RP2aW1qxVbw+U/yaqOgyRb9VER
	t7CcYkvNr02rp6F5f/P7MUBu0xpg7Yfk56v3d3IEvx15X2xJjSdunMDG9w8AvtwNWSCGR+LuXkJKw
	AvRUAYvC/r3H9c5G6KWGnYgiWy3Q/2qrZ6zZIlDzU6/LmAhDX3sjUVbomWh95H2aII31UVfXXTBBr
	wlHheixQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59730)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzLmQ-0004lN-2S;
	Mon, 31 Mar 2025 21:30:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzLmN-0001zI-1U;
	Mon, 31 Mar 2025 21:30:43 +0100
Date: Mon, 31 Mar 2025 21:30:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Da Xue <da@lessconfused.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Da Xue <da@libre.computer>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-amlogic@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
Message-ID: <Z-r7c1bAHJK48xhD@shell.armlinux.org.uk>
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch>
 <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
 <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 31, 2025 at 03:09:00PM -0400, Da Xue wrote:
> On Mon, Mar 31, 2025 at 9:55 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Mar 31, 2025 at 03:43:26PM +0200, Andrew Lunn wrote:
> > > On Mon, Mar 31, 2025 at 07:44:20AM +0000, Christian Hewitt wrote:
> > > > From: Da Xue <da@libre.computer>
> > > >
> > > > This bit is necessary to enable packets on the interface. Without this
> > > > bit set, ethernet behaves as if it is working, but no activity occurs.
> > > >
> > > > The vendor SDK sets this bit along with the PHY_ID bits. U-boot also
> > > > sets this bit, but if u-boot is not compiled with networking support
> > > > the interface will not work.
> > > >
> > > > Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
> > > > Signed-off-by: Da Xue <da@libre.computer>
> > > > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > > > ---
> > > > Resending on behalf of Da Xue who has email sending issues.
> > > > Changes since v1 [0]:
> > > > - Remove blank line between Fixes and SoB tags
> > > > - Submit without mail server mangling the patch
> > > > - Minor tweaks to subject line and commit message
> > > > - CC to stable@vger.kernel.org
> > > >
> > > > [0] https://patchwork.kernel.org/project/linux-amlogic/patch/CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com/
> > > >
> > > >  drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > > index 00c66240136b..fc5883387718 100644
> > > > --- a/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > > +++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > > @@ -17,6 +17,7 @@
> > > >  #define  REG2_LEDACT               GENMASK(23, 22)
> > > >  #define  REG2_LEDLINK              GENMASK(25, 24)
> > > >  #define  REG2_DIV4SEL              BIT(27)
> > > > +#define  REG2_RESERVED_28  BIT(28)
> > >
> > > It must have some meaning, it cannot be reserved. So lets try to find
> > > a better name.
> >
> > Indeed, that was my thoughts as well, but Andrew got his reply in
> > before I got around to replying!
> 
> The datasheets don't have much in the way of information about this
> register bit. The Amlogic GXL datasheet is notoriously inaccurate.
> 
> ETH_REG2 0XC8834558
> 29:28 R 0x1 reserved
> 
> It claims the bit is read only while the BSP hard codes the setting of
> this register. I am open to any name for this register bit.
> This is the only thing holding up distro netbooting for these very
> popular chip family.

Which interface mode do we think this affects?

As a suggestion, maybe call it:

REG2_<interfacemode>_EN

and possibly add a comment "This bit is documented as reserved, but
needs to be set so that <interfacemode> can pass traffic. This is
an unofficial name."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

