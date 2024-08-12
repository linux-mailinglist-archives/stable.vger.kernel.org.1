Return-Path: <stable+bounces-66792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45894F27C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA382B2467F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78032186E51;
	Mon, 12 Aug 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lSxFDJDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD0186295;
	Mon, 12 Aug 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478800; cv=none; b=B4jO6RbmzddG3UQzleuCclTmfTzh6ZobEorBVXMKqzx6dgAU0THS4sCUjImTFAZJv2yJ49+IfRI4oxvIHqPrmdH9MwvM888+/cBTEGY9RYhmbnsqdu2TBYXXxHEzZDMoTQTr3Tav/GKSrVPed1V9wZTKJm1j6wLZo6r5GktxRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478800; c=relaxed/simple;
	bh=4BdxxmfCXSe3q2EB9s504csBGPq8aDAYo+16vZLhqfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5DYPk4JJM0a7kE6+I93F1xPbz+B1c5rUuHl1xhCMe1a3IkPU0nnA7DoPH7W8rmn+nZx3qgW4HlhUO/isqICnM/T7pIuQvyf+VX2GTPYTfCkHPKxy0djBkPZQdFSSreEOaog6+k0spGTG0Zkl4yd7sWrBcb2YBCAHb67Th9225c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lSxFDJDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C5C32782;
	Mon, 12 Aug 2024 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478800;
	bh=4BdxxmfCXSe3q2EB9s504csBGPq8aDAYo+16vZLhqfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSxFDJDz45bozI6/1Vs4l0LC0/5h11ArSEHwngjS7ozzjR/O3cJWlWXxTka622qWV
	 kb+rjjwPMkgkWroiuGhfU4K7x67ja1zgHPTvLrM3L4UEsn1TSHJe6FNDTy2v9X3Y7u
	 XmStEmK4olQGjyAf7igQcwV/dbgavicwIMasVDPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/150] ACPI: SBS: manage alarm sysfs attribute through psy core
Date: Mon, 12 Aug 2024 18:01:44 +0200
Message-ID: <20240812160126.056411681@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 6bad28cfc30988a845fb3f59a99f4b8a4ce8fe95 ]

Let the power supply core register the attribute.

This ensures that the attribute is created before the device is
announced to userspace, avoiding a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/sbs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index e6a01a8df1b81..7c0eba1a37d87 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -77,7 +77,6 @@ struct acpi_battery {
 	u16 spec;
 	u8 id;
 	u8 present:1;
-	u8 have_sysfs_alarm:1;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -462,12 +461,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	return count;
 }
 
-static const struct device_attribute alarm_attr = {
+static struct device_attribute alarm_attr = {
 	.attr = {.name = "alarm", .mode = 0644},
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
 
+static struct attribute *acpi_battery_attrs[] = {
+	&alarm_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(acpi_battery);
+
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -509,7 +514,10 @@ static int acpi_battery_read(struct acpi_battery *battery)
 static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	int result;
 
 	battery->id = id;
@@ -539,10 +547,6 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	result = device_create_file(&battery->bat->dev, &alarm_attr);
-	if (result)
-		goto end;
-	battery->have_sysfs_alarm = 1;
       end:
 	pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -554,11 +558,8 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
 
-	if (battery->bat) {
-		if (battery->have_sysfs_alarm)
-			device_remove_file(&battery->bat->dev, &alarm_attr);
+	if (battery->bat)
 		power_supply_unregister(battery->bat);
-	}
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
-- 
2.43.0




