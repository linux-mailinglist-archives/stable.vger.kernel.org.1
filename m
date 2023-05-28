Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB67713C50
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjE1TOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjE1TOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86685E4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541DD61935
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7009EC433D2;
        Sun, 28 May 2023 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301248;
        bh=2jt1SRCXVZJzcGV80pA+R6dAheXDurY2i67w+fVCSKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoIhp8BXe9C+4d/tMEk/2Oa9vxoonHEZ3wbJlosktnio3e7wrR7UGAgFgAKtmE2S4
         Cs+NWB2kGEC9jllBVtRo4+RwUBGuen80coB/j7fgIsncaHZBWhF4doeyqzYoHr5j8Z
         9qiaSJmdHYYJvFJtttiLU7DhLHyFyP2AppKOzMYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/86] net: fec: Better handle pm_runtime_get() failing in .remove()
Date:   Sun, 28 May 2023 20:10:14 +0100
Message-Id: <20230528190830.087864957@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit f816b9829b19394d318e01953aa3b2721bca040d ]

In the (unlikely) event that pm_runtime_get() (disguised as
pm_runtime_resume_and_get()) fails, the remove callback returned an
error early. The problem with this is that the driver core ignores the
error value and continues removing the device. This results in a
resource leak. Worse the devm allocated resources are freed and so if a
callback of the driver is called later the register mapping is already
gone which probably results in a crash.

Fixes: a31eda65ba21 ("net: fec: fix clock count mis-match")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230510200020.1534610-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c6fc77a211ea6..1085f1d721b02 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3569,7 +3569,9 @@ fec_drv_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev,
+			"Failed to resume device in remove callback (%pe)\n",
+			ERR_PTR(ret));
 
 	cancel_work_sync(&fep->tx_timeout_work);
 	fec_ptp_stop(pdev);
@@ -3582,8 +3584,13 @@ fec_drv_remove(struct platform_device *pdev)
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
 
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
+	/* After pm_runtime_get_sync() failed, the clks are still off, so skip
+	 * disabling them again.
+	 */
+	if (ret >= 0) {
+		clk_disable_unprepare(fep->clk_ahb);
+		clk_disable_unprepare(fep->clk_ipg);
+	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.39.2



