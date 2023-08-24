Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8861B787155
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHXORT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbjHXORR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:17:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7376ACD0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:17:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bbbda48904so86508351fa.2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692886632; x=1693491432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zWfxaz/cUCJkVxVyJpUo46ErD//bqro0X/XXZXc60Y=;
        b=a7Fs4XyjZn2tM7QSfDVQGRGiG5EwXNBH8ikeC3+N39F4IKCsFa+/m+BRTNFBqmwv8R
         0brQgPt3RJlioyR+SPj5Qz6/xEl+jYYjkJWSnX2t3PsUGbtrsuGPV8OAbQKgfL1kk3N7
         od6E4LZJgDPk5aePsB/+QxhUbtn8+D+fkWTkLD+hO7ToQI/IyfnE5NPi+HU99EYccN71
         xdlff1AmnkvXL+H174uBhf1qJT68aQ9AWAc0a8nhHbfRpmZiO1jnNNdOT0Ukb++dIeDW
         HHKX3uUSwJwb+ldZUoxl/tBgdX3gUAGF9ohevZL1ksc741B30wTNqU4+5ZiUmxKQjt6N
         dW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886632; x=1693491432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zWfxaz/cUCJkVxVyJpUo46ErD//bqro0X/XXZXc60Y=;
        b=a1xZypf5q5I1R+85HR0p/92v8f/F2AMxrCy6ziBDg6cjsysti3VkorsPfHswucMVQ4
         CS6wkiIeNY2P2yP/dBtOJj0SO/+N2oRpOhmhNU7oSIYy2fDIQvOomcjQkDNYwh+jne0Z
         ERFU9buaiXdw9fUcLsTf1U0VxsCohCdoGj6jCpVOpKFzieXCE5xJyoA570X5ZDhXJ9au
         uvgcpSc8x2Rs+C6+a7XsoQJTcux9p1KeKTpgyNJkorThstmcnqzoFxkyUnEpJDQEwK8j
         9EbizLCvy5U2v2SyGkHbEEaTkbUkkAlKE3gkPj4MmzJfz/AcSWoQd9czNolZxlU6DgMu
         rupQ==
X-Gm-Message-State: AOJu0YwYbxf0Rtw/oAC0tMIQ9TuZSEDIgum53nSiDRpa0VonxkuQEMye
        3ov6+s9VI+KER8o1PBGHh7cfPOAysPs=
X-Google-Smtp-Source: AGHT+IE6KBGxJyMKVS6XmR42ScgMJKGYYB6gHzJRZbtiHrbUnEdYcP0y79OxDLAno8fdbnXZbwGt1w==
X-Received: by 2002:a2e:b1c4:0:b0:2b9:3883:a765 with SMTP id e4-20020a2eb1c4000000b002b93883a765mr11953116lja.31.1692886632075;
        Thu, 24 Aug 2023 07:17:12 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id dv11-20020a170906b80b00b00997d7aa59fasm11177990ejb.14.2023.08.24.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:17:11 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     stable@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>
Subject: [PATCH v6.1] hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
Date:   Thu, 24 Aug 2023 16:15:00 +0200
Message-ID: <20230824141500.1813549-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081222-chummy-aqueduct-85c2@gregkh>
References: <2023081222-chummy-aqueduct-85c2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
This is a backport of the upstream commit to v6.1. No functional
changes, except that Aquaero support first appeared in
v6.3, so that part of the original is not included here.
---
 drivers/hwmon/aquacomputer_d5next.c | 36 ++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index c51a2678f0eb..8c7796d3fdd2 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -12,9 +12,11 @@
 
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
@@ -49,6 +51,8 @@ static const char *const aqc_device_names[] = {
 
 #define CTRL_REPORT_ID			0x03
 
+#define CTRL_REPORT_DELAY		200	/* ms */
+
 /* The HID report that the official software always sends
  * after writing values, currently same for all devices
  */
@@ -269,6 +273,9 @@ struct aqc_data {
 	enum kinds kind;
 	const char *name;
 
+	ktime_t last_ctrl_report_op;
+	int ctrl_report_delay;	/* Delay between two ctrl report operations, in ms */
+
 	int buffer_size;
 	u8 *buffer;
 	int checksum_start;
@@ -325,17 +332,35 @@ static int aqc_pwm_to_percent(long val)
 	return DIV_ROUND_CLOSEST(val * 100 * 100, 255);
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
 	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0)
 		ret = -ENODATA;
 
+	priv->last_ctrl_report_op = ktime_get();
+
 	return ret;
 }
 
@@ -345,6 +370,8 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	int ret;
 	u16 checksum;
 
+	aqc_delay_ctrl_report(priv);
+
 	/* Init and xorout value for CRC-16/USB is 0xffff */
 	checksum = crc16(0xffff, priv->buffer + priv->checksum_start, priv->checksum_length);
 	checksum ^= 0xffff;
@@ -356,12 +383,16 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	if (ret < 0)
-		return ret;
+		goto record_access_and_ret;
 
 	/* The official software sends this report after every change, so do it here as well */
 	ret = hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
 				 SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
+
+record_access_and_ret:
+	priv->last_ctrl_report_op = ktime_get();
+
 	return ret;
 }
 
@@ -853,6 +884,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = D5NEXT_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->temp_label = label_d5next_temp;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -893,6 +925,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -913,6 +946,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = QUADRO_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
-- 
2.41.0

