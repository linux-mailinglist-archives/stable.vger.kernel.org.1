Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB4E7ECDE1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjKOTiz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjKOTix (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A371AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E60FC433C9;
        Wed, 15 Nov 2023 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077127;
        bh=Abe+wYXbQDMKoTFuVKYR38yilc3Hxix5pMp13dGYEGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlcJivy4YnVJzW8XgQx+ZvJK2LMxOwv7t4N2r/GaUXQCnvE1prXAcweg5Eg6ys0Fa
         AigBK7LEl7Fdr5n3z5Q1DJhwmChQ/uJoQSKcmvj1tKGkyHACQkjSuFQXW1TfA2QTIx
         ROI+0U/u2zxIwGPb81vxix85w9PaKA4kJfLGJZ+Y=
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
Subject: [PATCH 6.6 124/603] thermal/drivers/mediatek: Fix probe for THERMAL_V2
Date:   Wed, 15 Nov 2023 14:11:09 -0500
Message-ID: <20231115191621.820669288@linuxfoundation.org>
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
index 843214d30bd8b..8b0edb2048443 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1267,7 +1267,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
 
-	if (mt->conf->version != MTK_THERMAL_V2)
+	if (mt->conf->version != MTK_THERMAL_V1)
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 
 	if (mt->conf->version == MTK_THERMAL_V1)
-- 
2.42.0



