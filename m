Return-Path: <stable+bounces-174559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C45FB363D5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CC88A5C18
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323E1E502;
	Tue, 26 Aug 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/1buINX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FA2B2DA;
	Tue, 26 Aug 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214714; cv=none; b=sdt3vjBiWmMLuhvS3onbMNh08aTUPNG5U5Q6VSdoT9VzXD07XNwbpuZ9ovUefg5vPjSKu51wgPu3PNcOnq35tj0Elpq0xJA1WLAvxwA8COBKB6W0w+1tK8APgdOEkeNuRHOcjBjAYlIrsFSIKtpGGCcgAJWAD2Aj5XYhF6lncZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214714; c=relaxed/simple;
	bh=bfIaJvX4HxM8XKGKZNX25zt9kF0NoLICv9nNCk668xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlQ9Dq8t04UvjP1ePxtozf1fCxzcD3UJStn6L+h8roks3+m7iLiHJIt8nJO+F+BVJUzpJOhObxADSg9nOF3eHEzlZvVaZscD7084zQozsZNsbirN5LFrrYxNXlBabOuN0MTCqUcgbPzm27Ku7TIpf9/4t0Oz2ZTA2v4NIhRdg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/1buINX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E0C116B1;
	Tue, 26 Aug 2025 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214714;
	bh=bfIaJvX4HxM8XKGKZNX25zt9kF0NoLICv9nNCk668xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/1buINX+qs1e5C0NPlaSgmgvJWSsZ81yp7Hhvr5nYIS1dF0H3cyShIzoFzcV9eaS
	 emgWMH4papWg++b3Rk6Y9PIS8WaARu1kzABwNt23f4wBvI4knCTBsbSDuDV10hYlsb
	 vvgk2AjDP0V4Qt9+qvtSFCtWfGGH8BwTz+78yA0w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 241/482] ASoC: fsl: merge DAI call back functions into ops
Date: Tue, 26 Aug 2025 13:08:14 +0200
Message-ID: <20250826110936.724810533@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 5e5f68ca836e740c1d788f04efa84b37ed185606 ]

ALSA SoC merges DAI call backs into .ops.
This patch merge these into one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87jzu5b0ue.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0e270f32975f ("ASoC: fsl_sai: replace regmap_write with regmap_update_bits")
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
index c541e2a0202a..3ec5b88bd9a2 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -781,13 +781,6 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -798,12 +791,19 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
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
index 1e421d9a03fb..402d9bbdbab5 100644
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
index 84e6f9eb784d..210ca7199ada 100644
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
index 17fefd27ec90..c7f4c1734825 100644
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
index 8ee6f41563ea..1b6f5e33ff93 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -358,12 +358,6 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
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
@@ -400,8 +394,14 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
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
index 27ad825c78f2..33d01a5e9b31 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -883,17 +883,6 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
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
@@ -919,6 +908,18 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
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
@@ -937,7 +938,6 @@ static int fsl_sai_dai_resume(struct snd_soc_component *component)
 }
 
 static struct snd_soc_dai_driver fsl_sai_dai_template = {
-	.probe = fsl_sai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index fb6806b2db85..d89963b8171d 100644
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
index 6af00b62a60f..17887359dca1 100644
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
index c043efe4548d..4c5864e8267d 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -864,13 +864,6 @@ static struct snd_kcontrol_new fsl_xcvr_tx_ctls[] = {
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
@@ -887,8 +880,15 @@ static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
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
2.50.1




