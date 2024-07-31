Return-Path: <stable+bounces-64761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56377942D51
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A67283174
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4121AD9D9;
	Wed, 31 Jul 2024 11:36:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9C1AC447;
	Wed, 31 Jul 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425769; cv=none; b=R5Es8n+PrmaiFGa3qYPoouzDzvZVOeW6UDU4YbqgqQh5YbPSXyWsBAiuJLXlBa620HrlJcRFi3z/lr8xTH0OWn3ozDfqxYA/Ufai4MFHoZtVwsZ4Pqp4AxznehKh05sD31HkA7T3kR8/crv8fHheV1U4VYWhyHb/QAKAs6ToBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425769; c=relaxed/simple;
	bh=6vTBV9+mdhv+EHYrb1lvIvVGi44E3Oq+SM9h5Vo2K2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3Jc+iXOBPJoy3tVBsvYZzCYsg/Op7ibxxgFdjVi76oU/Zpet8Mto0G0ZqfH28lr+vQsNBUSoVsCrn5wJp7V4rUb5XWjU68/vEg9M0nNUbHJW3S4KGyagEkZk7xeHaXTdWctQwK7dG1PSsWPaS0N8/iAMNuEmrTYCSZlRJ3EcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac5.versanet.de ([83.135.90.197] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sZ7cT-0003Dc-Jz; Wed, 31 Jul 2024 13:35:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Rob Herring <robh@kernel.org>,
	Judy Hsiao <judyhsiao@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] fix eMMC/SPI flash corruption when audio has been used on RK3399 Puma
Date: Wed, 31 Jul 2024 13:35:47 +0200
Message-Id: <172242573602.2549881.5467215847844665967.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731-puma-emmc-6-v1-0-4e28eadf32d0@cherry.de>
References: <20240731-puma-emmc-6-v1-0-4e28eadf32d0@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jul 2024 13:05:27 +0200, Quentin Schulz wrote:
> In commit 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch
> on rk3399"), an additional pinctrl state was added whose default pinmux
> is for 8ch i2s0. However, Puma only has 2ch i2s0. It's been overriding
> the pinctrl-0 property but the second property override was missed in
> the aforementioned commit.
> 
> On Puma, a hardware slider called "BIOS Disable/Normal Boot" can disable
> eMMC and SPI to force booting from SD card. Another software-controlled
> GPIO is then configured to override this behavior to make eMMC and SPI
> available without human intervention. This is currently done in U-Boot
> and it was enough until the aforementioned commit.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: fix eMMC/SPI corruption when audio has been used on RK3399 Puma
      commit: bb94a157b37ec23f53906a279320f6ed64300eba
[2/2] arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma
      commit: 741f5ba7ccba5d7ae796dd11c320e28045524771

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

