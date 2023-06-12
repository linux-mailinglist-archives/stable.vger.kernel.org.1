Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA26572C0BE
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjFLKyV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjFLKyH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192126591
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F07614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425AC433D2;
        Mon, 12 Jun 2023 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566367;
        bh=+ZBCRj1kzTGu0fnO1M4sdXQuZUwwO+tV/jPDhQ/rbrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAIdovt8nIjyy/LDQS6YxesqzZpPyb5gFHU9pVA4kF3sdSxQjjS8robafCikwsn9F
         IYts/k7ym1C0/L1DpjBd6YIiS1Xs4gAT5QxFZ2d/bpNZukTOi/l+QiKdXTwAe22sh3
         pD/WKva5ox2ttYKpGaak07FkBXuqF/Qjw3aQqLyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Trevor Wu <trevor.wu@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 77/91] ASoC: mediatek: mt8195: fix use-after-free in driver remove path
Date:   Mon, 12 Jun 2023 12:27:06 +0200
Message-ID: <20230612101705.294907156@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Trevor Wu <trevor.wu@mediatek.com>

[ Upstream commit dc93f0dcb436dfd24a06c5b3c0f4c5cd9296e8e5 ]

During mt8195_afe_init_clock(), mt8195_audsys_clk_register() was called
followed by several other devm functions. At mt8195_afe_deinit_clock()
located at mt8195_afe_pcm_dev_remove(), mt8195_audsys_clk_unregister()
was called.

However, there was an issue with the order in which these functions were
called. Specifically, the remove callback of platform_driver was called
before devres released the resource, resulting in a use-after-free issue
during remove time.

At probe time, the order of calls was:
1. mt8195_audsys_clk_register
2. afe_priv->clk = devm_kcalloc
3. afe_priv->clk[i] = devm_clk_get

At remove time, the order of calls was:
1. mt8195_audsys_clk_unregister
3. free afe_priv->clk[i]
2. free afe_priv->clk

To resolve the problem, we can utilize devm_add_action_or_reset() in
mt8195_audsys_clk_register() so that the remove order can be changed to
3->2->1.

Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230601033318.10408-3-trevor.wu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c    |  5 --
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h    |  1 -
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |  4 --
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c | 47 ++++++++++---------
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h |  1 -
 5 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
index 8420b2c71332a..d1939e08d333c 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
@@ -136,11 +136,6 @@ int mt8195_afe_init_clock(struct mtk_base_afe *afe)
 	return 0;
 }
 
-void mt8195_afe_deinit_clock(struct mtk_base_afe *afe)
-{
-	mt8195_audsys_clk_unregister(afe);
-}
-
 int mt8195_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk)
 {
 	int ret;
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.h b/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
index f8e6eeb29a895..24eb2f06682f2 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
@@ -90,7 +90,6 @@ int mt8195_afe_get_mclk_source_clk_id(int sel);
 int mt8195_afe_get_mclk_source_rate(struct mtk_base_afe *afe, int apll);
 int mt8195_afe_get_default_mclk_source_by_rate(int rate);
 int mt8195_afe_init_clock(struct mtk_base_afe *afe);
-void mt8195_afe_deinit_clock(struct mtk_base_afe *afe);
 int mt8195_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk);
 void mt8195_afe_disable_clk(struct mtk_base_afe *afe, struct clk *clk);
 int mt8195_afe_prepare_clk(struct mtk_base_afe *afe, struct clk *clk);
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 6c15d45f4a006..4e817542dd745 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3239,15 +3239,11 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 static void mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
-
 	snd_soc_unregister_component(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8195_afe_runtime_suspend(&pdev->dev);
-
-	mt8195_afe_deinit_clock(afe);
 }
 
 static const struct of_device_id mt8195_afe_pcm_dt_match[] = {
diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
index 740aa6ddda0ec..353aa17323648 100644
--- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
@@ -148,6 +148,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD6(CLK_AUD_GASRC19, "aud_gasrc19", "asm_h_sel", 19),
 };
 
+static void mt8195_audsys_clk_unregister(void *data)
+{
+	struct mtk_base_afe *afe = data;
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
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
 int mt8195_audsys_clk_register(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
@@ -188,27 +211,5 @@ int mt8195_audsys_clk_register(struct mtk_base_afe *afe)
 		afe_priv->lookup[i] = cl;
 	}
 
-	return 0;
-}
-
-void mt8195_audsys_clk_unregister(struct mtk_base_afe *afe)
-{
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
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
+	return devm_add_action_or_reset(afe->dev, mt8195_audsys_clk_unregister, afe);
 }
diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
index 239d31016ba76..69db2dd1c9e02 100644
--- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
+++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
@@ -10,6 +10,5 @@
 #define _MT8195_AUDSYS_CLK_H_
 
 int mt8195_audsys_clk_register(struct mtk_base_afe *afe);
-void mt8195_audsys_clk_unregister(struct mtk_base_afe *afe);
 
 #endif
-- 
2.39.2



