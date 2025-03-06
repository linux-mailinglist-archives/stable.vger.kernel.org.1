Return-Path: <stable+bounces-121264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E6A54F51
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911AF3B3930
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B8185B5F;
	Thu,  6 Mar 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oIjh9Id0"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1342E634;
	Thu,  6 Mar 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275324; cv=none; b=lMh7WGI9bnsmZr9lRbaw1uC01VUuyI8mfC9VnyUjhovWYWHtmMzPxSf9Sydzt80gLVnbp2OQlfbijh2V/5HFDVVBoOxynU/75xBYkmLxnJyzy/MwFZbaQcZAWJkXGGRIScCeOYQSw27hV70gUAPZOBUuMoUJunFJqEy/D9atmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275324; c=relaxed/simple;
	bh=aiimo7eOKlG1yltwAAIGQi1oBb/uVswZcGZDfBpYiV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Jf2q6VU2OCqJ5gzLDim0z0bxL6LdHn50/00IFfYKrfj7P0gP+8ic3Bc0ThSQo6qVkDg9B0g1AS0o3PnZxFMwMwI1I4IhYFq9gGAE6wTWZd+PMA/1gDKK8JsPRZim5DoDy4zXW2akppm3BTAzRsyES0yAYHm/MSuj9OGlYDjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oIjh9Id0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=8C6T0qOrO+SavdUv26hm/aE79BWJPJvi5q6z9TE1FxY=; b=oI
	jh9Id0KiIJoJgLzVkuaxkVZG74FXZpLRpXI9bGuuq9dlwfeH/TeoxeMyQd4btTskAjj/fg/ZVDBam
	cNiPmf+d6iQauUK/cvBWiuAWBXEMjKUiy4ELBe5hWWgGeNHK0uWPQesLvnP1js7Do+e9vHUBwiWpd
	gRyaK/Y08lGOhcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqDFg-002q5e-Mh; Thu, 06 Mar 2025 16:35:12 +0100
Date: Thu, 6 Mar 2025 16:35:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY
 configuration errata
Message-ID: <d09c8547-550d-4ea1-8739-2bcf9e7c3fb0@lunn.ch>
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
 <20250304160619.181046-2-andrei.botila@oss.nxp.com>
 <7c14179c-0262-47e5-a13e-a53c2061da9b@redhat.com>
 <f37c7159-528d-4c58-b531-8d66757d2c16@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f37c7159-528d-4c58-b531-8d66757d2c16@oss.nxp.com>

> >> +/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
> >> +static void nxp_c45_tja1120_errata(struct phy_device *phydev)
> >> +{
> >> +	int silicon_version, sample_type;
> >> +	bool macsec_ability;
> >> +	int phy_abilities;
> >> +	int ret = 0;
> >> +
> >> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
> >> +	if (ret < 0)
> >> +		return;
> >> +
> >> +	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
> >> +	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
> >> +		return;
> >> +
> >> +	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
> >> +
> >> +	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> >> +				     VEND1_PORT_ABILITIES);
> >> +	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
> >> +	if ((!macsec_ability && silicon_version == 2) ||
> >> +	    (macsec_ability && silicon_version == 1)) {
> >> +		/* TJA1120/TJA1121 PHY configuration errata workaround.
> >> +		 * Apply PHY writes sequence before link up.
> >> +		 */
> >> +		if (!macsec_ability) {
> >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
> >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
> >> +		} else {
> >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
> >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
> >> +		}
> >> +
> >> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
> >> +
> >> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
> >> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
> >> +
> >> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
> >> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
> > 
> > Please add macro with meaningful names for all the magic numbers used
> > above, thanks!
> > 
> > Paolo
> > 
> 
> Hello, these registers are not documented in the datasheet or errata sheet.
> The access sequence comes 1-to-1 from the errata so I couldn't use macros.

Yes, we sometimes just have to accept the drivers are doing magic we
have no idea about because the vendor does not want to tell is. All
the registers in MDIO_MMD_VEND1 are clearly vendor specific. The
MDIO_MMD_PMAPMD registers are also in the range reserved for
vendors. So i think we just have to accept it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

