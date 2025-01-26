Return-Path: <stable+bounces-110736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B59A1CBF7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E053C7A5B8C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916BB17C21C;
	Sun, 26 Jan 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghiNvmvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5A1AAA05;
	Sun, 26 Jan 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904044; cv=none; b=lHvUeyHuY/1NJdy7yiowejLueoRkKbq5nrF4Dh5lE/rBuVZCQFupW34A6Nwbgk9ZIe+bQJNbq3CbvwC/I+soS2iJ9XR+Gf4vYo3A5aVHScw0kLPf+uzOMfiQ6BNVlniHgdqdPNx5ex0hZe1O07Lf9nRxG7A3jOCzqKlIJPx8UAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904044; c=relaxed/simple;
	bh=BoZsPj5PgnYivoDPYiUJZ20sRFeaI+4ITBnlF4dXwpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kFNiTUjQoh71fXB8WWoETY8ao3dGvxwQZM/1x6fJoIwi1JxkC1YlZkmrw3mS6lQUV20GGIaetTHEDaT2mVIQfnOxG4rfdZlBWyPkX5TwLemWneMfoyociL+aILznsF5tK/kzttFGg7k+ACh8S/e3EcJ9U/a26pPF/e8F6x3jItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghiNvmvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B06C4CED3;
	Sun, 26 Jan 2025 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904043;
	bh=BoZsPj5PgnYivoDPYiUJZ20sRFeaI+4ITBnlF4dXwpI=;
	h=From:To:Cc:Subject:Date:From;
	b=ghiNvmvAwCkmph0KOiw4GYBhCRu7TzK7IX+E3J24/yJFaiEJkFmIGNxA3DuSaBOE9
	 DsuYTGT1ZgM1cCYX13fpgKj4K4Ql0frmxSRqfZXmKLeD5M2mPWU06Wan62ziQQm64M
	 QxmsxCWXda5tiERDBX7sJcXNfFgX2norhzveGuqsiWJoNOAfbYEaLGu4LRvKv0T65c
	 EEBrqjlw6eMQK/CP1/mNHxUi9bgEhgKamRIw7OVgQuREx0UOM53j9rSmIEQNRsE6de
	 XuPJhqY8DFPb/gbhrseq5H51ef+OknqY4k+8wCEnAmOoFDjsycN4Yp4q2Ix4xsxbad
	 pNiRWiG92jGXg==
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
Subject: [PATCH AUTOSEL 6.13 01/16] ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid during params
Date: Sun, 26 Jan 2025 10:07:03 -0500
Message-Id: <20250126150720.961959-1-sashal@kernel.org>
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
X-stable-base: Linux 6.13
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
index 0db2a3e554fb2..da12aabc1bb85 100644
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
index f991785f727e9..be689f6e10c81 100644
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


