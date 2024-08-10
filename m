Return-Path: <stable+bounces-66341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D0894DEE7
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 23:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FE01C217E4
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7A1422DE;
	Sat, 10 Aug 2024 21:59:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DC1870;
	Sat, 10 Aug 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723327180; cv=none; b=BYfs2cbNXMQBJbugSocNCr36dmRZ7DgjKR9JsfPFTqzb5xWX/5A77MNB2iyqBtgMPb/eDE/gI/buIZpt/6wQglLB4SW2eeVPgCmVx32cfs84WZNXzjJXFHYUvtT4ibbcPsw7JoslNUSulZ+jeE+sioFtOI7pTQC5j0mR7rP5c/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723327180; c=relaxed/simple;
	bh=2IGyCYkqSklmYdc1Jfu7GDllfuT25bYA9XgNnhhO/T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXjdhQbGx+pJ5IXW3aXEbidF2HjPCoV3HemjfObjWOtZApC9ynEIz1Xy7lm4Dkq8XoOhxwqxXg7I/DXOosBeevoXFiB+hbrZHuBnddJDlWdNr9ZQ5/AW7Drv0Gt85Bf41+lVTX2fkniCV4sLdjISRkpywenslNoWKoNrYtFUgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1scu7b-0007sP-Dh; Sat, 10 Aug 2024 23:59:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	Nikola Radojevic <nikola@radojevic.rs>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
Date: Sat, 10 Aug 2024 23:59:32 +0200
Message-Id: <172332716790.290487.980895423301498235.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2a23b6cfd8c0513e5b233b4006ee3d3ed09b824f.1722805655.git.dsimic@manjaro.org>
References: <2a23b6cfd8c0513e5b233b4006ee3d3ed09b824f.1722805655.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 4 Aug 2024 23:10:24 +0200, Dragan Simic wrote:
> Increase the frequency of the PWM signal that drives the LED backlight of
> the Pinebook Pro's panel, from about 1.35 KHz (which equals to the PWM
> period of 740,740 ns), to exactly 8 kHz (which equals to the PWM period of
> 125,000 ns).  Using a higher PWM frequency for the panel backlight, which
> reduces the flicker, can only be beneficial to the end users' eyes.
> 
> On top of that, increasing the backlight PWM signal frequency reportedly
> eliminates the buzzing emitted from the Pinebook Pro's built-in speakers
> when certain backlight levels are set, which cause some weird interference
> with some of the components of the Pinebook Pro's audio chain.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
      commit: 8c51521de18755d4112a77a598a348b38d0af370

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

