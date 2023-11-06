Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878047E23E1
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjKFNPq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjKFNPp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:15:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C60BD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:15:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDE2C433C8;
        Mon,  6 Nov 2023 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276542;
        bh=loUCKoprdXJsVQ7uZdkiLCZRNqKziYvbeus94tHOuBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ki0I5bLd15PDwfNatbUyQNpCTALgF9wdOk8WAPGNpZsPIbEVZFxfktyvZPTg97sWX
         0W8lmi7DptwatWlBuArhwE2aVO3cE+1ulwBBkiDEHCgaq1PiTfKLX2N9hKxX+zCNbc
         H3bFno3D4ne5KysgpU3OJBAtJ2nqrytlfsCz/b0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 04/88] ASoC: fsl-asoc-card: use integer type for fll_id and pll_id
Date:   Mon,  6 Nov 2023 14:02:58 +0100
Message-ID: <20231106130305.929590204@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 2b21207afd06714986a3d22442ed4860ba4f9ced ]

As the pll_id and pll_id can be zero (WM8960_SYSCLK_AUTO)
with the commit 2bbc2df46e67 ("ASoC: wm8960: Make automatic the
default clocking mode")

Then the machine driver will skip to call set_sysclk() and set_pll()
for codec, when the sysclk rate is different with what wm8960 read
at probe, the output sound frequency is wrong.

So change the fll_id and pll_id initial value, still keep machine
driver's behavior same as before.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1695202992-24864-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 76b5bfc288fde..bab7d34cf585b 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -52,8 +52,8 @@ struct codec_priv {
 	unsigned long mclk_freq;
 	unsigned long free_freq;
 	u32 mclk_id;
-	u32 fll_id;
-	u32 pll_id;
+	int fll_id;
+	int pll_id;
 };
 
 /**
@@ -206,7 +206,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Specific configuration for PLL */
-	if (codec_priv->pll_id && codec_priv->fll_id) {
+	if (codec_priv->pll_id >= 0 && codec_priv->fll_id >= 0) {
 		if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
 			pll_out = priv->sample_rate * 384;
 		else
@@ -248,7 +248,7 @@ static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
 
 	priv->streams &= ~BIT(substream->stream);
 
-	if (!priv->streams && codec_priv->pll_id && codec_priv->fll_id) {
+	if (!priv->streams && codec_priv->pll_id >= 0 && codec_priv->fll_id >= 0) {
 		/* Force freq to be free_freq to avoid error message in codec */
 		ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
 					     codec_priv->mclk_id,
@@ -621,6 +621,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dapm_routes = audio_map;
 	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
 	priv->card.driver_name = DRIVER_NAME;
+
+	priv->codec_priv.fll_id = -1;
+	priv->codec_priv.pll_id = -1;
+
 	/* Diversify the card configurations */
 	if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
 		codec_dai_name = "cs42888";
-- 
2.42.0



