Return-Path: <stable+bounces-80899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022D990C80
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5505282546
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E11F8934;
	Fri,  4 Oct 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq4i4cov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22551F892B;
	Fri,  4 Oct 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066205; cv=none; b=k0v0Bi+4JH1CUaTjjO//aoVBJ5ggwro/nYkrW8yWmSGaAu4mv5UIP2k5LE2s7pdBOnnGF96yDzR8OVYfunMhE8Z5G866uaycRSQVrjpYbbJRXvOSu4x2d4/aWVaCEuGKjvBV/VdxkPcUEKeR1SbHLxyVPhvkO/CG8npxRzkt+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066205; c=relaxed/simple;
	bh=U8J2Tw65NFpyqvT4U3DdgcwfsguyzmGDIVIcuB4XB5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2dWadxFpXdT0ipHoKxNMj/3gRwRKe78xHZ/uZV44SCobqfU+MgdJxeG/o/aVhWsVhJh7Dul/9BLSzICVGrKmHoriINttgW0IvJuRaUd3EBr6vDP8BLvFIfqBoQ7SrdTee5u5myVgzYU3wDZN2IYrBc5wAQ8L6bQfIBFYDEN9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq4i4cov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBB3C4CECD;
	Fri,  4 Oct 2024 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066204;
	bh=U8J2Tw65NFpyqvT4U3DdgcwfsguyzmGDIVIcuB4XB5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xq4i4covqVYYEg2C5YOHMjfAGQz+puer+/fXsZzNJIoJQjQO06YV4PhTU4YzOf4nL
	 /4/o0vbB3W6oJHV1w8GMlhoGXyfwg1hjpCcl7coVSkCyjNaBpdSd2u4BiLzD9Uw+Lq
	 8rIlJ9gR//srVPxuctvCFd5wJHwhzrbZ4K3JHuVE8bVElHqz4I2OGLydcfBUHrJ1GA
	 fbmjQGxB3/YBl/knum4pRkOf+EQI+5OyDHmJcaPzKDu6vVX2ivucki35+8mh8nJGDk
	 bP8Omtgfmt4s/EUpmCGOpY9om3F90Pct+sJcqAktXXVEIM6sip5Et1o7daU2h4N7FO
	 fuUmjGdVJjQOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 43/70] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
Date: Fri,  4 Oct 2024 14:20:41 -0400
Message-ID: <20241004182200.3670903-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit a54c441b46a0745683c2eef5a359d22856d27323 ]

For i.MX7D DRAM related mux clock, the clock source change should ONLY
be done done in low level asm code without accessing DRAM, and then
calling clk API to sync the HW clock status with clk tree, it should never
touch real clock source switch via clk API, so CLK_SET_PARENT_GATE flag
should NOT be added, otherwise, DRAM's clock parent will be disabled when
DRAM is active, and system will hang.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20240607133347.3291040-8-peng.fan@oss.nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx7d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 2b77d1fc7bb94..1e1296e748357 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -498,9 +498,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_hw_mux2_flags("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] = imx_clk_hw_mux2_flags("nand_usdhc_src", base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_DRAM_PHYM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_src", base + 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel));
 	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_alt_src", base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2_flags("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
 	hws[IMX7D_USB_HSIC_ROOT_SRC] = imx_clk_hw_mux2_flags("usb_hsic_src", base + 0xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);
-- 
2.43.0


