Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47C7D32D6
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjJWLY2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjJWLY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:24:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203310F0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:24:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47729C433CB;
        Mon, 23 Oct 2023 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060246;
        bh=XuWaLwl8GSEet30fwOCvOPIa9lXJs/Hpcurtwkn5UnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ui3Zk1PwhBlio39ziEXWBXzoZ45Tz29FT4vH0tVcJcSFbG78yqq4oeBK7F2K0k0sA
         uEn+v0EVx8fWONwGrCGrh5JooviyHzr0BTnrRJRShf64wBgsYShx33e66RR+YwesGN
         kc9c9aQNYkunZp67BkVrsXhGQ1OJahPAj+dcz9uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        stable <stable@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 081/196] usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub
Date:   Mon, 23 Oct 2023 12:55:46 +0200
Message-ID: <20231023104830.839921151@linuxfoundation.org>
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

From: Javier Carrasco <javier.carrasco@wolfvision.net>

[ Upstream commit e59e38158c61162f2e8beb4620df21a1585117df ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 8d5c83c9ff877..8edd0375e0a8a 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -409,6 +409,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 61fee18f9dfc9..d023fb90b4118 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -31,6 +31,7 @@ static const struct onboard_hub_pdata genesys_gl852g_data = {
 };
 
 static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
-- 
2.40.1



