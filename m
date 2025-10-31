Return-Path: <stable+bounces-191971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4DC27259
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C932B4E186D
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B631D378;
	Fri, 31 Oct 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="K5j1YPLL"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3D3126D2;
	Fri, 31 Oct 2025 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951232; cv=none; b=fRo79Oir8XToXbeJ+pT40wLC4360rXqpnWpvrs1QgAhBVMprEyPilDqVvjDORULaxaS0J8B+kytlaLdU+aPdq8dH6WLtltriBgKvrFzz540BsMnP6dIxNPfJhb1RL+sHrZ7noIbKbYb9ZsZCL3bjN9hUN62IWQ/6Q0xSrfDdF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951232; c=relaxed/simple;
	bh=gD1tzaDehh+0GxRCexa0zWW/1nFj35pmxAOJyzGNT4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq8eQbDOg6dxNjkkNlo6oSV0TeV6+bA6/9e96VPq6k9WDjLui+iAyNYZD5pt1552KEGOO/jf1jVdApq3kEyZpCrilfMyWocTFFq5Vefn+D6boFP/3ilV4vsnlMqhuJzC2DJGs8hePPw8OAXQ0hvHs39FShddzhJjBfeynIBGIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=K5j1YPLL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=tEa69CK3CTq5tuu64iEIaNtjdvD8PfZrn4NwDRYVVEE=; b=K5j1YPLLAPK8LsJ15mP9RfnJ/y
	yNCYG+xKZ9qHW713h9oRYYDBbccv98h8OgqbYMmGcA1OmNOwu3jYUW0GCFUhP3flN6BPRv1upMntW
	HGRaTFqzhwEXjPiJEvOJvhb7DhJWJGsxGV/tOEGJgEbRdfTnhzl+u16TDTWhuoo6XKHSjjuio0OGh
	UaYh42F2VcruFlaf4r+m1LDHhj5RFHl+3DJyOFXI30I9Hyl73ygzkkSazlOr5JkYwlmiCOt+3VzLG
	ssTlZ6uFd5HwHXWZRqQ4xfjhoODXTv+xVlg61DyzrO2lkY9+1aSGbNoS94mnTsCbOibUgwfIGsg+/
	nEcZCRdw==;
Received: from i53875bca.versanet.de ([83.135.91.202] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vExzr-0004vM-52; Fri, 31 Oct 2025 23:53:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: include rk3399-base instead of rk3399 in rk3399-op1
Date: Fri, 31 Oct 2025 23:53:20 +0100
Message-ID: <176195118797.233084.5136305180547007153.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251029-rk3399-op1-include-v1-1-2472ee60e7f8@cherry.de>
References: <20251029-rk3399-op1-include-v1-1-2472ee60e7f8@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Oct 2025 14:50:59 +0100, Quentin Schulz wrote:
> In commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dtsi
> files for SoC variants"), everything shared between variants of RK3399
> was put into rk3399-base.dtsi and the rest in variant-specific DTSI,
> such as rk3399-t, rk3399-op1, rk3399, etc.
> Therefore, the variant-specific DTSI should include rk3399-base.dtsi and
> not another variant's DTSI.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: include rk3399-base instead of rk3399 in rk3399-op1
      commit: 08d70143e3033d267507deb98a5fd187df3e6640

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

