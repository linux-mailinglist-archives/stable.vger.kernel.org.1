Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B270C98A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjEVTtN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjEVTtM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109295
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD3A62AB8
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA76C433D2;
        Mon, 22 May 2023 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784950;
        bh=sN+ljAG2CWIjdk/sq0aOHVfWXZYjrll48ueT5LQil+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/zUhyBpIwLbQqFG5IkVKiynvcMGzLL1OlMI2HiWZmhAyXdO5fw8Ub1Djam2WGhJZ
         o4yB5jPFUusIdFNl0mTSNci87R6+2tcuUNIiCM0hoknWUvPRTk/S1pYUi6LxzllJif
         8zTUZhlDrFAkmbbM3sCdJhwPOet56qdbfaS+HYLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 250/364] ASoC: mediatek: mt8186: Fix use-after-free in driver remove path
Date:   Mon, 22 May 2023 20:09:15 +0100
Message-Id: <20230522190418.947897881@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit a93d2afd3f77a7331271a0f25c6a11003db69b3c ]

When devm runs function in the "remove" path for a device it runs them
in the reverse order. That means that if you have parts of your driver
that aren't using devm or are using "roll your own" devm w/
devm_add_action_or_reset() you need to keep that in mind.

The mt8186 audio driver didn't quite get this right. Specifically, in
mt8186_init_clock() it called mt8186_audsys_clk_register() and then
went on to call a bunch of other devm function. The caller of
mt8186_init_clock() used devm_add_action_or_reset() to call
mt8186_deinit_clock() but, because of the intervening devm functions,
the order was wrong.

Specifically at probe time, the order was:
1. mt8186_audsys_clk_register()
2. afe_priv->clk = devm_kcalloc(...)
3. afe_priv->clk[i] = devm_clk_get(...)

At remove time, the order (which should have been 3, 2, 1) was:
1. mt8186_audsys_clk_unregister()
3. Free all of afe_priv->clk[i]
2. Free afe_priv->clk

The above seemed to be causing a use-after-free. Luckily, it's easy to
fix this by simply using devm more correctly. Let's move the
devm_add_action_or_reset() to the right place. In addition to fixing
the use-after-free, code inspection shows that this fixes a leak
(missing call to mt8186_audsys_clk_unregister()) that would have
happened if any of the syscon_regmap_lookup_by_phandle() calls in
mt8186_init_clock() had failed.

Fixes: 55b423d5623c ("ASoC: mediatek: mt8186: support audio clock control in platform driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org
Link: https://lore.kernel.org/r/20230511092437.1.I31cceffc8c45bb1af16eb613e197b3df92cdc19e@changeid
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c    |  6 ---
 sound/soc/mediatek/mt8186/mt8186-afe-clk.h    |  1 -
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |  4 --
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c | 46 ++++++++++---------
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h |  1 -
 5 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
index a6b4f29049bbc..539e3a023bc4e 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
@@ -644,9 +644,3 @@ int mt8186_init_clock(struct mtk_base_afe *afe)
 
 	return 0;
 }
-
-void mt8186_deinit_clock(void *priv)
-{
-	struct mtk_base_afe *afe = priv;
-	mt8186_audsys_clk_unregister(afe);
-}
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.h b/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
index d5988717d8f2d..a9d59e506d9af 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
@@ -81,7 +81,6 @@ enum {
 struct mtk_base_afe;
 int mt8186_set_audio_int_bus_parent(struct mtk_base_afe *afe, int clk_id);
 int mt8186_init_clock(struct mtk_base_afe *afe);
-void mt8186_deinit_clock(void *priv);
 int mt8186_afe_enable_cgs(struct mtk_base_afe *afe);
 void mt8186_afe_disable_cgs(struct mtk_base_afe *afe);
 int mt8186_afe_enable_clock(struct mtk_base_afe *afe);
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index 41172a82103ee..a868a04ed4e7a 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2848,10 +2848,6 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, mt8186_deinit_clock, (void *)afe);
-	if (ret)
-		return ret;
-
 	/* init memif */
 	afe->memif_32bit_supported = 0;
 	afe->memif_size = MT8186_MEMIF_NUM;
diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
index 578969ca91c8e..5666be6b1bd2e 100644
--- a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
@@ -84,6 +84,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD2(CLK_AUD_ETDM_OUT1_BCLK, "aud_etdm_out1_bclk", "top_audio", 24),
 };
 
+static void mt8186_audsys_clk_unregister(void *data)
+{
+	struct mtk_base_afe *afe = data;
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	if (!afe_priv)
+		return;
+
+	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
+		cl = afe_priv->lookup[i];
+		if (!cl)
+			continue;
+
+		clk = cl->clk;
+		clk_unregister_gate(clk);
+
+		clkdev_drop(cl);
+	}
+}
+
 int mt8186_audsys_clk_register(struct mtk_base_afe *afe)
 {
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
@@ -124,27 +147,6 @@ int mt8186_audsys_clk_register(struct mtk_base_afe *afe)
 		afe_priv->lookup[i] = cl;
 	}
 
-	return 0;
+	return devm_add_action_or_reset(afe->dev, mt8186_audsys_clk_unregister, afe);
 }
 
-void mt8186_audsys_clk_unregister(struct mtk_base_afe *afe)
-{
-	struct mt8186_afe_private *afe_priv = afe->platform_priv;
-	struct clk *clk;
-	struct clk_lookup *cl;
-	int i;
-
-	if (!afe_priv)
-		return;
-
-	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
-		cl = afe_priv->lookup[i];
-		if (!cl)
-			continue;
-
-		clk = cl->clk;
-		clk_unregister_gate(clk);
-
-		clkdev_drop(cl);
-	}
-}
diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
index b8d6a06e11e8d..897a2914dc191 100644
--- a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
@@ -10,6 +10,5 @@
 #define _MT8186_AUDSYS_CLK_H_
 
 int mt8186_audsys_clk_register(struct mtk_base_afe *afe);
-void mt8186_audsys_clk_unregister(struct mtk_base_afe *afe);
 
 #endif
-- 
2.39.2



