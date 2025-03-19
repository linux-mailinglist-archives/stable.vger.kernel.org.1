Return-Path: <stable+bounces-125290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E3EA690AA
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0218A1183
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF275219A7E;
	Wed, 19 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToOczuTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C490219319;
	Wed, 19 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395085; cv=none; b=jDxLVaqJsiwQ7kjwpdAWc6OfIDpJ5sP2HfiC7aluAYBHj2VjhHc2JaOxWwDzVD2TSgdLfjA9bPhSfo/8ATsHSl3S5+iQfRtrajGt/z9GwgCsNng2K/knZIcmJrQ0BhRdVhz0x81mBXlSwnIFO53Z8vXIla2hP/uEEoElXzbZjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395085; c=relaxed/simple;
	bh=gDMTzQqTdf3MR41EsUG+gPMM179rSJHgPRp169Kvf1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEcUuLL1LRZnphnID6bakcQEU4CRwgbgETz+UzxS4fiYIngjjInauh/jslXPkFI0+FF3EJsZan1s9MoZVwul0c0QD9F88Wwol1dP9gfQ7Mgj7mSTFyce9AnYXfOVspd6nZ0nbjYpeD2JhB4Iq1gxGiCl/9XT6TOwHjYAl7oQv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToOczuTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3364EC4CEE4;
	Wed, 19 Mar 2025 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395085;
	bh=gDMTzQqTdf3MR41EsUG+gPMM179rSJHgPRp169Kvf1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToOczuTXDHRkMKgr3Pl5SKdQicSLlkldR+Cd5fYefQckbqHw/GiRrJjulrYAgwudN
	 qg1N4piInlESPj69/D53nPRzXSgTS/8KC6x+EIf5OWVoboVSo2vGaNYiQV7igZdvcO
	 mwuDmeIPhX3cAsACc0qsxPps1J5OYx8OaHQpO4WU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 090/231] platform/x86: int3472: Use correct type for "polarity", call it gpio_flags
Date: Wed, 19 Mar 2025 07:29:43 -0700
Message-ID: <20250319143029.063389432@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit fc22b06fbd2afefa1eddff69a6fd30c539cef577 ]

Struct gpiod_lookup flags field's type is unsigned long. Thus use unsigned
long for values to be assigned to that field. Similarly, also call the
field gpio_flags which it really is.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250211072841.7713-2-sakari.ailus@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 15678508ee501..dc4d09611c5ab 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -55,7 +55,7 @@ static void skl_int3472_log_sensor_module_name(struct int3472_discrete_device *i
 
 static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
 					 struct acpi_resource_gpio *agpio,
-					 const char *func, u32 polarity)
+					 const char *func, unsigned long gpio_flags)
 {
 	char *path = agpio->resource_source.string_ptr;
 	struct acpi_device *adev;
@@ -70,14 +70,14 @@ static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
 	if (!adev)
 		return -ENODEV;
 
-	*table_entry = GPIO_LOOKUP(acpi_dev_name(adev), agpio->pin_table[0], func, polarity);
+	*table_entry = GPIO_LOOKUP(acpi_dev_name(adev), agpio->pin_table[0], func, gpio_flags);
 
 	return 0;
 }
 
 static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
 					  struct acpi_resource_gpio *agpio,
-					  const char *func, u32 polarity)
+					  const char *func, unsigned long gpio_flags)
 {
 	int ret;
 
@@ -87,7 +87,7 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	}
 
 	ret = skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int3472->n_sensor_gpios],
-					    agpio, func, polarity);
+					    agpio, func, gpio_flags);
 	if (ret)
 		return ret;
 
@@ -100,7 +100,7 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 static struct gpio_desc *
 skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 				       struct acpi_resource_gpio *agpio,
-				       const char *func, u32 polarity)
+				       const char *func, unsigned long gpio_flags)
 {
 	struct gpio_desc *desc;
 	int ret;
@@ -111,7 +111,7 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 		return ERR_PTR(-ENOMEM);
 
 	lookup->dev_id = dev_name(int3472->dev);
-	ret = skl_int3472_fill_gpiod_lookup(&lookup->table[0], agpio, func, polarity);
+	ret = skl_int3472_fill_gpiod_lookup(&lookup->table[0], agpio, func, gpio_flags);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -122,32 +122,33 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 	return desc;
 }
 
-static void int3472_get_func_and_polarity(u8 type, const char **func, u32 *polarity)
+static void int3472_get_func_and_polarity(u8 type, const char **func,
+					  unsigned long *gpio_flags)
 {
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
 		*func = "reset";
-		*polarity = GPIO_ACTIVE_LOW;
+		*gpio_flags = GPIO_ACTIVE_LOW;
 		break;
 	case INT3472_GPIO_TYPE_POWERDOWN:
 		*func = "powerdown";
-		*polarity = GPIO_ACTIVE_LOW;
+		*gpio_flags = GPIO_ACTIVE_LOW;
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 		*func = "clk-enable";
-		*polarity = GPIO_ACTIVE_HIGH;
+		*gpio_flags = GPIO_ACTIVE_HIGH;
 		break;
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 		*func = "privacy-led";
-		*polarity = GPIO_ACTIVE_HIGH;
+		*gpio_flags = GPIO_ACTIVE_HIGH;
 		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
 		*func = "power-enable";
-		*polarity = GPIO_ACTIVE_HIGH;
+		*gpio_flags = GPIO_ACTIVE_HIGH;
 		break;
 	default:
 		*func = "unknown";
-		*polarity = GPIO_ACTIVE_HIGH;
+		*gpio_flags = GPIO_ACTIVE_HIGH;
 		break;
 	}
 }
@@ -194,7 +195,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	struct gpio_desc *gpio;
 	const char *err_msg;
 	const char *func;
-	u32 polarity;
+	unsigned long gpio_flags;
 	int ret;
 
 	if (!acpi_gpio_get_io_resource(ares, &agpio))
@@ -217,7 +218,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	type = FIELD_GET(INT3472_GPIO_DSM_TYPE, obj->integer.value);
 
-	int3472_get_func_and_polarity(type, &func, &polarity);
+	int3472_get_func_and_polarity(type, &func, &gpio_flags);
 
 	pin = FIELD_GET(INT3472_GPIO_DSM_PIN, obj->integer.value);
 	if (pin != agpio->pin_table[0])
@@ -227,16 +228,16 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	active_value = FIELD_GET(INT3472_GPIO_DSM_SENSOR_ON_VAL, obj->integer.value);
 	if (!active_value)
-		polarity ^= GPIO_ACTIVE_LOW;
+		gpio_flags ^= GPIO_ACTIVE_LOW;
 
 	dev_dbg(int3472->dev, "%s %s pin %d active-%s\n", func,
 		agpio->resource_source.string_ptr, agpio->pin_table[0],
-		str_high_low(polarity == GPIO_ACTIVE_HIGH));
+		str_high_low(gpio_flags == GPIO_ACTIVE_HIGH));
 
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
 	case INT3472_GPIO_TYPE_POWERDOWN:
-		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func, polarity);
+		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func, gpio_flags);
 		if (ret)
 			err_msg = "Failed to map GPIO pin to sensor\n";
 
@@ -244,7 +245,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
-		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, func, polarity);
+		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, func, gpio_flags);
 		if (IS_ERR(gpio)) {
 			ret = PTR_ERR(gpio);
 			err_msg = "Failed to get GPIO\n";
-- 
2.39.5




