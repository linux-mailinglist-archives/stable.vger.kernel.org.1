Return-Path: <stable+bounces-249537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHtUFHo7DGqpagUAu9opvQ
	(envelope-from <stable+bounces-249537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4557C3CB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AD4530160F7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F13A3E9F;
	Tue, 19 May 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNs+nc0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B23A383A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186025; cv=none; b=ZdPGSWVreKw6Pusg4mfioS7HRIfidODDHVw2XI74FP/4NeUlFXvxft/IwPPIk0IqjD+Y9B3PqpPVf2PPYYt9N7I2KYDvcuj7lOm8Kx+8IGyZBZB9ZGzteozMoH9wh0iZaT552TCp4SZNMi4fn9IcUuj64CFLpYmWB0f1NMPWt3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186025; c=relaxed/simple;
	bh=IRHw6JYFmMMVJ9VU9oMzWWEgtpIyUY78UhyRkhGFaxQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XNXp15erq3taWtl/Z/SjX79px5a6XPhF7mXq7Ce/I+UaQceY3HQHkEt1DuXAGODiZPqHjXN0XqnoSNEhg2YSOYe8hwDZsxvw5MaBQnYkdf66CouJUCj1mjNpoxBs7S0XyEI0MX95qMMCINP0/xQusuTSk9XjhbhRxeVSGSWtRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNs+nc0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79888C2BCB3;
	Tue, 19 May 2026 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779186024;
	bh=IRHw6JYFmMMVJ9VU9oMzWWEgtpIyUY78UhyRkhGFaxQ=;
	h=Subject:To:Cc:From:Date:From;
	b=pNs+nc0Wq5eQkb9DUKvPUGKcKY0JFcf8TPzzT0P0uN1gbABZn5cXWJ5beP0g+hvpv
	 f5R87izftqTtdhoCbw0Lu73vd9OnkN6OpAuIDYABZ1G0Z6urlMZ/P3nBptP8LVvEIm
	 BJppy1oT1UTCeUGAO0fMOmEPn+GVPYuZE0OJeT1E=
Subject: FAILED: patch "[PATCH] ACPI: driver: Check ACPI_COMPANION() against NULL during" failed to apply to 7.0-stable tree
To: rafael.j.wysocki@intel.com,andriy.shevchenko@linux.intel.com,johannes.goede@oss.qualcomm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2026 12:19:38 +0200
Message-ID: <2026051938-urban-cane-71ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249537-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,intel.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: C1C4557C3CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x e4865a56d013e86e46ea6acea15bb6eae01898ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051938-urban-cane-71ad@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4865a56d013e86e46ea6acea15bb6eae01898ff Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 8 May 2026 20:04:33 +0200
Subject: [PATCH] ACPI: driver: Check ACPI_COMPANION() against NULL during
 probe

Since every platform driver can be forced to match a device that doesn't
match its list of device IDs because of device_match_driver_override(),
platform drivers that rely on the existence of a device's ACPI companion
object should verify its presence.

Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
against NULL to 13 platform drivers handling core ACPI devices.

Also change the value returned by the ACPI thermal zone driver when
the device's ACPI companion is not present to -ENODEV for consistency
with the other drivers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/4516068.ejJDZkT8p0@rafael.j.wysocki
Cc: 7.0+ <stable@vger.kernel.org> # 7.0+

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index e9e970fd8f33..27f31744f29e 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -192,11 +192,15 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 
 static int acpi_ac_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct power_supply_config psy_cfg = {};
+	struct acpi_device *adev;
 	struct acpi_ac *ac;
 	int result;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	ac = kzalloc_obj(struct acpi_ac);
 	if (!ac)
 		return -ENOMEM;
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 0a8e02bc8c8b..ec94b09bb747 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -423,7 +423,11 @@ static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
 
 	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					       acpi_pad_notify, adev);
diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index cac07e997028..386fc1abcbdc 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -815,12 +815,16 @@ static void acpi_tad_remove(void *data)
 static int acpi_tad_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_tad_driver_data *dd;
