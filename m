Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E157ECFEB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjKOTvl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjKOTvk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75015B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC854C433C8;
        Wed, 15 Nov 2023 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077896;
        bh=HTh6NiZ8+lp3HgyDDkgxevS9wEafWZO9huGWoqmKTzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHpswcxMEpwi0kP/HB6Z+5G1TzJV56VdfcSCkrr5R3/j3ShnZQQPskKL7Ls8mZTWN
         Cz4pZFUwf/GvidR+gIiFZexJ87eP6/j6yXpoVI3lnk6PGYPw5NOM3c4Hdt/nXDCwm2
         Sbs8qUG3HnNWBlgyC+I4LdFBxMZ7gZ4GBXlJWBPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 586/603] ASoC: hdmi-codec: register hpd callback on component probe
Date:   Wed, 15 Nov 2023 14:18:51 -0500
Message-ID: <20231115191651.854461283@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 15be353d55f9e12e34f9a819f51eb41fdef5eda8 ]

The HDMI hotplug callback to the hdmi-codec is currently registered when
jack is set.

The hotplug not only serves to report the ASoC jack state but also to get
the ELD. It should be registered when the component probes instead, so it
does not depend on the card driver registering a jack for the HDMI to
properly report the ELD.

Fixes: 25ce4f2b3593 ("ASoC: hdmi-codec: Get ELD in before reporting plugged event")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20231106104013.704356-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 09eef6042aad6..20da1eaa4f1c7 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -877,18 +877,13 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 			       void *data)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
-	int ret = -ENOTSUPP;
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
-		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
-						    hcp->hcd.data,
-						    plugged_cb,
-						    component->dev);
-		if (ret)
-			hcp->jack = NULL;
+		return 0;
 	}
-	return ret;
+
+	return -ENOTSUPP;
 }
 
 static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
@@ -982,6 +977,21 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	return ret;
 }
 
+static int hdmi_probe(struct snd_soc_component *component)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	if (hcp->hcd.ops->hook_plugged_cb) {
+		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
+						    hcp->hcd.data,
+						    plugged_cb,
+						    component->dev);
+	}
+
+	return ret;
+}
+
 static void hdmi_remove(struct snd_soc_component *component)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
@@ -992,6 +1002,7 @@ static void hdmi_remove(struct snd_soc_component *component)
 }
 
 static const struct snd_soc_component_driver hdmi_driver = {
+	.probe			= hdmi_probe,
 	.remove			= hdmi_remove,
 	.dapm_widgets		= hdmi_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
-- 
2.42.0



