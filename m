Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F377AC20
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjHMV3h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjHMV3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05A10D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3357362ACB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CCAC433C7;
        Sun, 13 Aug 2023 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962177;
        bh=f7I3qE8EBYRg9ZD/eq7mO7Gz5mLK61S+AV/mQctu8F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6nrUVvOG0vUyTmWbOXpYhvJufWqs3qc1RTJPThf7R13S1b8Zl7rqB8QTw8PCvcoW
         KUkH3cFlbxbk3/TQzvas5V0DmPmS9UceWvxfZCSq6L3jbiSfvPIonnOu+WdtaYC1NL
         AUzkyyT8eKRB9QJgTjTTyaFB47Lt5GQVz5mi+5E0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Savic <savicaleksa83@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 124/206] hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
Date:   Sun, 13 Aug 2023 23:18:14 +0200
Message-ID: <20230813211728.583748505@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aleksa Savic <savicaleksa83@gmail.com>

commit 56b930dcd88c2adc261410501c402c790980bdb5 upstream.

Add a 200ms delay after sending a ctrl report to Quadro,
Octo, D5 Next and Aquaero to give them enough time to
process the request and save the data to memory. Otherwise,
under heavier userspace loads where multiple sysfs entries
are usually set in quick succession, a new ctrl report could
be requested from the device while it's still processing the
previous one and fail with -EPIPE. The delay is only applied
if two ctrl report operations are near each other in time.

Reported by a user on Github [1] and tested by both of us.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82

Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
Link: https://lore.kernel.org/r/20230807172004.456968-1-savicaleksa83@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/aquacomputer_d5next.c |   37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -13,9 +13,11 @@
 
 #include <linux/crc16.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
@@ -61,6 +63,8 @@ static const char *const aqc_device_name
 #define CTRL_REPORT_ID			0x03
 #define AQUAERO_CTRL_REPORT_ID		0x0b
 
+#define CTRL_REPORT_DELAY		200	/* ms */
+
 /* The HID report that the official software always sends
  * after writing values, currently same for all devices
  */
@@ -496,6 +500,9 @@ struct aqc_data {
 	int secondary_ctrl_report_size;
 	u8 *secondary_ctrl_report;
 
+	ktime_t last_ctrl_report_op;
+	int ctrl_report_delay;	/* Delay between two ctrl report operations, in ms */
+
 	int buffer_size;
 	u8 *buffer;
 	int checksum_start;
@@ -577,17 +584,35 @@ static int aqc_aquastreamxt_convert_fan_
 	return 0;
 }
 
+static void aqc_delay_ctrl_report(struct aqc_data *priv)
+{
+	/*
+	 * If previous read or write is too close to this one, delay the current operation
+	 * to give the device enough time to process the previous one.
+	 */
+	if (priv->ctrl_report_delay) {
+		s64 delta = ktime_ms_delta(ktime_get(), priv->last_ctrl_report_op);
+
+		if (delta < priv->ctrl_report_delay)
+			msleep(priv->ctrl_report_delay - delta);
+	}
+}
+
 /* Expects the mutex to be locked */
 static int aqc_get_ctrl_data(struct aqc_data *priv)
 {
 	int ret;
 
+	aqc_delay_ctrl_report(priv);
+
 	memset(priv->buffer, 0x00, priv->buffer_size);
 	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0)
 		ret = -ENODATA;
 
+	priv->last_ctrl_report_op = ktime_get();
+
 	return ret;
 }
 
@@ -597,6 +622,8 @@ static int aqc_send_ctrl_data(struct aqc
 	int ret;
 	u16 checksum;
 
+	aqc_delay_ctrl_report(priv);
+
 	/* Checksum is not needed for Aquaero */
 	if (priv->kind != aquaero) {
 		/* Init and xorout value for CRC-16/USB is 0xffff */
@@ -612,12 +639,16 @@ static int aqc_send_ctrl_data(struct aqc
 	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	if (ret < 0)
-		return ret;
+		goto record_access_and_ret;
 
 	/* The official software sends this report after every change, so do it here as well */
 	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
 				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+record_access_and_ret:
+	priv->last_ctrl_report_op = ktime_get();
+
 	return ret;
 }
 
@@ -1443,6 +1474,7 @@ static int aqc_probe(struct hid_device *
 
 		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
 		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -1466,6 +1498,7 @@ static int aqc_probe(struct hid_device *
 		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 
@@ -1516,6 +1549,7 @@ static int aqc_probe(struct hid_device *
 		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 
@@ -1543,6 +1577,7 @@ static int aqc_probe(struct hid_device *
 		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;


