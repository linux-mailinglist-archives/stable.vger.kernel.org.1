Return-Path: <stable+bounces-71470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F316964050
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE2F1F23668
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAF318C347;
	Thu, 29 Aug 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FfNxxO8i"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87018E76D;
	Thu, 29 Aug 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924224; cv=none; b=mA3ez1gU5bRvV0OZCtH2poiTEKGSGQQtuVVNhNZIQIHP1c1XpfskQg6L1R0lc0oncF1HqOwKrS+ASRnVryuHOV97PAmgvHPLbl2p1b4brFexy4nN25SGDGaQuZVlBiKAA/iXMBXh7TpIU+O/Z8jmiWnPP3KsLMktpf/xOPkMBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924224; c=relaxed/simple;
	bh=ljZRLR6ytzY0AL4iexkNEXILNTY8g0s6vpQRByJ+buE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b621gLM+fjBT/SPmjKmbjYYxCIR3XXmKeooxB1s51ObVcc7224e2EtkunhBQn17w7LM0HNCp5Snoo0lgMIL0QsSzsQfgVUsWQp4R3h6tciT8Ly8Jv9Mn/Fp2NYrMxsr1MfC66Rh+5ZXkrHU19otdKBeHN9M4HfUM0BFbyRDFo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FfNxxO8i; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A4/PMpvvxpYEvmqf7GIVYSw2u73NgreGhX+iQ/x8PvU=; b=FfNxxO8iDdSp0bEAxEyoSmJfKI
	8uDKoObVrSLicbi6Cn6RyY4kgmdObgMv2VQRvCQm0ZnNWWJ6LfcoOTxaEKhqY6ciKtca3wD7+82HA
	iCNsZ/VytXcnB8N3BQCebiRA8HNrlasovHk0SM7VF3eazaXMfRG8KAgH6qrcrUpHk+gXGKJcapBdm
	nRx6fehSqR8UToaOILbgOXsbbMo5r1KgEokNtWBIYKuQ0/LbumGl8k94zBikhRHJ9jfqAlDiAR/9K
	ojKaRoCA0YmEAIIfhGqXjJLggXUqzeN30B/lN8KgN9bNji5iQVSpkEjNtL0AN6gLaaFRpqbuiFU6U
	M5ye0ubw==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjbaH-0002nq-3y; Thu, 29 Aug 2024 11:36:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	stable@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] clk: rockchip: clk-rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p
Date: Thu, 29 Aug 2024 11:36:48 +0200
Message-ID: <172492351365.1695089.15416632298326411853.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829052820.3604-1-eagle.alexander923@gmail.com>
References: <20240829052820.3604-1-eagle.alexander923@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 08:28:20 +0300, Alexander Shiyan wrote:
> The 32kHz input clock is named "xin32k" in the driver,
> so the name "32k" appears to be a typo in this case. Lets fix this.
> 
> 

Applied, thanks!

[1/1] clk: rockchip: clk-rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p
      commit: 0d02e8d284a45bfa8997ebe8764437b8eb6b108b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

