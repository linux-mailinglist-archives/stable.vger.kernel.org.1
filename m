Return-Path: <stable+bounces-75978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7829766D3
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D972840A3
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1D419FA65;
	Thu, 12 Sep 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IAdEHiUR"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEE1E51D;
	Thu, 12 Sep 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137680; cv=none; b=l/R8QPsKfwpEwlGb0SiPT4/AMru6RdWiGh0ulEBtvgQpal7jntKmBn8+L+Ac8sqPmOCFBocIX+8Hgsfa8oiiOi1T8zhoZA9V3Js73V9s2OVqW3nzbeDQM7xNvh+1cBp9rfMIknZGdhkco4epYCKJUnlGSPbhDmnRyp6L5DasZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137680; c=relaxed/simple;
	bh=jpfMi5Rm1Hk8MtZMwmhmcakH/o80RIYQBe//R+tRjcE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX1ec99sQZ0Z7YPc4+wPTAXaSQHAsHX+FPzL+jnvPY5VJVLTtKvJEC+OGgFhuY72gBwB47VgRFQsNKqQLplRS+zlu7G1PYg0ix73HpGWkeOboLK8pdwjYbsEBDm/FioD8W5dd2BRw3/MfMSp10qWCGS6stPDG/2KZeq8tALgAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IAdEHiUR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726137679; x=1757673679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpfMi5Rm1Hk8MtZMwmhmcakH/o80RIYQBe//R+tRjcE=;
  b=IAdEHiUR54VISxAhMHt0omH2HAdL9pNts0HN45cvEA22zXD9PAptiQnu
   uAMMFR5MPsWr+ZBXHXals2sVcaWrCxd67Fd+nkNXILSlC8/7N/zSdsJy+
   PKu1vuNu+gH06ZUndUkqbHNu8EWnaSBFbaNR5s5cY3XEwP4hL3O70qdXb
   IbzOgTEbE8gVwDd2RsKxpuNAb4N4prhY/tVgYBpWKCxDgJxAT5QyzFpQM
   MR+y6MtDCPUOLZdelKSwGbyPTDU6LnFwbde9bWcrxKABV9zJESUCXnsz7
   FGFxBLfPEEUaoaXJuDbqF1sKR/eyyzj+ZYvaoFquPjH4CDTeR7VGyZjw5
   g==;
X-CSE-ConnectionGUID: tqbkiD8eSzma3pF+wzscBA==
X-CSE-MsgGUID: Xax4C/E3Tu2vJ2YmG1yi8w==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="asc'?scan'208";a="31694078"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 03:41:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 03:40:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 12 Sep 2024 03:40:44 -0700
Date: Thu, 12 Sep 2024 11:40:11 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Hal Feng <hal.feng@starfivetech.com>
CC: WangYuli <wangyuli@uniontech.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "sashal@kernel.org" <sashal@kernel.org>,
	William Qiu <william.qiu@starfivetech.com>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>, Walker Chen
	<walker.chen@starfivetech.com>, "robh@kernel.org" <robh@kernel.org>,
	"kernel@esmil.dk" <kernel@esmil.dk>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 6.6 v2 3/4] riscv: dts: starfive: Add the nodes and pins
 of I2Srx/I2Stx0/I2Stx1
Message-ID: <20240912-lividly-remover-6d71b985a803@wendy>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
 <D2DCF9E2F70EDC93+20240912025539.1928223-3-wangyuli@uniontech.com>
 <ZQ2PR01MB13070BA638E892A5516DEA8CE6642@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jXCjevABJ3fUeyuz"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13070BA638E892A5516DEA8CE6642@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>

--jXCjevABJ3fUeyuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:23:09AM +0000, Hal Feng wrote:
> > On 12.09.24 10:55, WangYuli wrote:
> > +	i2srx_pins: i2srx-0 {
> > +		clk-sd-pins {
> > +			pinmux =3D <GPIOMUX(38, GPOUT_LOW,
> > +					      GPOEN_DISABLE,
> > +					      GPI_SYS_I2SRX_BCLK)>,
> > +				 <GPIOMUX(63, GPOUT_LOW,
> > +					      GPOEN_DISABLE,
> > +					      GPI_SYS_I2SRX_LRCK)>,
> > +				 <GPIOMUX(38, GPOUT_LOW,
> > +					      GPOEN_DISABLE,
> > +					      GPI_SYS_I2STX1_BCLK)>,
> > +				 <GPIOMUX(63, GPOUT_LOW,
> > +					      GPOEN_DISABLE,
> > +					      GPI_SYS_I2STX1_LRCK)>,
> > +				 <GPIOMUX(61, GPOUT_LOW,
> > +					      GPOEN_DISABLE,
> > +					      GPI_SYS_I2SRX_SDIN0)>;
> > +			input-enable;
> > +		};
> > +	};
> > +
> > +	i2stx1_pins: i2stx1-0 {
> > +		sd-pins {
> > +			pinmux =3D <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
> > +					      GPOEN_ENABLE,
> > +					      GPI_NONE)>;
> > +			bias-disable;
> > +			input-disable;
> > +		};
> > +	};
> > +
> > +	mclk_ext_pins: mclk-ext-0 {
> > +		mclk-ext-pins {
> > +			pinmux =3D <GPIOMUX(4, GPOUT_LOW,
> > +					     GPOEN_DISABLE,
> > +					     GPI_SYS_MCLK_EXT)>;
> > +			input-enable;
> > +		};
> > +	};
> > +
> >  	mmc0_pins: mmc0-0 {
> >  		 rst-pins {
> >  			pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
>=20
> The above changes had been reverted in commit e0503d47e93d in the mainlin=
e.
> Is it appropriate to merge this patch into the stable branch?
>=20
> https://lore.kernel.org/all/20240415125033.86909-1-hannah.peuckmann@canon=
ical.com/

Hah, I had gone looking this morning because I had a hunch that there
was some missing fix this series didn't, but couldn't remember what it
was. I completely forgot that some of this was non-present overlay
related stuff that had had to be reverted.

So yes, if it had to be reverted in mainline, it shouldn't get
backported. Thanks for spotting that Hal.

Cheers,
Conor.

--jXCjevABJ3fUeyuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuLFCwAKCRB4tDGHoIJi
0kLkAQDZzYyDnfaVx1KPdhfL5iMpjCffndWbDiKFnYhExyDQbAD/b8scbjJYHqJK
OHORY7atNwZsEw8jTLQpkmAFLu/VRAc=
=3sWz
-----END PGP SIGNATURE-----

--jXCjevABJ3fUeyuz--

