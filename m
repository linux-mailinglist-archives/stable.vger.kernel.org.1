Return-Path: <stable+bounces-67977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3095300E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5B91C24BE9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFDF19FA93;
	Thu, 15 Aug 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UaCCS/AA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA851714A8;
	Thu, 15 Aug 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729112; cv=none; b=JzXlVu0xiuEx9v5WYLDlcAHwI9cE0qzVPkHTjHLZNJoOzolW1fzYNJ8DZiPMjOkeOllkUL0DJmeoy+1Nz0jarz6apAsQE91H2HpGCd/cJbr5sYKa2XuetgrY0kEESsjHVxdvk96EGg3BUAukUZUIaJfmy1JNkQ8SaLzufBalHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729112; c=relaxed/simple;
	bh=55hPH0WOI8yeSBsHSz5gctNLyp1O00VJJyhI7mhqRbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8IEB3tsh6jGtKLVV7dPRSP+zzu8cSBdeS6OBD3iSqRwadzu1rvnYw8DcrgclzQ1ySGKF5uUveMHL+s4IXiiTdw7WgwTsvA7xIfzZUPhd8EofviuHrDUsTws+azx8IzqLyilAhClmuglalqQErigAcw254PP51CFJmNOW4MU29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UaCCS/AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B8C32786;
	Thu, 15 Aug 2024 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729111;
	bh=55hPH0WOI8yeSBsHSz5gctNLyp1O00VJJyhI7mhqRbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaCCS/AALhJ/BxHRSANQ/9OfhDP+ypTZxHARBlwwdFS5Rkv04b/nwbS+fObjRYOWC
	 sd3nHaodg/DsBllmfirR6Ck4Mwiu7NUMr+QqLB7GIbXegNxyV3rq5eCH4eTANuf24G
	 O0tMkBd0Fal/gaRf4gIJsVBb91zlQy/ohNewJ9ng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gergo Koteles <soyer@irl.hu>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 18/22] platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
Date: Thu, 15 Aug 2024 15:25:26 +0200
Message-ID: <20240815131831.960710832@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>
References: <20240815131831.265729493@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit cde7886b35176d56e72bfc68dc104fa08e7b072c ]

Some models need to trigger the EC after each YMC event for the yoga
mode control to work properly. EC triggering consist of a VPC call from
the lenovo-ymc module. Except for this, all VPC calls are in the
ideapad-laptop module.

Since ideapad-laptop has a notification chain, a new YMC_EVENT action
can be added and triggered from the lenovo-ymc module. Then the
ideapad-laptop can trigger the EC.

If the triggering is in the ideapad-laptop module, then the ec_trigger
module parameter should be there as well.

