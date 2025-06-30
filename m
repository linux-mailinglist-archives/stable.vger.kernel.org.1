Return-Path: <stable+bounces-158882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1534AED852
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C607B1893EAA
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F9220680;
	Mon, 30 Jun 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="p+mVLfZ6"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C626AF3;
	Mon, 30 Jun 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274916; cv=none; b=q3AUcj6xa96SEQF0NYKOvNtretieSqzI271+0le60p4AfJzzpfNkQHJqeOno3ZMwdMtREATseDP0+z6hHK5hI5k8I/kowgdDVIueHNkQqZeYNolyhIzOwOgIA4DeC+xsgLlbyA+lRd3MJZgEm4oEVgE2C+W3qhjV/XJgq7fMRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274916; c=relaxed/simple;
	bh=TkLhFhWumGvB9oEam+IXBxxJbwl1aAR9CRlttTKT5kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wm4cCIkZC+A21PmGR3hA7yeqmaLoqEPJ+Gh51oA/+v3Z4wTVNWkV6mVrOnCuwtVzGvfcsqQOqu6nBU1htkz0yntqWs1e3eulrsWEMdtTZyVkgzyrSaZXJNLN5t1jbsm8Fi4GBQtl3Sl6m2oapmiT2bU+ru7b0HiSyUXPEG47x6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=p+mVLfZ6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=+fqpA/Lpac9+JlswIBpsVSCZtAGmxs1CgIvPDGfFS84=; b=p+mVLfZ6Sbj4jjBCwKAaXU3Eh1
	BQ99XI07HJ0uWwEVHEhluIiblIYNyzteiu1sClMHdiViQuFQv9vaL+EHhkDWTefKVtNq7H9Kv/DwN
	WrvFu7bkHcLzdUQ5FeJRWha2fWeH3X38S+6GSE/7Ey7ZUcqB3n/xlMv38L5tlPqUTsgFLLnTy7ENu
	9Riljpgx4CyvPsr9fYiTfOOc98BULHfeQ4F6W8vDaCuJ88QY/YuuTtCuvjmIa2XEaLx6zUBOtnAwB
	VhYe/9iU26D7U0XmPloUlvO575XgXzYLPEzaJxXN8SopKWtsSPrBb0EoJZSHWVCMJdtvwFYyi4NDE
	Qa3cWGnw==;
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uWAbC-00068L-5E; Mon, 30 Jun 2025 11:14:50 +0200
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
Date: Mon, 30 Jun 2025 11:14:38 +0200
Message-ID: <175127486757.133006.13048263625888495346.b4-ty@sntech.de>
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

[1/3] dt-bindings: display: vop2: Add optional PLL clock property for rk3576
      commit: 3832dc42aed9b047ccecebf5917d008bd2dac940

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

