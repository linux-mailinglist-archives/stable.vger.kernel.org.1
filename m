Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1B755686
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjGPUv0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjGPUvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A030D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B4660E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE2CC433C8;
        Sun, 16 Jul 2023 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540683;
        bh=t5dc8HQpTwI7tli9JanaKj+q2mIcDbz75/FufcyVGEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOLXc1+4TrOPNk8Nk70KdmKDCMW+2ojstEa1Yk/8R1BILrRMBV8XMvKbttrpDCPd+
         e8A5q4bzpQDwU+Qc/YZO2MzF7h0JE48BvcdZm1HUuQcH3tnNgIAIdV1EzPKApOhs+h
         5FU1vX1OuZ8bSJ3ci00W7E8UD32UOrfE4WZy0Adg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jia-wei Chang <Jia-wei.Chang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 450/591] cpufreq: mediatek: correct voltages for MT7622 and MT7623
Date:   Sun, 16 Jul 2023 21:49:49 +0200
Message-ID: <20230716194935.551903619@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit f85534113f5ae90a52521cdb9e9977a43ee42626 ]

The MT6380 regulator typically used together with MT7622 does not
support the current maximum processor and SRAM voltage in the cpufreq
driver (1360000uV).
For MT7622 limit processor and SRAM supply voltages to 1350000uV to
avoid having the tracking algorithm request unsupported voltages from
the regulator.

On MT7623 there is no separate SRAM supply and the maximum voltage used
is 1300000uV. Create dedicated platform data for MT7623 to cover that
case as well.

Fixes: 0883426fd07e3 ("cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623")
Suggested-by: Jia-wei Chang <Jia-wei.Chang@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 9a39a7ccfae96..fef68cb2b38f7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -696,9 +696,16 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
 static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
 	.min_volt_shift = 100000,
 	.max_volt_shift = 200000,
-	.proc_max_volt = 1360000,
+	.proc_max_volt = 1350000,
 	.sram_min_volt = 0,
-	.sram_max_volt = 1360000,
+	.sram_max_volt = 1350000,
+	.ccifreq_supported = false,
+};
+
+static const struct mtk_cpufreq_platform_data mt7623_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 1300000,
 	.ccifreq_supported = false,
 };
 
@@ -734,7 +741,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
-	{ .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
+	{ .compatible = "mediatek,mt7623", .data = &mt7623_platform_data },
 	{ .compatible = "mediatek,mt8167", .data = &mt8516_platform_data },
 	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
-- 
2.39.2



