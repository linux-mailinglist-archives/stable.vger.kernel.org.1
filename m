Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10477ECBB4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjKOTX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjKOTX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1121AC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8056CC433C7;
        Wed, 15 Nov 2023 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076232;
        bh=i3CbYYWU7wZ1jKIMKmTsyp5YrsCUwZvt3yX79hcakh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMJo8G0GujbeII0nR0qwuM1W/Ty3va3rzyFHGjyExV0hRBppvYFwCsXk0sn6EdniI
         JmfRTr8h0nbgAT91K6MFOq1B42P4eORj2+ggrB6iVQyGEjljEwIrTa03UhF6PkZoXx
         0iXGSIRShhGoNRMFGONSNv9BvnU+tWyouHaim8q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 159/550] regulator: mt6358: Fail probe on unknown chip ID
Date:   Wed, 15 Nov 2023 14:12:23 -0500
Message-ID: <20231115191611.723838252@linuxfoundation.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 7442edec72bc657e6ce38ae01de9f10e55decfaa ]

The MT6358 and MT6366 PMICs, and likely many others from MediaTek, have
a chip ID register, making the chip semi-discoverable.

The driver currently supports two PMICs and expects to be probed on one
or the other. It does not account for incorrect mfd driver entries or
device trees. While these should not happen, if they do, it could be
catastrophic for the device. The driver should be sure the hardware is
what it expects.

Make the driver fail to probe if the chip ID presented is not a known
one.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: f0e3c6261af1 ("regulator: mt6366: Add support for MT6366 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230913082919.1631287-2-wenst@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/mt6358-regulator.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 65fbd95f1dbb0..4ca8fbf4b3e2e 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -688,12 +688,18 @@ static int mt6358_regulator_probe(struct platform_device *pdev)
 	const struct mt6358_regulator_info *mt6358_info;
 	int i, max_regulator, ret;
 
-	if (mt6397->chip_id == MT6366_CHIP_ID) {
-		max_regulator = MT6366_MAX_REGULATOR;
-		mt6358_info = mt6366_regulators;
-	} else {
+	switch (mt6397->chip_id) {
+	case MT6358_CHIP_ID:
 		max_regulator = MT6358_MAX_REGULATOR;
 		mt6358_info = mt6358_regulators;
+		break;
+	case MT6366_CHIP_ID:
+		max_regulator = MT6366_MAX_REGULATOR;
+		mt6358_info = mt6366_regulators;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported chip ID: %d\n", mt6397->chip_id);
+		return -EINVAL;
 	}
 
 	ret = mt6358_sync_vcn33_setting(&pdev->dev);
-- 
2.42.0



