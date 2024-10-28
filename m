Return-Path: <stable+bounces-88989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA19B2D6C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E01F21D29
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19F1DA0ED;
	Mon, 28 Oct 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb2Tj6Da"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9E1D9598;
	Mon, 28 Oct 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112674; cv=none; b=ihaJhHzrQn9Nrt4gxmIVNfWRPp+kf0Mcw7WiVjGV1LucN7Pu4p3jJCxxKhoxd43+777vl97nQR5xdawBo9mL1uxMmbW0xYQZjqkRH4pTPV80btuBc79q3YXBuMGNTP8cIKSShn2/D1rEpuf3Q186NEcu+AilAfXBE4iTXkGmHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112674; c=relaxed/simple;
	bh=1RFqRlm7TkOTkW78+E3dqzZ6TyWeXL0PlAvwW23uhkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXOqazJnMiMVA7YhcBnnmqvky7/cSS7sacRRZcrPjAtspW8kJIZ7BLp9iWo0JcWy3bFOjc1ftP+LDW6QWq+G6F6Mc+WiD3MfDQneR0NhWwIqzOQpAPZURRxPk/B4eM748fciorGfIX7wvNqytOQBseiUxIcbHFAwuP3AfQ/7UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb2Tj6Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC0C4CEE3;
	Mon, 28 Oct 2024 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112674;
	bh=1RFqRlm7TkOTkW78+E3dqzZ6TyWeXL0PlAvwW23uhkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bb2Tj6DaqrlzB94Exa+Qj2KDNRQV8lSIGuo/7dvm+E9i9gf0QQSBBdwn57ptsJWiP
	 Mwj6m7cQmZeGq+iW9KOgR1hoQCJG+x/EcUy47dPzsGsq/+Iy0YyIINkBb2NNbcapEg
	 h7xmKrLnOnPGuToVIUBLTdFf89WpBrrTrcRla8t6CfzMz7KjHmXEiOhuDX5i22U80o
	 c3aznKTmKeTCbTukMk58OGaZmsstDDxrZgq0WCgT3vx0flywp4CI7wHvVzUIZZ0G+E
	 2WqXXGsXS22/q2aageEkbztrk2VtrMh1ldKU3rMCPqIAmaU5gAAdCwIILVxjBU6yZ8
	 Ta3V+v2rRhh/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 07/32] ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
Date: Mon, 28 Oct 2024 06:49:49 -0400
Message-ID: <20241028105050.3559169-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 6e38a7e098d32d128b00b42a536151de9ea1340b ]

When a PCM is restarted after a snd_pcm_drain/snd_pcm_drop(), the prepare
callback will be invoked and the hw_params will be set again. For the
HDA DAI's, the hw_params function handles this case already but not for
the non-HDA DAI's. So, add the check for link_prepared to verify if the
hw_params should be done again or not. Additionally, for SDW DAI's reset
the PCMSyCM registers as would be done in the case of a start after a
hw_free.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
All: stable@vger.kernel.org # 6.10.x 6.11.x
Link: https://patch.msgid.link/20241016032910.14601-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c | 36 +++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 1c823f9eea570..8cccf38967e72 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -370,6 +370,13 @@ static int non_hda_dai_hw_params_data(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	sdev = widget_to_sdev(w);
+	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
+
+	/* nothing more to do if the link is already prepared */
+	if (hext_stream && hext_stream->link_prepared)
+		return 0;
+
 	/* use HDaudio stream handling */
 	ret = hda_dai_hw_params_data(substream, params, cpu_dai, data, flags);
 	if (ret < 0) {
@@ -377,7 +384,6 @@ static int non_hda_dai_hw_params_data(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	sdev = widget_to_sdev(w);
 	if (sdev->dspless_mode_selected)
 		return 0;
 
@@ -482,6 +488,31 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	int i;
 
+	ops = hda_dai_get_ops(substream, cpu_dai);
+	if (!ops) {
+		dev_err(cpu_dai->dev, "DAI widget ops not set\n");
+		return -EINVAL;
+	}
+
+	sdev = widget_to_sdev(w);
+	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
+
+	/* nothing more to do if the link is already prepared */
+	if (hext_stream && hext_stream->link_prepared)
+		return 0;
+
+	/*
+	 * reset the PCMSyCM registers to handle a prepare callback when the PCM is restarted
+	 * due to xruns or after a call to snd_pcm_drain/drop()
+	 */
+	ret = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id, cpu_dai->id,
+					     0, 0, substream->stream);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "%s:  hdac_bus_eml_sdw_map_stream_ch failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	data.dai_index = (link_id << 8) | cpu_dai->id;
 	data.dai_node_id = intel_alh_id;
 	ret = non_hda_dai_hw_params_data(substream, params, cpu_dai, &data, flags);
@@ -490,10 +521,7 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ops = hda_dai_get_ops(substream, cpu_dai);
-	sdev = widget_to_sdev(w);
 	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
-
 	if (!hext_stream)
 		return -ENODEV;
 
-- 
2.43.0


