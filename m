Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3FA7D32AD
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjJWLWu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjJWLWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:22:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ADCD6
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:22:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2527C433C7;
        Mon, 23 Oct 2023 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060166;
        bh=2Ec9ThD4GedrZSz2iTnyNopnRoyDm0LJrnCWfs7nXYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0GoTRQVCXiBT+yGWG05rIuL5UhvvY29FL1vEemAb317AXAOnwouVmbMb33N7Y4SE
         sELayDKzn9hH1Udui4dUeHcMfRQmmsOoK/hrG8PsaC4blh0Bee8Ze1UvwlNMZVUa9f
         fZRVKKnifU+8HEM5z295O8eGJCoyr9QDjiQ6ccoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josua Mayer <josua@solid-run.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 053/196] net: rfkill: gpio: prevent value glitch during probe
Date:   Mon, 23 Oct 2023 12:55:18 +0200
Message-ID: <20231023104830.030818476@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josua Mayer <josua@solid-run.com>

commit b2f750c3a80b285cd60c9346f8c96bd0a2a66cde upstream.

When either reset- or shutdown-gpio have are initially deasserted,
e.g. after a reboot - or when the hardware does not include pull-down,
there will be a short toggle of both IOs to logical 0 and back to 1.

It seems that the rfkill default is unblocked, so the driver should not
glitch to output low during probe.
It can lead e.g. to unexpected lte modem reconnect:

[1] root@localhost:~# dmesg | grep "usb 2-1"
[    2.136124] usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
[   21.215278] usb 2-1: USB disconnect, device number 2
[   28.833977] usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd

The glitch has been discovered on an arm64 board, now that device-tree
support for the rfkill-gpio driver has finally appeared :).

Change the flags for devm_gpiod_get_optional from GPIOD_OUT_LOW to
GPIOD_ASIS to avoid any glitches.
The rfkill driver will set the intended value during rfkill_sync_work.

Fixes: 7176ba23f8b5 ("net: rfkill: add generic gpio rfkill driver")
Signed-off-by: Josua Mayer <josua@solid-run.com>
Link: https://lore.kernel.org/r/20231004163928.14609-1-josua@solid-run.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/rfkill-gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -98,13 +98,13 @@ static int rfkill_gpio_probe(struct plat
 
 	rfkill->clk = devm_clk_get(&pdev->dev, NULL);
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
 	rfkill->reset_gpio = gpio;
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 


