Return-Path: <stable+bounces-118676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B3A40C31
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 00:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679ED7ACC2E
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D7204F88;
	Sat, 22 Feb 2025 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1M2KCIl0"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3226202C24;
	Sat, 22 Feb 2025 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268112; cv=none; b=HfeJZnj3Uf9i/ESOgtmfsxMTj1CZeoOPzAT8AYcqTrhYZQFFTMtTqqtMv20jphiR/atDM/vK6M8+uL622KcVv+dgiT8IecaXADlg9cUw0IIM+OX8haWi3R3lae5fQS8nlILnuvUrRqZ41GwZluJK2itSBp2ynwVkWwVfPq29dI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268112; c=relaxed/simple;
	bh=UqYdF5iwKVG31GpgfQOmFZ8Iy7Futv9BjukkWDjyFc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyBWOPzEFndYN01HDzkw3zZbNk7g0CGX5hoLKc++R1fhc9ra7lQBih6eUXuzYxb6/kI64Un6rb+RLQUEwfbLbZmWnMsuahaFFhRL5qAP61k0sOUiCaCUw0d9fC7KqWHVk0GKRndZ/omBgBy2cPzuLXwIe1GFeMm2LKq2Kj83Tj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1M2KCIl0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5tD/n9p77JLIQnsXhSkhebyHF5kKTn39LJUodlTkHgk=; b=1M2KCIl0fzgWFlfeseAap/GMIX
	UBEUlJlSaRdsFDrhiemPWzgPVbx3B+LnJp0y7LMlYUPIXN7biIF5TKPpCZLGidhJG8ucDkPv1ZOmk
	/a3CK2K7NwJ9PFOIWlcOzM+XabT2gzOqXrQ2JQmjw/pd4dSSUR0lWKNcxq7HOGIUoKHxqUrLe0RgK
	adKjocvTDFbO7Ib20w9J5J3Wl3CBijPs2WesLDymFn9sYj06Lcmir+jW0GY1q0lTu7lkWr4i1ruem
	PpVfcSJ3KK11Az330+SuBgBVKtrR3PWsfM/KcZe/tuVH6wYLepY33t5bq4vOKqjzvw5yOtyUvXUY0
	6/A3lznw==;
Received: from i53875a10.versanet.de ([83.135.90.16] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlzEO-0004TL-QF; Sun, 23 Feb 2025 00:48:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] (subset) arm64: dts: rockchip: pinmux fixes and support for 2 adapters for Theobroma boards
Date: Sun, 23 Feb 2025 00:48:18 +0100
Message-ID: <174026756671.3008209.2772154778070237628.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
References: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Feb 2025 15:04:32 +0100, Quentin Schulz wrote:
> This is based on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v6.15-armsoc/dts64
> 6ee0b9ad3995 ("arm64: dts: rockchip: Add rng node to RK3588") as it
> depends on the (merged) series from
> https://lore.kernel.org/all/20250211-pre-ict-jaguar-v6-0-4484b0f88cfc@cherry.de/
> 
> Patches for Haikou Video Demo adapter for PX30 Ringneck and RK3399 Puma
> (patches 4 and 5) also depend on the following patch series:
> https://lore.kernel.org/linux-devicetree/20250220-pca976x-reset-driver-v1-0-6abbf043050e@cherry.de/
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: rockchip: add support for HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
[4/5] arm64: dts: rockchip: add overlay for PX30 Ringneck Haikou Video Demo adapter
[5/5] arm64: dts: rockchip: add overlay for RK3399 Puma Haikou Video Demo adapter

I've not taken the uart pinctrl patches, as they seem to conflict with
Lucasz' Ringneck pinctrl patches that moved into 6.14-rc now.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4eee627ea59304cdd66c5d4194ef13486a6c44fc


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

