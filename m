Return-Path: <stable+bounces-111988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC753A2543C
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210783A4A04
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43412207DE2;
	Mon,  3 Feb 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wVtWgjgt"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCD1FBE88;
	Mon,  3 Feb 2025 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570581; cv=none; b=MavOaKNi8fPWobALBcB5VS5pz5Ojv3uipN0uYinQo0pUbtekRxJU+4aZhiIWYhaivH0ZslxliX4LMgbw09E6sN30Tzst8DtzDfpfD7DBXUH/u9yzAkT4XUNvJRvu/UgpI4AyPlLPO9j/cV2IwZdfNlfqeOXKtqxGeUZeN8fLDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570581; c=relaxed/simple;
	bh=BnLa6i9uHTei5BUGODcN7bebF1kVtW6DZS3sGD/Lx6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Hqoyr3+yFolyugDNBISbMQkUejwJWN4GwK5tvaa4HMEhlnmtkKNpTrmxhSazWvbHNPrvK74rNZXDztXAaWEnt4/dYDxTnguWj5ePpJAludi99pBZLvKhfOnfZ/LjoTLF8fFXBTPSG07vhyYUVD5baIiRhQUom6Xgj/ZilOGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wVtWgjgt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W4nx1cYB2XMya5dsknAcGEuuSmOAaTjn1xFWh2exy+4=; b=wVtWgjgtbp2wxfGovdDNbeIw0E
	EK1DVFc4xJIWIQwM8SK8cRKLncxvRuaFsv9BkE3sExkoDVmzBORvBTcZ8MUJp/gB1iJvtHVsJjDFK
	k82QPc9SoMUbcfmK/QGYscdGDZXhnG/YUZ2DdZwVj/rDK0WTJzo9j7YcUDtJVt3WFo6Por+nohmVZ
	k4avGC5VXYb04RXQC1opmK6BIqwJ3eUz36D6yuVo+S8XaFxCsIQBQJ98Hya2Hkq/5PXm0per0zxko
	vCNA3LIqDtzGYtLgOIkqOASfCFfATZ25mEDLuW3r7KJXpFijwVeGLLZ0r1NrfzlDtUFyxZTbuIpyy
	07QCjOgQ==;
Received: from i53875b5c.versanet.de ([83.135.91.92] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tercl-0005Vr-GX; Mon, 03 Feb 2025 09:16:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix broken tsadc pinctrl names for rk3588
Date: Mon,  3 Feb 2025 09:15:57 +0100
Message-ID: <173857053617.78657.9000996460900671824.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250130053849.4902-1-eagle.alexander923@gmail.com>
References: <20250130053849.4902-1-eagle.alexander923@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 Jan 2025 08:38:49 +0300, Alexander Shiyan wrote:
> The tsadc driver does not handle pinctrl "gpio" and "otpout".
> Let's use the correct pinctrl names "default" and "sleep".
> Additionally, Alexey Charkov's testing [1] has established that
> it is necessary for pinctrl state to reference the &tsadc_shut_org
> configuration rather than &tsadc_shut for the driver to function correctly.
> 
> [1] https://lkml.org/lkml/2025/1/24/966
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix broken tsadc pinctrl names for rk3588
      commit: 5c8f9a05336cf5cadbd57ad461621b386aadb762

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

