Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A867BDE1D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376914AbjJINQE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376929AbjJINQD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162619D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C62C433C8;
        Mon,  9 Oct 2023 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857360;
        bh=I9DDwXpS6VNGHvn5zBwSFuvkwmxr3muJWfGwsW/4I48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbXV/DIrNgBvzv4tGYZOom53OIK6kEMBceyu4ndx+FFVz4BYwU4tj8TW0wYGz7EbQ
         LK3XYmDdEwXe8gq0SOgpnFjXVZIqB0CKMocv+NJDEUQUG8uYkvfT4GeUKyueNCtSab
         4cVTcv6wkFEBHjI831EAaMgVxvCHAcqlK0SQy6Bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sameer Pujar <spujar@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/162] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
Date:   Mon,  9 Oct 2023 14:59:50 +0200
Message-ID: <20231009130123.207558832@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sameer Pujar <spujar@nvidia.com>

[ Upstream commit e765886249c533e1bb5cbc3cd741bad677417312 ]

Tegra audio graph card has many DAI links which connects internal
AHUB modules and external audio codecs. Since these are DPCM links,
hw_params() call in the machine driver happens for each connected
BE link and PLLA is updated every time. This is not really needed
for all links as only I/O link DAIs derive respective clocks from
PLLA_OUT0 and thus from PLLA. Hence add checks to limit the clock
updates to DAIs over I/O links.

This found to be fixing a DMIC clock discrepancy which is suspected
to happen because of back to back quick PLLA and PLLA_OUT0 rate
updates. This was observed on Jetson TX2 platform where DMIC clock
ended up with unexpected value.

Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Link: https://lore.kernel.org/r/1694098945-32760-3-git-send-email-spujar@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra_audio_graph_card.c | 30 ++++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/tegra/tegra_audio_graph_card.c b/sound/soc/tegra/tegra_audio_graph_card.c
index 1f2c5018bf5ac..4737e776d3837 100644
--- a/sound/soc/tegra/tegra_audio_graph_card.c
+++ b/sound/soc/tegra/tegra_audio_graph_card.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <sound/graph_card.h>
 #include <sound/pcm_params.h>
+#include <sound/soc-dai.h>
 
 #define MAX_PLLA_OUT0_DIV 128
 
@@ -44,6 +45,21 @@ struct tegra_audio_cdata {
 	unsigned int plla_out0_rates[NUM_RATE_TYPE];
 };
 
+static bool need_clk_update(struct snd_soc_dai *dai)
+{
+	if (snd_soc_dai_is_dummy(dai) ||
+	    !dai->driver->ops ||
+	    !dai->driver->name)
+		return false;
+
+	if (strstr(dai->driver->name, "I2S") ||
+	    strstr(dai->driver->name, "DMIC") ||
+	    strstr(dai->driver->name, "DSPK"))
+		return true;
+
+	return false;
+}
+
 /* Setup PLL clock as per the given sample rate */
 static int tegra_audio_graph_update_pll(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
@@ -140,19 +156,7 @@ static int tegra_audio_graph_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int err;
 
-	/*
-	 * This gets called for each DAI link (FE or BE) when DPCM is used.
-	 * We may not want to update PLLA rate for each call. So PLLA update
-	 * must be restricted to external I/O links (I2S, DMIC or DSPK) since
-	 * they actually depend on it. I/O modules update their clocks in
-	 * hw_param() of their respective component driver and PLLA rate
-	 * update here helps them to derive appropriate rates.
-	 *
-	 * TODO: When more HW accelerators get added (like sample rate
-	 * converter, volume gain controller etc., which don't really
-	 * depend on PLLA) we need a better way to filter here.
-	 */
-	if (cpu_dai->driver->ops && rtd->dai_link->no_pcm) {
+	if (need_clk_update(cpu_dai)) {
 		err = tegra_audio_graph_update_pll(substream, params);
 		if (err)
 			return err;
-- 
2.40.1



