Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A17D35C0
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjJWLvd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjJWLv1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:51:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F4E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E9BC433CA;
        Mon, 23 Oct 2023 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061885;
        bh=6HGC3m1DVl/5VXoc4Mh4QMrQ9QEyFlB+61oENWY02gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLPMZkI4XyWkJK00iLcUEOJH10l3OLPgI2OEfgYR60qfoAUBQR07iWhrAtHhd0Qor
         jsxFGPsVU1JQ/jy/2ZTB5Y1Hvki9GQBWK0Vivi/zAojbsQuV691AUor0pnELJ7rzxx
         c9BAP9HmwWlRPmq9/YBkntiIp2Hhk1LtcuPgxMXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 198/202] phy: mapphone-mdm6600: Fix runtime PM for remove
Date:   Mon, 23 Oct 2023 12:58:25 +0200
Message-ID: <20231023104832.205931215@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit b99e0ba9633af51638e5ee1668da2e33620c134f ]

Otherwise we will get an underflow on remove.

Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Fixes: f7f50b2a7b05 ("phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20230913060433.48373-2-tony@atomide.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 436b5ab6dc6d5..c3e2ab6a2a717 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -641,6 +641,7 @@ static int phy_mdm6600_remove(struct platform_device *pdev)
 	struct phy_mdm6600 *ddata = platform_get_drvdata(pdev);
 	struct gpio_desc *reset_gpio = ddata->ctrl_gpios[PHY_MDM6600_RESET];
 
+	pm_runtime_get_noresume(ddata->dev);
 	pm_runtime_dont_use_autosuspend(ddata->dev);
 	pm_runtime_put_sync(ddata->dev);
 	pm_runtime_disable(ddata->dev);
-- 
2.42.0



