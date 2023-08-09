Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F494775D25
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjHILeX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjHILeX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E41BFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291576349A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DDCC433C8;
        Wed,  9 Aug 2023 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580861;
        bh=lausnEgg029whm/HvP1pe8VaXC5LsLy45zSkH/vd8TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5nJOVvjmpGQexjjBvAXJ7ywK0ux6kCGMVOFb2pbJYa9a8JdQGfSjORKHhalsuyeh
         kIpdFnpKIHUb8EKWYl6LeCrzWceDXAb+NNGAsxqzr1ohfFsMhmI4mUUvBSJtW/YlfO
         zq4foeQ/TZJReh2jjNb38RTXt8Uxo8JY+yccXjjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Markus Elfring <elfring@users.sourceforge.net>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 006/201] i2c: Delete error messages for failed memory allocations
Date:   Wed,  9 Aug 2023 12:40:08 +0200
Message-ID: <20230809103644.010708890@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 6b3b21a8542fd2fb6ffc61bc13b9419f0c58ebad ]

These issues were detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 05f933d5f731 ("i2c: nomadik: Remove a useless call in the remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c  | 4 +---
 drivers/i2c/busses/i2c-nomadik.c  | 1 -
 drivers/i2c/busses/i2c-sh7760.c   | 1 -
 drivers/i2c/busses/i2c-tiny-usb.c | 4 +---
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 9f71daf6db64b..c073f5b8833a2 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -694,10 +694,8 @@ static int iic_probe(struct platform_device *ofdev)
 	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&ofdev->dev, "failed to allocate device data\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(ofdev, dev);
 
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a3363b20f168a..b456e4ae8830c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -972,7 +972,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
-		dev_err(&adev->dev, "cannot allocate memory\n");
 		ret = -ENOMEM;
 		goto err_no_mem;
 	}
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 319d1fa617c88..a0ccc5d009874 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -445,7 +445,6 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 
 	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
 	if (!id) {
-		dev_err(&pdev->dev, "no mem for private data\n");
 		ret = -ENOMEM;
 		goto out0;
 	}
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 7279ca0eaa2d0..d1fa9ff5aeab4 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -226,10 +226,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!dev)
 		goto error;
-	}
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
-- 
2.39.2



