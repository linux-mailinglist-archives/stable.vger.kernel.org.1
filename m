Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3362D713CAF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjE1TRl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjE1TRh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D611F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74839619FD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91971C433D2;
        Sun, 28 May 2023 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301448;
        bh=3G35kd6T4kS2rg35txsY0C3k2e5PT1s9hEOIzlHqrBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlZ1W0S52Lt2AcEIkmFLQe8FvuX0YL5lagKpi8nAqjGq6fEx95DitkRrlDlOID/FW
         44jKHaNAfS4QR3vYZyXwRzmtzwU3w6mtxeiW55L5Iv5No6i1etz5VjzAIiOBhhU0a5
         M6sZhJzsQphae95jzvU1V+MvzVwKNNcY4r3us1Gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/132] HID: logitech-hidpp: Dont use the USB serial for USB devices
Date:   Sun, 28 May 2023 20:09:33 +0100
Message-Id: <20230528190834.635057071@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 7ad1fe0da0fa91bf920b79ab05ae97bfabecc4f4 ]

For devices that support the 0x0003 feature (Device Information) version 4,
set the serial based on the output of that feature, rather than relying
on the usbhid code setting the USB serial.

This should allow the serial when connected through USB to (nearly)
match the one when connected through a unifying receiver.

For example, on the serials on a G903 wired/wireless mouse:
- Unifying: 4067-e8-ce-cd-45
- USB before patch: 017C385C3837
- USB after patch: c086-e8-ce-cd-45

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20230302130117.3975-1-hadess@hadess.net
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 504e8917b06f3..a4d9ee9170998 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -777,6 +777,55 @@ static bool hidpp_is_connected(struct hidpp_device *hidpp)
 	return ret == 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x0003: Device Information                                                 */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_DEVICE_INFORMATION			0x0003
+
+#define CMD_GET_DEVICE_INFO				0x00
+
+static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
+{
+	struct hidpp_report response;
+	u8 feature_type;
+	u8 feature_index;
+	int ret;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_DEVICE_INFORMATION,
+				     &feature_index,
+				     &feature_type);
+	if (ret)
+		return ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_GET_DEVICE_INFO,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	/* See hidpp_unifying_get_serial() */
+	*serial = *((u32 *)&response.rap.params[1]);
+	return 0;
+}
+
+static int hidpp_serial_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	u32 serial;
+	int ret;
+
+	ret = hidpp_get_serial(hidpp, &serial);
+	if (ret)
+		return ret;
+
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
+		 hdev->product, &serial);
+	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
+
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x0005: GetDeviceNameType                                                  */
 /* -------------------------------------------------------------------------- */
@@ -3040,6 +3089,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
 		hidpp_unifying_init(hidpp);
+	else if (hid_is_usb(hidpp->hid_dev))
+		hidpp_serial_init(hidpp);
 
 	connected = hidpp_is_connected(hidpp);
 	atomic_set(&hidpp->connected, connected);
-- 
2.39.2



