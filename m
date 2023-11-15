Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3A7ED0E4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjKOT6O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343869AbjKOT6N (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730ADB8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB654C433CA;
        Wed, 15 Nov 2023 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078290;
        bh=FWTW+c6L1Wf+mBh03TgicehPDX8SQUV/8kBya8O0Bxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvQTYKKMfv7r9m4KWrzfLQsVBsIgmAwe8ZotnfgSP9BRGxMK5xV536ubZLIovGO5f
         VJLxdl3NtZY3mUNhLMJlns08+EJIoCWuOEL5fdkpRSOun2BSUqILJN0kndxbXgt5+O
         RmbAs5AOpqCHNLHis6jnUFldfh/gr//UVgAKGs5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 231/379] HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk
Date:   Wed, 15 Nov 2023 14:25:06 -0500
Message-ID: <20231115192658.788935977@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit d83956c8855c6c2ed4bd16cec4a5083d63df17e4 ]

HIDPP_QUIRK_NO_HIDINPUT isn't used by any devices but still happens to
work as HIDPP_QUIRK_DELAYED_INIT is defined to the same value. Remove
HIDPP_QUIRK_NO_HIDINPUT and use HIDPP_QUIRK_DELAYED_INIT everywhere
instead.

Tested on a T650 which requires that quirk, and a number of unifying and
Bluetooth devices that don't.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20230125121723.3122-2-hadess@hadess.net
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Stable-dep-of: 11ca0322a419 ("HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d2772dfc4da6a..fb9ce038bf684 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
-#define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
+#define HIDPP_QUIRK_DELAYED_INIT		BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
 #define HIDPP_QUIRK_HIDPP_WHEELS		BIT(26)
@@ -83,8 +83,6 @@ MODULE_PARM_DESC(disable_tap_to_click,
 					 HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL | \
 					 HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL)
 
-#define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
-
 #define HIDPP_CAPABILITY_HIDPP10_BATTERY	BIT(0)
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
@@ -4039,7 +4037,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
+	if (!(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
 
@@ -4274,7 +4272,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_hw_close(hdev);
 		hid_hw_stop(hdev);
 
-		if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
+		if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 			connect_mask &= ~HID_CONNECT_HIDINPUT;
 
 		/* Now export the actual inputs and hidraw nodes to the world */
-- 
2.42.0



