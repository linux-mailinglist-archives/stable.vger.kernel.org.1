Return-Path: <stable+bounces-134908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A19A95B0B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116BC175C6D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EF1F3BB8;
	Tue, 22 Apr 2025 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLCfZwff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE81F2BA1;
	Tue, 22 Apr 2025 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288172; cv=none; b=Q6lq8MpQv1ouhI7sV0s5eTPowjF8Nr+iWLZVgQ0oXuHX7uGzQ1bv6tRGj+CZpX7dTrNLBCUtCQsdps4atvV/GSOZA709EqCWOLqBiyMbhBzCImuIbyNZsMs0IHsmJ0qwlJu16A2RDX4lYQgP8iaO5GP2FrggQDeTtTZFMFPYm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288172; c=relaxed/simple;
	bh=M/Vh5PrH5sWiUm5Qrjy+xXnQol6blThEU2beFMWc1OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFt+ynlcstyDsbDsIGz7TAuZnLvKDindHr+ZUbIxOnyqHRvwy9xY6+HPzVrC/RifBjp0UPYAg6UVqXafOAv7tM+O8+dmaWoGgT/AL+QmfxuJYtcYaBRzGWmOipfa7G8vKuNpEnCZnWYuFI9xlUWikEYS/FfsF/Z4xMoxyTiy8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLCfZwff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367D2C4CEE4;
	Tue, 22 Apr 2025 02:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288172;
	bh=M/Vh5PrH5sWiUm5Qrjy+xXnQol6blThEU2beFMWc1OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLCfZwffvAq1WC0jUZv6l4AMjFVTzCcIkQfLN5bVWUo8G9P/gxLcNxFRyDgu/zZsP
	 +ZLvdN//4S2SnqbltnGJeHL44jrNkNKALdFk9XblP0/BhYZeOL/FTcUL9AL30BxTkr
	 wCOJWWNp1Vsp8nQ5T4r4Ue8o8BNn+wU44HI19VakZycdUMiSVyf0d/ptTbfOLaoWFx
	 pUYcFqM9ybBrs+cLLc7otX5rxI8P9fuVqh7kjBpaE0+kGCzjXPrEzrwC98+8Ex747k
	 e6a8pzq/AhK51asDVnK+eqxrydQq5Mos5hdkOuY842wHUKGzM1OjajDRZZrZ9ritsp
	 hEEu5y1vwWihQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 10/30] platform/x86: x86-android-tablets: Add "9v" to Vexia EDU ATLA 10 tablet symbols
Date: Mon, 21 Apr 2025 22:15:30 -0400
Message-Id: <20250422021550.1940809-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 3343b086c7035222c24956780ea4423655cad6d2 ]

The Vexia EDU ATLA 10 tablet comes in 2 different versions with
significantly different mainboards. The only outward difference is that
the charging barrel on one is marked 5V and the other is marked 9V.

Both need to be handled by the x86-android-tablets code. Add 9v to
the symbols for the existing support for the 9V Vexia EDU ATLA 10 tablet
symbols to prepare for adding support for the 5V version.

All this patch does is s/vexia_edu_atla10_info/vexia_edu_atla10_9v_info/.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20250407092017.273124-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/x86-android-tablets/dmi.c    |  2 +-
 .../platform/x86/x86-android-tablets/other.c  | 64 +++++++++----------
 .../x86-android-tablets/x86-android-tablets.h |  2 +-
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/dmi.c b/drivers/platform/x86/x86-android-tablets/dmi.c
index 3e5fa3b6e2fdf..e43d482b17a35 100644
--- a/drivers/platform/x86/x86-android-tablets/dmi.c
+++ b/drivers/platform/x86/x86-android-tablets/dmi.c
@@ -187,7 +187,7 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 			/* Above strings are too generic, also match on BIOS date */
 			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
 		},
-		.driver_data = (void *)&vexia_edu_atla10_info,
+		.driver_data = (void *)&vexia_edu_atla10_9v_info,
 	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 1d93d9edb23f4..74dcac8d19d72 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -599,62 +599,62 @@ const struct x86_dev_info whitelabel_tm800a550l_info __initconst = {
 };
 
 /*
- * Vexia EDU ATLA 10 tablet, Android 4.2 / 4.4 + Guadalinex Ubuntu tablet
+ * Vexia EDU ATLA 10 tablet 9V, Android 4.2 + Guadalinex Ubuntu tablet
  * distributed to schools in the Spanish Andalucía region.
  */
 static const char * const crystal_cove_pwrsrc_psy[] = { "crystal_cove_pwrsrc" };
 
