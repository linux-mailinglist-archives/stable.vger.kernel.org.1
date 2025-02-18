Return-Path: <stable+bounces-116871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63AA3A958
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B749C1748B0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754F2046AA;
	Tue, 18 Feb 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NncNsdTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6520102B;
	Tue, 18 Feb 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910418; cv=none; b=SAbWrQIpC5+alcMCFiXz0B3SkdgJb0kmVfVBDoHI+gzmB22VKqxHtL15l6+CwMynQEaqPy6jL8U2TJ6KVEjMsjVA/CNN1KpV6wgonZTrcBam2kkyxkZmBjB/245aIMJu6FBbEVLq3QG35GqnA7xBGM0j1+5/J+LKp5pw54FRBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910418; c=relaxed/simple;
	bh=LdtzdOFt4c3JVnt2IqX0N0jlHd/IKoQ64fBioyu5dNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvGc61oPuvfZN+ddxALxyHumW30wKz1hUOlBHU24gSm6hdpAGqKMh6Eeddffso5VmJ/sN5NCiynHBRcdCdf860gQU4pTpez0TmXUPpChstWc6NZiwB6raSNijf8W4ibzXGQJ1kgpfgxX1G6j/EMuuCuaetNKRnEvh0fLpxxUjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NncNsdTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEAFC4CEE9;
	Tue, 18 Feb 2025 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910417;
	bh=LdtzdOFt4c3JVnt2IqX0N0jlHd/IKoQ64fBioyu5dNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NncNsdTjwnccegfFl3Ab8YUcduVmA3qoe08bM1okT2P1WY3jXyoZohoVaG7it65UW
	 6QpSw+IJP9FvXMC+zAwERo6ZspPtj5d7eb6mD5l2PN8JQyKYM6WMmNLwdNnMMitlj3
	 dNdbF87F7gkrwfhkK0Ega1YW1fy3ffWjojHV4UhWxYHrnWUHUlDTHgZ6F0y9rUWqHj
	 r8hsrPYu6r9TpQLH8Reo19pLBh0Ltaf9mbVI52lze6oi2T0j3ccDf1Ocrg+uJsoBRy
	 Cm72ILmH4Xd19a8WIpn5oWCB39JHYGzYNcUcDGwfvXEH9nSjpxoiFw/U4EmGQ9BAP6
	 jRP1RdGnCShOg==
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
Subject: [PATCH AUTOSEL 6.12 18/31] platform/x86: int3472: Call "reset" GPIO "enable" for INT347E
Date: Tue, 18 Feb 2025 15:26:04 -0500
Message-Id: <20250218202619.3592630-18-sashal@kernel.org>
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
index dc4d09611c5ab..9e69ac9cfb92c 100644
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


