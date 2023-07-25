Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4276144E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjGYLRw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjGYLRv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00991B8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC7BA615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E0BC433C7;
        Tue, 25 Jul 2023 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283866;
        bh=HUEROur+Iwzh2YYN2HVMhiVxBAQM3p9BMmwCz5lnvrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBpd+/YiqXNGywq6nFq0XJETi1QZ/vBU4084NweEDgcZ8+xkkx7w7Tqb2YBVQWuHF
         rgmFHocYph34TC/A1TghHu92BHo7avx+cUpLXUnapyl+s9ComFjfBGM3M4pyDasgn/
         30Cs41D0NZS3upfSXJ3dHMOtTWTlh4bPHQ/QTuXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 149/509] hwmon: (adm1275) Allow setting sample averaging
Date:   Tue, 25 Jul 2023 12:41:28 +0200
Message-ID: <20230725104600.549802733@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Potin Lai <potin.lai@quantatw.com>

[ Upstream commit a3cd66d7cbadcc0c29884f25b754fd22699c719c ]

Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs
to set sample averaging via sysfs manually.

This patch parses the properties "adi,power-sample-average" and
"adi,volt-curr-sample-average" from device tree, and setting sample
averaging during probe. Input value must be one of value in the
list [1, 2, 4, 8, 16, 32, 64, 128].

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
Link: https://lore.kernel.org/r/20220302123817.27025-2-potin.lai@quantatw.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: b153a0bb4199 ("hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1275.c | 40 ++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 0be1b5777d2f0..92eb047ff246f 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -687,7 +688,7 @@ static int adm1275_probe(struct i2c_client *client)
 		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
 		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
 			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
-			ret = i2c_smbus_write_byte_data(client,
+			ret = i2c_smbus_write_word_data(client,
 							ADM1275_PMON_CONFIG,
 							config);
 			if (ret < 0) {
@@ -756,6 +757,43 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_u32(client->dev.of_node,
+				 "adi,power-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of power samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, true,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting power sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
+	if (of_property_read_u32(client->dev.of_node,
+				"adi,volt-curr-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of voltage/current samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, false,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting voltage and current sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
 	if (voindex < 0)
 		voindex = vindex;
 	if (vindex >= 0) {
-- 
2.39.2



