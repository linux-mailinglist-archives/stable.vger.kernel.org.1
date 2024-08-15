Return-Path: <stable+bounces-69115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85159953581
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1091D285B4A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FD1A00EC;
	Thu, 15 Aug 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ZeZ4AvK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD11A00CF;
	Thu, 15 Aug 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732716; cv=none; b=WKLRIstTMhgbqvG9Q+sJ+09TrDD9t8ojN6Fc5iAp9IsF2v79LGvpggJHRSoMCgdlvLJvsQh25kbrWOTzlCNrRtaeEGZx873I/tsp4JqjCAwncL7USdRjoQRTaJ2qhZcGAWbKxlWXQeEExvxSSqWx5C1EZujv6IlGnQ0iLcAWpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732716; c=relaxed/simple;
	bh=d85HJ7cLQwTVSHwDGX3WRyH9rON94AtWLOYomZ9+Waw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JifOV0PFxl60PEw6BkEW/Gcl+3ElvEOdqORa0lGrSZqy8Hqj/KQVBwjA4E01/Bs+q3bQyrzj86OaXdPKGEdciMf0GSr5C3ziA7vm39rllp0JNnY5ujBgTRO5q54iWXZpnR9tRnpg9CLYcQAtEJHFbziC0bqe75XUKC869jwVo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ZeZ4AvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F4BC32786;
	Thu, 15 Aug 2024 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732716;
	bh=d85HJ7cLQwTVSHwDGX3WRyH9rON94AtWLOYomZ9+Waw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2ZeZ4AvKii7OJ3pFKX6RII9FrTPhzF4MIcKS9eNz9x0pd3LZaMKC/fLOTl4+1dYwE
	 ZjivgQqQuTdRIj8zBrCQ9fjKEn5yQPhU7kX8wFFnTyvVQfTTLny49yFwIpKSlq2so+
	 BQUHKQjxWFnXMK+LefKJ9YIseIX5IsLXQo0Bg2g4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 265/352] ACPI: battery: create alarm sysfs attribute atomically
Date: Thu, 15 Aug 2024 15:25:31 +0200
Message-ID: <20240815131929.686251797@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit a231eed10ed5a290129fda36ad7bcc263c53ff7d ]

Let the power supply core register the attribute.
This ensures that the attribute is created before the device is
announced to userspace, avoid a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8b43efe97da5d..2e1462b8929c0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -670,12 +670,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
 /*
  * The Battery Hooking API
  *
@@ -812,7 +818,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -857,7 +866,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -868,7 +877,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
-- 
2.43.0




