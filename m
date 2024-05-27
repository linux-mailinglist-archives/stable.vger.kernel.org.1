Return-Path: <stable+bounces-46526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07148D075A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1016D1C21E7F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E516C437;
	Mon, 27 May 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLfMQZBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354616B75C;
	Mon, 27 May 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825372; cv=none; b=sKqP8HWm9l1kHwagIbOnrfcHXy+NpR5OJL5Vo2cHaea/OFhkNFawegtRoGVtfkmfa3xYheEmnWj5XnsrIrJ48pQrQpKW7q9yynM+DPrwUoyh0LLDupxPrcsi3cl7my5qi9Nf1jHdlAxnYBCCuK4upHuW7oEvt5qXCisIPUt4V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825372; c=relaxed/simple;
	bh=nAB1AY5pLwxASoQc+U9OyagLxu/vrLWdvrYD0hIJqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqpiJ+T1WcewKjnUv3ZoGkwBSrc1ZBBLQ4UaTA0AINf7iQmzRIecr6T7wjYxrdf4oo8mzxXSS5LO7fif5eZPeUWfGIV3OpxqcwobcFP9GoAlm+oxSqyzMPRG5OjAVNk70BNOPxl3T2LPBfpACICuodPGPOYqnuql/eMnlAXydLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLfMQZBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661CAC2BBFC;
	Mon, 27 May 2024 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825372;
	bh=nAB1AY5pLwxASoQc+U9OyagLxu/vrLWdvrYD0hIJqAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLfMQZBmSsIl1no6wOWpYoJrbZcDNAK9QY036CyouHXMYjeNqBJfOvKjYL0eW+b9C
	 BdrGIfv2EcDkDwsRroB11Iui57iz1snGC3BUhCVHwKWhRsL3X+RY1FBVj4kUumf3wC
	 Ya1WLgobUqeh/u2P4O4RB5DNHVP+yetjpCVMdVE4Vyysjw3PgM38Q9eCKr6oC+FmLX
	 6wmLTug7Rba7+os205QLfkh2hD0nVkUx9kG8sNNsNa4Wz8QvpNwSrgZ+PzcM4W8W9u
	 C+r0zsEYs7bqE/YcT5OD6ZmTbWNULBmLyO5BgswCctNgXVU0VyhZp2/unpWby7aZrs
	 4WQYjlXVq0yhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/16] platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 Pro 1380F/L data
Date: Mon, 27 May 2024 11:54:59 -0400
Message-ID: <20240527155541.3865428-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155541.3865428-1-sashal@kernel.org>
References: <20240527155541.3865428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 3eee73ad42c3899d97e073bf2c41e7670a3c575c ]

The Lenovo Yoga Tablet 2 Pro 1380F/L is a x86 ACPI tablet which ships with
Android x86 as factory OS. Its DSDT contains a bunch of I2C devices which
are not actually there, causing various resource conflicts. Enumeration of
these is skipped through the acpi_quirk_skip_i2c_client_enumeration().

Add support for manually instantiating the I2C + other devices which are
actually present on this tablet by adding the necessary device info to
the x86-android-tablets module.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240406125058.13624-2-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/x86-android-tablets/dmi.c    |  18 ++
 .../platform/x86/x86-android-tablets/lenovo.c | 216 ++++++++++++++++++
 .../x86-android-tablets/x86-android-tablets.h |   1 +
 3 files changed, 235 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets/dmi.c b/drivers/platform/x86/x86-android-tablets/dmi.c
index 5d6c12494f082..141a2d25e83be 100644
--- a/drivers/platform/x86/x86-android-tablets/dmi.c
+++ b/drivers/platform/x86/x86-android-tablets/dmi.c
@@ -104,6 +104,24 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 		},
 		.driver_data = (void *)&lenovo_yogabook_x91_info,
 	},
