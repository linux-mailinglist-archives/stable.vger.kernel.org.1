Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECC79B8D8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358324AbjIKWIf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbjIKOI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:08:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF08CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3667C433C7;
        Mon, 11 Sep 2023 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441300;
        bh=a0JfiRY1UbSeK94eFDboJeLh8pwtnjJEPtayLoQ8qNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiS6wcdrFKhmbFblreGr67bps7xzKWxdCaA7v8UrgHbXOaYEsXYPoXB9GXMrDbhau
         QMY1MePffcmOJN8HdkpEhuhuBBz2WSnWzhPYFNhU8Vuxa+1dwCOIWvrKzZVleo3af2
         cX5143cE8nQTTU/s+IduJGXhDeX1lQkPdA+1iqEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 364/739] ASoC: soc-dai.h: merge DAI call back functions into ops
Date:   Mon, 11 Sep 2023 15:42:43 +0200
Message-ID: <20230911134701.316565214@linuxfoundation.org>
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
Stable-dep-of: 5e5f68ca836e ("ASoC: fsl: merge DAI call back functions into ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-dai.h              | 13 ++++++++
 sound/soc/generic/audio-graph-card.c |  2 +-
 sound/soc/soc-core.c                 | 25 ++++++++++++++++
 sound/soc/soc-dai.c                  | 44 ++++++++++++++++------------
 4 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e3906ecda740a..502e057268691 100644
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
index c6e0f91321930..74705780a48bc 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -60,7 +60,7 @@ static bool soc_component_is_pcm(struct snd_soc_dai_link_component *dlc)
 	struct snd_soc_dai *dai = snd_soc_find_dai_with_mutex(dlc);
 
 	if (dai && (dai->component->driver->pcm_construct ||
-		    dai->driver->pcm_new))
+		    (dai->driver->ops && dai->driver->ops->pcm_new)))
 		return true;
 
 	return false;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a0bde23f5e6f..4167010ece193 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2422,6 +2422,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
+	struct snd_soc_dai_ops *ops; /* REMOVE ME */
 
 	lockdep_assert_held(&client_mutex);
 
@@ -2450,6 +2451,30 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
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
index 02dd64dea1792..c0b5faafa3fca 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -454,8 +454,9 @@ int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
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
 
@@ -539,19 +540,20 @@ int snd_soc_pcm_dai_probe(struct snd_soc_pcm_runtime *rtd, int order)
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
 
@@ -564,16 +566,19 @@ int snd_soc_pcm_dai_remove(struct snd_soc_pcm_runtime *rtd, int order)
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
 
@@ -586,8 +591,9 @@ int snd_soc_pcm_dai_new(struct snd_soc_pcm_runtime *rtd)
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
2.40.1



