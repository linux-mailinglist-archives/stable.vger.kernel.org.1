Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6276ADFA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjHAJfN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjHAJec (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F4EE5F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232D6614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E97FC433C8;
        Tue,  1 Aug 2023 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882352;
        bh=BlpZ905ny4sc/XE8c3TZg17Kqlv6zWBEltEw5Pve6yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RS3ViRZ3wtHtLvLOZwaGlY9CHsExwiI8pfvPAaISI0kdZ0ZrOlOMfSxMuDdZjOj6
         35K51bxPDeEbyThhGe9svny7gDk4Wyr+14LY0+BQuLERV914EdpowDqdaH5H6s4jyr
         5et+MQKh54MY22+97oX4takiYEfX/WDC2nfc2pkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/228] phy: phy-mtk-dp: Fix an error code in probe()
Date:   Tue,  1 Aug 2023 11:18:52 +0200
Message-ID: <20230801091925.505084272@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 5782017cc4d0c8f3425d55b893675bb8a20c33e9 ]

Negative -EINVAL was intended instead of positive EINVAL.

Fixes: 6a23afad443a ("phy: phy-mtk-dp: Add driver for DP phy")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/3c699e00-2883-40d9-92c3-0da1dc38fdd4@moroto.mountain
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 232fd3f1ff1b1..d7024a1443358 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -169,7 +169,7 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 
 	regs = *(struct regmap **)dev->platform_data;
 	if (!regs)
-		return dev_err_probe(dev, EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "No data passed, requires struct regmap**\n");
 
 	dp_phy = devm_kzalloc(dev, sizeof(*dp_phy), GFP_KERNEL);
-- 
2.39.2



