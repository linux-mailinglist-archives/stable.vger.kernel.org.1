Return-Path: <stable+bounces-210461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D89D3C349
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6AB686148
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B233B961E;
	Tue, 20 Jan 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EEUU3Ttc"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667783B8D65;
	Tue, 20 Jan 2026 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899371; cv=none; b=jiMO55GkbSdF5Oul2RLsCvaKAxtvf3891B2eIh4WPjK/wsOX+JJdLPDyJGjXFR1FN6jCRiRK65FqrkntK3lQyZj+lXEixubNWTNV0707gi1SCySqzhU/vVr9i1e/jQl8H95stEXP/pBCa3hNF/dDVOII1EuEuZqEVF1qXq6L6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899371; c=relaxed/simple;
	bh=dxgtuw6/eiHYsPsz91G2+s/blRfxmN8N4VduCGdXThM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsFqcoJpU87zWxWGfRKeUlqU/MetwbeJc8vMnaHStipHZAUnzUe2GcH2cgJKU5qHgf3z5XlP7VT0PAmuBx8y33gIq73W0zApr9jQEK4L+Er0CmuhsvKf6EDnHeq9zLSvUPbBBD4TudCzQoVfM+QGert1w1IM4NNWBpoK0TeVuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EEUU3Ttc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=dxgtuw6/eiHYsPsz91G2+s/blRfxmN8N4VduCGdXThM=; b=EEUU3TtcX15TaXsTpy+efUZgnr
	GvRN3Wul0JrdfXvzmqZFYEm9I5Uuv2B2EaNTsD6vtuVQ2+71/Bp0nMxYDfQreGXBBUP8E75DD691R
	sAIRMetPw+PlnHZgC9fXRBVhvGFkXks8VAGKpYofCqbwcrnGs2p5BTnF2BLcVEKn8IjMgEHdbP4kL
	vuJxuwoN8jvH8O5oN6rX7N6gVXJ1b2PMiViNfcUxHagz6JNq/xpOXqaAQAnK0ZGMXv6M0VDImvFsR
	LMq0DtfiImIzlNlKYk4TEmnqJ22gXd2Z3+oQymTtqHxJ9fB9TTcxhaeEAlz4ysIznmFaON5yNz4x1
	QaakdUVA==;
Received: from [192.76.154.230] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vi7Wm-003K6A-Kw; Tue, 20 Jan 2026 09:55:57 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, Quentin Schulz <quentin.schulz@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
Date: Tue, 20 Jan 2026 09:55:56 +0100
Message-ID: <5743823.mogB4TqSGs@phil>
In-Reply-To: <6479d7b8-7712-4181-9c82-0021da94d1a8@rock-chips.com>
References:
 <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
 <6479d7b8-7712-4181-9c82-0021da94d1a8@rock-chips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 20. Januar 2026, 02:39:28 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Shawn Lin:
> =E5=9C=A8 2026/01/19 =E6=98=9F=E6=9C=9F=E4=B8=80 17:22, Alexey Charkov =
=E5=86=99=E9=81=93:
> > Rockchip RK3576 UFS controller uses a dedicated pin to reset the connec=
ted
> > UFS device, which can operate either in a hardware controlled mode or a=
s a
> > GPIO pin.
> >=20
>=20
> It's the only one 1.2V IO could be used on RK3576 to reset ufs devices,
> except ufs refclk. So it's a dedicated pin for sure if using ufs, that's
> why we put it into rk3576.dtsi.
>=20
> > Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> > hardware controlled mode if it uses UFS to load the next boot stage.
> >=20
>=20
> ROM code could be specific, but the linux/loader driver is compatible=EF=
=BC=8C
> so for the coming SoCs, with more 1.2V IO could be used, it's more
> flexible to use gpio-based instead of hardware controlled(of course,
> move reset pinctrl settings into board dts).
>=20
> > Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> > device reset, request the required pin config explicitly.
> >=20
> > This doesn't appear to affect Linux, but it does affect U-boot:
> >=20
>=20
> IIUC, it's more or less a fix for loader, more precisely U-boot here?
> I'm not entirely certain about the handling here, is it standard
> convention to add a fixes tag in this context?

Yes, a fixes tag is warranted here, in Linux it "only" fixes a potential
issue due to the mismatch between pinconfig and gpio during probe.

nce this patch then enters the kernel, it can be cherry-picked to
the current u-boot development cycle. I don't think u-boot is doing
stable releases though, so U-Boot will only profit for the next
version where this is included.

Heiko



