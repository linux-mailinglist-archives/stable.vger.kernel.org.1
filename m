Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012537CACAC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjJPO6L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjJPO6L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:58:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA926AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:58:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBCCC433C7;
        Mon, 16 Oct 2023 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468287;
        bh=CJ0YD7BWlS7Du92oIv/5SV1t4+hN2zFZ4VDycHEx0WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iItQI5If5w6kN0sPECN7NfeC/NkIfu3Y7BftqhI33Nbic5X4dEGM3jllKUrGXzY5Y
         XL5qguKU4IywGISvjhE6dUnwccOCBcBEKx0XSCBonzMCfrgc9qTAlOV/pTOAZb1iIw
         Wbw2Lk+kR+pl1yqtdWwYUV4Wsg6SH9o8lh5Z693Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        stable <stable@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 6.5 180/191] usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub
Date:   Mon, 16 Oct 2023 10:42:45 +0200
Message-ID: <20231016084019.575683212@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco@wolfvision.net>

commit e59e38158c61162f2e8beb4620df21a1585117df upstream.

The USB2412 is a 2-Port USB 2.0 hub controller that provides a reset pin
and a single 3v3 powre source, which makes it suitable to be controlled
by the onboard_hub driver.

This hub has the same reset timings as USB2514/2517 and the same
onboard hub specific-data can be reused for USB2412.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: stable <stable@kernel.org>
Acked-by: Matthias Kaehlcke <mka@chromium.org>
Link: https://lore.kernel.org/r/20230911-topic-2412_onboard_hub-v1-1-7704181ddfff@wolfvision.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/onboard_usb_hub.c |    1 +
 drivers/usb/misc/onboard_usb_hub.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -409,6 +409,7 @@ static void onboard_hub_usbdev_disconnec
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -35,6 +35,7 @@ static const struct onboard_hub_pdata vi
 };
 
 static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },


