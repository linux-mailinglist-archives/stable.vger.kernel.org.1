Return-Path: <stable+bounces-190045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EDCC0F726
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F310A3BA994
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7219230EF91;
	Mon, 27 Oct 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ghH1DooK"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75730C615;
	Mon, 27 Oct 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583485; cv=none; b=CMyycHpHFoscmhyQDragZ+YCpZuytXtiuuLPW5HLPt0Avx1Ep+3DIQfuhdl4VAvnUDbWC6x3iY6mJDzzhFsBgFJKC8KVX0bfTx91haeoZXSz7H6qLK/quW2js6kguI5wdHaXdrlj3YT92P4y7qcxARMR03DQTuRMFcSMZ0QU2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583485; c=relaxed/simple;
	bh=OFlj4QGnrs2E3fl/0ujJ9X4ekencKhGEKiw/mctCT/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDOK6HEJNZ92zLohvA2cg2JdmV1cqbQe6oJcU6nTVlpXIhjVwEAHYPTwjGUt9swdvSKgrkJMG3slQLIULYHy4tSN53y78I/vVElEW5UbqhaIEqFCp8uMu7dNMSRx0QJ+mK5XaWzYlj4v4Dq4eAQSUnm5zmps5uXH9reXW4uXrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ghH1DooK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5CP7gRt0BblrjBDXAO/3HHhQ8A2T8uZzDR6yvnegDug=; b=ghH1DooKmkmLdJXWxXedWnU15v
	ZVCXtgDvd+7aaDvknLD7KfrqAbbh5Y1S6A7CHrwNY91J13EqMnCaspEqILKrexhyVFpqn06DgqN1o
	yvP/jZHR+E7BlwiQJw45D4qHvgkDX1LkbhGxEMLFyeOghMU8ZENl4LQ7AxO3JlE6mA12lDlddFphx
	rsYhIlMpjkpudqsSZdZJVhTKnNO2vPJpYnFKMfNcWo96W3/Wwp4PSfUb2Yche/GY3TLsA1eGXVR9D
	Y7OLQrhcd0LF6fua4WZKSoEdFXUJjcEQTeuMq8B5NRM5TojiE1+qF9Ek07/pf1eiHPusM8RshePVO
	h+Ys3XJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDQKh-0000000026D-2lSw;
	Mon, 27 Oct 2025 16:44:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDQKf-000000005kr-0qgI;
	Mon, 27 Oct 2025 16:44:33 +0000
Date: Mon, 27 Oct 2025 16:44:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <aP-hca4pDsDlEGUt@shell.armlinux.org.uk>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
 <aP-Hgo5mf7BQyee_@shell.armlinux.org.uk>
 <f65c1650-22c3-4363-8b7e-00d19bf7af88@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f65c1650-22c3-4363-8b7e-00d19bf7af88@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 27, 2025 at 04:34:54PM +0100, Emanuele Ghidoli wrote:
> > So, this needs to be tested - please modify phylib's
> > genphy_c45_read_eee_cap1() to print the value read from the register.
> > 
> > If it is 0xffff, that confirms that theory.
> It’s not 0xffff; I verified that the value read is:
> TI DP83867 stmmac-0:02: Reading EEE capabilities from MDIO_PCS_EEE_ABLE: 0x0006

Thanks for testing. So the published manual for this PHY is wrong.
https://www.ti.com/lit/ds/symlink/dp83867ir.pdf page 64.

The comment I quoted from that page implies that the PCS and AN
MMD registers shouldn't be implemented.

Given what we now know, I'd suggest TI PHYs are a mess. Stuff they
say in the documentation that is ignored plainly isn't, and their
PHYs report stuff as capable but their PHYs aren't capable.

I was suggesting to clear phydev->supported_eee, but that won't
work if the MDIO_AN_EEE_ADV register is implemented even as far
as exchanging EEE capabilities with the link partner. We use the
supported_eee bitmap to know whether a register is implemented.
Clearing ->supported_eee will mean we won't write to the advertisement
register. That's risky. Given the brokenness so far, I wouldn't like
to assume that the MDIO_AN_EEE_ADV register contains zero by default.

Calling phy_disable_eee() from .get_features() won't work, because
after we call that method, of_set_phy_eee_broken() will then be
called, which will clear phydev->eee_disabled_modes. I think that is
a mistake. Is there any reason why we would want to clear the
disabled modes? Isn't it already zero? (note that if OF_MDIO is
disabled, or there's no DT node, we don't zero this.)

Your placement is the only possible location as the code currently
stands, but I would like to suggest that of_set_phy_eee_broken()
should _not_ be calling linkmode_zero(modes), and we should be able
to set phydev->eee_disabled_modes in the .get_features() method.

Andrew, would you agree?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

