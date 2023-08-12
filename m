Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3577A189
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHLRxY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHLRxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264010E5
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9159561CB8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1401C433C7;
        Sat, 12 Aug 2023 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691862805;
        bh=sbKePlEVYTJ/bS1oBesJvhqjibfsOh/a29zNdBWmKM8=;
        h=Subject:To:Cc:From:Date:From;
        b=eJ2XmSoGu74mLGRBqnTGKqe5hnqZymiUqLcdNvv31Qfl+eKj9o/Y7/XG0IYWODp0e
         n78ORHiaDh2Etus7E5AH7KO+UzLNOQe3CibfhWONAE2n9b92KJHjX4jiismTaJfnvJ
         4bMh9WtbZbEIBwfnwrzNJ5isqXnkbonx0P8TVeKE=
Subject: FAILED: patch "[PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay after" failed to apply to 6.1-stable tree
To:     savicaleksa83@gmail.com, linux@roeck-us.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 19:53:22 +0200
Message-ID: <2023081222-chummy-aqueduct-85c2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 56b930dcd88c2adc261410501c402c790980bdb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081222-chummy-aqueduct-85c2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

56b930dcd88c ("hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report")
19692f17cd13 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream XT")
866e630a3b8b ("hwmon: (aquacomputer_d5next) Add temperature offset control for Aquaero")
6c83ccb10c49 ("hwmon: (aquacomputer_d5next) Add infrastructure for Aquaero control reports")
b29090bac935 ("hwmon: (aquacomputer_d5next) Device dependent control report settings")
7505dab78f58 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream Ultimate")
e0f6c370f0ad ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Poweradjust 3")
3d2e9f582a8e ("hwmon: (aquacomputer_d5next) Add support for reading calculated Aquaero sensors")
2c55211104b4 ("hwmon: (aquacomputer_d5next) Support sensors for Aquacomputer Aquaero")
ad2f0811fbeb ("hwmon: (aquacomputer_d5next) Device dependent serial number and firmware offsets")
249c752110a5 ("hwmon: (aquacomputer_d5next) Add structure for fan layout")
8bcb02bdc638 ("hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_SIZE to AQC_SENSOR_SIZE")
6ff838f2877d ("hwmon: (aquacomputer_d5next) Add support for Quadro flow sensor pulses")
d5d896b83822 ("hwmon: (aquacomputer_d5next) Clear up macros and comments")
662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56b930dcd88c2adc261410501c402c790980bdb5 Mon Sep 17 00:00:00 2001
From: Aleksa Savic <savicaleksa83@gmail.com>
Date: Mon, 7 Aug 2023 19:20:03 +0200
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay after
 sending ctrl report

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

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a997dbcb563f..023807859be7 100644
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
@@ -63,6 +65,8 @@ static const char *const aqc_device_names[] = {
 #define CTRL_REPORT_ID			0x03
 #define AQUAERO_CTRL_REPORT_ID		0x0b
 
+#define CTRL_REPORT_DELAY		200	/* ms */
+
 /* The HID report that the official software always sends
  * after writing values, currently same for all devices
  */
@@ -527,6 +531,9 @@ struct aqc_data {
 	int secondary_ctrl_report_size;
 	u8 *secondary_ctrl_report;
 
+	ktime_t last_ctrl_report_op;
+	int ctrl_report_delay;	/* Delay between two ctrl report operations, in ms */
+
 	int buffer_size;
 	u8 *buffer;
 	int checksum_start;
@@ -611,17 +618,35 @@ static int aqc_aquastreamxt_convert_fan_rpm(u16 val)
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
 
@@ -631,6 +656,8 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	int ret;
 	u16 checksum;
 
+	aqc_delay_ctrl_report(priv);
+
 	/* Checksum is not needed for Aquaero */
 	if (priv->kind != aquaero) {
 		/* Init and xorout value for CRC-16/USB is 0xffff */
@@ -646,12 +673,16 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
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
 
@@ -1524,6 +1555,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
 		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -1547,6 +1579,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 
@@ -1597,6 +1630,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 
@@ -1624,6 +1658,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;

