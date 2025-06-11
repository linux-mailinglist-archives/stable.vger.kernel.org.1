Return-Path: <stable+bounces-152485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E7AD61DB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157387AA2C2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107112475F2;
	Wed, 11 Jun 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EidgVnMi"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8048246BD8;
	Wed, 11 Jun 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678529; cv=none; b=BqcjPag/0/NoS3C8G108NVe5iBcy4YgjyZaPgUD0yCM6Tc9GcXToah6wqp41vhxXeqyWExPStXKUYaXnEvLvoDdoxCOvpfQ4wOJLbX9J1WnG605QszJs6IfCYVxVutnk+iu5SiBZizvByT4Es48T714dii66vqT5A7fMBCykA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678529; c=relaxed/simple;
	bh=p125Qdh7AXpcJlrV+7yqlZZwam5I0mnuIIk+bsJi8UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jehTSceDXq4wo1appcXu70F3UOJ1vdHDSDRPeHkRp9fKN6OV5uNThmxov70mPe9yQCOR5atiOpJbyRu/l6Epci36QnHGsiFM4gxNBPJFyxpmOhL7ckxSQpTsHTkenuYL2BKpDQipUQ1T+WhQDJ57fhwOYmnCbcz45pXPTxLG3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EidgVnMi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749678526;
	bh=p125Qdh7AXpcJlrV+7yqlZZwam5I0mnuIIk+bsJi8UU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EidgVnMiQFzztrReyrHUBVJ/dgBh0iS528uSU6ZSU0dw/oVXjLTONw6yvYb3IBPqR
	 fKgkeucn1eAdTsG9IGr5r2aUrGrxN6zYq7QdHqiCmC4B2zFZDg7TQ2Scgu1sd8Vkma
	 /SDNw9lX2QVSf79dLPn5C6nN0SqBisjOIt9F2xoXzfsDGUwlygMqnwXUlB33nyq/cD
	 J+eh0MSZQk8Vd1Il9blFhNbKZsEAk+7KZhyEnvNY1mRQzI+tfGnnc6nJ1MWCJYMAHN
	 elozjHQDkEKzQZ3L1vxI/6Li0jeFjXFFpvi0NF2PChhCmw9F5Y1S3CwcqhF6ed1T5e
	 1bPu91kPSGFTQ==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id EFA8C17E0342;
	Wed, 11 Jun 2025 23:48:45 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Jun 2025 00:47:49 +0300
Subject: [PATCH 3/3] arm64: dts: rockchip: Add HDMI PHY PLL clock source to
 VOP2 on rk3576
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
In-Reply-To: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
char rate via phy_configure_opts_hdmi"), the workaround of passing the
rate from DW HDMI QP bridge driver via phy_set_bus_width() became
partially broken, as it cannot reliably handle mode switches anymore.

Attempting to fix this up at PHY level would not only introduce
additional hacks, but it would also fail to adequately resolve the
display issues that are a consequence of the system CRU limitations.

Instead, proceed with the solution already implemented for RK3588: make
use of the HDMI PHY PLL as a better suited DCLK source for VOP2. This
will not only address the aforementioned problem, but it should also
facilitate the proper operation of display modes up to 4K@60Hz.

It's worth noting that anything above 4K@30Hz still requires high TMDS
clock ratio and scrambling support, which hasn't been mainlined yet.

Fixes: d74b842cab08 ("arm64: dts: rockchip: Add vop for rk3576")
Cc: stable@vger.kernel.org
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 6a13fe0c3513fb2ff7cd535aa70e3386c37696e4..b1ac23035dd789f0478bf10c78c74ef167d94904 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1155,12 +1155,14 @@ vop: vop@27d00000 {
 				 <&cru HCLK_VOP>,
 				 <&cru DCLK_VP0>,
 				 <&cru DCLK_VP1>,
-				 <&cru DCLK_VP2>;
+				 <&cru DCLK_VP2>,
+				 <&hdptxphy>;
 			clock-names = "aclk",
 				      "hclk",
 				      "dclk_vp0",
 				      "dclk_vp1",
-				      "dclk_vp2";
+				      "dclk_vp2",
+				      "pll_hdmiphy0";
 			iommus = <&vop_mmu>;
 			power-domains = <&power RK3576_PD_VOP>;
 			rockchip,grf = <&sys_grf>;

-- 
2.49.0


