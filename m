Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B7B78724B
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbjHXOwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbjHXOwP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B248A1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E4D65FC1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B510BC433C7;
        Thu, 24 Aug 2023 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888733;
        bh=yqQ+EmpLi0nFN89QQ5n69f9cVqnu3sjGQ5ZRqEW7/6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIJYYIBeKZL2JG0RuXyx7rG9sVy+v8PNtRaHtqzHzFm16fZufoirmXlq4v5jb+muq
         shOUW1R1tC1MMz+OVh8GkIeVouwVI0flKR35vhNpTQ+omovg5Uw2ESaikwDNR0G/a2
         6LfHOn7vJiNpBli22jw2nJBhJzmLWqjxgik/Wcx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 014/139] HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
Date:   Thu, 24 Aug 2023 16:48:57 +0200
Message-ID: <20230824145024.206121867@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: stuarthayhurst <stuart.a.hayhurst@gmail.com>

[ Upstream commit 48aea8b445c422a372cf15915101035a47105421 ]

Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard, for device detection
For this device, this provides battery reporting on top of hid-generic

Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c61da859cd3c6..0ac67dd76574e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4377,6 +4377,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
+	{ /* Logitech G915 TKL Keyboard over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
@@ -4392,6 +4394,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+	{ /* Logitech G915 TKL keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
 	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
-- 
2.40.1



