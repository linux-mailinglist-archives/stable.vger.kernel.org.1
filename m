Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294A46F8ED3
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjEFFx7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjEFFx6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB649EC
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416496150F
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E302C433D2;
        Sat,  6 May 2023 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352436;
        bh=nlpyr10g2XZPqRdfFv7mhNsh/7Qg2/J+UqsnTv/h2y8=;
        h=Subject:To:Cc:From:Date:From;
        b=kQYNAGRTkhWRzefBfqFB/GYa0RvCbpaNHaFY2GMVe3xOeSkQX3VcG78kZkhRQQRY7
         mBw5x7tn8KveJhLmHiuqshWl8rCstDvTL+a6tS4cC+90j0c8JjASwPjwiZpdLPz2HC
         3CUtR3q3cwcxg5vEza7JqhRoe2/wTIzIp7MwWTHo=
Subject: FAILED: patch "[PATCH] USB: dwc3: fix runtime pm imbalance on probe errors" failed to apply to 4.14-stable tree
To:     johan+linaro@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, rogerq@ti.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 10:59:01 +0900
Message-ID: <2023050601-unvarying-crock-13e0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 9a8ad10c9f2e0925ff26308ec6756b93fc2f4977
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050601-unvarying-crock-13e0@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a8ad10c9f2e0925ff26308ec6756b93fc2f4977 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 4 Apr 2023 09:25:14 +0200
Subject: [PATCH] USB: dwc3: fix runtime pm imbalance on probe errors

Make sure not to suspend the device when probe fails to avoid disabling
clocks and phys multiple times.

Fixes: 328082376aea ("usb: dwc3: fix runtime PM in error path")
Cc: stable@vger.kernel.org      # 4.8
Cc: Roger Quadros <rogerq@ti.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230404072524.19014-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ed0ab90d3fac..d2350a87450e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1895,13 +1895,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
+	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto err1;
 
 	pm_runtime_forbid(dev);
 
@@ -1966,12 +1964,10 @@ err3:
 	dwc3_free_event_buffers(dwc);
 
 err2:
-	pm_runtime_allow(&pdev->dev);
-
-err1:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
+	pm_runtime_allow(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 disable_clks:
 	dwc3_clk_disable(dwc);
 assert_reset:

