Return-Path: <stable+bounces-164153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15297B0DDED
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C76818944ED
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1512EA757;
	Tue, 22 Jul 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dxuXi93l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98352EA16D;
	Tue, 22 Jul 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193421; cv=none; b=eh0Mgq7z/QL1Edhd28ooe/RrKwSjlw9cskowrueyNtLrTxB/cuPeMW7jlNj/t9Bi5x3BWcpv1Nl8dbdTls2h+5zwOfklYvOIYtJifNMsdjES5a6PY3CKmSayDjhWiMiJOWpp9yXAoWqY7KMBTQUzbem518WCwZ0JyEcvo3vB10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193421; c=relaxed/simple;
	bh=Cw95j5JLrxv5b1c4DfYmloKNSbv1Pe0Z20zm/8YpSkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+dRJaMq3d906JxflDqv0UnG09N8d1BX35FhvlnQMW2eKWccz1Gh9NRzTYoOqa2AGLYZerknMBZrGBtKg82/a5wIpyja9zlFa/qx4AF2AVb2b9rWbtwsswGjl3d5Tnzz2Ji7CqGjj8p4XuriZX71zobzBIesQ8nQCWbRofZ5bVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxuXi93l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7ACC4CEEB;
	Tue, 22 Jul 2025 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193421;
	bh=Cw95j5JLrxv5b1c4DfYmloKNSbv1Pe0Z20zm/8YpSkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxuXi93llWUSu8QQACdv3VMZIu9Q7C53BJ+H+D/ds8jfRCR5nEuFtq2P3KDQRe1Za
	 6NSEyJdKuY5Agpcl9k3lXqri10L37VzUimsEP7hA4lQgd08fNrvl5g6EaJLb7qZYf/
	 753ca7ZV85hXyckln04Vp8GexxMZ+WKs2b386qiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maud Spierings <maudspierings@gocontroll.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.15 087/187] iio: common: st_sensors: Fix use of uninitialize device structs
Date: Tue, 22 Jul 2025 15:44:17 +0200
Message-ID: <20250722134348.961533374@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maud Spierings <maudspierings@gocontroll.com>

commit 9f92e93e257b33e73622640a9205f8642ec16ddd upstream.

Throughout the various probe functions &indio_dev->dev is used before it
is initialized. This caused a kernel panic in st_sensors_power_enable()
when the call to devm_regulator_bulk_get_enable() fails and then calls
dev_err_probe() with the uninitialized device.

This seems to only cause a panic with dev_err_probe(), dev_err(),
dev_warn() and dev_info() don't seem to cause a panic, but are fixed
as well.

The issue is reported and traced here: [1]

