Return-Path: <stable+bounces-145701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7BABE371
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7661B66B92
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E7280CE4;
	Tue, 20 May 2025 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="o5oj1aQi"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AC255E32;
	Tue, 20 May 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768204; cv=none; b=bD/CjuJYU7Gib4pnKhaMHr76VqMSEWz4tBDx/2PQW3I83iv0ut+1xK3yRXCgbPjmKmTzbKa52LfZixrVm6IYqG4hrZkKEUf6636BW3ZmDwHttelRf1T0EaGw73F6D/xth5f1raqby3UNZsBy3U73UbpDNWaxjsPgw70PLv0l1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768204; c=relaxed/simple;
	bh=Vz+vC8r6tItNXvJdokhwwK8eNZ26S+q73/GqY+D9oP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3HC0FrBcyhzPtVelYtJIJWxMGC7cAtsV/GN93eluTzBNarTt9TYtwAs7GOkbyFcbPdtzp1aOD/pJTSF1bR8fKvJy0Xe2lT2ku1BXX3OKiBzMkc4naBUzE7OAxruVowHorQP3EGHx8xQicrGaZhUYAjtuzGXlyO4nSOQRmqxCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=o5oj1aQi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=77Orl8NpipdYvhsO2FtBLXQftPwnNmsi3bKTaPQfEjc=; b=o5oj1aQi2Xu1XLkmhdd3x82+Qd
	QhExqp6guYpPCMqF+fPvfrwQ2vTp1CLiwDGhdfF9jJ57J8DcZ47F2rs6k7ZIOzrg+yTGOV0yXLWx8
	GqDNo2FmnO5dI5388aFjxPlx7nxOegtB0vTauEqUAD15aGs+t30lMZHAb5OvS5YEEHLEU9IQgCgjA
	vMCsf79AcXDDzsbcjIyZ50JQaX2oKxGSmYWi0EwBJqcsggB1V3j+2R2O78LajRUqy17pdvyw2QKoz
	qYBlZB+4CH7LL6CtqY3lvioo1EU0QjsJyPit/Ap564zY2zbZEFDK0N7EVTKEvi7uT2e00Yu90NnME
	Bo6sPTJw==;
Received: from [61.8.146.112] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uHSLe-0004fK-Eb; Tue, 20 May 2025 21:09:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing SFC power-domains to rk3576
Date: Tue, 20 May 2025 21:09:46 +0200
Message-ID: <174776817930.2879626.18234961052038091921.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520-rk3576-fix-fspi-pmdomain-v1-1-f07c6e62dadd@kernel.org>
References: <20250520-rk3576-fix-fspi-pmdomain-v1-1-f07c6e62dadd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 20 May 2025 13:14:27 +0200, Sebastian Reichel wrote:
> Add the power-domains for the RK3576 SFC nodes according to the
> TRM part 1. This fixes potential SErrors when accessing the SFC
> registers without other peripherals (e.g. eMMC) doing a prior
> power-domain enable. For example this is easy to trigger on the
> Rock 4D, which enables the SFC0 interface, but does not enable
> the eMMC interface at the moment.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add missing SFC power-domains to rk3576
      commit: ede1fa1384c230c9823f6bf1849cf50c5fc8a83e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

