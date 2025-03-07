Return-Path: <stable+bounces-121385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3CDA568CE
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D7E16A292
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85547219A75;
	Fri,  7 Mar 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCaSk0Bg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D118CC10;
	Fri,  7 Mar 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353868; cv=none; b=NOBT2VNeZ18XsMSWDcSxxeCd6vqyvK5gRJAW+83Omj9VYd3Dcc18Xq7tM7MRYgVu7GUtSYm8PZNecBTt+wQks9mi6YxYDB8G69eXNeuu2Rac6z6yxtdnGTLnGur60lr6UiO5xUaC/L/jeagJyPO54KkK6YpyuFgmMsxK0HYVWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353868; c=relaxed/simple;
	bh=6rgP9vhHzDhXIeeMY7SruHis1mPBRaG0gWZB3Xp80Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncqx/GSrCQzMjUb44/5Ew+tiPDoxc7lHaZHbbkfd1V+/76EkLkCOoKKoUUqdhVruXbd67DBHmzMtwNJkL3WFsvmeXgY6Glt7CYudBx5j5ptq4BZvi8ENCAHdkCRiDUy6DPT+2QoEbtpivOyOSCMG6A/TBmN6yNpG+/8N4zT+V4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCaSk0Bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC32C4CED1;
	Fri,  7 Mar 2025 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741353867;
	bh=6rgP9vhHzDhXIeeMY7SruHis1mPBRaG0gWZB3Xp80Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCaSk0BgFKbXTN/gpc8XAwgt9pZFho5e117sCcq3XEsNmU9PqYOCEWQtgsU/DN8ZQ
	 StcA1jDR4Bg1rjV+2HriRPrI8NGt0WgdoEJNfJDssbiyga41QR6yYbQI8Zn8osHCCF
	 1DQ92tufIXzpUvr3tHo7l16htVC0OS++echbf66+/HGTqaKlohKw+btkQ4JKTs+3OJ
	 NKYJHLStdd5v4hoykz+R9IOFDF2Sl5mE5VKs6vYCJTsjXAKrKlm67vGAQgCHAhzkEO
	 Vm4n+F+VoVsaDGvU+WoyxixxlaHCsdNWDUHXXMncnwY7ub5SRuDLSsFOJPBXoS4+En
	 G0V9JziINO58w==
Date: Fri, 7 Mar 2025 13:24:22 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrei Botila <andrei.botila@oss.nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <20250307132422.GH3666230@kernel.org>
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
 <20250304160619.181046-2-andrei.botila@oss.nxp.com>
 <7c14179c-0262-47e5-a13e-a53c2061da9b@redhat.com>
 <f37c7159-528d-4c58-b531-8d66757d2c16@oss.nxp.com>
 <d09c8547-550d-4ea1-8739-2bcf9e7c3fb0@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d09c8547-550d-4ea1-8739-2bcf9e7c3fb0@lunn.ch>

On Thu, Mar 06, 2025 at 04:35:12PM +0100, Andrew Lunn wrote:
> > >> +/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
> > >> +static void nxp_c45_tja1120_errata(struct phy_device *phydev)
> > >> +{
> > >> +	int silicon_version, sample_type;
> > >> +	bool macsec_ability;
> > >> +	int phy_abilities;
> > >> +	int ret = 0;
> > >> +
> > >> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
> > >> +	if (ret < 0)
> > >> +		return;
> > >> +
> > >> +	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
> > >> +	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
> > >> +		return;
> > >> +
> > >> +	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
> > >> +
> > >> +	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> > >> +				     VEND1_PORT_ABILITIES);
> > >> +	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
> > >> +	if ((!macsec_ability && silicon_version == 2) ||
> > >> +	    (macsec_ability && silicon_version == 1)) {
> > >> +		/* TJA1120/TJA1121 PHY configuration errata workaround.
> > >> +		 * Apply PHY writes sequence before link up.
> > >> +		 */
> > >> +		if (!macsec_ability) {
> > >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
> > >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
> > >> +		} else {
> > >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
> > >> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
> > >> +		}
> > >> +
> > >> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
> > >> +
> > >> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
> > >> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
> > >> +
> > >> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
> > >> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
> > > 
> > > Please add macro with meaningful names for all the magic numbers used
> > > above, thanks!
> > > 
> > > Paolo
> > > 
> > 
> > Hello, these registers are not documented in the datasheet or errata sheet.
> > The access sequence comes 1-to-1 from the errata so I couldn't use macros.
> 
> Yes, we sometimes just have to accept the drivers are doing magic we
> have no idea about because the vendor does not want to tell is. All
> the registers in MDIO_MMD_VEND1 are clearly vendor specific. The
> MDIO_MMD_PMAPMD registers are also in the range reserved for
> vendors. So i think we just have to accept it.

+1

It can happen that vendors regard such information as IP that they do
not wish to disclose. Not saying that is the case here. Just saying
it is one reason that we sometimes have to accept such things.
So I think what you say above is completely reasonable.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 

