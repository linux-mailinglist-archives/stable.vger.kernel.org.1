Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDC6FAC05
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjEHLUA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjEHLTt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF037C73
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC2A062C64
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDA7C433EF;
        Mon,  8 May 2023 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544785;
        bh=tjLUeJE1CJIYDg4itPBro/bY2qaiygOfo1H3q0rTcYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkEFKwZ1DUB3RlVKqLhPZ6+j2mqdyAmAC2AslXFHOmj3s2d3nZw/gcUrgDoasm7oy
         tBfUZq/N4JMbUGlxsIf+BgCjACvIJSGLqzznt2VyaJ7MO+beXPesExSrGsS/ShtL/L
         MMmyyrfTHsZhBbYhVQAyuJZ/1nu+pl9b2Jj2NmB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Aashish Sharma <shraash@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 523/694] ASoC: mediatek: common: Fix refcount leak in parse_dai_link_info
Date:   Mon,  8 May 2023 11:45:58 +0200
Message-Id: <20230508094451.256161045@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Aashish Sharma <shraash@google.com>

[ Upstream commit beed115c2ce78f990222a29abed042582df4e87c ]

Add missing of_node_put()s before the returns to balance
of_node_get()s and of_node_put()s, which may get unbalanced
in case the for loop 'for_each_available_child_of_node' returns
early.

Fixes: 4302187d955f ("ASoC: mediatek: common: add soundcard driver common code")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Link: https://lore.kernel.org/r/202304090504.2K8L6soj-lkp@intel.com/
Signed-off-by: Aashish Sharma <shraash@google.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Trevor Wu <trevor.wu@mediatek.com>
Link: https://lore.kernel.org/r/20230411003431.4048700-1-shraash@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/common/mtk-soundcard-driver.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 7c55c2cb1f214..738093451ccbf 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -47,20 +47,26 @@ int parse_dai_link_info(struct snd_soc_card *card)
 	/* Loop over all the dai link sub nodes */
 	for_each_available_child_of_node(dev->of_node, sub_node) {
 		if (of_property_read_string(sub_node, "link-name",
-					    &dai_link_name))
+					    &dai_link_name)) {
+			of_node_put(sub_node);
 			return -EINVAL;
+		}
 
 		for_each_card_prelinks(card, i, dai_link) {
 			if (!strcmp(dai_link_name, dai_link->name))
 				break;
 		}
 
-		if (i >= card->num_links)
+		if (i >= card->num_links) {
+			of_node_put(sub_node);
 			return -EINVAL;
+		}
 
 		ret = set_card_codec_info(card, sub_node, dai_link);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(sub_node);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.39.2



