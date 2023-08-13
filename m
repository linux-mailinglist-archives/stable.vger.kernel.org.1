Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9803377ACA6
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjHMVf3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjHMVf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74B10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A4761E35
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52376C433C7;
        Sun, 13 Aug 2023 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962529;
        bh=o5YfiK6t4S8NtYPXrKKLgoKUEkE1Prvv03srNdyjNYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzTMLnsm4tGHvbJFkzLBwicv7+koDUnSIFa3B4benEweLAMXaKmsJqD8Wh/q2tao3
         3NiZRNADDVbBXqs9UX0LX7uVn3Lt9O9apmE3JIT9qHQC+PVj94C9L+sR/jumknbDFe
         VKcU5ieQeKKq5DDznRWXSqgRVaCEqJfefGtpZYkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 055/149] iio: adc: ina2xx: avoid NULL pointer dereference on OF device match
Date:   Sun, 13 Aug 2023 23:18:20 +0200
Message-ID: <20230813211720.458888285@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

From: Alvin Šipraga <alsi@bang-olufsen.dk>

commit a41e19cc0d6b6a445a4133170b90271e4a2553dc upstream.

The affected lines were resulting in a NULL pointer dereference on our
platform because the device tree contained the following list of
compatible strings:

    power-sensor@40 {
        compatible = "ti,ina232", "ti,ina231";
        ...
    };

Since the driver doesn't declare a compatible string "ti,ina232", the OF
matching succeeds on "ti,ina231". But the I2C device ID info is
populated via the first compatible string, cf. modalias population in
of_i2c_get_board_info(). Since there is no "ina232" entry in the legacy
I2C device ID table either, the struct i2c_device_id *id pointer in the
probe function is NULL.

Fix this by using the already populated type variable instead, which
points to the proper driver data. Since the name is also wanted, add a
generic one to the ina2xx_config table.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
Link: https://lore.kernel.org/r/20230619141239.2257392-1-alvin@pqrs.dk
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ina2xx-adc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -124,6 +124,7 @@ static const struct regmap_config ina2xx
 enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
+	const char *name;
 	u16 config_default;
 	int calibration_value;
 	int shunt_voltage_lsb;	/* nV */
@@ -155,6 +156,7 @@ struct ina2xx_chip_info {
 
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
+		.name = "ina219",
 		.config_default = INA219_CONFIG_DEFAULT,
 		.calibration_value = 4096,
 		.shunt_voltage_lsb = 10000,
@@ -164,6 +166,7 @@ static const struct ina2xx_config ina2xx
 		.chip_id = ina219,
 	},
 	[ina226] = {
+		.name = "ina226",
 		.config_default = INA226_CONFIG_DEFAULT,
 		.calibration_value = 2048,
 		.shunt_voltage_lsb = 2500,
@@ -996,7 +999,7 @@ static int ina2xx_probe(struct i2c_clien
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
 
-	if (id->driver_data == ina226) {
+	if (type == ina226) {
 		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
 		ina226_set_int_time_vbus(chip, INA226_DEFAULT_IT, &val);
 		ina226_set_int_time_vshunt(chip, INA226_DEFAULT_IT, &val);
@@ -1015,7 +1018,7 @@ static int ina2xx_probe(struct i2c_clien
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (id->driver_data == ina226) {
+	if (type == ina226) {
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
 		indio_dev->info = &ina226_info;
@@ -1024,7 +1027,7 @@ static int ina2xx_probe(struct i2c_clien
 		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
 		indio_dev->info = &ina219_info;
 	}
-	indio_dev->name = id->name;
+	indio_dev->name = id ? id->name : chip->config->name;
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
 					  &ina2xx_setup_ops);


