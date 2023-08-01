Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82376AF14
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHAJo7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjHAJoo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044544A5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64DC861514
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E57C433C7;
        Tue,  1 Aug 2023 09:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882927;
        bh=BlpZ905ny4sc/XE8c3TZg17Kqlv6zWBEltEw5Pve6yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fW3BJc3FCeOqlUMiKcbpFg/K9PZlMLQBxylN2X9V8CYB560yowpeIe2sIA7pp+DXE
         loM230CvgA/ZrYNQuyuwgmTrqarA0z8LuYhga3LZJH55UJ6hPFxjEiFaBiaYeJm4/H
         xa1B8ORM76Kln7QF1eEy7dh4RHWFORz5NyOlRTJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 052/239] phy: phy-mtk-dp: Fix an error code in probe()
Date:   Tue,  1 Aug 2023 11:18:36 +0200
Message-ID: <20230801091927.415913083@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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



