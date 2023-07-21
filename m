Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C802775D2CB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGUTDp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGUTDo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A2D30D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CEB61D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3493C433C8;
        Fri, 21 Jul 2023 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966222;
        bh=EIAn2JUUCUq2MrFuOL8GPXe0oP1N3e/slTzw+FQMeW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrLcsDiB0lQJ6OW8OqxVbcAugkku2A/08hjBhip5n+lkTg++FClczzQuSXrEZn/c+
         lMES8FYH9/Ty8dGJGaKHaETInUzHjksCO72T/XKasM4qw74/ELbfdKvXFwrGy0B+kz
         PqCyIZg2vyGD1BTp/ilV7O4MRwFu+DUin+maIIkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 268/532] usb: dwc2: Fix some error handling paths
Date:   Fri, 21 Jul 2023 18:02:52 +0200
Message-ID: <20230721160628.879848669@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ada050c69108bc34be13ecc11f7fad0f20ebadc4 ]

dwc2_driver_probe() calls dwc2_lowlevel_hw_init() which deassert some reset
lines.
Should an error happen in dwc2_lowlevel_hw_init() after calling
reset_control_deassert() or in the probe after calling
dwc2_lowlevel_hw_init(), the reset lines remain deasserted.

Add some devm_add_action_or_reset() calls to re-assert the lines if needed.

Update the remove function accordingly.

This change is compile-tested only.

Fixes: 83f8da562f8b ("usb: dwc2: Add reset control to dwc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/c64537b5339342bd00f7c2152b8fc23792b9f95a.1683306479.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/platform.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ad8c7de4bfb19..6496bfbd34ed9 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -205,6 +205,11 @@ int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	return ret;
 }
 
+static void dwc2_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 {
 	int i, ret;
@@ -217,6 +222,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	}
 
 	reset_control_deassert(hsotg->reset);
+	ret = devm_add_action_or_reset(hsotg->dev, dwc2_reset_control_assert,
+				       hsotg->reset);
+	if (ret)
+		return ret;
 
 	hsotg->reset_ecc = devm_reset_control_get_optional(hsotg->dev, "dwc2-ecc");
 	if (IS_ERR(hsotg->reset_ecc)) {
@@ -226,6 +235,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	}
 
 	reset_control_deassert(hsotg->reset_ecc);
+	ret = devm_add_action_or_reset(hsotg->dev, dwc2_reset_control_assert,
+				       hsotg->reset_ecc);
+	if (ret)
+		return ret;
 
 	/*
 	 * Attempt to find a generic PHY, then look for an old style
@@ -352,9 +365,6 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 
-	reset_control_assert(hsotg->reset);
-	reset_control_assert(hsotg->reset_ecc);
-
 	return 0;
 }
 
-- 
2.39.2



