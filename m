Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69612775DC1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHILlF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjHILlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311581FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54AD63662
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D673BC433C7;
        Wed,  9 Aug 2023 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581263;
        bh=lDrp53wHGiA6GHEG7Ra3SHKe3ejrjp0ycdmdJrfeLXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU170Yw8k47wypbBvQ2k9ZGIiPvAVmotNtQU4T6R288Am6yvQc1h97h4z/U/5T39B
         CB17bqR2WxawByYEtOrdJ290dsC+BcE4p9uBROi7/QtwCb6nt+IajnH4ok+f61mEjr
         O0OYLNwAYTEpnK1py8pUAEjJOT7MWWKs7E6KV59s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ross Maynard <bids.7405@bigpond.com>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 164/201] USB: zaurus: Add ID for A-300/B-500/C-700
Date:   Wed,  9 Aug 2023 12:42:46 +0200
Message-ID: <20230809103649.219493808@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ross Maynard <bids.7405@bigpond.com>

commit b99225b4fe297d07400f9e2332ecd7347b224f8d upstream.

The SL-A300, B500/5600, and C700 devices no longer auto-load because of
"usbnet: Remove over-broad module alias from zaurus."
This patch adds IDs for those 3 devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
Fixes: 16adf5d07987 ("usbnet: Remove over-broad module alias from zaurus.")
Signed-off-by: Ross Maynard <bids.7405@bigpond.com>
Cc: stable@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/69b5423b-2013-9fc9-9569-58e707d9bafb@bigpond.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ether.c |   21 +++++++++++++++++++++
 drivers/net/usb/zaurus.c    |   21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -604,6 +604,13 @@ static const struct usb_device_id	produc
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,   /* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
@@ -611,11 +618,25 @@ static const struct usb_device_id	produc
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,   /* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,   /* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor               = 0x04DD,
 	.idProduct              = 0x9031,	/* C-750 C-760 */
--- a/drivers/net/usb/zaurus.c
+++ b/drivers/net/usb/zaurus.c
@@ -289,11 +289,25 @@ static const struct usb_device_id	produc
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,	/* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,	/* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 	          | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8007,	/* C-700 */
@@ -301,6 +315,13 @@ static const struct usb_device_id	produc
 	.driver_info = ZAURUS_PXA_INFO,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,	/* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor               = 0x04DD,
 	.idProduct              = 0x9031,	/* C-750 C-760 */


