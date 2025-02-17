Return-Path: <stable+bounces-115664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E4A34502
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10A0172B18
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16091221562;
	Thu, 13 Feb 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxkChpss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766B26B0BA;
	Thu, 13 Feb 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458823; cv=none; b=T4tGT29VAbh+nEWef3cGmjb6aw3+JydBiSp/q8qNPtAe4UVqlaW2d0ATVJbVNIOUZ48cdYyCeBDnspDSTtu7UywDZC4donivy4zIZdl9YySu3JS2Fm8rW0x+9a8LvCjWnxL2V7tnZXCz/8CjQN2PNNT2wutunlNrds+g5U1/768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458823; c=relaxed/simple;
	bh=oNyaSlFAvjyHAvJqzAEYU1ZlpCM9AaB0kXDUO6Ak+to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4egfDiJOrvpwmEj3t4ns/o8CZO6o8YHF1QuchLigSPw3h+yzp6QZbrtCGahFTWEAyHbgDj+NbaYXQF6mR3hhEoc+IY6wK3mDiOjewQz0jByXrIieqzhA8yJy0buVpd002GjbpPtIxXYRHXgVIlxRHAFP3Z+qiC6N50rmSsK+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxkChpss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6DFC4CED1;
	Thu, 13 Feb 2025 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458823;
	bh=oNyaSlFAvjyHAvJqzAEYU1ZlpCM9AaB0kXDUO6Ak+to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zxkChpssxgpbx89lhw69EnCX5HrNHu3HPbcpc9DnsRAKjyTlAI+wd7DwQ9O056+v5
	 B69pv8EvIVtS4pA7X/7eQuUf/tJbLlgnrA1BMzTTCzywFlxGK1MWz+RI8tyICECyGb
	 rEStyUwzk+OB4d1wmA6XbFNpUUcTQ+Urc3mF3hgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 087/443] ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid during params
Date: Thu, 13 Feb 2025 15:24:12 +0100
Message-ID: <20250213142443.968007438@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

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




