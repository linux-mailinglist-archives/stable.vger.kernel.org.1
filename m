Return-Path: <stable+bounces-158920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB4AED8FF
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32593AAF9A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EB247282;
	Mon, 30 Jun 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Pu/fibC1"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2E246BDE;
	Mon, 30 Jun 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276781; cv=none; b=GFUckcUyIXuJWHOVb1feSpvrbozZ4WakqZ1prObfeQzu+vtGPSQEorOgllwz/b5xPXyaPxzPmX3OIS/j4fAtwseJupZ7OSe+nDw6SwyS264ksKxz0SiRr4x9B5YBZ+c4dGsIMx+RvTSU8C4DKVWF97X72AzUQoNp5NCccvp97E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276781; c=relaxed/simple;
	bh=PLueSt++Ts2krxIFLmq/SQC+sljmxI5Q0voO9Xojcq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPdcza8yRrp0K5BqsRiLeAmiKFE60hGK4K1/r/XpDRQx7lEbeGvWb2j+D7R1u/S4QnJaCUjZl81bcxID1i6/OAuWiSCLRFtcqL6fnLqkOzLXjAs1GRf+I4pw0JQkV9SaYp/A9HJh2QuM1AP8r02E+dnhtKPjVA3cMZEM++s4/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Pu/fibC1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Y9NDST3Jz+7qAkVnnzdeFtTSjYFFZgsmdrwgsOErAQY=; b=Pu/fibC1BioK2jFS+/Suan3gfe
	zBYwD4ZBY7ZB1zEtAPgJm2z3UNMA+PnhtTqRzjvNcvb2KuMnEWkHaxxUCCHHEQXpWGq20qDhRLWU+
	G+wtiuiql6xdkh6SD9oiHa53LDdVNnmwh1AoRN/Y1RAiWEqA2sx+mW2pCf99z5xSyw0NYAXItuI5V
	Ce/KUF5+ZK7a9RrW3DQsMM8EAhCh1Elb69rFXWZA38eEQCx8AsIed1xwO1+Au+ILf4RaTNOxuHZEy
	XA7OR98Su158f5OEA3BxePxjf1vptmkojr1my+NDYGstJnVBCVo4c/wBt7IGPXyWj9cJXDWDc3jzE
	VAWVHt1Q==;
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uWB5J-0006Zc-NW; Mon, 30 Jun 2025 11:45:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	Andy Yan <andyshrk@163.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: dts: rockchip: Fix HDMI output on RK3576
Date: Mon, 30 Jun 2025 11:45:43 +0200
Message-ID: <175127673170.138768.2750019660187884094.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 12 Jun 2025 00:47:46 +0300, Cristian Ciocaltea wrote:
> Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
> char rate via phy_configure_opts_hdmi"), the workaround of passing the
> PHY rate from DW HDMI QP bridge driver via phy_set_bus_width() became
> partially broken, unless the rate adjustment is done as with RK3588,
> i.e. by CCF from VOP2.
> 
> Attempting to fix this up at PHY level would not only introduce
> additional hacks, but it would also fail to adequately resolve the
> display issues that are a consequence of the system CRU limitations.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: Enable HDMI PHY clk provider on rk3576
      commit: aba7987a536cee67fb0cb724099096fd8f8f5350
[3/3] arm64: dts: rockchip: Add HDMI PHY PLL clock source to VOP2 on rk3576
      commit: 4ab8b8ac952fb08d03655e1da0cfee07589e428f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

