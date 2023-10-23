Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4A7D33D2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJWLe2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjJWLe1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:34:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01958E8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:34:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8DAC433C9;
        Mon, 23 Oct 2023 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060864;
        bh=/kB7S1wIzJlvb5d6rM6KbkAgObVbztSIGy59hLtbjzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lML7g9fWYWUge6dcHJMhvB/+qNtq9gAgbuuRc/jGnBMIucPy7RUp4Je+pYyNl7pUf
         wdOcvT0/tDZ2HAf9PNtZDPkf5vhyTtO2j/SMlf2RlslMxmKDRIwE6YAsUBnZljq+IP
         28v28wibBVDEADIEVPeHvd4LkCNGi0/8cybs9xzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Miaoqian Lin <linmq006@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 118/123] phy: mapphone-mdm6600: Fix runtime disable on probe
Date:   Mon, 23 Oct 2023 12:57:56 +0200
Message-ID: <20231023104821.743081171@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 719606154c7033c068a5d4c1dc5f9163b814b3c8 ]

Commit d644e0d79829 ("phy: mapphone-mdm6600: Fix PM error handling in
phy_mdm6600_probe") caused a regression where we now unconditionally
disable runtime PM at the end of the probe while it is only needed on
errors.

Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Miaoqian Lin <linmq006@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: d644e0d79829 ("phy: mapphone-mdm6600: Fix PM error handling in phy_mdm6600_probe")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20230913060433.48373-1-tony@atomide.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 39d13f7e4cf33..042927f8ac4f3 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -626,10 +626,12 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(ddata->dev);
 
 cleanup:
-	if (error < 0)
+	if (error < 0) {
 		phy_mdm6600_device_power_off(ddata);
-	pm_runtime_disable(ddata->dev);
-	pm_runtime_dont_use_autosuspend(ddata->dev);
+		pm_runtime_disable(ddata->dev);
+		pm_runtime_dont_use_autosuspend(ddata->dev);
+	}
+
 	return error;
 }
 
-- 
2.42.0



