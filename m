Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7D703AFA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbjEOR6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244933AbjEOR5u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423EA19967
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA6B62FCE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E04C433EF;
        Mon, 15 May 2023 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173262;
        bh=9873AN7ruXnRNMUukeNYPmOhvnuxy9TUjX0nQxZiGgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=su9tIHUCniBsmMpcza9MKbc4dLv9tR4uuwlNix7mTjo/+SaKzXfTHxlevR34RQE8W
         6nPRBJvYd7EjnDX3Hs5/+Apv19tvAUx01SGyWftTJX7lbkL4gQ2/zK9GPeb3mvqPpY
         +7bRrI8qFBREosVjkDLHKtI789F9ybxidluu3+R0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roger Quadros <rogerq@ti.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5.4 010/282] USB: dwc3: fix runtime pm imbalance on probe errors
Date:   Mon, 15 May 2023 18:26:28 +0200
Message-Id: <20230515161722.577425493@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 9a8ad10c9f2e0925ff26308ec6756b93fc2f4977 upstream.

Make sure not to suspend the device when probe fails to avoid disabling
clocks and phys multiple times.

Fixes: 328082376aea ("usb: dwc3: fix runtime PM in error path")
Cc: stable@vger.kernel.org      # 4.8
Cc: Roger Quadros <rogerq@ti.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230404072524.19014-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1496,13 +1496,11 @@ static int dwc3_probe(struct platform_de
 
 	spin_lock_init(&dwc->lock);
 
+	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto err1;
 
 	pm_runtime_forbid(dev);
 
@@ -1562,12 +1560,10 @@ err3:
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
 	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:


