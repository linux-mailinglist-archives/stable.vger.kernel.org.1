Return-Path: <stable+bounces-91856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC79C0D0A
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 18:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D1028558D
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934F2170C9;
	Thu,  7 Nov 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KhmX1nKt"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4918FDAF;
	Thu,  7 Nov 2024 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001014; cv=none; b=QAqQZre1lgs51y0l4PN9Gm8f2nU+2E7JhH8rGZSiyrfCuulzA35GaTsOmu1I8XcYfGCtHL/6hTD+7kdjJZhEQX1eRaw67gcpkKewnfXaiYsDc7q38OE1JHRpECQg3AOhm3qDaBv3hg4/lRwouXjZhQqe7u+cFSyKzyzPle8xOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001014; c=relaxed/simple;
	bh=cVWXsWREldHGvAnkQzjYTNrGacOlXfarZYKSjY8dOdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKd3Mfn6XhF74BX5kW6/ZSPYQc5p486v9I1dC48aM6hVPbhG1mzUDlyP5LQ1GzKZigGV7CBMcL5CDTc9qzHzI8GlFYBq3GgQdgA+X9beRM6dVlDAdFNLfpl7/WRhsChwX3tYN/upigHZgSp5xRXJ5YNb2c4qGhrQqTf35LL3zPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KhmX1nKt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fMOEMQkzH0c9rkq40/WN60OYh9eTdzYKpSbLvnHZRCo=; b=KhmX1nKtkrOGhCb068/ZQakPU/
	Hrbnlm43lRLeEDtLuwnkIrjjQuTJkMMLCPM2ffsaw25s2js+zdlNrfo/qpiW83NlV6clpIbLwjdC3
	rIb0yGXi4d44ev7+tvuYeIIODL778bDwVr3/mLBp96PuYKE+qzAhsdrhSYSIEvCxqhy4BuekkUe1w
	7AOY/Y9s3nD9rpsSGKHrNngO45w6DGchmnkZMcE9YsgMO180fydxOCZoQviLBJLmMhetHxgHQQiL3
	vJU7ahw4/5vC8MBQYww+O7hIToG2P+NlcknIWDHFK5i6LV5Pca4CXJ3J2evYck3gY3DaGfVjMH2Lz
	/FmyjvNQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48932)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t96Qr-0003YX-0w;
	Thu, 07 Nov 2024 17:36:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t96Qo-0001SH-14;
	Thu, 07 Nov 2024 17:36:30 +0000
Date: Thu, 7 Nov 2024 17:36:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: dp83869: fix status reporting for
 1000base-x autonegotiation
Message-ID: <Zyz6nolj9-9bjyx8@shell.armlinux.org.uk>
References: <20241104-dp83869-1000base-x-v2-1-f97e39a778bf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-dp83869-1000base-x-v2-1-f97e39a778bf@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 04, 2024 at 09:52:32AM +0100, Romain Gantois wrote:
> The DP83869 PHY transceiver supports converting from RGMII to 1000base-x.
> In this operation mode, autonegotiation can be performed, as described in
> IEEE802.3.
> 
> The DP83869 has a set of fiber-specific registers located at offset 0xc00.
> When the transceiver is configured in RGMII-to-1000base-x mode, these
> registers are mapped onto offset 0, which should, in theory, make reading
> the autonegotiation status transparent.
> 
> However, the fiber registers at offset 0xc04 and 0xc05 do not follow the
> bit layout of their standard counterparts. Thus, genphy_read_status()
> doesn't properly read the capabilities advertised by the link partner,
> resulting in incorrect link parameters.

This description is wrong. The format of registers 4 and 5 depends on
the media.

In twisted-pair ethernet, then:

ADVERTISE_PAUSE_ASYM / LPA_PAUSE_ASYM
ADVERTISE_PAUSE_CAP / LPA_PAUSE_CAP
ADVERTISE_100FULL / LPA_100FULL
ADVERTISE_100HALF / LPA_100HALF
ADVERTISE_10FULL / LPA_10FULL
ADVERTISE_10HALF / LPA_10HALF
ADVERTISE_CSMA

apply. In 1000base-X:

ADVERTISE_1000XPSE_ASYM / LPA_1000XPAUSE_ASYM
ADVERTISE_1000XPAUSE / LPA_1000XPAUSE
ADVERTISE_1000XHALF / LPA_1000XHALF
ADVERTISE_1000XFULL / LPA_1000XFULL

apply - these being bits 8, 7, 6, 5:

> +#define DP83869_LPA_1000FULL   BIT(5)
> +#define DP83869_LPA_PAUSE_CAP  BIT(7)
> +#define DP83869_LPA_PAUSE_ASYM BIT(8)
> +#define DP83869_LPA_LPACK      BIT(14)

so these are just reimplementing definitions we already have. Please
use the existing definitions. Even better, use mii_lpa_mod_linkmode_x()
and linkmode_adv_to_mii_adv_x() which we already have in your code.

Same likely goes for DP83869_BP_*

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

