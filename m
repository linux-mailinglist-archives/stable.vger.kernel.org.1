Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD37ECE93
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjKOToE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjKOToC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731599E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF80C433C7;
        Wed, 15 Nov 2023 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077439;
        bh=QEI6Z8Jur33hQjFrDxvv7rtXaUkL78w0gMP9s/6PtEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGhfcaRrQbK4xw+vZg8fgwZD0TCqnWpbk7NlQg/ZgBJgq/kUqCxXLuAF/IqcyvKCT
         NgdVTMCKepML7LaXbxvIKur/wZLUMNyo++FYoOWe1r0/b1Ki4QMaDhUQhaW1IqkI3z
         W0Mp4akQqOCYqXvxSYicN1P19tb95YqLxF+PhLaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 304/603] firmware: ti_sci: Mark driver as non removable
Date:   Wed, 15 Nov 2023 14:14:09 -0500
Message-ID: <20231115191634.440825866@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dhruva Gole <d-gole@ti.com>

[ Upstream commit 7b7a224b1ba1703583b25a3641ad9798f34d832a ]

The TI-SCI message protocol provides a way to communicate between
various compute processors with a central system controller entity. It
provides the fundamental device management capability and clock control
in the SOCs that it's used in.

The remove function failed to do all the necessary cleanup if
there are registered users. Some things are freed however which
likely results in an oops later on.

Ensure that the driver isn't unbound by suppressing its bind and unbind
sysfs attributes. As the driver is built-in there is no way to remove
device once bound.

We can also remove the ti_sci_remove call along with the
ti_sci_debugfs_destroy as there are no callers for it any longer.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/linux-arm-kernel/20230216083908.mvmydic5lpi3ogo7@pengutronix.de/
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20230921091025.133130-1-d-gole@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/ti_sci.c | 46 +--------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 26a37f47f4ca5..66c3846c91476 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -190,19 +190,6 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	return 0;
 }
 
-/**
- * ti_sci_debugfs_destroy() - clean up log debug file
- * @pdev:	platform device pointer
- * @info:	Pointer to SCI entity information
- */
-static void ti_sci_debugfs_destroy(struct platform_device *pdev,
-				   struct ti_sci_info *info)
-{
-	if (IS_ERR(info->debug_region))
-		return;
-
-	debugfs_remove(info->d);
-}
 #else /* CONFIG_DEBUG_FS */
 static inline int ti_sci_debugfs_create(struct platform_device *dev,
 					struct ti_sci_info *info)
@@ -3449,43 +3436,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_sci_remove(struct platform_device *pdev)
-{
-	struct ti_sci_info *info;
-	struct device *dev = &pdev->dev;
-	int ret = 0;
-
-	of_platform_depopulate(dev);
-
-	info = platform_get_drvdata(pdev);
-
-	if (info->nb.notifier_call)
-		unregister_restart_handler(&info->nb);
-
-	mutex_lock(&ti_sci_list_mutex);
-	if (info->users)
-		ret = -EBUSY;
-	else
-		list_del(&info->node);
-	mutex_unlock(&ti_sci_list_mutex);
-
-	if (!ret) {
-		ti_sci_debugfs_destroy(pdev, info);
-
-		/* Safe to free channels since no more users */
-		mbox_free_channel(info->chan_tx);
-		mbox_free_channel(info->chan_rx);
-	}
-
-	return ret;
-}
-
 static struct platform_driver ti_sci_driver = {
 	.probe = ti_sci_probe,
-	.remove = ti_sci_remove,
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.42.0



