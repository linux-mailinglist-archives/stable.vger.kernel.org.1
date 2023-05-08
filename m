Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C006FAABF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEHLGS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjEHLGC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8BB33FEA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7434B62A74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89789C4339B;
        Mon,  8 May 2023 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543893;
        bh=7yAbatqgq7LIvEWfrKnftoaGmhpPFDRJmzZFO4NpaqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr/7Bp3ZZg05F88UjFoR7nzcRyql2G2A9/DTyQ5t/J6WuKQI/Ws5383iAp3AZ+0Bj
         kKO1GwfwiDIAoCFTwKp39dux6c+ShgXyHaghDn/c0XKr1CuF2AOR4gUHKolD0Ehewc
         Ge5hQHi7u0fFaHvsHcuXU0FFE5ROMvQy5gMhZ0Wg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Nick Hainke <vincent@systemli.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 235/694] cpufreq: mediatek: raise proc/sram max voltage for MT8516
Date:   Mon,  8 May 2023 11:41:10 +0200
Message-Id: <20230508094439.977708850@linuxfoundation.org>
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

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

[ Upstream commit d3296bb4cafd4bad4a5cf2eeab9d19cc94f9e30e ]

Since the upper boundary of proc/sram voltage of MT8516 is 1300 mV,
which is greater than the value of MT2701 1150 mV, we fix it by adding
the corresponding platform data and specify proc/sram_max_volt to
support MT8516.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
Reported-by: Nick Hainke <vincent@systemli.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 6dc225546a8d6..764e4fbdd536c 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -711,20 +711,29 @@ static const struct mtk_cpufreq_platform_data mt8186_platform_data = {
 	.ccifreq_supported = true,
 };
 
+static const struct mtk_cpufreq_platform_data mt8516_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 1310000,
+	.sram_min_volt = 0,
+	.sram_max_volt = 1310000,
+	.ccifreq_supported = false,
+};
+
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
-	{ .compatible = "mediatek,mt8167", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8167", .data = &mt8516_platform_data },
 	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8176", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8183", .data = &mt8183_platform_data },
 	{ .compatible = "mediatek,mt8186", .data = &mt8186_platform_data },
 	{ .compatible = "mediatek,mt8365", .data = &mt2701_platform_data },
-	{ .compatible = "mediatek,mt8516", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8516", .data = &mt8516_platform_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_machines);
-- 
2.39.2