+	acpi_handle handle;
 	acpi_status status;
 	unsigned long long caps;
 	int ret;
 
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
 	/*
 	 * Initialization failure messages are mostly about firmware issues, so
 	 * print them at the "info" level.
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b4c25474f42f..d4ae21a71007 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1214,10 +1214,14 @@ static void sysfs_battery_cleanup(struct acpi_battery *battery)
 
 static int acpi_battery_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_battery *battery;
+	struct acpi_device *device;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index dc064a388c23..b47301ee4c8a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -531,15 +531,20 @@ static int acpi_lid_input_open(struct input_dev *input)
 
 static int acpi_button_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_notify_handler handler;
+	struct acpi_device *device;
 	struct acpi_button *button;
 	struct input_dev *input;
-	const char *hid = acpi_device_hid(device);
 	acpi_status status;
 	char *name, *class;
+	const char *hid;
 	int error = 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	hid = acpi_device_hid(device);
 	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
 	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
 		return -ENODEV;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 45204538ed87..64ad4cfa6208 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1676,10 +1676,14 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool ca
 
 static int acpi_ec_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct acpi_ec *ec;
 	int ret;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	if (boot_ec && (boot_ec->handle == device->handle ||
 	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
 		/* Fast path: this device corresponds to the boot EC. */
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 4d5e12ed6f3c..060e8d670f5d 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -50,9 +50,13 @@ static void acpi_hed_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_hed_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	int err;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	/* Only one hardware error device */
 	if (hed_handle)
 		return -EINVAL;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index d13264fb9e02..9304ac996d41 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3341,12 +3341,16 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_nfit_desc *acpi_desc;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_table_header *tbl;
+	struct acpi_device *adev;
 	acpi_status status = AE_OK;
 	acpi_size sz;
 	int rc = 0;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					     acpi_nfit_notify, dev);
 	if (rc)
diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 32bdf8cbe8f2..2387376832a1 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -360,10 +360,14 @@ static void pfrt_log_put_idx(void *data)
 
 static int acpi_pfrt_log_probe(struct platform_device *pdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	struct pfrt_log_device *pfrt_log_dev;
+	acpi_handle handle;
 	int ret;
 
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
 	if (!acpi_has_method(handle, "_DSM")) {
 		dev_dbg(&pdev->dev, "Missing _DSM\n");
 		return -ENODEV;
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 11b1c2828005..6283105bb0e8 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -538,10 +538,14 @@ static void pfru_put_idx(void *data)
 
 static int acpi_pfru_probe(struct platform_device *pdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	struct pfru_device *pfru_dev;
+	acpi_handle handle;
 	int ret;
 
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
 	if (!acpi_has_method(handle, "_DSM")) {
 		dev_dbg(&pdev->dev, "Missing _DSM\n");
 		return -ENODEV;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 440f1d69aca8..86b7c7975852 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -629,11 +629,15 @@ static void acpi_sbs_callback(void *context)
 
 static int acpi_sbs_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct acpi_sbs *sbs;
 	int result = 0;
 	int id;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	sbs = kzalloc_obj(struct acpi_sbs);
 	if (!sbs) {
 		result = -ENOMEM;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index f413270415b6..c0ffa267f96c 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -237,11 +237,15 @@ static int smbus_alarm(void *context)
 
 static int acpi_smbus_hc_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	int status;
 	unsigned long long val;
 	struct acpi_smb_hc *hc;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
 		pr_err("error obtaining _EC.\n");
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b8b487d89d25..dfc7daa809b5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -789,7 +789,7 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 	int i;
 
 	if (!device)
-		return -EINVAL;
+		return -ENODEV;
 
 	tz = kzalloc_obj(struct acpi_thermal);
 	if (!tz)
diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 531e65b01bcb..92516ef84b02 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -38,9 +38,13 @@ static u32 acpi_tiny_power_button_event(void *not_used)
 
 static int acpi_tiny_power_button_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	acpi_status status;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 							  acpi_tiny_power_button_event,


