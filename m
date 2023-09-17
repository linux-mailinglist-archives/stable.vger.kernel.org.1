Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518B7A3758
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjIQTRw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjIQTRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAF115
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:17:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB7CC433C8;
        Sun, 17 Sep 2023 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978255;
        bh=EohJLrEoOvb8ggYwESR+ZD1ATwzUgZUwQ57p3Mnt8GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlAEaT9fkX/wg4YtyVtgsIrsQZs1203PVx42uKR8WOIIxyNIn2j80c3VeMQGhP6gn
         o2j/lCygMvpL2YTyjh9bVHUAxY+OPR9gBn7+4mVeGLYiV8sYYURw0Lxnoq7tGwboca
         NkwppLDmhEptggDd06VsyQ/iT+cGGwz/ddKHGTxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luke Lu <luke.lu@libre.computer>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 5.10 009/406] usb: dwc3: meson-g12a: do post init to fix broken usb after resumption
Date:   Sun, 17 Sep 2023 21:07:43 +0200
Message-ID: <20230917191101.348819122@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luke Lu <luke.lu@libre.computer>

commit 1fa206bb764f37d2ab4bf671e483153ef0659b34 upstream.

Device connected to usb otg port of GXL-based boards can not be
recognised after resumption, doesn't recover even if disconnect and
reconnect the device. dmesg shows it disconnects during resumption.

[   41.492911] usb 1-2: USB disconnect, device number 3
[   41.499346] usb 1-2: unregistering device
[   41.511939] usb 1-2: unregistering interface 1-2:1.0

Calling usb_post_init() will fix this issue, and it's tested and
verified on libretech's aml-s905x-cc board.

Cc: stable@vger.kernel.org # v5.8+
Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Signed-off-by: Luke Lu <luke.lu@libre.computer>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230809212911.18903-1-luke.lu@libre.computer
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -931,6 +931,12 @@ static int __maybe_unused dwc3_meson_g12
 			return ret;
 	}
 
+	if (priv->drvdata->usb_post_init) {
+		ret = priv->drvdata->usb_post_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 


