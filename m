Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E97ECF27
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjKOTqk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjKOTqj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE13F19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E60C433C7;
        Wed, 15 Nov 2023 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077596;
        bh=Z0Chi7nD35BL5iY0so+ti1InsW0lPXmFvBPvC4+fR+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkGALs2uLeJZjmMuWtnngTG6b7Hj+ZKrsV8KYeySnBMKrs4V7aUmQx2rR+TRlWB9p
         3L9jDl5Bc7yaQrc2zF5AFRKUAS9DA5jZQ76uukahvrjhb3vtP8amsP2Tq9sXiriwkA
         FPTjsCAaUIj0a0+pNTjzTOhPCmwXxQV6oI5PnW48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 369/603] ASoC: Intel: sof_sdw_rt_sdca_jack_common: add rt713 support
Date:   Wed, 15 Nov 2023 14:15:14 -0500
Message-ID: <20231115191639.050087259@linuxfoundation.org>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit b6d6e5abf64562985fdbbdbdfe8088cde634d834 ]

Adding rt713 support to sof_sdw_rt_sdca_jack_common.c.

Fixes: fbaaf80d8cf6 ("ASoC: Intel: sof_sdw: add rt713 support")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20231012190826.142619-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw_rt_sdca_jack_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw_rt_sdca_jack_common.c b/sound/soc/intel/boards/sof_sdw_rt_sdca_jack_common.c
index 623e3bebb8884..4360b9f5ff2c7 100644
--- a/sound/soc/intel/boards/sof_sdw_rt_sdca_jack_common.c
+++ b/sound/soc/intel/boards/sof_sdw_rt_sdca_jack_common.c
@@ -58,6 +58,11 @@ static const struct snd_soc_dapm_route rt712_sdca_map[] = {
 	{ "rt712 MIC2", NULL, "Headset Mic" },
 };
 
+static const struct snd_soc_dapm_route rt713_sdca_map[] = {
+	{ "Headphone", NULL, "rt713 HP" },
+	{ "rt713 MIC2", NULL, "Headset Mic" },
+};
+
 static const struct snd_kcontrol_new rt_sdca_jack_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -109,6 +114,9 @@ static int rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd)
 	} else if (strstr(component->name_prefix, "rt712")) {
 		ret = snd_soc_dapm_add_routes(&card->dapm, rt712_sdca_map,
 					      ARRAY_SIZE(rt712_sdca_map));
+	} else if (strstr(component->name_prefix, "rt713")) {
+		ret = snd_soc_dapm_add_routes(&card->dapm, rt713_sdca_map,
+					      ARRAY_SIZE(rt713_sdca_map));
 	} else {
 		dev_err(card->dev, "%s is not supported\n", component->name_prefix);
 		return -EINVAL;
-- 
2.42.0