+	{
+		/*
+		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13") This has more or less
+		 * the same BIOS as the 830F/L or 1050F/L (8" and 10") below,
+		 * but unlike the 8" / 10" models which share the same mainboard
+		 * this model has a different mainboard.
+		 * This match for the 13" model MUST come before the 8" + 10"
+		 * match since that one will also match the 13" model!
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+			/* Full match so as to NOT match the 830/1050 BIOS */
+			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21.X64.0005.R00.1504101516"),
+		},
+		.driver_data = (void *)&lenovo_yoga_tab2_1380_info,
+	},
 	{
 		/*
 		 * Lenovo Yoga Tablet 2 830F/L or 1050F/L (The 8" and 10"
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 26a4ef670ad7c..56fdc384e800f 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -17,6 +17,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/lp855x.h>
 #include <linux/platform_device.h>
+#include <linux/power/bq24190_charger.h>
 #include <linux/reboot.h>
 #include <linux/rmi.h>
 #include <linux/spi/spi.h>
@@ -539,6 +540,221 @@ static void lenovo_yoga_tab2_830_1050_exit(void)
 	}
 }
 
+/*
+ * Lenovo Yoga Tablet 2 Pro 1380F/L
+ *
+ * The Lenovo Yoga Tablet 2 Pro 1380F/L mostly has the same design as the 830F/L
+ * and the 1050F/L so this re-uses some of the handling for that from above.
+ */
+static const char * const lc824206xa_chg_det_psy[] = { "lc824206xa-charger-detect" };
+
+static const struct property_entry lenovo_yoga_tab2_1380_bq24190_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", lc824206xa_chg_det_psy),
+	PROPERTY_ENTRY_REF("monitored-battery", &generic_lipo_hv_4v35_battery_node),
+	PROPERTY_ENTRY_BOOL("omit-battery-class"),
+	PROPERTY_ENTRY_BOOL("disable-reset"),
+	{ }
+};
+
+static const struct software_node lenovo_yoga_tab2_1380_bq24190_node = {
+	.properties = lenovo_yoga_tab2_1380_bq24190_props,
+};
+
+/* For enabling the bq24190 5V boost based on id-pin */
+static struct regulator_consumer_supply lc824206xa_consumer = {
+	.supply = "vbus",
+	.dev_name = "i2c-lc824206xa",
+};
+
+static const struct regulator_init_data lenovo_yoga_tab2_1380_bq24190_vbus_init_data = {
+	.constraints = {
+		.name = "bq24190_vbus",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = &lc824206xa_consumer,
+	.num_consumer_supplies = 1,
+};
+
+struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
+	.regulator_init_data = &lenovo_yoga_tab2_1380_bq24190_vbus_init_data,
+};
+
+static const struct property_entry lenovo_yoga_tab2_1380_lc824206xa_props[] = {
+	PROPERTY_ENTRY_BOOL("onnn,enable-miclr-for-dcp"),
+	{ }
+};
+
+static const struct software_node lenovo_yoga_tab2_1380_lc824206xa_node = {
+	.properties = lenovo_yoga_tab2_1380_lc824206xa_props,
+};
+
+static const char * const lenovo_yoga_tab2_1380_lms303d_mount_matrix[] = {
+	"0", "-1", "0",
+	"-1", "0", "0",
+	"0", "0", "1"
+};
+
+static const struct property_entry lenovo_yoga_tab2_1380_lms303d_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("mount-matrix", lenovo_yoga_tab2_1380_lms303d_mount_matrix),
+	{ }
+};
+
+static const struct software_node lenovo_yoga_tab2_1380_lms303d_node = {
+	.properties = lenovo_yoga_tab2_1380_lms303d_props,
+};
+
+static const struct x86_i2c_client_info lenovo_yoga_tab2_1380_i2c_clients[] __initconst = {
+	{
+		/* BQ27541 fuel-gauge */
+		.board_info = {
+			.type = "bq27541",
+			.addr = 0x55,
+			.dev_name = "bq27541",
+			.swnode = &fg_bq24190_supply_node,
+		},
+		.adapter_path = "\\_SB_.I2C1",
+	}, {
+		/* bq24292i battery charger */
+		.board_info = {
+			.type = "bq24190",
+			.addr = 0x6b,
+			.dev_name = "bq24292i",
+			.swnode = &lenovo_yoga_tab2_1380_bq24190_node,
+			.platform_data = &lenovo_yoga_tab2_1380_bq24190_pdata,
+		},
+		.adapter_path = "\\_SB_.I2C1",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
+			.chip = "INT33FC:02",
+			.index = 2,
+			.trigger = ACPI_EDGE_SENSITIVE,
+			.polarity = ACPI_ACTIVE_HIGH,
+			.con_id = "bq24292i_irq",
+		},
+	}, {
+		/* LP8557 Backlight controller */
+		.board_info = {
+			.type = "lp8557",
+			.addr = 0x2c,
+			.dev_name = "lp8557",
+			.platform_data = &lenovo_lp8557_pwm_and_reg_pdata,
+		},
+		.adapter_path = "\\_SB_.I2C3",
+	}, {
+		/* LC824206XA Micro USB Switch */
+		.board_info = {
+			.type = "lc824206xa",
+			.addr = 0x48,
+			.dev_name = "lc824206xa",
+			.swnode = &lenovo_yoga_tab2_1380_lc824206xa_node,
+		},
+		.adapter_path = "\\_SB_.I2C3",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
+			.chip = "INT33FC:02",
+			.index = 1,
+			.trigger = ACPI_LEVEL_SENSITIVE,
+			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "lc824206xa_irq",
+		},
+	}, {
+		/* AL3320A ambient light sensor */
+		.board_info = {
+			.type = "al3320a",
+			.addr = 0x1c,
+			.dev_name = "al3320a",
+		},
+		.adapter_path = "\\_SB_.I2C5",
+	}, {
+		/* LSM303DA accelerometer + magnetometer */
+		.board_info = {
+			.type = "lsm303d",
+			.addr = 0x1d,
+			.dev_name = "lsm303d",
+			.swnode = &lenovo_yoga_tab2_1380_lms303d_node,
+		},
+		.adapter_path = "\\_SB_.I2C5",
+	}, {
+		/* Synaptics RMI touchscreen */
+		.board_info = {
+			.type = "rmi4_i2c",
+			.addr = 0x38,
+			.dev_name = "rmi4_i2c",
+			.platform_data = &lenovo_yoga_tab2_830_1050_rmi_pdata,
+		},
+		.adapter_path = "\\_SB_.I2C6",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_APIC,
+			.index = 0x45,
+			.trigger = ACPI_EDGE_SENSITIVE,
+			.polarity = ACPI_ACTIVE_HIGH,
+		},
+	}
+};
+
+static const struct platform_device_info lenovo_yoga_tab2_1380_pdevs[] __initconst = {
+	{
+		/* For the Tablet 2 Pro 1380's custom fast charging driver */
+		.name = "lenovo-yoga-tab2-pro-1380-fastcharger",
+		.id = PLATFORM_DEVID_NONE,
+	},
+};
+
+const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
+	"bq24190_charger",            /* For the Vbus regulator for lc824206xa */
+	NULL
+};
+
+static int __init lenovo_yoga_tab2_1380_init(void)
+{
+	int ret;
+
+	/* To verify that the DMI matching works vs the 830 / 1050 models */
+	pr_info("detected Lenovo Yoga Tablet 2 Pro 1380F/L\n");
+
+	ret = lenovo_yoga_tab2_830_1050_init_codec();
+	if (ret)
+		return ret;
+
+	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
+	lenovo_yoga_tab2_830_1050_sys_off_handler =
+		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
+					 lenovo_yoga_tab2_830_1050_power_off, NULL);
+	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
+		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
+
+	return 0;
+}
+
+static struct gpiod_lookup_table lenovo_yoga_tab2_1380_fc_gpios = {
+	.dev_id = "serial0-0",
+	.table = {
+		GPIO_LOOKUP("INT33FC:00", 57, "uart3_txd", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FC:00", 61, "uart3_rxd", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table * const lenovo_yoga_tab2_1380_gpios[] = {
+	&lenovo_yoga_tab2_830_1050_codec_gpios,
+	&lenovo_yoga_tab2_1380_fc_gpios,
+	NULL
+};
+
+const struct x86_dev_info lenovo_yoga_tab2_1380_info __initconst = {
+	.i2c_client_info = lenovo_yoga_tab2_1380_i2c_clients,
+	.i2c_client_count = ARRAY_SIZE(lenovo_yoga_tab2_1380_i2c_clients),
+	.pdev_info = lenovo_yoga_tab2_1380_pdevs,
+	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_1380_pdevs),
+	.gpio_button = &lenovo_yoga_tab2_830_1050_lid,
+	.gpio_button_count = 1,
+	.gpiod_lookup_tables = lenovo_yoga_tab2_1380_gpios,
+	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
+	.modules = lenovo_yoga_tab2_1380_modules,
+	.init = lenovo_yoga_tab2_1380_init,
+	.exit = lenovo_yoga_tab2_830_1050_exit,
+};
+
 /* Lenovo Yoga Tab 3 Pro YT3-X90F */
 
 /*
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index e46e1128acc81..3613152aaf86c 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -99,6 +99,7 @@ extern const struct x86_dev_info czc_p10t;
 extern const struct x86_dev_info lenovo_yogabook_x90_info;
 extern const struct x86_dev_info lenovo_yogabook_x91_info;
 extern const struct x86_dev_info lenovo_yoga_tab2_830_1050_info;
+extern const struct x86_dev_info lenovo_yoga_tab2_1380_info;
 extern const struct x86_dev_info lenovo_yt3_info;
 extern const struct x86_dev_info medion_lifetab_s10346_info;
 extern const struct x86_dev_info nextbook_ares8_info;
-- 
2.43.0


