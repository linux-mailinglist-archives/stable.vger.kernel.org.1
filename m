Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312F7ECFEA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjKOTvj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjKOTvi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098519F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A87C433C7;
        Wed, 15 Nov 2023 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077894;
        bh=c0UzMj+zSHxgiyxhgc16PX2qwyRlPKKbGwW+AhFAfUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSxEn5te6GNIEwR0IYx17YVFieZfRCpmOP3uk0Rt8GjUMek7IXxfUgDnbu6/7wCu6
         49UdVvlh8PdxJxk+X0RfhFirWqaPj23krhP25HVSNWs59YyxPEof62YNEJRSNqEeit
         wfBshMHgWkJg3nwYEa/hmU8Bu1nV2nXdFqYAwOW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Eugen Hristev <eugen.hristev@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 585/603] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial: fix error messages
Date:   Wed, 15 Nov 2023 14:18:50 -0500
Message-ID: <20231115191651.804295225@linuxfoundation.org>
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

From: Eugen Hristev <eugen.hristev@collabora.com>

[ Upstream commit 004fc58edea6f00db9ad07b40b882e8d976f7a54 ]

Property 'playback-codecs' is referenced as 'speaker-codec' in the error
message, and this can lead to confusion.
Correct the error message such that the correct property name is
referenced.

Fixes: 0da16e370dd7 ("ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and rt5682s")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231031103139.77395-1-eugen.hristev@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 9c11016f032c2..9777ba89e956c 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -1179,7 +1179,7 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 	playback_codec = of_get_child_by_name(pdev->dev.of_node, "playback-codecs");
 	if (!playback_codec) {
 		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'speaker-codecs' missing or invalid\n");
+		dev_err_probe(&pdev->dev, ret, "Property 'playback-codecs' missing or invalid\n");
 		goto err_playback_codec;
 	}
 
@@ -1193,7 +1193,7 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = mt8186_mt6366_card_set_be_link(card, dai_link, playback_codec, "I2S3");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",
+			dev_err_probe(&pdev->dev, ret, "%s set playback_codec fail\n",
 				      dai_link->name);
 			goto err_probe;
 		}
-- 
2.42.0



