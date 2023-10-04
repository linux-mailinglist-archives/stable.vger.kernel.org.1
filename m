Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5794C7B83BA
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjJDPhE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjJDPhE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1246BBD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:36:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E7DC433C7;
        Wed,  4 Oct 2023 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696433818;
        bh=bmk/nWms+BQIVsUJl+thHYdan0ai9RQ9nTWW+C3dpx4=;
        h=Subject:To:Cc:From:Date:From;
        b=w16z0v+0iyv+1NLM+rvnhYt0a9m/6Z11t4oCeDCpFKl38qi8tjvj+oAdrmNzs53ft
         T8+1IExGQ1A7FXEEzu7LVDfiyXxyyfRQux2BTo6sxjg4LuwCM6LddXQVtVHTsstn/+
         EYBdWXabTmA+ZUFdkZfmJ0o6akmrByftVSCborSo=
Subject: FAILED: patch "[PATCH] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates" failed to apply to 6.5-stable tree
To:     spujar@nvidia.com, broonie@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 17:36:50 +0200
Message-ID: <2023100450-shone-catchy-89d1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x e765886249c533e1bb5cbc3cd741bad677417312
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100450-shone-catchy-89d1@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e765886249c533e1bb5cbc3cd741bad677417312 Mon Sep 17 00:00:00 2001
From: Sameer Pujar <spujar@nvidia.com>
Date: Thu, 7 Sep 2023 20:32:25 +0530
Subject: [PATCH] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

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

diff --git a/sound/soc/tegra/tegra_audio_graph_card.c b/sound/soc/tegra/tegra_audio_graph_card.c
index 1f2c5018bf5a..4737e776d383 100644
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

