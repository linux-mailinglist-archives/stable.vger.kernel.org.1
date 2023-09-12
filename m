Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E434879B65B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379424AbjIKWoE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjIKOI2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:08:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80796CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BB3C433C8;
        Mon, 11 Sep 2023 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441303;
        bh=/0OcBgvOFAAgzeU5zVbmzjFsu2JxLo2akofTApft/aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNBxdNyvzDw4NNo3kdrtaxzTIDBfMRuQ1+vcFxuhrDG/TjjdLZ00CflzuuZ95NNDm
         KalEOlQ46pMVZxHyPYESqY/TN+pSt/Q93AgZEk00T3cuFMOcxlLeImUkpA1eddnuMp
         c+MuGUAJF7bSBvTS64cu+ammT05hvV+9MGB3fzbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 365/739] ASoC: fsl: merge DAI call back functions into ops
Date:   Mon, 11 Sep 2023 15:42:44 +0200
Message-ID: <20230911134701.347315064@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 5e5f68ca836e740c1d788f04efa84b37ed185606 ]

ALSA SoC merges DAI call backs into .ops.
This patch merge these into one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87jzu5b0ue.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c    | 16 ++++++++--------
 sound/soc/fsl/fsl_aud2htx.c | 10 +++++-----
 sound/soc/fsl/fsl_easrc.c   | 16 ++++++++--------
 sound/soc/fsl/fsl_esai.c    | 20 ++++++++++----------
 sound/soc/fsl/fsl_micfil.c  | 14 +++++++-------
 sound/soc/fsl/fsl_sai.c     | 24 ++++++++++++------------
 sound/soc/fsl/fsl_spdif.c   | 17 ++++++++---------
 sound/soc/fsl/fsl_ssi.c     |  3 +--
 sound/soc/fsl/fsl_xcvr.c    | 16 ++++++++--------
 9 files changed, 67 insertions(+), 69 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index adb8a59de2bd9..b793263291dc8 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -780,13 +780,6 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
-	.startup      = fsl_asrc_dai_startup,
-	.hw_params    = fsl_asrc_dai_hw_params,
-	.hw_free      = fsl_asrc_dai_hw_free,
-	.trigger      = fsl_asrc_dai_trigger,
-};
-
 static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
@@ -797,12 +790,19 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
+	.probe		= fsl_asrc_dai_probe,
+	.startup	= fsl_asrc_dai_startup,
+	.hw_params	= fsl_asrc_dai_hw_params,
+	.hw_free	= fsl_asrc_dai_hw_free,
+	.trigger	= fsl_asrc_dai_trigger,
+};
+
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S24_3LE)
 
 static struct snd_soc_dai_driver fsl_asrc_dai = {
-	.probe = fsl_asrc_dai_probe,
 	.playback = {
 		.stream_name = "ASRC-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_aud2htx.c b/sound/soc/fsl/fsl_aud2htx.c
index 46b0c5dcc4a50..fc56f6ade3682 100644
--- a/sound/soc/fsl/fsl_aud2htx.c
+++ b/sound/soc/fsl/fsl_aud2htx.c
@@ -49,10 +49,6 @@ static int fsl_aud2htx_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_aud2htx_dai_ops = {
-	.trigger	= fsl_aud2htx_trigger,
-};
-
 static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_aud2htx *aud2htx = dev_get_drvdata(cpu_dai->dev);
@@ -84,8 +80,12 @@ static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_aud2htx_dai_ops = {
+	.probe		= fsl_aud2htx_dai_probe,
+	.trigger	= fsl_aud2htx_trigger,
+};
+
 static struct snd_soc_dai_driver fsl_aud2htx_dai = {
-	.probe = fsl_aud2htx_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 670cbdb361b6c..ba62995c909ac 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1531,13 +1531,6 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
-	.startup = fsl_easrc_startup,
-	.trigger = fsl_easrc_trigger,
-	.hw_params = fsl_easrc_hw_params,
-	.hw_free = fsl_easrc_hw_free,
-};
-
 static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_asrc *easrc = dev_get_drvdata(cpu_dai->dev);
@@ -1548,8 +1541,15 @@ static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
+	.probe		= fsl_easrc_dai_probe,
+	.startup	= fsl_easrc_startup,
+	.trigger	= fsl_easrc_trigger,
+	.hw_params	= fsl_easrc_hw_params,
+	.hw_free	= fsl_easrc_hw_free,
+};
+
 static struct snd_soc_dai_driver fsl_easrc_dai = {
-	.probe = fsl_easrc_dai_probe,
 	.playback = {
 		.stream_name = "ASRC-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 936f0cd4b06d8..d0d8a01da9bdd 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -785,15 +785,6 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
-	.startup = fsl_esai_startup,
-	.trigger = fsl_esai_trigger,
-	.hw_params = fsl_esai_hw_params,
-	.set_sysclk = fsl_esai_set_dai_sysclk,
-	.set_fmt = fsl_esai_set_dai_fmt,
-	.set_tdm_slot = fsl_esai_set_dai_tdm_slot,
-};
-
 static int fsl_esai_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
@@ -804,8 +795,17 @@ static int fsl_esai_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
+	.probe		= fsl_esai_dai_probe,
+	.startup	= fsl_esai_startup,
+	.trigger	= fsl_esai_trigger,
+	.hw_params	= fsl_esai_hw_params,
+	.set_sysclk	= fsl_esai_set_dai_sysclk,
+	.set_fmt	= fsl_esai_set_dai_fmt,
+	.set_tdm_slot	= fsl_esai_set_dai_tdm_slot,
+};
+
 static struct snd_soc_dai_driver fsl_esai_dai = {
-	.probe = fsl_esai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 9d01225dedd9a..d0548b35d1eb2 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -717,12 +717,6 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
-	.startup = fsl_micfil_startup,
-	.trigger = fsl_micfil_trigger,
-	.hw_params = fsl_micfil_hw_params,
-};
-
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
@@ -760,8 +754,14 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
+	.probe		= fsl_micfil_dai_probe,
+	.startup	= fsl_micfil_startup,
+	.trigger	= fsl_micfil_trigger,
+	.hw_params	= fsl_micfil_hw_params,
+};
+
 static struct snd_soc_dai_driver fsl_micfil_dai = {
-	.probe = fsl_micfil_dai_probe,
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f7676d30c82fd..1e4020fae05ab 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -849,17 +849,6 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
-	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
-	.set_sysclk	= fsl_sai_set_dai_sysclk,
-	.set_fmt	= fsl_sai_set_dai_fmt,
-	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
-	.hw_params	= fsl_sai_hw_params,
-	.hw_free	= fsl_sai_hw_free,
-	.trigger	= fsl_sai_trigger,
-	.startup	= fsl_sai_startup,
-};
-
 static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
