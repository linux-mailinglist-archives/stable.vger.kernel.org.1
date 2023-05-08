Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95D6FAAC7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjEHLGi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjEHLGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94933D73
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D1762A82
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A5DC433EF;
        Mon,  8 May 2023 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543897;
        bh=6QHdSxgOiOqKxFvZzYeaWNF3IttFGI+xjhYuVopaj3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pz34KEVF7od6x8u9j6a5dXSNo43I+WWycNEUXXUrKPWFdt24bpL/mr0ihIpgw+neH
         sDQg6MSe74cj5Uf9khMkBCf504ooKQeWmWJQufywMSg342BXXS3c8Ai6hzMaS9WQVm
         SKagOxkeVHDBQchNTiljibPIVHybXLD7Istlj5Ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 236/694] cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623
Date:   Mon,  8 May 2023 11:41:11 +0200
Message-Id: <20230508094440.006638048@linuxfoundation.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 0883426fd07e39355362e3f2eb9aee1a154dcaf6 ]

During the addition of SRAM voltage tracking for CCI scaling, this
driver got some voltage limits set for the vtrack algorithm: these
were moved to platform data first, then enforced in a later commit
6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
using these as max values for the regulator_set_voltage() calls.

In this case, the vsram/vproc constraints for MT7622 and MT7623
were supposed to be the same as MT2701 (and a number of other SoCs),
but that turned out to be a mistake because the aforementioned two
SoCs' maximum voltage for both VPROC and VPROC_SRAM is 1.36V.

Fix that by adding new platform data for MT7622/7623 declaring the
right {proc,sram}_max_volt parameter.

Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 764e4fbdd536c..9a39a7ccfae96 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -693,6 +693,15 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
 	.ccifreq_supported = false,
 };
 
+static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 1360000,
+	.sram_min_volt = 0,
+	.sram_max_volt = 1360000,
+	.ccifreq_supported = false,
+};
+
 static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
 	.min_volt_shift = 100000,
 	.max_volt_shift = 200000,
@@ -724,8 +733,8 @@ static const struct mtk_cpufreq_platform_data mt8516_platform_data = {
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
-	{ .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
-	{ .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
+	{ .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
 	{ .compatible = "mediatek,mt8167", .data = &mt8516_platform_data },
 	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
-- 
2.39.2



