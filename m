Return-Path: <stable+bounces-174558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC459B36436
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0262C2A4F3D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409831DAC95;
	Tue, 26 Aug 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rkP7THET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2F139579;
	Tue, 26 Aug 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214712; cv=none; b=fSYCunCa10tKbOLmFaZsfkej4xkoJ/u8v4m5et0KUm9JUMyWNxo8lyVN/SAfLgmHIcEQ8bTtEvXS2juXEwwNBypMggRsQW8SVSAvPGMM/BMzTRHtQU84LhaYD6pZBOCH9HoxT0+cVixCaakdnkRbO66KalqPvI6lsM8my+m2M68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214712; c=relaxed/simple;
	bh=+0pWM7yYAX9DGKHGlJmMuHMtOjGo03zTENSFcHB0ajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXBA+NUjEmMpWx7UDPqYFT6L+mPjU/jSeu6vjTbKj/1UbjtsOBHkLKUojLmGXKi6gNrlooyx7yuReBOezhW0KkBs2VjWlR7OVuVu4qiEJYjcA0q6a3Z8qBC9Ftr1fi7yGGa/G3W0e6PqJlZVCrCtAGtR2rgqxD91E0RrQV144zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rkP7THET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D985C4CEF1;
	Tue, 26 Aug 2025 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214711;
	bh=+0pWM7yYAX9DGKHGlJmMuHMtOjGo03zTENSFcHB0ajQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkP7THET7sVqmUZe0/kIpq33rsS/dVstlZX45cF67VQYtiSJfG0dLPsrO4Zsf9CGi
	 gkVAL63qJ6z889ic9fMJ2CqFurzofRf5wkOsokbsyfENi/BRs4xfQc3Y4RLhzM2o1T
	 +gkboXFGRXxH/i/9MWv4q03F0rxKwbAclBugGTuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 240/482] ASoC: soc-dai.h: merge DAI call back functions into ops
Date: Tue, 26 Aug 2025 13:08:13 +0200
Message-ID: <20250826110936.699914174@linuxfoundation.org>
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

[ Upstream commit 3e8bcec0787d1a73703c915c31cb00a2fd18ccbf ]

snd_soc_dai_driver has .ops for call back functions (A), but it also
has other call back functions (B). It is duplicated and confusable.

	struct snd_soc_dai_driver {
		...
 ^		int (*probe)(...);
 |		int (*remove)(...);
(B)		int (*compress_new)(...);
 |		int (*pcm_new)(...);
 v		...
(A)		const struct snd_soc_dai_ops *ops;
		...
	}

This patch merges (B) into (A).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87v8dpb0w6.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0e270f32975f ("ASoC: fsl_sai: replace regmap_write with regmap_update_bits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-dai.h              | 13 ++++++++
 sound/soc/generic/audio-graph-card.c |  2 +-
 sound/soc/soc-core.c                 | 25 ++++++++++++++++
 sound/soc/soc-dai.c                  | 44 ++++++++++++++++------------
 4 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ea7509672086..9fece4e37828 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -272,6 +272,15 @@ int snd_soc_dai_compr_get_metadata(struct snd_soc_dai *dai,
 				   struct snd_compr_metadata *metadata);
 
 struct snd_soc_dai_ops {
+	/* DAI driver callbacks */
+	int (*probe)(struct snd_soc_dai *dai);
+	int (*remove)(struct snd_soc_dai *dai);
+	/* compress dai */
+	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
+	/* Optional Callback used at pcm creation*/
+	int (*pcm_new)(struct snd_soc_pcm_runtime *rtd,
+		       struct snd_soc_dai *dai);
+
 	/*
 	 * DAI clocking configuration, all optional.
 	 * Called by soc_card drivers, normally in their hw_params.
@@ -353,6 +362,10 @@ struct snd_soc_dai_ops {
 	u64 *auto_selectable_formats;
 	int num_auto_selectable_formats;
 
+	/* probe ordering - for components with runtime dependencies */
+	int probe_order;
+	int remove_order;
+
 	/* bit field */
 	unsigned int no_capture_mute:1;
 };
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 5daa824a4ffc..e5481142c6c4 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -114,7 +114,7 @@ static bool soc_component_is_pcm(struct snd_soc_dai_link_component *dlc)
 	struct snd_soc_dai *dai = snd_soc_find_dai_with_mutex(dlc);
 
 	if (dai && (dai->component->driver->pcm_construct ||
-		    dai->driver->pcm_new))
+		    (dai->driver->ops && dai->driver->ops->pcm_new)))
 		return true;
 
 	return false;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1ff7a0b0a236..80192b089f25 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2426,6 +2426,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
