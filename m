Return-Path: <stable+bounces-85345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163399E6E6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C75B25993
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32341E764A;
	Tue, 15 Oct 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ldP8pHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0F1D4154;
	Tue, 15 Oct 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992803; cv=none; b=Xya7CrQHWNLPhIC4q3VozgoATo0Ypwf+jVqyPPOE7s0bkNp7W/ZCPWQnonqzlYa2u8ySrVnTNfgycv+DtCSppO14WxSJ0ZlrPUBUEXlO5HQd3NG6YEzS8apdiLfprhOeSH2VLb5AMIKheV1MipJ5WwCJOS1o/rbksIVt1Z4KOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992803; c=relaxed/simple;
	bh=xnS2v80SVwyhU/eSyRmR24QX/Lwt/IGKAUYCCgJNwT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psHFYs3ANJVORulTWtw1oYmpnCvkuCcj8BSwTRNA2rvkC2UNilYq8lnuQHNeDAxu0IAwM1Vnz2jju7wXknHcHol0QzhpIsM2hVsEK0ZxPEyJXMPSlEhp48Q+5SwOWGnFe6I1BG6HBBGnhG6wrq1msZ9sAytUTALimVtga0Oyr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ldP8pHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A23C4CEC6;
	Tue, 15 Oct 2024 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992803;
	bh=xnS2v80SVwyhU/eSyRmR24QX/Lwt/IGKAUYCCgJNwT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ldP8pHq+/xiMOHXca+oH9gkV4ze3Go4NFo1L3xBvwYSHf/n0/0dJ6duRbFo6+OO/
	 hbMqcGhJioTZ75OOUTGvfojeW0kjjnGHW/lSiBxCIDlG7fwERY/B/2Wupd5+OdJ35V
	 09kds6SbKYqX2XrSL0CRkShf7tdUu7SIfZ1cLZPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 223/691] clk: imx: imx8mp: fix clock tree update of TF-A managed clocks
Date: Tue, 15 Oct 2024 13:22:51 +0200
Message-ID: <20241015112449.211203316@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

[ Upstream commit 3d29036853b9cb07ac49e8261fca82a940be5c41 ]

On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
SiP and then does clk_set_parent on the DDR muxes to synchronize
the clock tree.

since commit 936c383673b9 ("clk: imx: fix composite peripheral flags"),
these TF-A managed muxes have SET_PARENT_GATE set, which results
in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:

clk_set_parent(dram_apb_src, sys1_pll_40m);(busfreq-imx8mq.c)

commit 926bf91248dd
("clk: imx8m: fix clock tree update of TF-A managed clocks") adds this
method and enables 8mm, 8mn and 8mq. i.MX8MP also needs it.

This is safe to do, because updating the Linux clock tree to reflect
reality will always be glitch-free.

Another reason to this patch is that powersave image BT music
requires dram to be 400MTS, so clk_set_parent(dram_alt_src,
sys1_pll_800m); is required. Without this patch, it will not succeed.

Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20240607133347.3291040-7-peng.fan@oss.nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index cdeacdc143b5c..8e980271b9dc6 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -566,8 +566,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
-- 
2.43.0




