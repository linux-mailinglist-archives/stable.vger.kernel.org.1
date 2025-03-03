Return-Path: <stable+bounces-120183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEDA4CD2C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45F018966A1
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6AD236435;
	Mon,  3 Mar 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="hhAMS7MQ"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF6214A91
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035998; cv=none; b=WkXHhkQGRd4jE7IvN6wKklz2tmptl+CIhWHhwLxmAi49XcRKj5+3K/5Vq/WEIvRTN8iKqRMqil66T0E4sIskLsgHEqzjdHxi+nzNbm1XAtd+txG51nYSjp8Y8vFsqxLwzNbjMwRGYo52Vf8V9P/8TMPSxaieLDFAYepgPtr2A5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035998; c=relaxed/simple;
	bh=jWG5TigqFmqAJ4CUg+iwF8c4+jmlQjaLQT8Sdry/QPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ACu4sh/3qAIG4iO8WoXQoWhve8XIc7cqEJoEXPv61SzOjVkzBRdz1Xv43oDqBNYLsL6I1lG703h9x9mv2LykJxOOzL9RfweETkSrwwtJZrnrC39UrmIX+r8/fqWnCxcoUkkhqyiRl8YZDq3JobsLgNJ7CYy5iNlwh8gPmvcJEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=hhAMS7MQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1741035981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KL0RgwYMwPDxX5LpzzMcHu60ayt30SuNBgN28Dcp7Hw=;
	b=hhAMS7MQqfegpHYoQsM7IHG8RpfHLNLMhR4NpVcSml6EfVHIhEBd4qnqJaEA+NcyD5UEXv
	/GZ+dPQlEnhRCREQPzmIhrhEwVWUhHTiHGUpktS++q2XO3w3N63tqaCybc5PSZoH6g/al5
	VHMtOXuLLRyk8cqN94xKgPB8c32YHT8VXhDkz0e0NEf1S06OOlTY5PoN7ijS99Zsd3wfS7
	5ntajLM2A3m523uU0iOKB9DUghxdu15t7m2J9qSWkRx+xTdtD6yfy+v4wL91Sih30/LZiM
	Xu48SnixKJi453V9kWQfHc39ouhljwhKPql4fRyG1l6Q9ccBKYfysSlsedZjzQ==
Content-Type: multipart/signed;
 boundary=3e1d67d79bc1372e9f689bf3a32389e21547715a78ffa78981b7ded1a50b;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 03 Mar 2025 22:06:04 +0100
Message-Id: <D86XQOCG7LJH.3NI330ETDBP5Z@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <chris@z9.de>, <stable@vger.kernel.org>, "Vincenzo Palazzo"
 <vincenzopalazzodev@gmail.com>, "Peter Geis" <pgwipeout@gmail.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, "Marek Kraus" <gamiee@pine64.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add missing PCIe supplies
 to RockPro64 board dtsi
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <cover.1740941097.git.dsimic@manjaro.org>
 <b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org>
In-Reply-To: <b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--3e1d67d79bc1372e9f689bf3a32389e21547715a78ffa78981b7ded1a50b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Sun Mar 2, 2025 at 7:48 PM CET, Dragan Simic wrote:
> Add missing "vpcie0v9-supply" and "vpcie1v8-supply" properties to the "pc=
ie0"
> node in the Pine64 RockPro64 board dtsi file.  This eliminates the follow=
ing
> warnings from the kernel log:
>
>   rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy reg=
ulator
>   rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy reg=
ulator
>
> These additions improve the accuracy of hardware description of the RockP=
ro64
> and, in theory, they should result in no functional changes to the way bo=
ard
> works after the changes, because the "vcca_0v9" and "vcca_1v8" regulators=
 are
> always enabled. [1][2]  However, extended reliability testing, performed =
by
> Chris, [3] has proven that the age-old issues with some PCI Express cards=
,
> when used with a Pine64 RockPro64, are also resolved.

Thanks for this patch :-)

I 'reported' the issue based on the logs I saw from other people, but
now that I have a RockPro64 (version 2.1) myself, I can confirm that
without this patch I saw those warnings myself.

When booted up without a PCIe card in the slot, I also saw these errors:
[    5.106650] rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout=
!
[    5.107373] rockchip-pcie f8000000.pcie: probe with driver rockchip-pcie=
 failed with error -110

You indicated that that was due to there being no PCIe card inserted.

