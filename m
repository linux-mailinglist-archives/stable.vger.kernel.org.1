Return-Path: <stable+bounces-24741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C9986960F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49AB1C21B6D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCD13DBBC;
	Tue, 27 Feb 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cKUb8FuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3D13B78E;
	Tue, 27 Feb 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042862; cv=none; b=AjuGHfOs9Hz4yP85o1Jkw4KVXQDSCyNS/Fi5ZETC2J0+1n3VPfcfe6r4NFHvyQBHUnI/nfVmArTEqVFzYb7HUu6c2j37q0Fz0tqhJ2IHKUAePxaD6iT2xEtwFVM2rCWduoUm094Xc4jJHcPwJC/SxEQcWGhKuZsQH9X7IvxjU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042862; c=relaxed/simple;
	bh=1WnB0ub7oga/pC5nKTSVoja8+vW9QUV4gjXG1NqLNTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6bujxG6wX4be/Jain/meyqLNpcJx1QiOMYxQ+xXgIA9IlWfbDK4wXinZiHOu4WiSZ/Y/AaBozLU2B9eQY0nWfPY+8CUu41dPYIUTidY7h/h/s3rwcG6DuKfzeMcxrEeR1AEct6+NXIt6+K84PnVSVN7gQ/u+qUw5Mn4oc7aEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cKUb8FuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79B9C433C7;
	Tue, 27 Feb 2024 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042862;
	bh=1WnB0ub7oga/pC5nKTSVoja8+vW9QUV4gjXG1NqLNTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKUb8FuLEnY15dXaWYulWe1q2SX4F1AofeoFu18O8mjiVKS8WoH4Qjnwyff7PvJE2
	 i4Y2OETopEKPCpOTJadxoIgbhByhvZnQmEduvhqLjXGPMtRnZY6+/iyYjtc6F4w0Ij
	 3UNUnyCEhOg7LRVX4KTCvJ362xK9ZmE7T+SXm9QU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Abel Vesa <abel.vesa@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 147/245] clk: imx8mp: Add DISP2 pixel clock
Date: Tue, 27 Feb 2024 14:25:35 +0100
Message-ID: <20240227131619.993876056@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 39772efd98adecbd5b8c6096d465d2fcbafbde6a ]

Add pixel clock for second LCDIFv3 interface. Both LCDIFv3 interfaces use
the same set of parent clock, so deduplicate imx8mp_media_disp1_pix_sels
into common imx8mp_media_disp_pix_sels and use it for both.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Abel Vesa <abel.vesa@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Link: https://lore.kernel.org/r/20220313123949.207284-1-marex@denx.de
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Stable-dep-of: 5c1f7f109094 ("dt-bindings: clocks: imx8mp: Add ID for usb suspend clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mp.c             | 5 +++--
 include/dt-bindings/clock/imx8mp-clock.h | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index aeb611eaabd3b..b1c83f9809123 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -355,7 +355,7 @@ static const char * const imx8mp_media_mipi_phy1_ref_sels[] = {"osc_24m", "sys_p
 							       "clk_ext2", "audio_pll2_out",
 							       "video_pll1_out", };
 
-static const char * const imx8mp_media_disp1_pix_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
+static const char * const imx8mp_media_disp_pix_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
 							   "audio_pll1_out", "sys_pll1_800m",
 							   "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
 
@@ -548,6 +548,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
 	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
 	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
+	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
@@ -609,7 +610,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, ccm_base + 0xbc80);
 	hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, ccm_base + 0xbd00);
 	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, ccm_base + 0xbd80);
-	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite("media_disp1_pix", imx8mp_media_disp1_pix_sels, ccm_base + 0xbe00);
+	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite("media_disp1_pix", imx8mp_media_disp_pix_sels, ccm_base + 0xbe00);
 	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
 	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
 	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 43927a1b9e940..4fff3e57f460b 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -319,7 +319,9 @@
 #define IMX8MP_CLK_HSIO_AXI			311
 #define IMX8MP_CLK_MEDIA_ISP			312
 
-#define IMX8MP_CLK_END				313
+#define IMX8MP_CLK_MEDIA_DISP2_PIX		313
+
+#define IMX8MP_CLK_END				314
 
 #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
-- 
2.43.0




