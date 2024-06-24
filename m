Return-Path: <stable+bounces-55004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976D91499C
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A71F24788
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 12:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869D13BAC3;
	Mon, 24 Jun 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZGfeUx9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7F13CA91;
	Mon, 24 Jun 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231342; cv=none; b=PZXu5nlIOi81aGsT1yqYnhBPimd5Z9zHVKfZ/Uv+zBJcfBDXFraYyzpsZ50NL3baY+++nCecP9kRaFRNjZsG44r0vCNogwkvF8u4nQs+3rbZHpHbZ96Gb3KGV0hPyiqdurts5rTxiXDyfaB8aHTlVEboZoNOgUvK7H48pXWoFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231342; c=relaxed/simple;
	bh=HkULgTbcgMho59o74DrgE8BND93M/VizDHfsiew3Aj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPKZm6Z+7eSzEpCJw/cxuNKZxjBvBk0BzaP3jOvw2ikjWeHBT3HlZtZypYGvJBMGsdKGoYmTwKEkSAmOU6Rirba3PqSjHssY3sDEnyqCaH8zCddJx38lfRc6lMbjA3iF4p3BzazqPdRtkIt1ctapRORpjUBXhJWdxQqpD6l/iEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZGfeUx9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719231340; x=1750767340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HkULgTbcgMho59o74DrgE8BND93M/VizDHfsiew3Aj8=;
  b=DZGfeUx96PE1FLcmg6utaOngd7rM0AdaXX4xjsP53b8EMnYNFoWF9Rer
   ZcTn2uO9x757kaAbaZn+oidetsPFFL00bctEcSEgtn+p/pr1P+qwlNKzG
   YG9Eeg1owre0daAe12TAhA4SJKPsGt6mdCBeqK517S0KfylYYCs+RPCdI
   l/7Si/BJRiV9pH+tYixpKzDiI5DfOweLp/Ji8jGnW+/Vyb3cuFjgCmpXf
   Bw5Z6lsmKckK2brgdb9haVXqCD+SLrvgEov15hKW45W0Rbjxp7UY3JSw/
   ayaw6KeNIwxMMk4hEVqO1d6hJrXjiYmAmrF04CfZj9AG2iy3GCts3FcXW
   w==;
X-CSE-ConnectionGUID: w5RimLbTQhStOszkP75+SA==
X-CSE-MsgGUID: ytf2w+hmR2G6YVEa9c7NfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15888063"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="15888063"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 05:15:40 -0700
X-CSE-ConnectionGUID: qtk3zWR4Q/SENaGgboWxWg==
X-CSE-MsgGUID: UzHG0/eoQ86cBBKb7uPDKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43358828"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.230])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 05:15:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ASoC: SOF: ipc4-topology: Use correct queue_id for requesting input pin format
Date: Mon, 24 Jun 2024 14:15:18 +0200
Message-ID: <20240624121519.91703-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624121519.91703-1-pierre-louis.bossart@linux.intel.com>
References: <20240624121519.91703-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

It is incorrect to request the input pin format of the destination widget
using the output pin index of the source module as the indexes are not
necessarily matching.
moduleA.out_pin1 can be connected to moduleB.in_pin0 for example.

Use the dst_queue_id to request the input format of the destination module.

This bug remained unnoticed likely because in nocodec topologies we don't
have process modules after a module copier, thus the pin/queue index is
ignored.
For the process module case, the code was likely have been tested in a
controlled way where all the pin/queue/format properties were present to
work.

Update the debug prints to have better information.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 sound/soc/sof/ipc4-topology.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index ce2910f70e65..90f6856ee80c 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2869,7 +2869,7 @@ static void sof_ipc4_put_queue_id(struct snd_sof_widget *swidget, int queue_id,
 static int sof_ipc4_set_copier_sink_format(struct snd_sof_dev *sdev,
 					   struct snd_sof_widget *src_widget,
 					   struct snd_sof_widget *sink_widget,
-					   int sink_id)
+					   struct snd_sof_route *sroute)
 {
 	struct sof_ipc4_copier_config_set_sink_format format;
 	const struct sof_ipc_ops *iops = sdev->ipc->ops;
@@ -2878,9 +2878,6 @@ static int sof_ipc4_set_copier_sink_format(struct snd_sof_dev *sdev,
 	struct sof_ipc4_fw_module *fw_module;
 	struct sof_ipc4_msg msg = {{ 0 }};
 
-	dev_dbg(sdev->dev, "%s set copier sink %d format\n",
-		src_widget->widget->name, sink_id);
-
 	if (WIDGET_IS_DAI(src_widget->id)) {
 		struct snd_sof_dai *dai = src_widget->private;
 
@@ -2891,13 +2888,15 @@ static int sof_ipc4_set_copier_sink_format(struct snd_sof_dev *sdev,
 
 	fw_module = src_widget->module_info;
 
-	format.sink_id = sink_id;
+	format.sink_id = sroute->src_queue_id;
 	memcpy(&format.source_fmt, &src_config->audio_fmt, sizeof(format.source_fmt));
 
-	pin_fmt = sof_ipc4_get_input_pin_audio_fmt(sink_widget, sink_id);
+	pin_fmt = sof_ipc4_get_input_pin_audio_fmt(sink_widget, sroute->dst_queue_id);
 	if (!pin_fmt) {
-		dev_err(sdev->dev, "Unable to get pin %d format for %s",
-			sink_id, sink_widget->widget->name);
+		dev_err(sdev->dev,
+			"Failed to get input audio format of %s:%d for output of %s:%d\n",
+			sink_widget->widget->name, sroute->dst_queue_id,
+			src_widget->widget->name, sroute->src_queue_id);
 		return -EINVAL;
 	}
 
@@ -2955,7 +2954,8 @@ static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *
 	sroute->src_queue_id = sof_ipc4_get_queue_id(src_widget, sink_widget,
 						     SOF_PIN_TYPE_OUTPUT);
 	if (sroute->src_queue_id < 0) {
-		dev_err(sdev->dev, "failed to get queue ID for source widget: %s\n",
+		dev_err(sdev->dev,
+			"failed to get src_queue_id ID from source widget %s\n",
 			src_widget->widget->name);
 		return sroute->src_queue_id;
 	}
@@ -2963,7 +2963,8 @@ static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *
 	sroute->dst_queue_id = sof_ipc4_get_queue_id(src_widget, sink_widget,
 						     SOF_PIN_TYPE_INPUT);
 	if (sroute->dst_queue_id < 0) {
-		dev_err(sdev->dev, "failed to get queue ID for sink widget: %s\n",
+		dev_err(sdev->dev,
+			"failed to get dst_queue_id ID from sink widget %s\n",
 			sink_widget->widget->name);
 		sof_ipc4_put_queue_id(src_widget, sroute->src_queue_id,
 				      SOF_PIN_TYPE_OUTPUT);
@@ -2972,10 +2973,11 @@ static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *
 
 	/* Pin 0 format is already set during copier module init */
 	if (sroute->src_queue_id > 0 && WIDGET_IS_COPIER(src_widget->id)) {
-		ret = sof_ipc4_set_copier_sink_format(sdev, src_widget, sink_widget,
-						      sroute->src_queue_id);
+		ret = sof_ipc4_set_copier_sink_format(sdev, src_widget,
+						      sink_widget, sroute);
 		if (ret < 0) {
-			dev_err(sdev->dev, "failed to set sink format for %s source queue ID %d\n",
+			dev_err(sdev->dev,
+				"failed to set sink format for source %s:%d\n",
 				src_widget->widget->name, sroute->src_queue_id);
 			goto out;
 		}
-- 
2.43.0


