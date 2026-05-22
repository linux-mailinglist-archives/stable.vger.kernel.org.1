Return-Path: <stable+bounces-253776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIT+HDxSEGodWQYAu9opvQ
	(envelope-from <stable+bounces-253776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:55:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5D5B4962
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 131E3305AF37
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47D4028D8;
	Fri, 22 May 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StJ1NQB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26540245E
	for <stable@vger.kernel.org>; Fri, 22 May 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453372; cv=none; b=DF4/IcCc69/sDV4JbbiUxNEyvC2+CKBILO3vslnEKV5QTk7Z8TOXh4M4sx96qF1iqit/IMFFez5LBJqxJuEYsm1JNQim8MmiykRH8hzuDrO8OndamBSuDnV6fz3nnSgdEfiLeeUp7m4mdHgwPP0I+l8xKU91HbWzgZTn3KiR5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453372; c=relaxed/simple;
	bh=TYgAnao0yAhJ9AiRMutuZcg7aNiMgN5+3A2QuM8lkdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hABNYAFyoj5YupDf3zicQGDts1Z5AODANuBhtRWyi1D4l4WV9+AR42GZxZTOWveZ0IGrCafuv1R+A8l+3BENa1ttxEl6ewyzjwxpRjiO7PfKOVkHzYdOOltWY6y9wEm9cEsIR+uXmZvIlRCohQFvvhrW2lwMkvtsaQwBmV99mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StJ1NQB+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A6B1F000E9;
	Fri, 22 May 2026 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453370;
	bh=sV4Esahi9JhjqgdD3cVaV1d2+npssgWrs+1MtyDHtAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StJ1NQB+j4XIkE1maj+34vUbvYIQlSYXY6K9Wwql3P8lTFcx9npMsb9zvnhr6u5JE
	 FzKRmtqglBOEGv3rP7J7FsnPIXWew1Tr0WPvNzd2YNgqTWsw+x8mCjg3HeoVcZzR6s
	 w8wdvzZwKkfaB1gsqLN2+tXMM8DjmG2DEjwRhggNww1rPLxVtATs/vC82mLbEkrSHW
	 cORCmbLRFegfeQ1zhvfsCEba5d5IipD7Yu7RxaPO49arhwjL7pEuTh2wjymHrSI8iU
	 +1EzMdmayfSz5XybptImaQnfeQRIp7QChTtDlHivK61wK7FFd8J1SS97B3Ta8jD7o3
	 T9OexYIgy9R7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y] ACPI: driver: Check ACPI_COMPANION() against NULL during probe
Date: Fri, 22 May 2026 08:36:07 -0400
Message-ID: <20260522123607.3811753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051938-urban-cane-71ad@gregkh>
References: <2026051938-urban-cane-71ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253776-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14B5D5B4962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit e4865a56d013e86e46ea6acea15bb6eae01898ff ]

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
[ reordered variable declaration to add NULL check before pre-existing stable-only code that dereferences the pointer ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ac.c                | 6 +++++-
 drivers/acpi/acpi_pad.c          | 6 +++++-
 drivers/acpi/acpi_tad.c          | 6 +++++-
 drivers/acpi/battery.c           | 6 +++++-
 drivers/acpi/button.c            | 9 +++++++--
 drivers/acpi/ec.c                | 6 +++++-
 drivers/acpi/hed.c               | 6 +++++-
 drivers/acpi/nfit/core.c         | 6 +++++-
 drivers/acpi/pfr_telemetry.c     | 6 +++++-
 drivers/acpi/pfr_update.c        | 6 +++++-
 drivers/acpi/sbs.c               | 6 +++++-
 drivers/acpi/sbshc.c             | 6 +++++-
 drivers/acpi/thermal.c           | 2 +-
 drivers/acpi/tiny-power-button.c | 6 +++++-
 14 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index c5d77c3cb4bce..56783af6239b1 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -203,11 +203,15 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 
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
index c9a0bcaba2e4c..dea7b2b4e5445 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -426,9 +426,13 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev;
 	acpi_status status;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	strscpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 6d870d97ada65..49e0710ac5ca3 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -593,12 +593,16 @@ static void acpi_tad_remove(struct platform_device *pdev)
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
 	ret = acpi_install_cmos_rtc_space_handler(handle);
 	if (ret < 0) {
 		dev_info(dev, "Unable to install space handler\n");
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8fbad8bc46503..c965b930a3902 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1215,10 +1215,14 @@ static void sysfs_battery_cleanup(struct acpi_battery *battery)
 
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
index 97b05246efab6..ff30f993b1506 100644
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
index 6f0065257a77c..2d94bae5c4d15 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1679,10 +1679,14 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool ca
 
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
 	strscpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_EC_CLASS);
 
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 4d5e12ed6f3c2..060e8d670f5d3 100644
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
index d13264fb9e026..9304ac996d41a 100644
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
index 32bdf8cbe8f23..2387376832a1b 100644
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
index 11b1c28280052..6283105bb0e8b 100644
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
index bbd3938f7b524..e32d424ff3e18 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -631,11 +631,15 @@ static void acpi_sbs_callback(void *context)
 
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
index 36850831910bc..4b2a3ef835739 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -240,11 +240,15 @@ static int smbus_alarm(void *context)
 
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
index 64356b004a57d..a7bb550a71856 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -790,7 +790,7 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 	int i;
 
 	if (!device)
-		return -EINVAL;
+		return -ENODEV;
 
 	tz = kzalloc_obj(struct acpi_thermal);
 	if (!tz)
diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 531e65b01bcbe..92516ef84b021 100644
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
-- 
2.53.0


