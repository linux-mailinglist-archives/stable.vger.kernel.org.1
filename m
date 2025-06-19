Return-Path: <stable+bounces-154831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B32AE0EE8
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF113BAD92
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E169248F7C;
	Thu, 19 Jun 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QH8mXZfz"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADE2206BF;
	Thu, 19 Jun 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367864; cv=none; b=IbQge4Is4WwHc+rIBWyGDzoRfxHipOEU5s2sK+Vkxuf0igqroodI84NkN7IGdQ1nVhk1iRbwYG6BBogwFkTZzwuUNs9qChw7h/Vy8t6vlpEv1HlkkmrFA3TTW/cO9DyDCAfYic4GBHvkX62Cpj1MUbEX7L/WqO1CMup0JscQxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367864; c=relaxed/simple;
	bh=emGQpgfZNVxPTF8CtUoR2PPOZht/3gzFE34gP6kZ2DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBCblIqOcNmNE0UuIucJhPfRtsM4F54Cc3eirhdxOpPayQkRiSymGXeskffPTy58XVl04K8v8aY3uGIlSw/gJVTCDUm65oGQLORbzZ8biR0AsLv6BtsatYCML0IwwcWo1MFGpEzPIeXJ4B46gC/Yw+bQMh2rZhhEMbI4bO6hDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QH8mXZfz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=136gTLj/Y0HhKLYdP9vuRieftyoXRpz7sdT5yNch5VM=; b=QH8mXZfzmnidfYF+tyRI3+PsbV
	fxoIuns/M44n0uG2Rc67+usaCePYkFX2F2F8H/5wHsZiF2KC9SlXbAz9fLsmH3CxwBH1plmPQwl0Z
	unBdqRs/Id2fE+ud78jwRICesEYhjpCZF4u7D8Yaa5/gE8M9gd6pwc3Dya2l3k9KdjcWR4BRIzwpv
	vACAr1YnOCPHLPmksbrWoms9ZBGLA2TXeaxbRWBbak5VHH95WwioBatFoSZRFXD/Z73wlsAnIVZJN
	mARKVOwdRzT+AHt+NJkkVYjjNIbXrHprV3uqIUQlWBC1UYSCqDrxgxWJlu7nEakbPjkvKfAh4g5Y8
	+1OIpuZg==;
Received: from 85-207-219-154.static.bluetone.cz ([85.207.219.154] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uSMdd-0007fA-Cl; Thu, 19 Jun 2025 23:17:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: enable further peripherals on ArmSoM Sige5
Date: Thu, 19 Jun 2025 23:17:24 +0200
Message-ID: <175036770856.1520003.17823147228060153634.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
References: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 14 Jun 2025 22:14:32 +0400, Alexey Charkov wrote:
> Link up the CPU regulators for DVFS, enable WiFi and Bluetooth.
> 
> Different board versions use different incompatible WiFi/Bluetooth modules
> so split the version-specific bits out into an overlay. Basic WiFi
> functionality works even without an overlay, but OOB interrupts and
> all Bluetooth stuff requires one.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5
      commit: c76bcc7d1f24e90a2d7b98d1e523d7524269fc56
[2/4] arm64: dts: rockchip: add SDIO controller on RK3576
      commit: e490f854b46369b096f3d09c0c6a00f340425136
[3/4] arm64: dts: rockchip: add version-independent WiFi/BT nodes on Sige5
      commit: 358ccc1d8b242b8c659e5e177caef174624e8cb6
[4/4] arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5 v1.2
      commit: a8cdcbe6a9f64f56ee24c9e8325fb89cf41a5d63

Patch 1 as fix for v6.16

I've also fixed the wifi@1 node in the overlay - which was using
spaces instead of tabs.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

