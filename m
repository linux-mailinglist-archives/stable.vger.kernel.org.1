Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0927ED3D6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjKOUy4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjKOUy4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:54:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1FBC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:54:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ED5C4E778;
        Wed, 15 Nov 2023 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081692;
        bh=ee24BRDa4aZu5/1Vf93kLsN34tQL3Jydb1zzm2KVMQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fw+1kUMjrTheLDBVxoxVDfIBtG2BAQWBN8KwPtYHTh0cPohNwWfu1C73NHoKVSzI1
         6NpQGb2hspzV9WIfIpjGQAF+z3HmvwnnLxEE2zo8qrCn25S5VutfmHVJxCS90pOstk
         pPbOS8SiuXW5+rq7lo7EYnEhmgKM1Y0dVbweTtRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 066/191] hwmon: (axi-fan-control) Support temperature vs pwm points
Date:   Wed, 15 Nov 2023 15:45:41 -0500
Message-ID: <20231115204648.553677194@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit 2aee7e67bee7a5aa741bad6a0a472f108b29ad40 ]

The HW has some predefined points where it will associate a PWM value.
However some users might want to better set these points to their
usecases. This patch exposes these points as pwm auto_points:

 * pwm1_auto_point1_temp_hyst: temperature threshold below which PWM should
   be 0%;
 * pwm1_auto_point1_temp: temperature threshold above which PWM should be
   25%;
 * pwm1_auto_point2_temp_hyst: temperature threshold below which PWM should
   be 25%;
 * pwm1_auto_point2_temp: temperature threshold above which PWM should be
   50%;
 * pwm1_auto_point3_temp_hyst: temperature threshold below which PWM should
   be 50%;
 * pwm1_auto_point3_temp: temperature threshold above which PWM should be
   75%;
 * pwm1_auto_point4_temp_hyst: temperature threshold below which PWM should
   be 75%;
 * pwm1_auto_point4_temp: temperature threshold above which PWM should be
   100%;

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20210811114853.159298-4-nuno.sa@analog.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 2a5b3370a1d9 ("hwmon: (axi-fan-control) Fix possible NULL pointer dereference")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/axi-fan-control.c | 74 ++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index e3f6b03e6764b..da0c3b6101f59 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -23,6 +24,14 @@
 #define ADI_REG_PWM_PERIOD	0x00c0
 #define ADI_REG_TACH_MEASUR	0x00c4
 #define ADI_REG_TEMPERATURE	0x00c8
+#define ADI_REG_TEMP_00_H	0x0100
+#define ADI_REG_TEMP_25_L	0x0104
+#define ADI_REG_TEMP_25_H	0x0108
+#define ADI_REG_TEMP_50_L	0x010c
+#define ADI_REG_TEMP_50_H	0x0110
+#define ADI_REG_TEMP_75_L	0x0114
+#define ADI_REG_TEMP_75_H	0x0118
+#define ADI_REG_TEMP_100_L	0x011c
 
 #define ADI_REG_IRQ_MASK	0x0040
 #define ADI_REG_IRQ_PENDING	0x0044
@@ -62,6 +71,39 @@ static inline u32 axi_ioread(const u32 reg,
 	return ioread32(ctl->base + reg);
 }
 
+/*
+ * The core calculates the temperature as:
+ *	T = /raw * 509.3140064 / 65535) - 280.2308787
+ */
+static ssize_t axi_fan_control_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	u32 temp = axi_ioread(attr->index, ctl);
+
+	temp = DIV_ROUND_CLOSEST_ULL(temp * 509314ULL, 65535) - 280230;
+
+	return sprintf(buf, "%u\n", temp);
+}
+
+static ssize_t axi_fan_control_store(struct device *dev, struct device_attribute *da,
+				     const char *buf, size_t count)
+{
+	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	u32 temp;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &temp);
+	if (ret)
+		return ret;
+
+	temp = DIV_ROUND_CLOSEST_ULL((temp + 280230) * 65535ULL, 509314);
+	axi_iowrite(temp, attr->index, ctl);
+
+	return count;
+}
+
 static long axi_fan_control_get_pwm_duty(const struct axi_fan_control_data *ctl)
 {
 	u32 pwm_width = axi_ioread(ADI_REG_PWM_WIDTH, ctl);
@@ -370,6 +412,36 @@ static const struct hwmon_chip_info axi_chip_info = {
 	.info = axi_fan_control_info,
 };
 
+/* temperature threshold below which PWM should be 0% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp_hyst, axi_fan_control, ADI_REG_TEMP_00_H);
+/* temperature threshold above which PWM should be 25% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, axi_fan_control, ADI_REG_TEMP_25_L);
+/* temperature threshold below which PWM should be 25% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp_hyst, axi_fan_control, ADI_REG_TEMP_25_H);
+/* temperature threshold above which PWM should be 50% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, axi_fan_control, ADI_REG_TEMP_50_L);
+/* temperature threshold below which PWM should be 50% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp_hyst, axi_fan_control, ADI_REG_TEMP_50_H);
+/* temperature threshold above which PWM should be 75% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, axi_fan_control, ADI_REG_TEMP_75_L);
+/* temperature threshold below which PWM should be 75% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp_hyst, axi_fan_control, ADI_REG_TEMP_75_H);
+/* temperature threshold above which PWM should be 100% */
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, axi_fan_control, ADI_REG_TEMP_100_L);
+
+static struct attribute *axi_fan_control_attrs[] = {
+	&sensor_dev_attr_pwm1_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(axi_fan_control);
+
 static const u32 version_1_0_0 = ADI_AXI_PCORE_VER(1, 0, 'a');
 
 static const struct of_device_id axi_fan_control_of_match[] = {
@@ -446,7 +518,7 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 							 name,
 							 ctl,
 							 &axi_chip_info,
-							 NULL);
+							 axi_fan_control_groups);
 
 	return PTR_ERR_OR_ZERO(ctl->hdev);
 }
-- 
2.42.0



