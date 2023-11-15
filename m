Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C87ECFE6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjKOTvf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjKOTvf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE71A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F604C433C7;
        Wed, 15 Nov 2023 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077891;
        bh=hxe2BnyCwPlorQsHX+wHWpx7pYJGctmh4t87CjD+9ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+7edXKHvVb52FJWK2DPx3Q+B/VFJqzxd+UbXyRtHAuIzupjNO+f2HMaSAN+DGHQG
         wO6MUUYo96sJ5n3zsOWxQjIu9HOLbjHbP2gi8mYve0EXAihAz0W5SlpEz8p1cOhvku
         f0ynxTXwvzfU/gTYEoXrce1+PviuYuVkhc2620ZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 584/603] ASoC: rt712-sdca: fix speaker route missing issue
Date:   Wed, 15 Nov 2023 14:18:49 -0500
Message-ID: <20231115191651.755772886@linuxfoundation.org>
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

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 1a3b7eab8500a6b923f7b62cc8aa4d832c7dfb3e ]

Sometimes the codec probe would be called earlier than the hardware initialization.
Therefore, the speaker route should be added before the the first_hw_init check.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Fixes: f3da2ed110e2 ("ASoC: rt1712-sdca: enable pm_runtime in probe,  keep status as 'suspended'")?
Link: https://lore.kernel.org/r/20231030103644.1787948-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt712-sdca.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca.c b/sound/soc/codecs/rt712-sdca.c
index 7077ff6ba1f4b..6954fbe7ec5f3 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -963,13 +963,6 @@ static int rt712_sdca_probe(struct snd_soc_component *component)
 	rt712_sdca_parse_dt(rt712, &rt712->slave->dev);
 	rt712->component = component;
 
-	if (!rt712->first_hw_init)
-		return 0;
-
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
-		return ret;
-
 	/* add SPK route */
 	if (rt712->hw_id != RT712_DEV_ID_713) {
 		snd_soc_add_component_controls(component,
@@ -980,6 +973,13 @@ static int rt712_sdca_probe(struct snd_soc_component *component)
 			rt712_sdca_spk_dapm_routes, ARRAY_SIZE(rt712_sdca_spk_dapm_routes));
 	}
 
+	if (!rt712->first_hw_init)
+		return 0;
+
+	ret = pm_runtime_resume(component->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
 	return 0;
 }
 
-- 
2.42.0



