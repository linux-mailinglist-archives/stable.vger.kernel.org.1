Return-Path: <stable+bounces-152484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C97AD61D8
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C031E1F74
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04742246778;
	Wed, 11 Jun 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X1KUaJ2v"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089002459D2;
	Wed, 11 Jun 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678520; cv=none; b=Hp/fvHNuejwCOllAmlfhxVNADdFhCmWXC3m41LSmyYCTGeCEUoqYqD3Q0QSrAeoQAHFSFJpeGMLCEZIsEAsMzfxdffukOwb6WUHkH0i/7n9qOZBfs9W+IUcJrPGnhnVUPNhFZB1AGsNIUn5On7CoP30CKcJZ1kXVMBx662Yfmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678520; c=relaxed/simple;
	bh=LH3RSD841MZ/Wiu+j6uCJ53sshntEVWDrCUzXD6Diq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7wF4y4LumL/i482v3AeRM0Xx+N6grjdIb3SX9SRud+2W+zbmpIa5Qxx5JenV93yyrMYjrjilyaIwcRb1mFvjdRa9w5oXsxXX3buvf8k3Rvt9ZycDhTeZj90fqP3zLz/eVmtO8hxa394Bn3V5O7lXinZ8EQoaeY03eygQAp1Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X1KUaJ2v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749678516;
	bh=LH3RSD841MZ/Wiu+j6uCJ53sshntEVWDrCUzXD6Diq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X1KUaJ2vZwipKPBKokVHgxzdwtYRuJjl1kPJJnlJRoEZsVaLlH7zvZbqAru5khxja
	 UdazX8hjDh3qWdJEMpTTnHKE/JHAbKmNX7yijDy+DUt+ZoZKani5n7TidH3PNS0HE/
	 zbf7rbjoEjvcYwcmcoSRN2TJgU7Z07KOJWHGwvDorHqzWRZ7bmkpmXUth+Owb1LVrl
	 b0L3vcnwziQl3r2jtx6klopCEyKTEcVFMt904uKxIjHJ3hupWP7AAnBXjSL1MRDDr3
	 rAFBRexrxeLCGq+3mvUhbpeELFkLTycraMSG1Mhm/7p2lK//T4MHCNCaV20CC9pUCz
	 cjjSSx+t5wXUA==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 182F617E1560;
	Wed, 11 Jun 2025 23:48:36 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Jun 2025 00:47:48 +0300
Subject: [PATCH 2/3] arm64: dts: rockchip: Enable HDMI PHY clk provider on
 rk3576
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-rk3576-hdmitx-fix-v1-2-4b11007d8675@collabora.com>
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

As with the RK3588 SoC, the HDMI PHY PLL on RK3576 can be used as a more
accurate pixel clock source for VOP2, which is actually mandatory to
ensure proper support for display modes handling.

Add the missing #clock-cells property to allow using the clock provider
functionality of HDMI PHY.

Fixes: ad0ea230ab2a ("arm64: dts: rockchip: Add hdmi for rk3576")
Cc: stable@vger.kernel.org
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 1086482f04792325dc4c22fb8ceeb27eef59afe4..6a13fe0c3513fb2ff7cd535aa70e3386c37696e4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -2391,6 +2391,7 @@ hdptxphy: hdmiphy@2b000000 {
 			reg = <0x0 0x2b000000 0x0 0x2000>;
 			clocks = <&cru CLK_PHY_REF_SRC>, <&cru PCLK_HDPTX_APB>;
 			clock-names = "ref", "apb";
+			#clock-cells = <0>;
 			resets = <&cru SRST_P_HDPTX_APB>, <&cru SRST_HDPTX_INIT>,
 				 <&cru SRST_HDPTX_CMN>, <&cru SRST_HDPTX_LANE>;
 			reset-names = "apb", "init", "cmn", "lane";

-- 
2.49.0


