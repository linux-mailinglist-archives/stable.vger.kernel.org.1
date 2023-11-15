Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7AF7ED416
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbjKOU4p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbjKOU4o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BCFB7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD46C4E77C;
        Wed, 15 Nov 2023 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081801;
        bh=3sni9EbWw/BL0Wf8CTckvxobrpv7JxFtln0lKEKKYKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yperG3cD9ih4tVL9Lx6/JrWoUd/TBLBdLzDs0rKk2pqEgQsjIPj2vpB/4uUQ6kMlh
         bQhBjfelrKiTeMbDJTVSaQFABvCu/Av5qxGku6+2nNOcDIZEgTu6yV5v9OcG4rpqVm
         oKJNEX0ELYriByJ80vagC3vshhIwuBjGbvQzA8is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 108/191] Revert "HID: logitech-hidpp: add a module parameter to keep firmware gestures"
Date:   Wed, 15 Nov 2023 15:46:23 -0500
Message-ID: <20231115204651.050380946@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit cae253d6033da885e71c29c1591b22838a52de76 ]

Now that we're in 2022, and the majority of desktop environments can and
should support touchpad gestures through libinput, remove the legacy
module parameter that made it possible to use gestures implemented in
firmware.

This will eventually allow simplifying the driver's initialisation code.

This reverts commit 9188dbaed68a4b23dc96eba165265c08caa7dc2a.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Link: https://lore.kernel.org/r/20221220154345.474596-1-hadess@hadess.net
Stable-dep-of: 11ca0322a419 ("HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 651fa0966939e..8d81a700886fc 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -31,11 +31,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
 MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
 
-static bool disable_raw_mode;
-module_param(disable_raw_mode, bool, 0644);
-MODULE_PARM_DESC(disable_raw_mode,
-	"Disable Raw mode reporting for touchpads and keep firmware gestures.");
-
 static bool disable_tap_to_click;
 module_param(disable_tap_to_click, bool, 0644);
 MODULE_PARM_DESC(disable_tap_to_click,
@@ -3851,11 +3846,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	    hidpp_application_equals(hdev, HID_GD_KEYBOARD))
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
 
-	if (disable_raw_mode) {
-		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
-		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
-	}
-
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_allocate(hdev, id);
 		if (ret)
-- 
2.42.0



