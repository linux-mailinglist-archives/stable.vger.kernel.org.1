Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBBD7ECB9F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjKOTX1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjKOTX0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DE1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05ABC433C8;
        Wed, 15 Nov 2023 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076203;
        bh=kJ+6qNT0jO1qXc9kqWug+yt55wNHOH2YOvbMt7C6Iro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdNmuOmpMd/DXTUp/9RHikafLAZddzgsNYpJwhJ0ANtHvDU9ma19GCapB9nk21bSA
         7Uwc8RxlskTykWjDWWql0yLuvZhMVSx/YxcdJXIkAvVx5umGLTL1m5ULxaAcrTaAxc
         YS9WzUukV00+xmEEsm+Ec1BkE3d8JdJtNmik1Lis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Frank Wunderlich <frank-w@public-files.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 116/550] thermal/drivers/mediatek: Fix probe for THERMAL_V2
Date:   Wed, 15 Nov 2023 14:11:40 -0500
Message-ID: <20231115191608.731494420@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Schneider-Pargmann <msp@baylibre.com>

[ Upstream commit 5055fadfa7e16f2427d5b3c40b2bf563ddfdab22 ]

Fix the probe function to call mtk_thermal_release_periodic_ts for
everything != MTK_THERMAL_V1. This was accidentally changed from V1
to V2 in the original patch.

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Closes: https://lore.kernel.org/lkml/B0B3775B-B8D1-4284-814F-4F41EC22F532@public-files.de/
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Closes: https://lore.kernel.org/lkml/07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org/
Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230918100706.1229239-1-msp@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index f59d36de20a09..677ff04d91ea0 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1268,7 +1268,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
 
-	if (mt->conf->version != MTK_THERMAL_V2)
+	if (mt->conf->version != MTK_THERMAL_V1)
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 
 	if (mt->conf->version == MTK_THERMAL_V1)
-- 
2.42.0



