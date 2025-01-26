Return-Path: <stable+bounces-110752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E4A1CC1F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC8D7A60A2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128C1F91C7;
	Sun, 26 Jan 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+JT7htn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E971F91CC;
	Sun, 26 Jan 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904087; cv=none; b=aH+IqIOnlru2q0z8fbZ2DnRq7CuIMnq4/JR/NvNU8IHPPONdQLpHQzLDP8N4WTVg50dkIiLOcQYDIwUxsud/eTKIVvjt+P2rfyh2OeMvpWjp15fTwmDh/03islpgzCEX0FX0GNEHgPs6TJmSiw11SGk+7OKeTF1cixWxkoq82pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904087; c=relaxed/simple;
	bh=X78rBr0Zxwa7cE0jsohoO4I5kg490OoXiO44VG5mxHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qf6OnemneuZlS4l9FbVIZw+w8i2r/0nOPT1zqJNA5GaqEswtdgi073WUUPukqNcecMyOORgJMNgP1LWFxGmiezxzZhUJVq8miZruOZ47yajGDeWq+Agp6PNWtqmctXnSWavup3C43JXR7Ykt/K8d+ktotRW3N4kKieRxyqIg2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+JT7htn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C6C4CED3;
	Sun, 26 Jan 2025 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904086;
	bh=X78rBr0Zxwa7cE0jsohoO4I5kg490OoXiO44VG5mxHM=;
	h=From:To:Cc:Subject:Date:From;
	b=U+JT7htnbmFLaf88YV3oJ7LxSc+QKGNk1pixHF7DQtveoDVniJt2Fhdyulgd31fue
	 +JUymklYn5fWcyx6zHpxb4MECDAZ+vbQ6Hal8AFqjBmqkAPUciVIEoAJWJnt/l8oUZ
	 CgRtFaCcTZTTCqy8HJ0v0nsbCm7+L1iaNnapTnFkgpnzBKVQUUYaR5qW18WhXJIGxN
	 aFumwB+cvX/DigCqXo6LUKUmlBbpsUdgkBD9/L9uKfE1TdBmQb6h0m0xQev8RhMNqZ
	 ww3mwlhmNVRbxz+zMo3ceHZ+XwGOdfM5FLbm1fdLHb//B5b1QsKj3PcHPHW8LWRx2z
	 V2/AA+6edKbTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	peterz@infradead.org,
	kai.vehmanen@linux.intel.com,
	brent.lu@intel.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/14] ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid during params
Date: Sun, 26 Jan 2025 10:07:48 -0500
Message-Id: <20250126150803.962459-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 569922b82ca660f8b24e705f6cf674e6b1f99cc7 ]

Each cpu DAI should associate with a widget. However, the topology might
not create the right number of DAI widgets for aggregated amps. And it
will cause NULL pointer deference.
Check that the DAI widget associated with the CPU DAI is valid to prevent
NULL pointer deference due to missing DAI widgets in topologies with
aggregated amps.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Link: https://patch.msgid.link/20241203104853.56956-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c | 12 ++++++++++++
 sound/soc/sof/intel/hda.c     |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 82f46ecd94301..2e58a264da556 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -503,6 +503,12 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	int i;
 
+	if (!w) {
+		dev_err(cpu_dai->dev, "%s widget not found, check amp link num in the topology\n",
+			cpu_dai->name);
+		return -EINVAL;
+	}
+
 	ops = hda_dai_get_ops(substream, cpu_dai);
 	if (!ops) {
 		dev_err(cpu_dai->dev, "DAI widget ops not set\n");
@@ -582,6 +588,12 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	 */
 	for_each_rtd_cpu_dais(rtd, i, dai) {
 		w = snd_soc_dai_get_widget(dai, substream->stream);
+		if (!w) {
+			dev_err(cpu_dai->dev,
+				"%s widget not found, check amp link num in the topology\n",
+				dai->name);
+			return -EINVAL;
+		}
 		ipc4_copier = widget_to_copier(w);
 		memcpy(&ipc4_copier->dma_config_tlv[cpu_dai_id], dma_config_tlv,
 		       sizeof(*dma_config_tlv));
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 70fc08c8fc99e..f10ed4d102501 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -63,6 +63,11 @@ static int sdw_params_stream(struct device *dev,
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(d, params_data->substream->stream);
 	struct snd_sof_dai_config_data data = { 0 };
 
+	if (!w) {
+		dev_err(dev, "%s widget not found, check amp link num in the topology\n",
+			d->name);
+		return -EINVAL;
+	}
 	data.dai_index = (params_data->link_id << 8) | d->id;
 	data.dai_data = params_data->alh_stream_id;
 	data.dai_node_id = data.dai_data;
-- 
2.39.5


