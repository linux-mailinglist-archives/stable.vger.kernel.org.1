Return-Path: <stable+bounces-206028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA85CFAACA
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6CA3201629
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CF2C029F;
	Tue,  6 Jan 2026 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ExHSgkXp"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2A27EFEE;
	Tue,  6 Jan 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725258; cv=none; b=A0Oav7D4iXDUgatNLOGeby1aMNCggePlsrMgnk+e7CmyShPXyOPX67iXkVgQv/F7Bc4d7RfJ1UZ4AcdMJ+0wW58Fi87s+GZzAPPm9GamqHxbqhd5RXWZuvVuykwn2bjusZXoRBSbhabtDX4Ko1mpitapYJKCZ4dr3x9hMu9/vLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725258; c=relaxed/simple;
	bh=95YVTR6nzXuF4GRhKpvASGVjjvw9o1+uk+ybtcqsFJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFaFWoh/dkkOOM/6AGQk1zUPAoDsd/qs/fQ9mCXA20de76LBj68YeY+lg4Jd4d8sa8vO2xl4OTaRzYmPFqG+MKeZ0cxfMNkdisjsg3QFT97B2f51fK/XrGsjGXo9KNs6lYRz34bLf4hTZUTvvoQyfM65s40MLgT64AtyItD0zrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ExHSgkXp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=P9FdgrVyF+ltzH5J8V9yVqvYq81tGjbEns+yQFUcek8=; b=ExHSgkXp+eGbtuOCRautigGMhZ
	903f7A5W7kymSzuJcFPWVSrqaAmiBfO8K1feB2nbOxcwKNo2bHmy+T1+JSUTvEdo9UmVguWgaUxbS
	22+43FS7v0h8io5HN6RA4FeCK/JQs+86itDMaO52JDSl1NlDPqvin/L0o3xqq/T6pj4/siyRE8/rZ
	QQEG28Kvn/dmuQDqt3umW0xYLTbwgSeaRMIa2zaDFrH/W1mYFba4tJB3et2dT3Ab+NDO2su2dKUUl
	fryfb/5DW8NOZ6AJD/xpNENOZXoehWv5g9g2vi3OLjb8VRpZoiIPpVQieAXdFMWdCSMl2K+NuWNi+
	QOlLLg4A==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vdC5b-001HlT-V4; Tue, 06 Jan 2026 19:47:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, John Clark <inindev@gmail.com>,
 Alexey Charkov <alchark@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH 0/7] arm64: dts: rockchip: Sound fixes and additions on RK3576
 boards
Date: Tue, 06 Jan 2026 19:47:31 +0100
Message-ID: <4068253.BddDVKsqQX@phil>
In-Reply-To: <176772487188.3029798.5459621815338520362.b4-ty@sntech.de>
References:
 <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
 <176772487188.3029798.5459621815338520362.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 6. Januar 2026, 19:41:55 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Heiko Stuebner:
>=20
> On Mon, 29 Dec 2025 14:11:57 +0400, Alexey Charkov wrote:
> > Here are some device tree updates to improve sound output on RK3576
> > boards.
> >=20
> > The first two patches fix analog audio output on FriendlyElec NanoPi M5,
> > as it doesn't work with the current device tree.
> >=20
> > The third one is purely cosmetic, to present a more user-friendly sound
> > card name to the userspace on NanoPi M5.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/7] arm64: dts: rockchip: Fix headphones widget name on NanoPi M5
>       commit: 5ab3dd9d0a63af66377f58633fec9dad650e6827
> [2/7] arm64: dts: rockchip: Configure MCLK for analog sound on NanoPi M5
>       commit: 3e4a81881c0929b21a0577bc6e69514c09da5c3f
> [3/7] arm64: dts: rockchip: Use a readable audio card name on NanoPi M5
>       commit: 309598fca339abd4e8eef0efe0d630714ca79ac9
> [4/7] arm64: dts: rockchip: Enable HDMI sound on FriendlyElec NanoPi M5
>       commit: bde555926b61740c6256a38a9cf5a4833be345cc
> [5/7] arm64: dts: rockchip: Enable HDMI sound on Luckfox Core3576
>       commit: 87af7643234a2b4cb49a97dfe7fb455633b3185d
> [6/7] arm64: dts: rockchip: Enable HDMI sound on RK3576 EVB1
>       commit: f5c9549964adbac931e163693bd17db872976679
> [7/7] arm64: dts: rockchip: Enable analog sound on RK3576 EVB1
>       commit: d8872b9dd9208c493f1f3811d42997fb968de064

=46orgot to add, thankfully the fixes + enablement don't depend on each
other, so I've applied patches 1+2 to my fixes branch for 6.19
and the rest for 6.20.


Heiko



