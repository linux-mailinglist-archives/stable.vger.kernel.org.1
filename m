Return-Path: <stable+bounces-81077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EFE990EA5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323FD1F22640
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DB229122;
	Fri,  4 Oct 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j38i6iQ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9311229113;
	Fri,  4 Oct 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066641; cv=none; b=OysAbGo4lO30a+R/aMA71vk9KeqTqETzo4ibkcYGj/J5hBg2s+PZBQUvTz+qJt93803p1V0LPxNBB64IUYK5OoGhEmqUhVoObs8XOnR8OGr9E0176u9gLnG/giBRJoCsplzkyuF1a4Mi2YE31DI8zwAyRsq/e7ydkvn2p/CtTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066641; c=relaxed/simple;
	bh=+MInjvOIugVc1lwubZe5zMasPwrDh20XqXcJx8xuQ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6wVz0ec5a9m3UlPiOZCQkOD7BetbvTA0CiP1wozqlXcSLd0g90+uTBODp54O72NbkiTj8Iv81H9eplBZkHBjsGK5oKHWPkyUf3zHa68zeQS4gS2DAmnJKLB5Pxi04TesILrXAiPuQfbb0ZMncB4FcMd89dJRbZuovDjFPozb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j38i6iQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4FFC4CECC;
	Fri,  4 Oct 2024 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066641;
	bh=+MInjvOIugVc1lwubZe5zMasPwrDh20XqXcJx8xuQ2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j38i6iQ9KQAVno8v/TR70UmED3rwAN02RuGC+W1mhNM477ioQDulxruJWcQdKAAnC
	 67Pfxw/aYqFcbEHKfD5u5B93WXsJ8WwJW/M7m33xVZncH6bbt3Rls9gZDW4LoB4Pmq
	 jlRWdqluMo0VvE0Ijo7FWiN5JGlvvKvqY2KjliU4557XwZfHPeozDmEdy8J46HaMID
	 lelQPvobrRTAAC9ddcSGo9Ct9KufcRSNl84d4ZMsseEHTH0/HGRYaXzguDwyVDFoVP
	 2/H3fD8hlLBina0W+iEhBVwLki9DUqpSCsIecmYSCp5zqNpMgLmDVcecnrMnPKvvFH
	 RHpQAkO3gsKvg==
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
Subject: [PATCH AUTOSEL 5.10 19/26] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
Date: Fri,  4 Oct 2024 14:29:45 -0400
Message-ID: <20241004183005.3675332-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 3f6fd7ef2a68f..0e68e5f2d7e7d 100644
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


