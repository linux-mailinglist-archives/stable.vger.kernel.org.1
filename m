Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6E97ED59C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjKOVHr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjKOVH1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988E1AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B493FC4E661;
        Wed, 15 Nov 2023 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081434;
        bh=HTeX0VajqkHILnCGat9VBO58eQgBOI+R22x8Xcu9ZXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLyry3B3ZCkelBvsOaaPZom7xOdSCSJnV97pccUdAJBkm3ajgOcBdhJ+WcLJq0jvF
         cUV+Nc+ehTqTp4H60tUsIH+9+S4lyloWGSbnpIXJjHJyZ0i1xp3tExBkQfIUlSp3Va
         vez1vOqVB3WEAVIHAnYqsI1lp8UQMqQm46HSz3Sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Tissoires <bentiss@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 152/244] HID: logitech-hidpp: Dont restart IO, instead defer hid_connect() only
Date:   Wed, 15 Nov 2023 15:35:44 -0500
Message-ID: <20231115203557.459504088@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 11ca0322a41920df2b462d2e45b0731e47ff475b ]

Restarting IO causes 2 problems:

1. Some devices do not like IO being restarted this was addressed in
   commit 498ba2069035 ("HID: logitech-hidpp: Don't restart communication
   if not necessary"), but that change has issues of its own and needs to
   be reverted.

2. Restarting IO and specifically calling hid_device_io_stop() causes
   received packets to be missed, which may cause connect-events to
   get missed.

Restarting IO was introduced in commit 91cf9a98ae41 ("HID: logitech-hidpp:
make .probe usbhid capable") to allow to retrieve the device's name and
serial number and store these in hdev->name and hdev->uniq before
connecting any hid subdrivers (hid-input, hidraw) exporting this info
to userspace.

But this does not require restarting IO, this merely requires deferring
calling hid_connect(). Calling hid_hw_start() with a connect-mask of
0 makes it skip calling hid_connect(), so hidpp_probe() can simply call
hid_connect() later without needing to restart IO.

Remove the stop + restart of IO and instead just call hid_connect() later
to avoid the issues caused by restarting IO.

Now that IO is no longer stopped, hid_hw_close() must be called at the end
of probe() to balance the hid_hw_open() done at the beginning probe().

This series has been tested on the following devices:
Logitech Bluetooth Laser Travel Mouse (bluetooth, HID++ 1.0)
Logitech M720 Triathlon (bluetooth, HID++ 4.5)
Logitech M720 Triathlon (unifying, HID++ 4.5)
Logitech K400 Pro (unifying, HID++ 4.1)
Logitech K270 (eQUAD nano Lite, HID++ 2.0)
Logitech M185 (eQUAD nano Lite, HID++ 4.5)
Logitech LX501 keyboard (27 Mhz, HID++ builtin scroll-wheel, HID++ 1.0)
Logitech M-RAZ105 mouse (27 Mhz, HID++ extra mouse buttons, HID++ 1.0)

And by bentiss:
Logitech Touchpad T650 (unifying)
Logitech Touchpad T651 (bluetooth)
Logitech MX Master 3B (BLE)
Logitech G403 (plain USB / Gaming receiver)

Fixes: 498ba2069035 ("HID: logitech-hidpp: Don't restart communication if not necessary")
Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231010102029.111003-2-hdegoede@redhat.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a716c6f3bfb58..907f45dfef4c1 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4155,8 +4155,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			 hdev->name);
 
 	/*
-	 * Plain USB connections need to actually call start and open
-	 * on the transport driver to allow incoming data.
+	 * First call hid_hw_start(hdev, 0) to allow IO without connecting any
+	 * hid subdrivers (hid-input, hidraw). This allows retrieving the dev's
+	 * name and serial number and store these in hdev->name and hdev->uniq,
+	 * before the hid-input and hidraw drivers expose these to userspace.
 	 */
 	ret = hid_hw_start(hdev, will_restart ? 0 : connect_mask);
 	if (ret) {
@@ -4214,19 +4216,14 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	flush_work(&hidpp->work);
 
 	if (will_restart) {
-		/* Reset the HID node state */
-		hid_device_io_stop(hdev);
-		hid_hw_close(hdev);
-		hid_hw_stop(hdev);
-
 		if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 			connect_mask &= ~HID_CONNECT_HIDINPUT;
 
 		/* Now export the actual inputs and hidraw nodes to the world */
-		ret = hid_hw_start(hdev, connect_mask);
+		ret = hid_connect(hdev, connect_mask);
 		if (ret) {
-			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
-			goto hid_hw_start_fail;
+			hid_err(hdev, "%s:hid_connect returned error %d\n", __func__, ret);
+			goto hid_hw_init_fail;
 		}
 	}
 
@@ -4238,6 +4235,11 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				 ret);
 	}
 
+	/*
+	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
+	 * events will still be received.
+	 */
+	hid_hw_close(hdev);
 	return ret;
 
 hid_hw_init_fail:
-- 
2.42.0



