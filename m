Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC4755637
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjGPUsi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGPUsf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE5E57
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C8E60EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF07C433C7;
        Sun, 16 Jul 2023 20:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540507;
        bh=KrIhQVJaVsnTPVIzhrhYVpzIzKNqwdh3dafuwhnClos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftj5/YnepVDMYLZUPwtYFKQNynv7AuPd+0j2wf6DztOIqEEwhxYTyk1qlsxM9Uizo
         ARfrzzgvM5t4nSkzOTS/t1SnVSMElHv0AOcyRdD8XQRASeB3z9IQuVl2XqIXlnsIa8
         frbosT4TxOjbCWOcOwCXiWkx9H6yM07AcD4zxNuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 388/591] usb: dwc2: Fix some error handling paths
Date:   Sun, 16 Jul 2023 21:48:47 +0200
Message-ID: <20230716194933.957901134@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index d1589ba7d322d..58f53faab340f 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -175,6 +175,11 @@ int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
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
@@ -185,6 +190,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 				     "error getting reset control\n");
 
 	reset_control_deassert(hsotg->reset);
+	ret = devm_add_action_or_reset(hsotg->dev, dwc2_reset_control_assert,
+				       hsotg->reset);
+	if (ret)
+		return ret;
 
 	hsotg->reset_ecc = devm_reset_control_get_optional(hsotg->dev, "dwc2-ecc");
 	if (IS_ERR(hsotg->reset_ecc))
@@ -192,6 +201,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 				     "error getting reset control for ecc\n");
 
 	reset_control_deassert(hsotg->reset_ecc);
+	ret = devm_add_action_or_reset(hsotg->dev, dwc2_reset_control_assert,
+				       hsotg->reset_ecc);
+	if (ret)
+		return ret;
 
 	/*
 	 * Attempt to find a generic PHY, then look for an old style
@@ -306,9 +319,6 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 
-	reset_control_assert(hsotg->reset);
-	reset_control_assert(hsotg->reset_ecc);
-
 	return 0;
 }
 
-- 
2.39.2



