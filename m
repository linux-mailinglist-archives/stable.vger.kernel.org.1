Return-Path: <stable+bounces-273309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IfD+LtFQUWr/CAMAu9opvQ
	(envelope-from <stable+bounces-273309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:06:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653673DFFF
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:06:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ch3Db0Tj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273309-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273309-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C641D3010154
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A73921E4;
	Fri, 10 Jul 2026 20:06:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C4225775
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713999; cv=none; b=fmrQq3BeTstRIS4Bs+UwtU76jZ0N5hr77f2b1yZ3DOCpX6fxdAme2vfS+EUY1I+4QaEHRGX70jd9Q+GZyi1/r/aAo+cpfH11fyI7ryteN7vUKCviigG3P9h+ljO4ZMcvYMtKoRxBUnZMPQwUFlGYAmCRLTZ1cnX3Yv1lMFiyFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713999; c=relaxed/simple;
	bh=G4/8VZ8H6nVZaFvjqmRc3r57Hq3SXKFV07fwRWha9UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtoUgqAmaoa8EIihJ4DxANqF2WGlT/Nh5HsrkZnyceg3CDe1vpCXHiAhG+dtFNwbBWLJbNGWIBhgIbtWGYaCSskoBtXKAdPxdnX2JyGprdm+z7VFQg1GCRXiJgCM32DqEOfAUFIeqyov8fYP2Nbw85ShrAtapIDlTmsEqRePUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch3Db0Tj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF6E1F00A3A;
	Fri, 10 Jul 2026 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713997;
	bh=5FfxVOefdCXJVIKPFbp/kWsCRP4MdKm1ro17fY+aK6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ch3Db0TjyOLygM0l1Vpg1x/g1A4xKJ1yjBncSdX+pWQkqke4pyLjOSIArxB6oE7o+
	 dcf5YhFSmzi4z+gOXGHFdhfuUqu6201A/PDuYAgIIIKqDkBcF8+a2xf95/Y88H+4rf
	 oJKnJ9qCc+laEeaUXQw1T6x3jtWfKO3tHeTHkAePiKTAm+BH3bMNbbey5aCxkkJnfz
	 3XOLRpNom7KqdRLDCF50g52EADsGUUIosPE17TKr4IDHNf/yQg0yirWEFkmcB225i6
	 NDngegFIDVjeuiILlJ4W5fPXaS0V6bjRYZF4u5H9X4SJZ0F3NJNIMFq1Wn1U9QfGFq
	 RM8buW8QdrMQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] ACPI: driver: Check ACPI_COMPANION() against NULL during probe
Date: Fri, 10 Jul 2026 16:06:31 -0400
Message-ID: <20260710200635.395836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070932-overdress-unsaved-5212@gregkh>
References: <2026070932-overdress-unsaved-5212@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273309-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:rafael.j.wysocki@intel.com,m:johannes.goede@oss.qualcomm.com,m:andriy.shevchenko@linux.intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0653673DFFF

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
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_tad.c      | 6 +++++-
 drivers/acpi/pfr_telemetry.c | 6 +++++-
 drivers/acpi/pfr_update.c    | 6 +++++-
 drivers/acpi/thermal.c       | 2 +-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index ecba82ac7cd5f9..542e16c3ab9f6f 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -588,12 +588,16 @@ static int acpi_tad_remove(struct platform_device *pdev)
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
diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 843f678ade0c22..d423c6608f7d3a 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -365,10 +365,14 @@ static void pfrt_log_put_idx(void *data)
 
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
index aedf7e40145e06..fb93d5401d89d6 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -507,10 +507,14 @@ static void pfru_put_idx(void *data)
 
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
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8263508415a8d0..2c656699a83cc0 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -926,7 +926,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	int result;
 
 	if (!device)
-		return -EINVAL;
+		return -ENODEV;
 
 	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
-- 
2.53.0


