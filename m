Return-Path: <stable+bounces-127279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD7A7719D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 02:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171861883F21
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D521D3E9;
	Mon, 31 Mar 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0ag+A0wE"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F521CFEF;
	Mon, 31 Mar 2025 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465579; cv=none; b=BaWA6CZeLchHXOjWWdyXJToXn/jgUSkWURDrFWavT73qFVbp0xOxb+x9OSdRtkTnIC/L/dSMdUfUoyPs4CT/Hmkh2xytwU0yUAIphjksaVtMpX2hJ19FIGTL5zJT87EGO2u2slR6MeCrvomChVd483G0eo5wMuXo/dU19HZwfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465579; c=relaxed/simple;
	bh=LGdQNnGviTAAfXA1QSxFRNMb1V+I+snZ41QAfqiNhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rljDuOYPuRiXPD4ZVLWuyCOkSkYiNJ3J1nelcPRSG6VBAGiqTx6Out6R/pueSVgiLf9AdpL97vxe+t0pIWQtZ6rZYHywoS3K6L0Brw5of/8o8pK3VmsEuZPnam+Uzude5ESP3AW6BkX0jit4CNi12acoSQ3wKvbd1pFAM6GvJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0ag+A0wE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tmf7ncwVgVWuyzc5cYxsbvgKOZsAU8DzNdzbOOmf17Q=; b=0ag+A0wE54kG5CVWg2YhBJ6RlV
	I/x442UnGC7ZGd93Z1rnW58RCtCT84L0GobDhQ+NLxS8FNx8AHd+93Sk1oHX0r/4EUL1NbNK4zTqo
	m6/ehJfUHcjXuongTsaAWX45rRvqV3yYKXF9IWZCLUDuZwhYJaFCxCkT8tClvAaCeQHPvNOuSPLJL
	+sSFaZciN7kWcwA0BIVGGB3mzUdlk3Hm1+o8putRYBxOD6UGLl0rvD0zJmer8oZv7DA/B41Ckd1gf
	aRmUDPr6wfvm+ulSWBJRYc0JZmZIRDW7INyPrO8O+EOoIxe73SCcgPzjQFOWvYx7GLT/cU1SVVbpg
	R5jE/4Sw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58766)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzP2P-000532-0j;
	Tue, 01 Apr 2025 00:59:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzP2L-00027L-1g;
	Tue, 01 Apr 2025 00:59:25 +0100
Date: Tue, 1 Apr 2025 00:59:25 +0100
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
Message-ID: <Z-ssXdmRLYqKbyn6@shell.armlinux.org.uk>
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch>
 <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
 <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com>
 <Z-r7c1bAHJK48xhD@shell.armlinux.org.uk>
 <CACdvmAhvh-+-yiATTqnzJCLthtr8uNpJqUrXQGs5MFJSHafkSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdvmAhvh-+-yiATTqnzJCLthtr8uNpJqUrXQGs5MFJSHafkSQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 31, 2025 at 05:21:08PM -0400, Da Xue wrote:
> I found this on the zircon kernel:
> 
> #define REG2_ETH_REG2_REVERSED (1 << 28)
> 
> pregs->Write32(REG2_ETH_REG2_REVERSED | REG2_INTERNAL_PHY_ID, PER_ETH_REG2);
> 
> I can respin and call it that.

Which interface mode is being used, and what is the MAC connected to?

"Reversed" seems to imply that _this_ end is acting as a PHY rather
than the MAC in the link, so I think a bit more information (the above)
is needed to ensure that this is the correct solution.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

