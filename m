Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397D78730A
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbjHXO7b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbjHXO7T (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708691BC5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA466701C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210D7C433C8;
        Thu, 24 Aug 2023 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889156;
        bh=kr1We91KmtJEeiVd00HurqECfmt7WNCS7jIEfR0qWsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3kR1qS8H9AAlqKnnn64gRKqF85tUVfjEFhd8PdYsCL5zX/02dbOXqqf/AIuDUbse
         8YCzu3fc/KqBMCHwdPPx4d8XLQAS4La3MpDrRxK4sR0K2hfbLXgX8arEazf+yb0cmL
         ifG+9S0PuJKRhdFeqZ0BVW9rX/uVEIN7dcXLI+dU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 035/135] Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
Date:   Thu, 24 Aug 2023 16:49:38 +0200
Message-ID: <20230824145028.428770068@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthew Anderson <ruinairas1992@gmail.com>

[ Upstream commit fa01eba11f0e57c767a5eab5291c7a01407a00be ]

Adding the device ID from the Asus Ally gets the bluetooth working
on the device.

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2695ece47eb0e..49d5375b04f40 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -432,6 +432,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.40.1