+	struct snd_soc_dai_ops *ops; /* REMOVE ME */
 
 	dev_dbg(dev, "ASoC: dynamically register DAI %s\n", dev_name(dev));
 
@@ -2456,6 +2457,30 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 	if (!dai->name)
 		return NULL;
 
+	/* REMOVE ME */
+	if (dai_drv->probe		||
+	    dai_drv->remove		||
+	    dai_drv->compress_new	||
+	    dai_drv->pcm_new		||
+	    dai_drv->probe_order	||
+	    dai_drv->remove_order) {
+
+		ops = devm_kzalloc(dev, sizeof(struct snd_soc_dai_ops), GFP_KERNEL);
+		if (!ops)
+			return NULL;
+		if (dai_drv->ops)
+			memcpy(ops, dai_drv->ops, sizeof(struct snd_soc_dai_ops));
+
+		ops->probe		= dai_drv->probe;
+		ops->remove		= dai_drv->remove;
+		ops->compress_new	= dai_drv->compress_new;
+		ops->pcm_new		= dai_drv->pcm_new;
+		ops->probe_order	= dai_drv->probe_order;
+		ops->remove_order	= dai_drv->remove_order;
+
+		dai_drv->ops = ops;
+	}
+
 	dai->component = component;
 	dai->dev = dev;
 	dai->driver = dai_drv;
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 5eac6a7559c7..8e12f1059e72 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -460,8 +460,9 @@ int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
 			     struct snd_soc_pcm_runtime *rtd, int num)
 {
 	int ret = -ENOTSUPP;
-	if (dai->driver->compress_new)
-		ret = dai->driver->compress_new(rtd, num);
+	if (dai->driver->ops &&
+	    dai->driver->ops->compress_new)
+		ret = dai->driver->ops->compress_new(rtd, num);
 	return soc_dai_ret(dai, ret);
 }
 
@@ -545,19 +546,20 @@ int snd_soc_pcm_dai_probe(struct snd_soc_pcm_runtime *rtd, int order)
 	int i;
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (dai->driver->probe_order != order)
-			continue;
-
 		if (dai->probed)
 			continue;
 
-		if (dai->driver->probe) {
-			int ret = dai->driver->probe(dai);
+		if (dai->driver->ops) {
+			if (dai->driver->ops->probe_order != order)
+				continue;
 
-			if (ret < 0)
-				return soc_dai_ret(dai, ret);
-		}
+			if (dai->driver->ops->probe) {
+				int ret = dai->driver->ops->probe(dai);
 
+				if (ret < 0)
+					return soc_dai_ret(dai, ret);
+			}
+		}
 		dai->probed = 1;
 	}
 
@@ -570,16 +572,19 @@ int snd_soc_pcm_dai_remove(struct snd_soc_pcm_runtime *rtd, int order)
 	int i, r, ret = 0;
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (dai->driver->remove_order != order)
+		if (!dai->probed)
 			continue;
 
-		if (dai->probed &&
-		    dai->driver->remove) {
-			r = dai->driver->remove(dai);
-			if (r < 0)
-				ret = r; /* use last error */
-		}
+		if (dai->driver->ops) {
+			if (dai->driver->ops->remove_order != order)
+				continue;
 
+			if (dai->driver->ops->remove) {
+				r = dai->driver->ops->remove(dai);
+				if (r < 0)
+					ret = r; /* use last error */
+			}
+		}
 		dai->probed = 0;
 	}
 
@@ -592,8 +597,9 @@ int snd_soc_pcm_dai_new(struct snd_soc_pcm_runtime *rtd)
 	int i;
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (dai->driver->pcm_new) {
-			int ret = dai->driver->pcm_new(rtd, dai);
+		if (dai->driver->ops &&
+		    dai->driver->ops->pcm_new) {
+			int ret = dai->driver->ops->pcm_new(rtd, dai);
 			if (ret < 0)
 				return soc_dai_ret(dai, ret);
 		}
-- 
2.50.1




