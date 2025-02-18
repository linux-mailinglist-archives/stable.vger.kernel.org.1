Return-Path: <stable+bounces-116840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBCA3A8F0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D31188D276
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E01DF277;
	Tue, 18 Feb 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJyZZFdw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AC1DF26A;
	Tue, 18 Feb 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910332; cv=none; b=qnL7crNmjXRhhjzghr+Mqo6cKvazioEQJPVoZ+iXSkZREdnvZXpEJPEsxLPOZ3GZjNac3WnBXDxUMMg66Qt9vtFnzg92cfMD337yZRvvbWGFsRBW6+cHNiarrcm0hw3wQWvVnEib/gqZ4FI8tgAWRf3nHGfEL4C7FE+a4FCzkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910332; c=relaxed/simple;
	bh=Y2tahZ7GjToKkjcaduLXw05/ckAmfifJ5mXk3WykwGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwwXhAa2CzYOUQua7PKIgQFLIgrQlF09nbf/QNXJdlYhh4Hcgm8ZGLFpy2J/gl6VFWdxAxKGAJcRgN4106FdHZb7QQG3PRyRUoC//khQ854dgh0OIKOO1f3Jw7swBEWd7wl+qx3Zh4wjn6TT5sNUqmiGdDFHqOblHCHnDZMySSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJyZZFdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BDDC4CEE8;
	Tue, 18 Feb 2025 20:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910332;
	bh=Y2tahZ7GjToKkjcaduLXw05/ckAmfifJ5mXk3WykwGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJyZZFdwP5KlE91HxD91ApEeMaH11xQHWBdrlfO/PBukg3IRdp3CwYNE4pXxJvezn
	 pbOltsxvvHh1hZ2uQKxJC3PKG8Kw4py9kA/wZ3qpQtxOX64cdB4w4/FZZDToFuL0Rv
	 1Kl/pk/zMQyH/CauKLH9XYlVe1vZH93Gh06kYzuQ6k5qkqFlToUWx/qy+fhYhfEh9Q
	 LQNyoO9Z80L5XiCp3LNZhma/jYaruN+geimWUtEOivmJiGX3uXr2YZcHAuGSCsiNKq
	 ZV4V8oDx9H6VjkBQSzC0lIuzb78utNuuK8Ju9q4Wz7eZ9HTFLJHAgO6PaS2WoS9zJe
	 +0e7Rk2gGOOBw==
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
Subject: [PATCH AUTOSEL 6.13 18/31] platform/x86: int3472: Call "reset" GPIO "enable" for INT347E
Date: Tue, 18 Feb 2025 15:24:38 -0500
Message-Id: <20250218202455.3592096-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 569617dbbd06286fb73f3f1c2ac91e51d863c7de ]

The DT bindings for ov7251 specify "enable" GPIO (xshutdown in
documentation) but the int3472 indiscriminately provides this as a "reset"
GPIO to sensor drivers. Take this into account by assigning it as "enable"
with active high polarity for INT347E devices, i.e. ov7251. "reset" with
active low polarity remains the default GPIO name for other devices.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250211072841.7713-3-sakari.ailus@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 52 +++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 8205993d3b5c4..a80c981caa340 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -2,6 +2,7 @@
 /* Author: Dan Scally <djrscally@gmail.com> */
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -122,10 +123,53 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 	return desc;
 }
 
-static void int3472_get_func_and_polarity(u8 type, const char **func,
-					  unsigned long *gpio_flags)
+/**
+ * struct int3472_gpio_map - Map GPIOs to whatever is expected by the
+ * sensor driver (as in DT bindings)
+ * @hid: The ACPI HID of the device without the instance number e.g. INT347E
+ * @type_from: The GPIO type from ACPI ?SDT
+ * @type_to: The assigned GPIO type, typically same as @type_from
+ * @func: The function, e.g. "enable"
+ * @polarity_low: GPIO_ACTIVE_LOW true if the @polarity_low is true,
+ * GPIO_ACTIVE_HIGH otherwise
+ */
+struct int3472_gpio_map {
+	const char *hid;
+	u8 type_from;
+	u8 type_to;
+	bool polarity_low;
+	const char *func;
+};
+
+static const struct int3472_gpio_map int3472_gpio_map[] = {
+	{ "INT347E", INT3472_GPIO_TYPE_RESET, INT3472_GPIO_TYPE_RESET, false, "enable" },
+};
+
+static void int3472_get_func_and_polarity(struct acpi_device *adev, u8 *type,
+					  const char **func, unsigned long *gpio_flags)
 {
-	switch (type) {
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(int3472_gpio_map); i++) {
+		/*
+		 * Map the firmware-provided GPIO to whatever a driver expects
+		 * (as in DT bindings). First check if the type matches with the
+		 * GPIO map, then further check that the device _HID matches.
+		 */
+		if (*type != int3472_gpio_map[i].type_from)
+			continue;
+
+		if (!acpi_dev_hid_uid_match(adev, int3472_gpio_map[i].hid, NULL))
+			continue;
+
+		*type = int3472_gpio_map[i].type_to;
+		*gpio_flags = int3472_gpio_map[i].polarity_low ?
+			      GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
+		*func = int3472_gpio_map[i].func;
+		return;
+	}
+
+	switch (*type) {
 	case INT3472_GPIO_TYPE_RESET:
 		*func = "reset";
 		*gpio_flags = GPIO_ACTIVE_LOW;
@@ -218,7 +262,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	type = FIELD_GET(INT3472_GPIO_DSM_TYPE, obj->integer.value);
 
-	int3472_get_func_and_polarity(type, &func, &gpio_flags);
+	int3472_get_func_and_polarity(int3472->sensor, &type, &func, &gpio_flags);
 
 	pin = FIELD_GET(INT3472_GPIO_DSM_PIN, obj->integer.value);
 	if (pin != agpio->pin_table[0])
-- 
2.39.5