@@ -885,6 +874,18 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
+	.probe		= fsl_sai_dai_probe,
+	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
+	.set_sysclk	= fsl_sai_set_dai_sysclk,
+	.set_fmt	= fsl_sai_set_dai_fmt,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
+	.hw_params	= fsl_sai_hw_params,
+	.hw_free	= fsl_sai_hw_free,
+	.trigger	= fsl_sai_trigger,
+	.startup	= fsl_sai_startup,
+};
+
 static int fsl_sai_dai_resume(struct snd_soc_component *component)
 {
 	struct fsl_sai *sai = snd_soc_component_get_drvdata(component);
@@ -903,7 +904,6 @@ static int fsl_sai_dai_resume(struct snd_soc_component *component)
 }
 
 static struct snd_soc_dai_driver fsl_sai_dai_template = {
-	.probe = fsl_sai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3fd26f2cdd60f..e6642cd7423b3 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -761,14 +761,6 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_spdif_dai_ops = {
-	.startup = fsl_spdif_startup,
-	.hw_params = fsl_spdif_hw_params,
-	.trigger = fsl_spdif_trigger,
-	.shutdown = fsl_spdif_shutdown,
-};
-
-
 /*
  * FSL SPDIF IEC958 controller(mixer) functions
  *
@@ -1279,8 +1271,15 @@ static int fsl_spdif_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_spdif_dai_ops = {
+	.probe		= fsl_spdif_dai_probe,
+	.startup	= fsl_spdif_startup,
+	.hw_params	= fsl_spdif_hw_params,
+	.trigger	= fsl_spdif_trigger,
+	.shutdown	= fsl_spdif_shutdown,
+};
+
 static struct snd_soc_dai_driver fsl_spdif_dai = {
-	.probe = &fsl_spdif_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 2,
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 53ed3701b0b0e..079ac04272b85 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1152,6 +1152,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 }
 
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
+	.probe = fsl_ssi_dai_probe,
 	.startup = fsl_ssi_startup,
 	.shutdown = fsl_ssi_shutdown,
 	.hw_params = fsl_ssi_hw_params,
@@ -1162,7 +1163,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 };
 
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
-	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
@@ -1187,7 +1187,6 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.symmetric_channels = 1,
-	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "CPU AC97 Playback",
 		.channels_min = 2,
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 318fe77683f56..fa0a15263c66d 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -888,13 +888,6 @@ static struct snd_kcontrol_new fsl_xcvr_tx_ctls[] = {
 	},
 };
 
-static const struct snd_soc_dai_ops fsl_xcvr_dai_ops = {
-	.prepare = fsl_xcvr_prepare,
-	.startup = fsl_xcvr_startup,
-	.shutdown = fsl_xcvr_shutdown,
-	.trigger = fsl_xcvr_trigger,
-};
-
 static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
@@ -915,8 +908,15 @@ static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_xcvr_dai_ops = {
+	.probe		= fsl_xcvr_dai_probe,
+	.prepare	= fsl_xcvr_prepare,
+	.startup	= fsl_xcvr_startup,
+	.shutdown	= fsl_xcvr_shutdown,
+	.trigger	= fsl_xcvr_trigger,
+};
+
 static struct snd_soc_dai_driver fsl_xcvr_dai = {
-	.probe  = fsl_xcvr_dai_probe,
 	.ops = &fsl_xcvr_dai_ops,
 	.playback = {
 		.stream_name = "CPU-Playback",
-- 
2.40.1



