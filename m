Return-Path: <stable+bounces-79004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10998D60E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40991F21BDD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB961D042F;
	Wed,  2 Oct 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLEmhmmP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05A1CDFBC;
	Wed,  2 Oct 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876159; cv=none; b=ehenA7bHao1Udw9pYHofPYzJRYKsHGj7Xh1qrsX5TF6zcQIdxHGQnI/wezwpaBBlZDbRfSE917jeTFo2apijtEgWsbU8oVDDFY8W4rSptGI19/sEIfd/yB/ytrR0ni4TZf6IJWjHHkjG5YoeqjRcsZdIq+c9oDtoSLqVE9ryUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876159; c=relaxed/simple;
	bh=OU1i0+DjLiqGbvqCMI2KCMLUmm4jq1aQa5nXAA3CiwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiEFH59zXhqmeQIDDCQAms8sAbcv4PRL/6zylhuSHwcZ92QcJNsrSTOKchHns39XxyNETtM+E2a2hYM8M/LAxhVoahuCHn4XJY6NUIoS6C98xr8SPl4e1rlsVmgLKZ4iB0RCjGqdamdi8xYKrrn3lrNwCo/ybnVeW7z3NHxLvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLEmhmmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9783C4CEC5;
	Wed,  2 Oct 2024 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876159;
	bh=OU1i0+DjLiqGbvqCMI2KCMLUmm4jq1aQa5nXAA3CiwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLEmhmmPW7VVHtZZCQxPSwEiL9ToJGtXSOasd3uBaHAZfp9ebdS4m+ZtxhtmgjQdg
	 6UzT4c7rYC0jlQhS8oXoQJmA77S0rr2dHSfWXjhnQ5HZv8pBnlB6SFyc96vDCUUBkl
	 1lzJGp0AiadfTY1HQl6KGbiDrJFQZR9jHczJmz4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 348/695] clk: imx: imx8mp: fix clock tree update of TF-A managed clocks
Date: Wed,  2 Oct 2024 14:55:46 +0200
Message-ID: <20241002125836.339088266@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index 670aa2bab3017..e561ff7b135fb 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
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