After applying this patch I booted up my RockPro64 and found that the
above mentioned warnings are indeed gone.

Then I inserted a Renesas Electronics Corp. uPD720201 USB 3.0 Host
Controller in the PCIe slot and booted up.
The above mentioned errors were indeed gone.
Furthermore ``lspci`` showed that card and when I plugged in an USB 3
drive in one of the ports, it was correctly detected and I could mount
the partition on my system. So feel free to include:

Tested-by: Diederik de Haas <didi.debian@cknow.org>

Cheers,
  Diederik

> Those issues were already mentioned in the commit 43853e843aa6 (arm64: dt=
s:
> rockchip: Remove unsupported node from the Pinebook Pro dts, 2024-04-01),
> together with a brief description of the out-of-tree enumeration delay pa=
tch
> that reportedly resolves those issues.  In a nutshell, booting a RockPro6=
4
> with some PCI Express cards attached to it caused a kernel oops. [4]
>
> Symptomatically enough, to the commit author's best knowledge, only the P=
ine64
> RockPro64, out of all RK3399-based boards and devices supported upstream,=
 has
> been reported to suffer from those PCI Express issues, and only the RockP=
ro64
> had some of the PCI Express supplies missing in its DT.  Thus, perhaps so=
me
> weird timing issues exist that caused the "vcca_1v8" always-on regulator,
> which is part of the RK808 PMIC, to actually not be enabled before the PC=
I
> Express is initialized and enumerated on the RockPro64, causing oopses wi=
th
> some PCIe cards, and the aforementioned enumeration delay patch [4] proba=
bly
> acted as just a workaround for the underlying timing issue.
>
> Admittedly, the Pine64 RockPro64 is a bit specific board by having a stan=
dard
> PCI Express slot, allowing use of various standard cards, but pretty much
> standard PCI Express cards have been attached to other RK3399 boards as w=
ell,
> and the commit author is unaware ot such issues reported for them.
>
> It's quite hard to be sure that the PCI Express issues are fully resolved=
 by
> these additions to the DT, without some really extensive and time-consumi=
ng
> testing.  However, these additions to the DT can result in good things an=
d
> improvements anyway, making them perfectly safe from the standpoint of be=
ing
> unable to do any harm or cause some unforeseen regressions.
>
> Shuffle and reorder the "vpcie*-supply" properties a bit, so they're sort=
ed
> alphanumerically, which is a bit more logical and more useful than having
> these properties listed in their strict alphabetical order.
>
> These changes apply to the both supported hardware revisions of the Pine6=
4
> RockPro64, i.e. to the production-run revisions 2.0 and 2.1. [1][2]
>
> [1] https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> [2] https://files.pine64.org/doc/rockpro64/rockpro64_v20-SCH.pdf
> [3] https://z9.de/hedgedoc/s/nF4d5G7rg#reboot-tests-for-PCIe-improvements
> [4] https://lore.kernel.org/lkml/20230509153912.515218-1-vincenzopalazzod=
ev@gmail.com/T/#u
>
> Fixes: bba821f5479e ("arm64: dts: rockchip: add PCIe nodes on rk3399-rock=
pro64")
> Cc: stable@vger.kernel.org
> Cc: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> Cc: Peter Geis <pgwipeout@gmail.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Tested-by: Chris Vogel <chris@z9.de>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 47dc198706c8..41ee381ff81f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -673,8 +673,10 @@ &pcie0 {
>  	num-lanes =3D <4>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pcie_perst>;
> -	vpcie12v-supply =3D <&vcc12v_dcin>;
> +	vpcie0v9-supply =3D <&vcca_0v9>;
> +	vpcie1v8-supply =3D <&vcca_1v8>;
>  	vpcie3v3-supply =3D <&vcc3v3_pcie>;
> +	vpcie12v-supply =3D <&vcc12v_dcin>;
>  	status =3D "okay";
>  };
> =20


--3e1d67d79bc1372e9f689bf3a32389e21547715a78ffa78981b7ded1a50b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ8YZxQAKCRDXblvOeH7b
btp4AQCpxT1Wwlbg+zU1W+K7B20UFqP9NHEG0RITnzD0J3T3KQEAnWg5e7gb3kpe
v8idNl4faXofRHNasq3iEeMwbqLWQA0=
=fTAb
-----END PGP SIGNATURE-----

--3e1d67d79bc1372e9f689bf3a32389e21547715a78ffa78981b7ded1a50b--

