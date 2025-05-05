Return-Path: <stable+bounces-140201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5F3AAA60C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA94A034D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B931E171;
	Mon,  5 May 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFuxTD1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C728E5FF;
	Mon,  5 May 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484324; cv=none; b=NffuaZ221K1svtf0GaYD2LofFNvJgNLnJbh0Z1B0C4kslC9aqNoIABWSob5l8RV2m3818dejNSnwThkNcu56Bv2UHX2rqEErTb2sZfWcNHf09TAA7hJ2ipnomQt2mqi5gATpH3PFc1LaIkNBNHeruVbSsFVUEyNRHsoDrjH4Dw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484324; c=relaxed/simple;
	bh=2DFBAgo7F8rUjSMxHwsHJ8b2g4n9DfX/Oet7h0o5k2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO3xIvbjEELV1H4TSpkPx66tHQC3oLns8r29nui3iNk9Rr23nma8T5VcnITxNRFd5TAhSA5MockEPPl4UBUJVSiKXD4cJzCCczMrpqNpGIMI/McZ+AcZyS1UJqy6Yi7ug9FCgKQw2NoaYDEGuKEp5pIZHYqArzZddOK3F13OHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFuxTD1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B6C4CEED;
	Mon,  5 May 2025 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484323;
	bh=2DFBAgo7F8rUjSMxHwsHJ8b2g4n9DfX/Oet7h0o5k2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFuxTD1XLzEoi6H/jTnzLMOam0EcwCCxwGhH88DTDl4lOgOUmszAPV/w5S/EoOQOB
	 QbhRL7LA3QkFAh2oe19tHZhtIZA3JF8GtmtVm/JR2XkX6EPc53sjTjknmJX0C4y2MH
	 jyMP7z3gJL5dT+YUgC1g/w2t189IDljsK1AMG4UtPkEGpk8jjy5k+YoJZAx2PJRaeT
	 ZKE+/5LAfrKNtI/+sC/1ruWUjtwxFNzyD5iZX92TT9u9KTCLVY3yXVgaNoFahQ5Az5
	 jrUJgujAECiVOPcH9fqv/N0etohqEGNwfCJV/A0n3P0vmajuRAN328b0XzJGT+FKeQ
	 0lD7TgA/oI2XA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 454/642] soundwire: cadence_master: set frame shape and divider based on actual clk freq
Date: Mon,  5 May 2025 18:11:10 -0400
Message-Id: <20250505221419.2672473-454-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit e738d77f78b3ac085dfb51be414e93464abba7ec ]

Frame shape and curr_dr_freq could be updated by sdw_compute_bus_params().
Peripherals will set curr_dr_freq as their frequency. Managers
should do the same. Then update frame shape according to the actual
bus frequency.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Link: https://lore.kernel.org/r/20250205074232.87537-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index f367670ea991b..68be8ff3f02b1 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1341,7 +1341,7 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
 	return val;
 }
 
-static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
+static int cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 {
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1355,14 +1355,25 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 		prop->default_row,
 		prop->default_col);
 
+	if (!prop->default_frame_rate || !prop->default_row) {
+		dev_err(cdns->dev, "Default frame_rate %d or row %d is invalid\n",
+			prop->default_frame_rate, prop->default_row);
+		return -EINVAL;
+	}
+
 	/* Set clock divider */
-	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
+	divider	= (prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR /
+		bus->params.curr_dr_freq) - 1;
 
 	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
 		     CDNS_MCP_CLK_MCLKD_MASK, divider);
 	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
 		     CDNS_MCP_CLK_MCLKD_MASK, divider);
 
+	/* Set frame shape base on the actual bus frequency. */
+	prop->default_col = bus->params.curr_dr_freq /
+			    prop->default_frame_rate / prop->default_row;
+
 	/*
 	 * Frame shape changes after initialization have to be done
 	 * with the bank switch mechanism
@@ -1375,6 +1386,8 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 	ssp_interval = prop->default_frame_rate / SDW_CADENCE_GSYNC_HZ;
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, ssp_interval);
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, ssp_interval);
+
+	return 0;
 }
 
 /**
@@ -1408,9 +1421,12 @@ EXPORT_SYMBOL(sdw_cdns_soft_reset);
  */
 int sdw_cdns_init(struct sdw_cdns *cdns)
 {
+	int ret;
 	u32 val;
 
-	cdns_init_clock_ctrl(cdns);
+	ret = cdns_init_clock_ctrl(cdns);
+	if (ret)
+		return ret;
 
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, false, 0);
 
-- 
2.39.5


