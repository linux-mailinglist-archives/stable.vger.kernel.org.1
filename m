Return-Path: <stable+bounces-175269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF1B366AE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB6B61769
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFB338F36;
	Tue, 26 Aug 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EyGlaoxc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00135083E;
	Tue, 26 Aug 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216590; cv=none; b=Wl5dxA1VE3Bd7qtp0LWDLen50s+ET422i2TIX3Z1ED6A2Jqpv1F1zSvilitrcvS9HtcMh6P+9If160ITKDxyI75GGds5KHVSQ1M0QpMYEOvpZRNFVofzLXbM6LzTf0A3rxZuFuTOVwqdkdXT4CJrf70JjOFJQASPs5pvXa1pxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216590; c=relaxed/simple;
	bh=wXfbHWcvavv/ShXu4Nnphda91ExjsSdLtTlhUoGfAaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLQOsRMSvnvjncWve+WEIRonPBbEoDIZGkAjaw4wwP7WQP8pPXKfmorQHV5qmj3TE4cvgUFY6r8e7pdWragGXFXJZCxAeVuhnsiE7f137JuHy1dR9dHSixIEjMwytOQvkiTbpxaHHU4EtoX85/R0lG7nGpBi1vhWIZKaO+cjovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EyGlaoxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11661C4CEF1;
	Tue, 26 Aug 2025 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216590;
	bh=wXfbHWcvavv/ShXu4Nnphda91ExjsSdLtTlhUoGfAaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyGlaoxcER0rmoLtC8fakorKqneMZBTTr56NnuxLAjFbTTP2fTEW6PDQ04jrHlvNL
	 DIG9Y1yLlRyF7CzUvuZLkQXJwbJcEyFTNKJn5nswh4ILhGDO/GxpZZUusJVJLCpTZ8
	 /0GqQ6sQOwAguBiDiQtU0A0jnkR13heIhbQ+dP0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 437/644] ASoC: soc-dai.h: merge DAI call back functions into ops
Date: Tue, 26 Aug 2025 13:08:48 +0200
Message-ID: <20250826110957.294344202@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index ef3bb1bcea4e..b42dbe2469af 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -266,6 +266,15 @@ int snd_soc_dai_compr_get_metadata(struct snd_soc_dai *dai,
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
@@ -347,6 +356,10 @@ struct snd_soc_dai_ops {
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
index 89814f68ff56..e50527766dcc 100644
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
index d28261ef1d4c..854d8f62008e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2454,6 +2454,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
+	struct snd_soc_dai_ops *ops; /* REMOVE ME */
 
 	dev_dbg(dev, "ASoC: dynamically register DAI %s\n", dev_name(dev));
 
@@ -2484,6 +2485,30 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
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
index 703aa9a76d03..4f7edef1e735 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -473,8 +473,9 @@ int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
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
 
@@ -558,19 +559,20 @@ int snd_soc_pcm_dai_probe(struct snd_soc_pcm_runtime *rtd, int order)
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
 
@@ -583,16 +585,19 @@ int snd_soc_pcm_dai_remove(struct snd_soc_pcm_runtime *rtd, int order)
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
 
@@ -605,8 +610,9 @@ int snd_soc_pcm_dai_new(struct snd_soc_pcm_runtime *rtd)
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




