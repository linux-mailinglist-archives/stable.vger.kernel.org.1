Return-Path: <stable+bounces-116870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD897A3A954
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3818B18956E0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17D1C700F;
	Tue, 18 Feb 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKTiISeG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43801FFC7C;
	Tue, 18 Feb 2025 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910417; cv=none; b=ixCDb4EiiOc+pqX0Jt8V47iA3eQVPUTZU5BbrwW5aNkYYjiWFPVI2BP4XNH484+tSJ6Kmiycb2gB/NubIyrrMyR771Oof/Af3rlcAceThP61fCcLBf9vESyWwjJ/dV6wlTnPHvDC3sT7WnnwygYX7yMXMHbJOmcLpi4WaR+pqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910417; c=relaxed/simple;
	bh=ErPDl5hiYfjIeBZk4ey0B5Jd07n/bpHkh7yaJ1/M8Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzSeAfRYzr8eP5P4rG5pPH/l68mRhctYFbvi41SaRUNVjd78lCAXbV9d+tTJg9J5FbHUcup2ccYkZ1qAtsg/0elNBzZeg2AfNkpQbA2Y2J1rZnRJoGnIGNO6a6Aad8A5dBwbQzCJ81y/9xvtjvdxwL18mBOKISGnCxJDfvhrHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKTiISeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F80C4CEE2;
	Tue, 18 Feb 2025 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910416;
	bh=ErPDl5hiYfjIeBZk4ey0B5Jd07n/bpHkh7yaJ1/M8Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKTiISeG49X5hJVWfSmLM5792lBPWQdRaeh2YR6EA59Mq4XzwzU9Dh1eynRriEsYK
	 ev6C0SmUnIwNZ/T0Bi6l5So4kccwD0WpY/hBi1TiNLBwqGQu3DiDpgW9srqXwF4iln
	 wpWVfT8JiJtoyxJamorKKHqM4ko2WY8IkWVlbEPPb+IbYWFEYor3AEB/U4lIgSXP03
	 zr2aYeZB0svpH500R2Qq3C048R2SBdkD8W1SVml5W0nHnCRzvy9KKHFG5vlc2+LaF1
	 63S6/wFkKXphPCkApbLdF2UEVYAzcKpGsz2/nuyLC9Iaw2Sa9cMaf3FzlEWV4s/4TW
	 z2ByUigZJ6sLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	djrscally@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 17/31] platform/x86: int3472: Use correct type for "polarity", call it gpio_flags
Date: Tue, 18 Feb 2025 15:26:03 -0500
Message-Id: <20250218202619.3592630-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

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


