Return-Path: <stable+bounces-38609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB68A0F83
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EAD1C21F42
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0FB146A77;
	Thu, 11 Apr 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KeofZmfu"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A6145B1A;
	Thu, 11 Apr 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831073; cv=none; b=ff/KUuNVf8mmD1n9IB5xRKkZusH2yvlib05YhAn44JxBX0KY7tenjP125pO3IpYg2+kjhIL6rhPMYjCzqbggATnePLq0FFO1L9tPQWtAwsFajv5wyqkI7B4MDtWS42EbI52YVrcv0vplVEx9UbVpY51KuspiEp734KlBWY4uSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831073; c=relaxed/simple;
	bh=nERzK6uiUZmiT9uae4iEiVGyGqgmGE6wJ6Z+kdvG0EY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slxt/wGAdCoHcI2GxLVK3hM8ymTSDokubMgkiSDpGJTURPoUIBt6GlLhZ41rdVOh0jgKnBONbOd0pNCzPco/eeXOkIV0fTqOnHW60nr3S5337V1FPK4pmeZu514y+X5swyIzmanFhrmAXx/V7equCz4mi3rSrhLoSpzxB9v+Lg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KeofZmfu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712831070; x=1744367070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nERzK6uiUZmiT9uae4iEiVGyGqgmGE6wJ6Z+kdvG0EY=;
  b=KeofZmfu1Hr3uRCikWJBMuQ04ipFrNLyhf5drBqNUbz7W3X0JkqCiXLV
   je/m88vXmsdDYDu6hgqVyOvT3pVo6mvwGqc5ibKK8YzO25QsCmAkyAhPG
   KtU/uOn73wPCClx+kdApSN3nDofl+rgzduKlx7nvuHUe197BF9vaTZTTP
   1wY6ZgyojF1smJhFknoCjXqPI1C9YdzMsWXqjzwxTLweWqpvL3JSirNHt
   R4DAZWWIKLw8qpJb4AINwmv4eaEoxKjVib0e8PZydY1r9T2EU+EuV9Ewm
   i98I1NKgfzt36tAI4YJk2CGDLSojaUzsF+yWtIBMG6YGAlq4L5oxsl6Dy
   g==;
X-CSE-ConnectionGUID: /nGzhmOARjCQo+iBZ8UVyg==
X-CSE-MsgGUID: De4qIDupQOexzJuRvjc1gA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708412400"; 
   d="asc'?scan'208";a="20498401"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:24:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 03:24:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Apr 2024 03:24:11 -0700
Date: Thu, 11 Apr 2024 11:23:20 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Sasha Levin <sashal@kernel.org>
CC: Greg KH <greg@kroah.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	<stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
	<buddyjojo06@outlook.com>, Bjorn Andersson <andersson@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
Message-ID: <20240411-expectant-daylight-398929f2733b@wendy>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
 <2024041132-heaviness-jasmine-d2d5@gregkh>
 <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>
 <2024041112-shank-winking-0b54@gregkh>
 <ZheX3KdUA76wTYMF@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xPJn6G/gKNn10dGm"
Content-Disposition: inline
In-Reply-To: <ZheX3KdUA76wTYMF@sashalap>

--xPJn6G/gKNn10dGm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 03:57:16AM -0400, Sasha Levin wrote:
> On Thu, Apr 11, 2024 at 09:34:39AM +0200, Greg KH wrote:
> > On Thu, Apr 11, 2024 at 09:27:28AM +0200, Krzysztof Kozlowski wrote:
> > > On 11/04/2024 09:22, Greg KH wrote:
> > > > On Wed, Apr 10, 2024 at 08:24:49PM +0200, Krzysztof Kozlowski wrote:
> > > >> On 10/04/2024 20:02, Greg KH wrote:
> > > >>> On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
> > > >>>>
> > > >>>>
> > > >>>> On 4/10/24 17:57, Sasha Levin wrote:
> > > >>>>> This is a note to let you know that I've just added the patch t=
itled
> > > >>>>>
> > > >>>>>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
> > > >>>>
> > > >>>> autosel has been reeaaaaaly going over the top lately, particula=
rly
> > > >>>> with dts patches.. I'm not sure adding support for a device is
> > > >>>> something that should go to stable
> > > >>>
> > > >>> Simple device ids and quirks have always been stable material.
> > > >>>
> > > >>
> > > >> That's true, but maybe DTS should have an exception. I guess you t=
hink
> > > >> this is trivial device ID, because the patch contents is small. Bu=
t it
> > > >> is or it can be misleading. The patch adds new small DTS file which
> > > >> includes another file:
> > > >>
> > > >> 	#include "sm7125-xiaomi-common.dtsi"
> > > >>
> > > >> Which includes another 7 files:
> > > >>
> > > >> 	#include <dt-bindings/arm/qcom,ids.h>
> > > >> 	#include <dt-bindings/firmware/qcom,scm.h>
> > > >> 	#include <dt-bindings/gpio/gpio.h>
> > > >> 	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > > >> 	#include "sm7125.dtsi"
> > > >> 	#include "pm6150.dtsi"
> > > >> 	#include "pm6150l.dtsi"
> > > >>
> > > >> Out of which last three are likely to be changing as well.
> > > >>
> > > >> This means that following workflow is reasonable and likely:
> > > >> 1. Add sm7125.dtsi (or pm6150.dtsi or pm6150l.dtsi)
> > > >> 2. Add some sm7125 board (out of scope here).
> > > >> 3. Release new kernel, e.g. v6.7.
> > > >> 4. Make more changes to sm7125.dtsi
> > > >> 5. The patch discussed here, so one adding sm7125-xiaomi-curtana.d=
ts.
> > > >>
> > > >> Now if you backport only (5) above, without (4), it won't work. Mi=
ght
> > > >> compile, might not. Even if it compiles, might not work.
> > > >>
> > > >> The step (4) here might be small, but might be big as well.
> > > >
> > > > Fair enough.  So should we drop this change?
> > >=20
> > > I vote for dropping. Also, I think such DTS patches should not be pic=
ked
> > > automatically via AUTOSEL. Manual backports or targetted Cc-stable,
> > > assuming that backporter investigated it, seem ok.
> >=20
> > Sasha now dropped this, thanks.
> >=20
> > Sasha, want to add dts changes to the AUTOSEL "deny-list"?
>=20
> Sure, this makes sense.

Does it? Seems like a rather big hammer to me. I totally understand
blocking the addition of new dts files to stable, but there's a whole
load of different people maintaining dts files with differing levels of
remembering to cc stable explicitly.

That said, often a dts backport depends on a driver (or binding) change
too, so backporting one without the other may have no effect. I have no
idea whether or not AUTOSEL is capable of picking out those sort of
dependencies.

--xPJn6G/gKNn10dGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhe6GAAKCRB4tDGHoIJi
0uE0AP4t44RM2m08xk6BhJsEsbugiQef6L7NtyZUnX+MWb1U6wEA5yfC1pcGgJni
kVDblylU83zqcpzjqZS26dlb7zj/NA8=
=5Zd7
-----END PGP SIGNATURE-----

--xPJn6G/gKNn10dGm--

