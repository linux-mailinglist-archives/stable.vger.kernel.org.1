Return-Path: <stable+bounces-81012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD58990DD1
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4781A1F2313F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EB213ED8;
	Fri,  4 Oct 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFFZlLJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB3213EF1;
	Fri,  4 Oct 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066489; cv=none; b=fttU8gNKld9V1xggwTzdaNMAXI+kF86DlDfxtYYOq6j86f85FSroLt61VwgUCPM2hLU9FRPnwrwa2k6rNCpRfvZk13Vv2h2VfI2mwigNVV1N0SVyos+YwWfFMLpthIcHjy2m01vVPPQs/Vomf0J/o2xJxfMSLk/Y+c/Xg2KrI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066489; c=relaxed/simple;
	bh=S+gIXNv0KHTkwmoTxCG6ZM62bVrbwx0KWhwHP8w3mjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWfC0SYJ6uwtXVQjIof2X6hfIfNRQ331ZWPn0OogZ44pkXXN+DjKdrye3vZnheZkAhIXv2MS73CWzfICVn2JXOeak2PhSVyoxtBsM/LB5nFbbGrpisxa9lzexocps5n2itZAaIS+XTV6pym1n4jVUVjwpGpXhWS9wdYNHr+/PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFFZlLJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94A0C4CECC;
	Fri,  4 Oct 2024 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066489;
	bh=S+gIXNv0KHTkwmoTxCG6ZM62bVrbwx0KWhwHP8w3mjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFFZlLJgI4kvQHxPxehQ5dtPJwjv/zT+ICSxrKImJYislygNoUVvC67ATre0one1Y
	 +EErx28oIBzLnxSSczvgFECWTwUVlx/N6zudEkIcu6T6D4YQX8NzcNKuM3M59HU+Pe
	 bvly4HS6f1O2lZlehPg+FzppiqqZs7DxvfNfLV5hsL7sve0sOpVk7hBcRwtk6vXySV
	 1M3cM9BWH3Fe9Lwh78OSKLbNhjhNdwtxWIWFma7G3Ik2pzLharjdYEUg/S4Fg/n5nP
	 JN/k50NADAOijrEwiCXMZhEEvfXAnMEdOVNb0oWh28vzHfF/cZBrYKcQe/Zi/uKQ5W
	 ioDkJ8TROr93A==
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
Subject: [PATCH AUTOSEL 6.1 28/42] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
Date: Fri,  4 Oct 2024 14:26:39 -0400
Message-ID: <20241004182718.3673735-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index cbf8131c63f7e..f26b85e8f3292 100644
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


