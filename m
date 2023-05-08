Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC996FA55F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjEHKIr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjEHKIq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A332935
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB1162383
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EDBC433D2;
        Mon,  8 May 2023 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540524;
        bh=loH+/AUtxY79C8dF7YK+lZcECoMA7wcYEEBP69cCZCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aj8Eun1GlLBdT6uNqkgWMz4BN2+h5PWpz6XAj6a884kSWHormMKm4Oc/r55gli68
         x26FVWTOiSuSanQZgTpbrdXOW1jige/wGr8HdZGmEUlMNdpZXJjT6Db5oWLQuKOXG1
         gPE7W7M6tE2GWBOj9rPj7SuV20+vOy70XH9PTCP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lucas Tanure <lucas.tanure@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 398/611] ASoC: cs35l41: Only disable internal boost
Date:   Mon,  8 May 2023 11:44:00 +0200
Message-Id: <20230508094435.215432126@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Lucas Tanure <lucas.tanure@collabora.com>

[ Upstream commit 4658de99d43cd740e019e7fd124b4128f8f4027f ]

In error situations, only the internal boost case should be disabled and
re-enabled.
Also, for other boost cases re-enabling the boost to the default internal
boost config is incorrect.

Fixes: 6450ef559056 ("ASoC: cs35l41: CS35L41 Boosted Smart Amplifier")
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: David Rhodes <david.rhodes@cirrus.com>
Link: https://lore.kernel.org/r/20230223084324.9076-2-lucas.tanure@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c223d83e02cfb..f2b5032daa6ae 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -356,6 +356,19 @@ static const struct snd_kcontrol_new cs35l41_aud_controls[] = {
 	WM_ADSP_FW_CONTROL("DSP1", 0),
 };
 
+static void cs35l41_boost_enable(struct cs35l41_private *cs35l41, unsigned int enable)
+{
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_INT_BOOST:
+		enable = enable ? CS35L41_BST_EN_DEFAULT : CS35L41_BST_DIS_FET_OFF;
+		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
+				enable << CS35L41_BST_EN_SHIFT);
+		break;
+	default:
+		break;
+	}
+}
+
 static irqreturn_t cs35l41_irq(int irq, void *data)
 {
 	struct cs35l41_private *cs35l41 = data;
@@ -431,8 +444,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 
 	if (status[0] & CS35L41_BST_OVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "VBST Over Voltage error\n");
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK, 0);
+		cs35l41_boost_enable(cs35l41, 0);
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 			     CS35L41_BST_OVP_ERR);
 		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
@@ -441,16 +453,13 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 				   CS35L41_BST_OVP_ERR_RLS);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
 				   CS35L41_BST_OVP_ERR_RLS, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK,
-				   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_BST_DCM_UVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "DCM VBST Under Voltage Error\n");
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK, 0);
+		cs35l41_boost_enable(cs35l41, 0);
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 			     CS35L41_BST_DCM_UVP_ERR);
 		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
@@ -459,16 +468,13 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 				   CS35L41_BST_UVP_ERR_RLS);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
 				   CS35L41_BST_UVP_ERR_RLS, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK,
-				   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_BST_SHORT_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "LBST error: powering off!\n");
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK, 0);
+		cs35l41_boost_enable(cs35l41, 0);
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 			     CS35L41_BST_SHORT_ERR);
 		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
@@ -477,9 +483,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 				   CS35L41_BST_SHORT_ERR_RLS);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
 				   CS35L41_BST_SHORT_ERR_RLS, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK,
-				   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.39.2



