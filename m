Return-Path: <stable+bounces-10788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338682CB9E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 11:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511C11C21ECE
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DB1848;
	Sat, 13 Jan 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0EF9QQn5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF728F7;
	Sat, 13 Jan 2024 10:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B42BC433F1;
	Sat, 13 Jan 2024 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140105;
	bh=Mcf0Y2OMdOh5NcyIMUJajAMAXbrJTaIWTOE+b2fGRIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0EF9QQn5KNZuWoB11NPyeKSh5zUTOJkWbm3ftjPxsee+UX3ceyRBambQyolpEpDXC
	 rPySU5StnXv+ocMfu/1hqWObBRbSfdhW16Jx+28vbtIAsK4jKYb3+DB1ProGdIHUrL
	 8GTnKLOhqblg1bWF5eZg78gFx6bVyQsNBpSS2k9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyang Huang <hzyitc@outlook.com>,
	Anand Moon <linux.amoon@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 48/59] mmc: meson-mx-sdhc: Fix initialization frozen issue
Date: Sat, 13 Jan 2024 10:50:19 +0100
Message-ID: <20240113094210.765240434@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
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

From: Ziyang Huang <hzyitc@outlook.com>

commit 8c124d998ea0c9022e247b11ac51f86ec8afa0e1 upstream.

Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
Then we set rx_clk_phase to 11 or 15 which is out of range and make
hardware frozen. After we send command request, no irq will be
interrupted and the mmc driver will keep to wait for request finished,
even durning rebooting.

So let's set it to Phase 90 which should work in most cases. Then let
meson_mx_sdhc_execute_tuning() to find the accurate value for data
transfer.

If this doesn't work, maybe need to define a factor in dts.

Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -269,7 +269,7 @@ static int meson_mx_sdhc_enable_clks(str
 static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
-	u32 rx_clk_phase;
+	u32 val, rx_clk_phase;
 	int ret;
 
 	meson_mx_sdhc_disable_clks(mmc);
@@ -290,27 +290,11 @@ static int meson_mx_sdhc_set_clk(struct
 		mmc->actual_clock = clk_get_rate(host->sd_clk);
 
 		/*
-		 * according to Amlogic the following latching points are
-		 * selected with empirical values, there is no (known) formula
-		 * to calculate these.
+		 * Phase 90 should work in most cases. For data transmission,
+		 * meson_mx_sdhc_execute_tuning() will find a accurate value
 		 */
-		if (mmc->actual_clock > 100000000) {
-			rx_clk_phase = 1;
-		} else if (mmc->actual_clock > 45000000) {
-			if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-				rx_clk_phase = 15;
-			else
-				rx_clk_phase = 11;
-		} else if (mmc->actual_clock >= 25000000) {
-			rx_clk_phase = 15;
-		} else if (mmc->actual_clock > 5000000) {
-			rx_clk_phase = 23;
-		} else if (mmc->actual_clock > 1000000) {
-			rx_clk_phase = 55;
-		} else {
-			rx_clk_phase = 1061;
-		}
-
+		regmap_read(host->regmap, MESON_SDHC_CLKC, &val);
+		rx_clk_phase = FIELD_GET(MESON_SDHC_CLKC_CLK_DIV, val) / 4;
 		regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
 				   MESON_SDHC_CLK2_RX_CLK_PHASE,
 				   FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,



