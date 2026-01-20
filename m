Return-Path: <stable+bounces-210477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12855D3C581
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5DF85A70B2
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083E3EDAA7;
	Tue, 20 Jan 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XSPs81KH"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A703ED11E;
	Tue, 20 Jan 2026 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904781; cv=none; b=sJEadh7EYzvgkB52pN7usASfaxmRb4KogoeRBGOmDKxuWoph0I3p3jhIMB8EXA6AxDND9GxYbjcEFhNH1OtjlFYjKeJMt6cn7uZwPkqEV0DaTrQruqKX8KAJrrbaWskh18rUeREnjrLcvyzavQrvSqDD0zX3DNgejfRK7ASlg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904781; c=relaxed/simple;
	bh=9diJR4kQZN+k/wbWqdTO6OI+/69IKXx1J/s9tKfVwNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJE8kRHxywwlIUfNi7zKU7E89tBSPWl7QnlB5chCGRTrS2pM0Lh4p7w2VeX9RnG14LYX9FMkyjJSvwk1OVNd1hpEEA4FpmvyTTihKeCIIBhxPOTG36a2Fj7Ou6B0bBrjf4j96N0RIpL9PcNCC65pyz92QuqkoiORvSUrMyKWw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XSPs81KH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=9diJR4kQZN+k/wbWqdTO6OI+/69IKXx1J/s9tKfVwNY=; b=XSPs81KHpZHhgt4vtOmZ7ONpWU
	Tzy1oFkhZq1dlMTqezc1Wp9D+9yA9sUuuBvcclPnRRb+r58xL8GsH+5a+RREbLfVd6N4FpoxBlDOs
	kqhk7o4uqD5ckBIWQmcW2nY+LC6w4h5oflfemO6nHeTZJxM/A4puTk1SIF7bF3RZnY3I43vNWgF3D
	R3BExg8bBa6b4Ki6C8sdL1FM+Se4MssShty8MlMnExKElAMOZQySHhLDIkTDsphbqwUaGd4Jz1fCM
	w96x4RqiTQe1XLY4K8po3yd5Pzhq6NHJORLR/4GFeQ8gi1mPdgM3bJlZh7xJJgBVEtu5T7pC5BAF8
	yUrUN0nQ==;
Received: from [192.76.154.238] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vi8w6-003MaT-5E; Tue, 20 Jan 2026 11:26:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
Date: Tue, 20 Jan 2026 11:26:09 +0100
Message-ID: <4253761.Y6S9NjorxK@phil>
In-Reply-To: <8df14d73-8e20-4d89-89eb-d40f27814d2d@cherry.de>
References:
 <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com> <5743823.mogB4TqSGs@phil>
 <8df14d73-8e20-4d89-89eb-d40f27814d2d@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 20. Januar 2026, 11:21:34 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Quentin Schulz:
> Hi Heiko,
>=20
> On 1/20/26 9:55 AM, Heiko Stuebner wrote:
> > Am Dienstag, 20. Januar 2026, 02:39:28 Mitteleurop=C3=A4ische Normalzei=
t schrieb Shawn Lin:
> >> =E5=9C=A8 2026/01/19 =E6=98=9F=E6=9C=9F=E4=B8=80 17:22, Alexey Charkov=
 =E5=86=99=E9=81=93:
> >>> Rockchip RK3576 UFS controller uses a dedicated pin to reset the conn=
ected
> >>> UFS device, which can operate either in a hardware controlled mode or=
 as a
> >>> GPIO pin.
> >>>
> >>
> >> It's the only one 1.2V IO could be used on RK3576 to reset ufs devices,
> >> except ufs refclk. So it's a dedicated pin for sure if using ufs, that=
's
> >> why we put it into rk3576.dtsi.
> >>
> >>> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> >>> hardware controlled mode if it uses UFS to load the next boot stage.
> >>>
> >>
> >> ROM code could be specific, but the linux/loader driver is compatible=
=EF=BC=8C
> >> so for the coming SoCs, with more 1.2V IO could be used, it's more
> >> flexible to use gpio-based instead of hardware controlled(of course,
> >> move reset pinctrl settings into board dts).
> >>
> >>> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controll=
ed
> >>> device reset, request the required pin config explicitly.
> >>>
> >>> This doesn't appear to affect Linux, but it does affect U-boot:
> >>>
> >>
> >> IIUC, it's more or less a fix for loader, more precisely U-boot here?
> >> I'm not entirely certain about the handling here, is it standard
> >> convention to add a fixes tag in this context?
> >=20
> > Yes, a fixes tag is warranted here, in Linux it "only" fixes a potential
> > issue due to the mismatch between pinconfig and gpio during probe.
> >=20
> > nce this patch then enters the kernel, it can be cherry-picked to
> > the current u-boot development cycle. I don't think u-boot is doing
> > stable releases though, so U-Boot will only profit for the next
> > version where this is included.
> >=20
>=20
> U-Boot only takes what's in devicetree-rebasing=20
> (https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-re=
basing.git),=20
> so only from Linus's tree AFAICT. C.f.=20
> https://docs.u-boot.org/en/latest/develop/process.html#resyncing-of-the-d=
evice-tree-subtree=20
> and=20
> https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resynci=
ng-with-devicetree-rebasing.=20
> See also OF_UPSTREAM Kconfig symbol in U-Boot.
>=20
> This policy does make adding support for a new board quite slow as we=20
> may need to wait months before it makes it to Linus's tree, and then go=20
> through the development cycle in U-Boot which can also take a few months=
=20
> if the timing is unfortunate. For now it seems like we're sticking with=20
> this policy to avoid too much in "downstream" DT in U-Boot. I know we=20
> push for this aggressively for new Rockchip boards and SoCs, cannot say=20
> for other vendors.

Yeah, this is what I "meant", but explained badly :-)

Also this is the reason I'd like that v2 soon'ish, that it can make its
way still into 6.20-rc1 and thus into u-boot.