-static const struct property_entry vexia_edu_atla10_ulpmc_props[] = {
+static const struct property_entry vexia_edu_atla10_9v_ulpmc_props[] = {
 	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", crystal_cove_pwrsrc_psy),
 	{ }
 };
 
-static const struct software_node vexia_edu_atla10_ulpmc_node = {
-	.properties = vexia_edu_atla10_ulpmc_props,
+static const struct software_node vexia_edu_atla10_9v_ulpmc_node = {
+	.properties = vexia_edu_atla10_9v_ulpmc_props,
 };
 
-static const char * const vexia_edu_atla10_accel_mount_matrix[] = {
+static const char * const vexia_edu_atla10_9v_accel_mount_matrix[] = {
 	"0", "-1", "0",
 	"1", "0", "0",
 	"0", "0", "1"
 };
 
-static const struct property_entry vexia_edu_atla10_accel_props[] = {
-	PROPERTY_ENTRY_STRING_ARRAY("mount-matrix", vexia_edu_atla10_accel_mount_matrix),
+static const struct property_entry vexia_edu_atla10_9v_accel_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("mount-matrix", vexia_edu_atla10_9v_accel_mount_matrix),
 	{ }
 };
 
-static const struct software_node vexia_edu_atla10_accel_node = {
-	.properties = vexia_edu_atla10_accel_props,
+static const struct software_node vexia_edu_atla10_9v_accel_node = {
+	.properties = vexia_edu_atla10_9v_accel_props,
 };
 
-static const struct property_entry vexia_edu_atla10_touchscreen_props[] = {
+static const struct property_entry vexia_edu_atla10_9v_touchscreen_props[] = {
 	PROPERTY_ENTRY_U32("hid-descr-addr", 0x0000),
 	PROPERTY_ENTRY_U32("post-reset-deassert-delay-ms", 120),
 	{ }
 };
 
-static const struct software_node vexia_edu_atla10_touchscreen_node = {
-	.properties = vexia_edu_atla10_touchscreen_props,
+static const struct software_node vexia_edu_atla10_9v_touchscreen_node = {
+	.properties = vexia_edu_atla10_9v_touchscreen_props,
 };
 
-static const struct property_entry vexia_edu_atla10_pmic_props[] = {
+static const struct property_entry vexia_edu_atla10_9v_pmic_props[] = {
 	PROPERTY_ENTRY_BOOL("linux,register-pwrsrc-power_supply"),
 	{ }
 };
 
-static const struct software_node vexia_edu_atla10_pmic_node = {
-	.properties = vexia_edu_atla10_pmic_props,
+static const struct software_node vexia_edu_atla10_9v_pmic_node = {
+	.properties = vexia_edu_atla10_9v_pmic_props,
 };
 
-static const struct x86_i2c_client_info vexia_edu_atla10_i2c_clients[] __initconst = {
+static const struct x86_i2c_client_info vexia_edu_atla10_9v_i2c_clients[] __initconst = {
 	{
 		/* I2C attached embedded controller, used to access fuel-gauge */
 		.board_info = {
 			.type = "vexia_atla10_ec",
 			.addr = 0x76,
 			.dev_name = "ulpmc",
-			.swnode = &vexia_edu_atla10_ulpmc_node,
+			.swnode = &vexia_edu_atla10_9v_ulpmc_node,
 		},
 		.adapter_path = "0000:00:18.1",
 	}, {
@@ -679,7 +679,7 @@ static const struct x86_i2c_client_info vexia_edu_atla10_i2c_clients[] __initcon
 			.type = "kxtj21009",
 			.addr = 0x0f,
 			.dev_name = "kxtj21009",
-			.swnode = &vexia_edu_atla10_accel_node,
+			.swnode = &vexia_edu_atla10_9v_accel_node,
 		},
 		.adapter_path = "0000:00:18.5",
 	}, {
@@ -688,7 +688,7 @@ static const struct x86_i2c_client_info vexia_edu_atla10_i2c_clients[] __initcon
 			.type = "hid-over-i2c",
 			.addr = 0x38,
 			.dev_name = "FTSC1000",
-			.swnode = &vexia_edu_atla10_touchscreen_node,
+			.swnode = &vexia_edu_atla10_9v_touchscreen_node,
 		},
 		.adapter_path = "0000:00:18.6",
 		.irq_data = {
@@ -703,7 +703,7 @@ static const struct x86_i2c_client_info vexia_edu_atla10_i2c_clients[] __initcon
 			.type = "intel_soc_pmic_crc",
 			.addr = 0x6e,
 			.dev_name = "intel_soc_pmic_crc",
-			.swnode = &vexia_edu_atla10_pmic_node,
+			.swnode = &vexia_edu_atla10_9v_pmic_node,
 		},
 		.adapter_path = "0000:00:18.7",
 		.irq_data = {
@@ -715,7 +715,7 @@ static const struct x86_i2c_client_info vexia_edu_atla10_i2c_clients[] __initcon
 	}
 };
 
-static const struct x86_serdev_info vexia_edu_atla10_serdevs[] __initconst = {
+static const struct x86_serdev_info vexia_edu_atla10_9v_serdevs[] __initconst = {
 	{
 		.ctrl.pci.devfn = PCI_DEVFN(0x1e, 3),
 		.ctrl_devname = "serial0",
@@ -723,7 +723,7 @@ static const struct x86_serdev_info vexia_edu_atla10_serdevs[] __initconst = {
 	},
 };
 
-static struct gpiod_lookup_table vexia_edu_atla10_ft5416_gpios = {
+static struct gpiod_lookup_table vexia_edu_atla10_9v_ft5416_gpios = {
 	.dev_id = "i2c-FTSC1000",
 	.table = {
 		GPIO_LOOKUP("INT33FC:00", 60, "reset", GPIO_ACTIVE_LOW),
@@ -731,12 +731,12 @@ static struct gpiod_lookup_table vexia_edu_atla10_ft5416_gpios = {
 	},
 };
 
-static struct gpiod_lookup_table * const vexia_edu_atla10_gpios[] = {
-	&vexia_edu_atla10_ft5416_gpios,
+static struct gpiod_lookup_table * const vexia_edu_atla10_9v_gpios[] = {
+	&vexia_edu_atla10_9v_ft5416_gpios,
 	NULL
 };
 
-static int __init vexia_edu_atla10_init(struct device *dev)
+static int __init vexia_edu_atla10_9v_init(struct device *dev)
 {
 	struct pci_dev *pdev;
 	int ret;
@@ -760,13 +760,13 @@ static int __init vexia_edu_atla10_init(struct device *dev)
 	return 0;
 }
 
-const struct x86_dev_info vexia_edu_atla10_info __initconst = {
-	.i2c_client_info = vexia_edu_atla10_i2c_clients,
-	.i2c_client_count = ARRAY_SIZE(vexia_edu_atla10_i2c_clients),
-	.serdev_info = vexia_edu_atla10_serdevs,
-	.serdev_count = ARRAY_SIZE(vexia_edu_atla10_serdevs),
-	.gpiod_lookup_tables = vexia_edu_atla10_gpios,
-	.init = vexia_edu_atla10_init,
+const struct x86_dev_info vexia_edu_atla10_9v_info __initconst = {
+	.i2c_client_info = vexia_edu_atla10_9v_i2c_clients,
+	.i2c_client_count = ARRAY_SIZE(vexia_edu_atla10_9v_i2c_clients),
+	.serdev_info = vexia_edu_atla10_9v_serdevs,
+	.serdev_count = ARRAY_SIZE(vexia_edu_atla10_9v_serdevs),
+	.gpiod_lookup_tables = vexia_edu_atla10_9v_gpios,
+	.init = vexia_edu_atla10_9v_init,
 	.use_pci = true,
 };
 
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index 63a38a0069bae..2204bbaf2ed5a 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -127,7 +127,7 @@ extern const struct x86_dev_info nextbook_ares8_info;
 extern const struct x86_dev_info nextbook_ares8a_info;
 extern const struct x86_dev_info peaq_c1010_info;
 extern const struct x86_dev_info whitelabel_tm800a550l_info;
-extern const struct x86_dev_info vexia_edu_atla10_info;
+extern const struct x86_dev_info vexia_edu_atla10_9v_info;
 extern const struct x86_dev_info xiaomi_mipad2_info;
 extern const struct dmi_system_id x86_android_tablet_ids[];
 
-- 
2.39.5


