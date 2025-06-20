Return-Path: <stable+bounces-155010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A86AE1691
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CE01883792
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4A266561;
	Fri, 20 Jun 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kAG2XmNt"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E623717F;
	Fri, 20 Jun 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409063; cv=none; b=Ul040v7QT2fPvylDhnWUUSaItF7j6L8nB3PZasOwsNpFu+CYYKmZ20MYiT/umt68hTBnm1lgty6ATCAjqmtVj6agABieI/CXNZ+KWoRUcV/5t1RRRCMnn0UoLt4TByvC7VThA1GcANDm+YYjbA6XjBIEZxUuPh+ta4NkrjoqpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409063; c=relaxed/simple;
	bh=Gt3fX70SHPx2FTGs0tJC6o/fQKTlAAmFGFVysVD1R1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bk6Ada3REXK73QDt3rUXxXfDlqe5NURPPFYPdSGXe2e1D4mizkVSiy6PG7nNJGdqWmGT9RVicUF0apsXtqbC+qJmNVH0/Mur8Ny2HY9DjU00IMirh4XfV1Bz0HCx2Hxx1HcpgBHAH8UKDXEbqzS4Xs7f56AbO8YTSnStsO84HIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kAG2XmNt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=2s1EfWhxZp+wUTpU6Av5sVxwB2ULwd+lJ/meBWs9Yxw=; b=kAG2XmNtW0d1LmL2rKWT6Lc/QX
	SOz6rnT0Lf4mLMiWEdu+MrXH2fAX12ZY4taDEwh3skekpPZaMOtfzgTWyUfwLAp1H3Y+U3ZQzHMj6
	r3dU5uIdxxv1pk2lk6bG5ADNU4W1XP0eA2O4VDOqTIBXnSxEoe4b1hsbdOAd+2VN+GbYQJk2SbFRT
	2gJFf/sXWDj53EnwotPMjuB20DX+VaDNAUvGbGO/BZCom166KZVRBQgiqAw/DX9tIfHH43d2QBsUG
	5G1P8jwrqMj3gP/BDb79MEdnrK2Dpd+tqftocvtzcPDkaeEmG2zDEU+NoO3bBS/SyoyYypq2tiy2D
	EjHMgqZA==;
Received: from 85-207-219-154.static.bluetone.cz ([85.207.219.154] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uSXM7-0007ky-L9; Fri, 20 Jun 2025 10:44:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Detlev Casanova <detlev.casanova@collabora.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject:
 Re: [PATCH v2 0/4] arm64: dts: rockchip: enable further peripherals on ArmSoM
 Sige5
Date: Fri, 20 Jun 2025 10:44:14 +0200
Message-ID: <5004008.8F6SAcFxjW@phil>
In-Reply-To:
 <CABjd4Yzz9mh0G5BhpPOGAoadD-A5eX4kdsF8rGrWk82hAE-MYQ@mail.gmail.com>
References:
 <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
 <175036770856.1520003.17823147228060153634.b4-ty@sntech.de>
 <CABjd4Yzz9mh0G5BhpPOGAoadD-A5eX4kdsF8rGrWk82hAE-MYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 20. Juni 2025, 10:40:49 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Alexey Charkov:
> On Fri, Jun 20, 2025 at 1:17=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> =
wrote:
> >
> >
> > On Sat, 14 Jun 2025 22:14:32 +0400, Alexey Charkov wrote:
> > > Link up the CPU regulators for DVFS, enable WiFi and Bluetooth.
> > >
> > > Different board versions use different incompatible WiFi/Bluetooth mo=
dules
> > > so split the version-specific bits out into an overlay. Basic WiFi
> > > functionality works even without an overlay, but OOB interrupts and
> > > all Bluetooth stuff requires one.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/4] arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5
> >       commit: c76bcc7d1f24e90a2d7b98d1e523d7524269fc56
> > [2/4] arm64: dts: rockchip: add SDIO controller on RK3576
> >       commit: e490f854b46369b096f3d09c0c6a00f340425136
> > [3/4] arm64: dts: rockchip: add version-independent WiFi/BT nodes on Si=
ge5
> >       commit: 358ccc1d8b242b8c659e5e177caef174624e8cb6
> > [4/4] arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5=
 v1.2
> >       commit: a8cdcbe6a9f64f56ee24c9e8325fb89cf41a5d63
> >
> > Patch 1 as fix for v6.16
> >
> > I've also fixed the wifi@1 node in the overlay - which was using
> > spaces instead of tabs.
>=20
> Thanks Heiko! It's annoying that YAML doesn't like tabs, so copying
> from binding examples is not a universally good idea :)
>=20
> By the way, is there any tool that helps catch those?

checkpatch.pl would be the tool to do that, but I'm not sure it handles
this at this time.

I also only saw things when I looked at the patch in "mcedit", because
it nicely distinguishes between tabs and spaces :-) .





