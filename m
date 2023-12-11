Return-Path: <stable+bounces-5372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB780CB75
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0541C20EE0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BB47787;
	Mon, 11 Dec 2023 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcLCElSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82C38DD0;
	Mon, 11 Dec 2023 13:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE634C433C8;
	Mon, 11 Dec 2023 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302758;
	bh=ZVIuTH2Y2x9ryR7tf4LOw2lFNj0UgMCxHQOZ/tfs0TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcLCElSXPDzKOXsgK0NvIRLzP2bCNvLuip3l8mQ7fd3eJxWvLOvm94qbyY1b7k7pv
	 l1sUoZi/63a9PXwFZaDka3etqwbuyGiC5atfer+D2fhEog8QlBIGlmJfrNgoJkIbTN
	 tj7btJMrE6V+iZSRmfrw5SNYzqf/yBN/FdyN43VTPLkV1rJWR2wrf56w5wHJ2V96rw
	 u40blCFDd4aOzy+wpVAn2rBVoXt+oZqtFzKCibBQO3vahAr8aRGJ18FAVP1ztti6gr
	 hMPEuZOVFAyZzxLXI/CLo1Sk+tY8xD1PORxsO3U5fZ3DBetukWJazRquB4gtffOw8g
	 sXYfqRwyVR0Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/47] ASoC: SOF: ipc4-topology: Add core_mask in struct snd_sof_pipeline
Date: Mon, 11 Dec 2023 08:50:18 -0500
Message-ID: <20231211135147.380223-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 0376b995bb7a65fb0c056f3adc5e9695ad0c1805 ]

With IPC4, a pipeline may contain multiple modules in the data
processing domain and they can be scheduled to run on different cores.
Add a new field in struct snd_sof_pipeline to keep track of all the
cores that are associated with the modules in the pipeline. Set the
pipeline core mask for IPC3 when initializing the pipeline widget IPC
structure. For IPC4, set the core mark when initializing the pipeline
widget and initializing processing modules in the data processing domain.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20231124135743.24674-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-topology.c | 2 ++
 sound/soc/sof/ipc4-topology.c | 9 +++++++++
 sound/soc/sof/sof-audio.h     | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index ba4ef290b6343..2c7a5e7a364cf 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -493,6 +493,7 @@ static int sof_ipc3_widget_setup_comp_mixer(struct snd_sof_widget *swidget)
 static int sof_ipc3_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct sof_ipc_pipe_new *pipeline;
 	struct snd_sof_widget *comp_swidget;
 	int ret;
@@ -545,6 +546,7 @@ static int sof_ipc3_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 		swidget->dynamic_pipeline_widget);
 
 	swidget->core = pipeline->core;
+	spipe->core_mask |= BIT(pipeline->core);
 
 	return 0;
 
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index c9c1d2ec7af25..05c3b1153a91c 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -654,6 +654,7 @@ static int sof_ipc4_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
 	struct sof_ipc4_pipeline *pipeline;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	int ret;
 
 	pipeline = kzalloc(sizeof(*pipeline), GFP_KERNEL);
@@ -668,6 +669,7 @@ static int sof_ipc4_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 	}
 
 	swidget->core = pipeline->core_id;
+	spipe->core_mask |= BIT(pipeline->core_id);
 
 	if (pipeline->use_chain_dma) {
 		dev_dbg(scomp->dev, "Set up chain DMA for %s\n", swidget->widget->name);
@@ -798,6 +800,7 @@ static int sof_ipc4_widget_setup_comp_mixer(struct snd_sof_widget *swidget)
 static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct sof_ipc4_src *src;
 	int ret;
 
@@ -820,6 +823,8 @@ static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
 		goto err;
 	}
 
+	spipe->core_mask |= BIT(swidget->core);
+
 	dev_dbg(scomp->dev, "SRC sink rate %d\n", src->sink_rate);
 
 	ret = sof_ipc4_widget_setup_msg(swidget, &src->msg);
@@ -865,6 +870,7 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
 	struct sof_ipc4_fw_module *fw_module;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct sof_ipc4_process *process;
 	void *cfg;
 	int ret;
@@ -921,6 +927,9 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 
 	sof_ipc4_widget_update_kcontrol_module_id(swidget);
 
+	/* set pipeline core mask to keep track of the core the module is scheduled to run on */
+	spipe->core_mask |= BIT(swidget->core);
+
 	return 0;
 free_base_cfg_ext:
 	kfree(process->base_config_ext);
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 5d5eeb1a1a6f0..a6d6bcd00ceec 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -480,6 +480,7 @@ struct snd_sof_widget {
  * @paused_count: Count of number of PCM's that have started and have currently paused this
 		  pipeline
  * @complete: flag used to indicate that pipeline set up is complete.
+ * @core_mask: Mask containing target cores for all modules in the pipeline
  * @list: List item in sdev pipeline_list
  */
 struct snd_sof_pipeline {
@@ -487,6 +488,7 @@ struct snd_sof_pipeline {
 	int started_count;
 	int paused_count;
 	int complete;
+	unsigned long core_mask;
 	struct list_head list;
 };
 
-- 
2.42.0


