Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968FF7D32CB
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjJWLX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJWLXv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:23:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF6D1724
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:23:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9036AC433C7;
        Mon, 23 Oct 2023 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060217;
        bh=dEvOZ5mhvQXknnrGWwXoFSCvwaQlLZgPSR8MfCq5YH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2YwdGSbQWkyv2TX0ASA2xMCZUY2Q5sQfmF7REGf6YnUErMG54wESonPTDg3pcT15
         q+ym9nZab4FlzFsb9z6/6MueElc3wvkcgRgdjA1jvc2RRJioBDiJAbkww6zL/5842e
         t11yF+PSEJoEzQNKgC4L1w7yTY2ZkJ3bexoIafb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Moon <linux.amoon@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 080/196] usb: misc: onboard_usb_hub: add Genesys Logic GL3523 hub support
Date:   Mon, 23 Oct 2023 12:55:45 +0200
Message-ID: <20231023104830.812922029@linuxfoundation.org>
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

From: Anand Moon <linux.amoon@gmail.com>

[ Upstream commit d97b4b35adcecd4b747d3e1c262e10e4a093cefa ]

Genesys Logic GL3523 is a 4-port USB 3.1 hub that has a reset pin to
toggle and a 5.0V core supply exported though an integrated LDO is
available for powering it.

Add the support for this hub, for controlling the reset pin and the core
power supply.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
[m.felsch@pengutronix.de: include review feedback & port to 6.4]
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20230623142228.4069084-2-m.felsch@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e59e38158c61 ("usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 7a1030ddf9956..8d5c83c9ff877 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -408,6 +408,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 0c2ab5755a7ea..61fee18f9dfc9 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -37,6 +37,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },
+	{ .compatible = "usb5e3,620", .data = &genesys_gl852g_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
-- 
2.40.1