Link: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/ [1]
Cc: stable@vger.kernel.org
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://... [1]
Link: https://patch.msgid.link/20250527-st_iio_fix-v4-1-12d89801c761@gocontroll.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/st_accel_core.c                  |   10 ++---
 drivers/iio/common/st_sensors/st_sensors_core.c    |   36 +++++++++------------
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   20 +++++------
 3 files changed, 31 insertions(+), 35 deletions(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1353,6 +1353,7 @@ static int apply_acpi_orientation(struct
 	union acpi_object *ont;
 	union acpi_object *elements;
 	acpi_status status;
+	struct device *parent = indio_dev->dev.parent;
 	int ret = -EINVAL;
 	unsigned int val;
 	int i, j;
@@ -1371,7 +1372,7 @@ static int apply_acpi_orientation(struct
 	};
 
 
-	adev = ACPI_COMPANION(indio_dev->dev.parent);
+	adev = ACPI_COMPANION(parent);
 	if (!adev)
 		return -ENXIO;
 
@@ -1380,8 +1381,7 @@ static int apply_acpi_orientation(struct
 	if (status == AE_NOT_FOUND) {
 		return -ENXIO;
 	} else if (ACPI_FAILURE(status)) {
-		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
-			 status);
+		dev_warn(parent, "failed to execute _ONT: %d\n", status);
 		return status;
 	}
 
@@ -1457,12 +1457,12 @@ static int apply_acpi_orientation(struct
 	}
 
 	ret = 0;
-	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
+	dev_info(parent, "computed mount matrix from ACPI\n");
 
 out:
 	kfree(buffer.pointer);
 	if (ret)
-		dev_dbg(&indio_dev->dev,
+		dev_dbg(parent,
 			"failed to apply ACPI orientation data: %d\n", ret);
 
 	return ret;
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -154,7 +154,7 @@ static int st_sensors_set_fullscale(stru
 	return err;
 
 st_accel_set_fullscale_error:
-	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+	dev_err(indio_dev->dev.parent, "failed to set new fullscale.\n");
 	return err;
 }
 
@@ -231,8 +231,7 @@ int st_sensors_power_enable(struct iio_d
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (err)
-		return dev_err_probe(&indio_dev->dev, err,
-				     "unable to enable supplies\n");
+		return dev_err_probe(parent, err, "unable to enable supplies\n");
 
 	return 0;
 }
@@ -241,13 +240,14 @@ EXPORT_SYMBOL_NS(st_sensors_power_enable
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	/* Sensor does not support interrupts */
 	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
 	    !sdata->sensor_settings->drdy_irq.int2.addr) {
 		if (pdata->drdy_int_pin)
-			dev_info(&indio_dev->dev,
+			dev_info(parent,
 				 "DRDY on pin INT%d specified, but sensor does not support interrupts\n",
 				 pdata->drdy_int_pin);
 		return 0;
@@ -256,29 +256,27 @@ static int st_sensors_set_drdy_int_pin(s
 	switch (pdata->drdy_int_pin) {
 	case 1:
 		if (!sdata->sensor_settings->drdy_irq.int1.mask) {
-			dev_err(&indio_dev->dev,
-					"DRDY on INT1 not available.\n");
+			dev_err(parent, "DRDY on INT1 not available.\n");
 			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 1;
 		break;
 	case 2:
 		if (!sdata->sensor_settings->drdy_irq.int2.mask) {
-			dev_err(&indio_dev->dev,
-					"DRDY on INT2 not available.\n");
+			dev_err(parent, "DRDY on INT2 not available.\n");
 			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 2;
 		break;
 	default:
-		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
+		dev_err(parent, "DRDY on pdata not valid.\n");
 		return -EINVAL;
 	}
 
 	if (pdata->open_drain) {
 		if (!sdata->sensor_settings->drdy_irq.int1.addr_od &&
 		    !sdata->sensor_settings->drdy_irq.int2.addr_od)
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"open drain requested but unsupported.\n");
 		else
 			sdata->int_pin_open_drain = true;
@@ -336,6 +334,7 @@ EXPORT_SYMBOL_NS(st_sensors_dev_name_pro
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *of_pdata;
 	int err = 0;
@@ -343,7 +342,7 @@ int st_sensors_init_sensor(struct iio_de
 	mutex_init(&sdata->odr_lock);
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
-	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
+	of_pdata = st_sensors_dev_probe(parent, pdata);
 	if (IS_ERR(of_pdata))
 		return PTR_ERR(of_pdata);
 	if (of_pdata)
@@ -370,7 +369,7 @@ int st_sensors_init_sensor(struct iio_de
 		if (err < 0)
 			return err;
 	} else
-		dev_info(&indio_dev->dev, "Full-scale not possible\n");
+		dev_info(parent, "Full-scale not possible\n");
 
 	err = st_sensors_set_odr(indio_dev, sdata->odr);
 	if (err < 0)
@@ -405,7 +404,7 @@ int st_sensors_init_sensor(struct iio_de
 			mask = sdata->sensor_settings->drdy_irq.int2.mask_od;
 		}
 
-		dev_info(&indio_dev->dev,
+		dev_info(parent,
 			 "set interrupt line to open drain mode on pin %d\n",
 			 sdata->drdy_int_pin);
 		err = st_sensors_write_data_with_mask(indio_dev, addr,
@@ -594,21 +593,20 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings
 int st_sensors_verify_id(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	int wai, err;
 
 	if (sdata->sensor_settings->wai_addr) {
 		err = regmap_read(sdata->regmap,
 				  sdata->sensor_settings->wai_addr, &wai);
 		if (err < 0) {
-			dev_err(&indio_dev->dev,
-				"failed to read Who-Am-I register.\n");
-			return err;
+			return dev_err_probe(parent, err,
+					     "failed to read Who-Am-I register.\n");
 		}
 
 		if (sdata->sensor_settings->wai != wai) {
-			dev_warn(&indio_dev->dev,
-				"%s: WhoAmI mismatch (0x%x).\n",
-				indio_dev->name, wai);
+			dev_warn(parent, "%s: WhoAmI mismatch (0x%x).\n",
+				 indio_dev->name, wai);
 		}
 	}
 
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -127,7 +127,7 @@ int st_sensors_allocate_trigger(struct i
 	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
 					     indio_dev->name);
 	if (sdata->trig == NULL) {
-		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
+		dev_err(parent, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
 	}
 
@@ -143,7 +143,7 @@ int st_sensors_allocate_trigger(struct i
 	case IRQF_TRIGGER_FALLING:
 	case IRQF_TRIGGER_LOW:
 		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"falling/low specified for IRQ but hardware supports only rising/high: will request rising/high\n");
 			if (irq_trig == IRQF_TRIGGER_FALLING)
 				irq_trig = IRQF_TRIGGER_RISING;
@@ -156,21 +156,19 @@ int st_sensors_allocate_trigger(struct i
 				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
 			if (err < 0)
 				return err;
-			dev_info(&indio_dev->dev,
+			dev_info(parent,
 				 "interrupts on the falling edge or active low level\n");
 		}
 		break;
 	case IRQF_TRIGGER_RISING:
-		dev_info(&indio_dev->dev,
-			 "interrupts on the rising edge\n");
+		dev_info(parent, "interrupts on the rising edge\n");
 		break;
 	case IRQF_TRIGGER_HIGH:
-		dev_info(&indio_dev->dev,
-			 "interrupts active high level\n");
+		dev_info(parent, "interrupts active high level\n");
 		break;
 	default:
 		/* This is the most preferred mode, if possible */
-		dev_err(&indio_dev->dev,
+		dev_err(parent,
 			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
@@ -179,7 +177,7 @@ int st_sensors_allocate_trigger(struct i
 	if (irq_trig == IRQF_TRIGGER_FALLING ||
 	    irq_trig == IRQF_TRIGGER_RISING) {
 		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"edge IRQ not supported w/o stat register.\n");
 			return -EOPNOTSUPP;
 		}
@@ -214,13 +212,13 @@ int st_sensors_allocate_trigger(struct i
 					sdata->trig->name,
 					sdata->trig);
 	if (err) {
-		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
+		dev_err(parent, "failed to request trigger IRQ.\n");
 		return err;
 	}
 
 	err = devm_iio_trigger_register(parent, sdata->trig);
 	if (err < 0) {
-		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
+		dev_err(parent, "failed to register iio trigger.\n");
 		return err;
 	}
 	indio_dev->trig = iio_trigger_get(sdata->trig);



