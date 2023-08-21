Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81E78330A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjHUUB0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHUUBZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62512C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228FA647A9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08960C433C8;
        Mon, 21 Aug 2023 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648077;
        bh=gqyS9+Et9HrnTElIM4gGIzXrxOxAu0t880LTgOoSUSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0pTiJqJ0ZKw/dPiePRN3ve315w9dsYqJuwsDPjLXK4Ii0XRRlvUEs2valE+JC3Wq
         ZR5dNf4vjpAtx9R7MfFfNb53XjxrT7hXt20e+ssGLbabNAfVV42mdhD/9CXPHmZBny
         UTutslgAMcGIKk3KQFIaqgybSx3GpeStAKAzw5no=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Hongfei <luhongfei@vivo.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 047/234] led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops
Date:   Mon, 21 Aug 2023 21:40:10 +0200
Message-ID: <20230821194130.815216471@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit 8f38f8fa7261819eb7d4fb369dc3bfab72259033 ]

Ensure child node references are decremented properly in the error path.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Link: https://lore.kernel.org/r/20230525111705.3055-1-luhongfei@vivo.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 1c849814a4917..212df2e3d3502 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1173,8 +1173,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		i = 0;
 		for_each_available_child_of_node(np, child) {
 			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child);
 				return ret;
+			}
 
 			info[i].color_index = led->channels[i]->color;
 			info[i].intensity = 0;
@@ -1352,8 +1354,10 @@ static int lpg_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		ret = lpg_add_led(lpg, np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	for (i = 0; i < lpg->num_channels; i++)
-- 
2.40.1