Move the ymc_trigger_ec functionality and the ec_trigger module
parameter to the ideapad-laptop module.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/d980ab3ac32b5e554f456b0ff17279bfdbe2a203.1721898747.git.soyer@irl.hu
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 7cc06e729460 ("platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/Kconfig          |  1 +
 drivers/platform/x86/ideapad-laptop.c | 49 ++++++++++++++++++++++
 drivers/platform/x86/ideapad-laptop.h |  4 ++
 drivers/platform/x86/lenovo-ymc.c     | 60 +--------------------------
 4 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 665fa95249865..ddfccc226751f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -477,6 +477,7 @@ config LENOVO_YMC
 	tristate "Lenovo Yoga Tablet Mode Control"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on IDEAPAD_LAPTOP
 	select INPUT_SPARSEKMAP
 	help
 	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 38d98ee558d32..96e1caf549c43 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -145,6 +145,7 @@ struct ideapad_private {
 		bool touchpad_ctrl_via_ec : 1;
 		bool ctrl_ps2_aux_port    : 1;
 		bool usb_charging         : 1;
+		bool ymc_ec_trigger       : 1;
 	} features;
 	struct {
 		bool initialized;
@@ -193,6 +194,12 @@ MODULE_PARM_DESC(touchpad_ctrl_via_ec,
 	"Enable registering a 'touchpad' sysfs-attribute which can be used to manually "
 	"tell the EC to enable/disable the touchpad. This may not work on all models.");
 
+static bool ymc_ec_trigger __read_mostly;
+module_param(ymc_ec_trigger, bool, 0444);
+MODULE_PARM_DESC(ymc_ec_trigger,
+	"Enable EC triggering work-around to force emitting tablet mode events. "
+	"If you need this please report this to: platform-driver-x86@vger.kernel.org");
+
 /*
  * shared data
  */
@@ -1599,10 +1606,50 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	priv->r_touchpad_val = value;
 }
 
+static const struct dmi_system_id ymc_ec_trigger_quirk_dmi_table[] = {
+	{
+		/* Lenovo Yoga 7 14ARB7 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		},
+	},
+	{
+		/* Lenovo Yoga 7 14ACN6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
+		},
+	},
+	{ }
+};
+
+static void ideapad_laptop_trigger_ec(void)
+{
+	struct ideapad_private *priv;
+	int ret;
+
+	guard(mutex)(&ideapad_shared_mutex);
+
+	priv = ideapad_shared;
+	if (!priv)
+		return;
+
+	if (!priv->features.ymc_ec_trigger)
+		return;
+
+	ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
+	if (ret)
+		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
+}
+
 static int ideapad_laptop_nb_notify(struct notifier_block *nb,
 				    unsigned long action, void *data)
 {
 	switch (action) {
+	case IDEAPAD_LAPTOP_YMC_EVENT:
+		ideapad_laptop_trigger_ec();
+		break;
 	}
 
 	return 0;
@@ -1768,6 +1815,8 @@ static void ideapad_check_features(struct ideapad_private *priv)
 	priv->features.ctrl_ps2_aux_port =
 		ctrl_ps2_aux_port || dmi_check_system(ctrl_ps2_aux_port_list);
 	priv->features.touchpad_ctrl_via_ec = touchpad_ctrl_via_ec;
+	priv->features.ymc_ec_trigger =
+		ymc_ec_trigger || dmi_check_system(ymc_ec_trigger_quirk_dmi_table);
 
 	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
 		priv->features.fan_mode = true;
diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/ideapad-laptop.h
index 3eb0dcd6bf7ba..948cc61800a95 100644
--- a/drivers/platform/x86/ideapad-laptop.h
+++ b/drivers/platform/x86/ideapad-laptop.h
@@ -14,6 +14,10 @@
 #include <linux/errno.h>
 #include <linux/notifier.h>
 
+enum ideapad_laptop_notifier_actions {
+	IDEAPAD_LAPTOP_YMC_EVENT,
+};
+
 int ideapad_laptop_register_notifier(struct notifier_block *nb);
 int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
 void ideapad_laptop_call_notifier(unsigned long action, void *data);
diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e1fbc35504d49..e0bbd6a14a89c 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -20,32 +20,10 @@
 #define LENOVO_YMC_QUERY_INSTANCE 0
 #define LENOVO_YMC_QUERY_METHOD 0x01
 
-static bool ec_trigger __read_mostly;
-module_param(ec_trigger, bool, 0444);
-MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force emitting tablet mode events");
-
 static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
 
-static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
-	{
-		/* Lenovo Yoga 7 14ARB7 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
-		},
-	},
-	{
-		/* Lenovo Yoga 7 14ACN6 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
-		},
-	},
-	{ }
-};
-
 static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 	{
 		.matches = {
@@ -62,21 +40,8 @@ static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 
 struct lenovo_ymc_private {
 	struct input_dev *input_dev;
-	struct acpi_device *ec_acpi_dev;
 };
 
-static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo_ymc_private *priv)
-{
-	int err;
-
-	if (!priv->ec_acpi_dev)
-		return;
-
-	err = write_ec_cmd(priv->ec_acpi_dev->handle, VPCCMD_W_YMC, 1);
-	if (err)
-		dev_warn(&wdev->dev, "Could not write YMC: %d\n", err);
-}
-
 static const struct key_entry lenovo_ymc_keymap[] = {
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
@@ -125,11 +90,9 @@ static void lenovo_ymc_notify(struct wmi_device *wdev, union acpi_object *data)
 
 free_obj:
 	kfree(obj);
-	lenovo_ymc_trigger_ec(wdev, priv);
+	ideapad_laptop_call_notifier(IDEAPAD_LAPTOP_YMC_EVENT, &code);
 }
 
-static void acpi_dev_put_helper(void *p) { acpi_dev_put(p); }
-
 static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 {
 	struct lenovo_ymc_private *priv;
@@ -143,29 +106,10 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 			return -ENODEV;
 	}
 
-	ec_trigger |= dmi_check_system(ec_trigger_quirk_dmi_table);
-
 	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	if (ec_trigger) {
-		pr_debug("Lenovo YMC enable EC triggering.\n");
-		priv->ec_acpi_dev = acpi_dev_get_first_match_dev("VPC2004", NULL, -1);
-
-		if (!priv->ec_acpi_dev) {
-			dev_err(&wdev->dev, "Could not find EC ACPI device.\n");
-			return -ENODEV;
-		}
-		err = devm_add_action_or_reset(&wdev->dev,
-				acpi_dev_put_helper, priv->ec_acpi_dev);
-		if (err) {
-			dev_err(&wdev->dev,
-				"Could not clean up EC ACPI device: %d\n", err);
-			return err;
-		}
-	}
-
 	input_dev = devm_input_allocate_device(&wdev->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -192,7 +136,6 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	/* Report the state for the first time on probe */
-	lenovo_ymc_trigger_ec(wdev, priv);
 	lenovo_ymc_notify(wdev, NULL);
 	return 0;
 }
@@ -217,3 +160,4 @@ module_wmi_driver(lenovo_ymc_driver);
 MODULE_AUTHOR("Gergo Koteles <soyer@irl.hu>");
 MODULE_DESCRIPTION("Lenovo Yoga Mode Control driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IDEAPAD_LAPTOP);
-- 
2.43.0




