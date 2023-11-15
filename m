Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6207ECE64
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjKOTmu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjKOTms (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EB9B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63940C433C7;
        Wed, 15 Nov 2023 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077364;
        bh=bSNT/uEZbOU4/df6QoNE/pf8NCheDYRgFDNOnjn7lmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyQFnMpuAIxKKVwQreifQBqPfog4T6fAzEjP5YgrGGMjaZ7qmgQ83O2/NWJGFRUCM
         BUTAEIqMS6EDfQ68kfhiH1ykFZ6Tz7A08xo6vbGSTb27Cjq8FzNXJgaGEAWbc5Ek2B
         LsFQ4bYp7XYplVZyQxcnkeDLD3pMn/HViGHOmz1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 256/603] drm/msm/a6xx: Fix unknown speedbin case
Date:   Wed, 15 Nov 2023 14:13:21 -0500
Message-ID: <20231115191630.998320599@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 75cb60d4f5f762b12643b67cbefefcf05ecfd7eb ]

When opp-supported-hw is present under an OPP node, but no form of
opp_set_supported_hw() has been called, that OPP is ignored by the API
and marked as unsupported.

Before Commit c928a05e4415 ("drm/msm/adreno: Move speedbin mapping to
device table"), an unknown speedbin would result in marking all OPPs
as available, but it's better to avoid potentially overclocking the
silicon - the GMU will simply refuse to power up the chip.

Currently, the Adreno speedbin code does just that (AND returns an
invalid error, (int)UINT_MAX). Fix that by defaulting to speedbin 0
(which is conveniently always bound to fuseval == 0).

Fixes: c928a05e4415 ("drm/msm/adreno: Move speedbin mapping to device table")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/559604/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d4e85e24002fb..522ca7fe67625 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2237,7 +2237,7 @@ static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *i
 		DRM_DEV_ERROR(dev,
 			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
 			speedbin);
-		return UINT_MAX;
+		supp_hw = BIT(0); /* Default */
 	}
 
 	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
-- 
2.42.0



